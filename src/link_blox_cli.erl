%%%
%%% @doc 
%%% LinkBloxCli Application Main Supervisor
%%% @end
%%%

-module(link_blox_cli).

-author("Mark Sebald").

-behaviour(supervisor).

-export([
          init/1,
          start_link/1
]).

%% ====================================================================
%% API functions
%% ====================================================================

start_link(Options) ->
    supervisor:start_link({local, ?MODULE}, ?MODULE, Options).

%% ====================================================================
%% Behavioural functions
%% ====================================================================

%% ====================================================================
%% init/1
%% ====================================================================
-spec init(Args :: term()) -> Result when
  Result :: {ok, {SupervisionPolicy, [ChildSpec]}} | ignore,
  SupervisionPolicy :: {RestartStrategy, MaxR :: non_neg_integer(), MaxT :: pos_integer()},
  RestartStrategy :: one_for_all
           | one_for_one
           | rest_for_one
           | simple_one_for_one,
  ChildSpec :: {Id :: term(), StartFunc, RestartPolicy, Type :: worker | supervisor, Modules},
  StartFunc :: {M :: module(), F :: atom(), A :: [term()] | undefined},
  RestartPolicy :: permanent
           | transient
           | temporary,
  Modules :: [module()] | dynamic.

init([NodeName, LangMod, SshPort, LogLevel, Cookie]) ->   
  logger:set_primary_config([{level, LogLevel}]),

  lb_utils:set_lang_mod(LangMod),
  
  lb_logger:info("Starting link_blox_cli, Node Name: ~p, Language Module: ~p, SSH Port: ~p, Log Level: ~p", [NodeName, LangMod, SshPort, LogLevel]),
 
  HostName = net_adm:localhost(),
  lb_logger:info(host_name, [HostName]),

  % if node not started, error returned, and app will crash
  
  {ok, NodeName} = start_node(NodeName),

  if (node() /= nonode@nohost) ->
    erlang:set_cookie(node(), Cookie),
    lb_logger:debug("Node cookie set to: ~p", [erlang:get_cookie()]);
  true ->
    lb_logger:debug("Node not started")
  end,
  
  lb_node_watcher:start(),

  ui_ssh_cli:start(SshPort, LangMod, "/etc/ssh"),
  
  ignore.

                   
%% ====================================================================
%% Internal functions
%% ====================================================================

-spec start_node(NodeName :: atom()) -> {ok, atom()}.

%% limit number of nodes we try to start
start_node(NodeName) ->

  % make sure epmd is running
  case net_adm:names() of
    {ok, _} ->
      lb_logger:info("epmd is running"),
      ok;
    {error, address} ->
      lb_logger:info("starting epmd"),
      Epmd = os:find_executable("epmd"),
      os:cmd(Epmd ++ " -daemon")
  end,
  
  case net_kernel:start([NodeName, shortnames]) of
    {ok, _Pid} -> 
      lb_logger:info(distributed_node_started, [NodeName]),
      {ok, NodeName};

    {error, {already_started, _Pid}} ->
      lb_logger:debug("~p Already started", [NodeName]),
      {error, already_started};

    {error, Error} ->
      lb_logger:error("~p Starting: ~p", [Error, NodeName]),
      {error, start_node_failed}
  end.

  


