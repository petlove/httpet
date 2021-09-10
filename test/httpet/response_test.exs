defmodule HTTPet.ResponseTest do
  use ExUnit.Case, async: true

  alias HTTPet.Response

  @valid_params %{
    body: "{\"json_valid\":\"yes\"}",
    headers: %{
      "Content-Type" => "application/json"
    },
    status_code: 299
  }

  describe "handle/1" do
    test "given a list with valid body, headers and status_code, it returns a Response's struct" do
      valid_params = Map.to_list(@valid_params)

      assert %Response{
               body: %{"json_valid" => "yes"},
               headers: %{"Content-Type" => "application/json"},
               status_code: 299
             } = Response.handle(valid_params)
    end
  end

  describe "struct" do
    test "enforces :body, :headers and :status_code" do
      assert_raise ArgumentError, fn ->
        struct!(Response, Map.drop(@valid_params, [:body]))
      end

      assert_raise ArgumentError, fn ->
        struct!(Response, Map.drop(@valid_params, [:headers]))
      end

      assert_raise ArgumentError, fn ->
        struct!(Response, Map.drop(@valid_params, [:status_code]))
      end
    end
  end
end
