# link_blox_cli

## Stand alone command line user interface for the link_blox IoT application

#### To Use:

Prerequisites:  Erlang 20 and Elixir 1.7 installed


```sh
...$ git clone https://github.com/mdsebald/link_blox_cli.git 
Cloning into 'link_blox_cli'...

...$ cd link_blox_cli

.../link_blox_cli$

.../link_blox_cli$ mix deps.get
* Getting ...
remote: ...
Receiving ...
Resolving ...
* Gettting ...

.../link_blox_cli$ mix compile
===> ...
Compiling ...
Generated ...
...
Generated link_blox_cli app
.../link_blox_cli$ mix run --no-halt

07:23:31.579 [debug] Creating config ets

07:23:31.590 [info]  Starting link_blox_cli, Node Name: :LinkBloxCli, Language Module: :lang_en_us, SSH Port: 1111, Log Level: :debug

07:23:31.601 [info]  Host name: MyPC.localdomain

07:23:31.637 [info]  epmd is running

07:23:31.669 [info]  Distributed node: :LinkBloxCli started

07:23:31.670 [debug] Node cookie set to: :LinkBlox_cookie

07:23:31.674 [info]  Starting node_watcher

07:23:31.677 [info]  Starting SSH CLI User Interface on port: 1111
```

Open another command prompt

```sh
...$ ssh -p 1111 MyPC

   W E L C O M E  T O  L i n k B l o x !

Enter command
none>connect LinkBlox@nerves-ffff
Connected to node: 'LinkBlox@nerves-ffff'

LinkBlox@nerves-ffff> status

Block Type       Block Name       Value                          Status       Exec Method
---------------- ---------------- ------------------------------ ------------ ------------
rpi_led          green_led        true                           normal       input_cos
i2c_mcp9808      temp_sens        71.0375                        normal       timer
float_to_7seg    conv             "71.04"                        normal       input_cos
i2c_ht16k33      display          0                              normal       input_cos

LinkBlox@nerves-84f0>
```


Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at [https://hexdocs.pm/link_blox_cli](https://hexdocs.pm/link_blox_cli).

