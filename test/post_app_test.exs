defmodule PostAppTest do
  use ExUnit.Case
  doctest PostApp

  test "greets the world" do
    assert PostApp.hello() == :world
  end
end
