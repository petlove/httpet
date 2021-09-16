defmodule HTTPet.RequestHeadersTest do
  use ExUnit.Case, async: true

  alias HTTPet.RequestHeaders

  describe "add_defaults/1" do
    @default_header [
      {:"Content-Type", "application/json"},
      {:"x-datadog-trace-id", nil},
      {:"x-datadog-parent-id", nil}
    ]

    test "given an empty map as header, it returns the defaults" do
      assert @default_header == RequestHeaders.add_defaults([])
    end

    test "given a map with differet keys, it returns the default headers merged to given headers" do
      expected_headers = @default_header ++ ["x-custom-data": "x-custom-value"]

      assert expected_headers ==
               RequestHeaders.add_defaults("x-custom-data": "x-custom-value")
    end

    test "given a map with overriding keys, it returns the header merged with given data as value" do
      assert Enum.any?(RequestHeaders.add_defaults("Content-Type": "text/html"), fn header ->
               header == {:"Content-Type", "text/html"}
             end)
    end
  end
end
