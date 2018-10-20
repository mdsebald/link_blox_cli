defmodule LinkBloxCliTest do
  use ExUnit.Case
  doctest LinkBloxCli

  test "greets the world" do
    assert LinkBloxCli.hello() == :world
  end
end
