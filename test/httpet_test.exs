defmodule HTTPetTest do
  use ExUnit.Case

  import Mox

  alias HTTPet.Clients.ClientBehaviourMock
  alias HTTPet.Response

  setup :verify_on_exit!

  @default_headers [
    "Content-Type": "application/json",
    "x-datadog-trace-id": nil,
    "x-datadog-parent-id": nil
  ]

  describe "HTTP Verbs" do
    test "get/4 a successfull call via the HTTP client, returns a tuple with :ok and a %Response{} struct" do
      ClientBehaviourMock
      |> expect(:get, 1, fn "http://0.0.0.0/uri/get",
                            @default_headers,
                            [timeout: 50_000, recv_timeout: 50_000] ->
        {:ok,
         Response.handle(
           body: "{\"valid_json\":\"yes\"}",
           headers: %{"Content-Type" => "application/json"},
           status_code: 299
         )}
      end)

      assert {:ok,
              %Response{
                body: %{valid_json: "yes"},
                headers: %{"Content-Type" => "application/json"},
                status_code: 299
              }} == HTTPet.get(:fake_service, "uri/get")
    end

    test "delete/4 a successfull call via the HTTP client, returns a tuple with :ok and a %Response{} struct" do
      ClientBehaviourMock
      |> expect(:delete, 1, fn "http://0.0.0.0/uri/delete",
                               @default_headers,
                               [timeout: 50_000, recv_timeout: 50_000] ->
        {:ok,
         Response.handle(
           body: "{\"valid_json\":\"yes\"}",
           headers: %{"Content-Type" => "application/json"},
           status_code: 499
         )}
      end)

      assert {:ok,
              %Response{
                body: %{valid_json: "yes"},
                headers: %{"Content-Type" => "application/json"},
                status_code: 499
              }} == HTTPet.delete(:fake_service, "uri/delete")
    end

    test "post/5 a successfull call via the HTTP client, returns a tuple with :ok and a %Response{} struct" do
      ClientBehaviourMock
      |> expect(:post, 1, fn "http://0.0.0.0/uri/post",
                             "{\"field\":\"value\"}",
                             @default_headers,
                             [timeout: 50_000, recv_timeout: 50_000] ->
        {:ok,
         Response.handle(
           body: "{\"valid_json\":\"yes\"}",
           headers: %{"Content-Type" => "application/json"},
           status_code: 299
         )}
      end)

      assert {:ok,
              %Response{
                body: %{valid_json: "yes"},
                headers: %{"Content-Type" => "application/json"},
                status_code: 299
              }} == HTTPet.post(:fake_service, "uri/post", %{field: "value"})
    end

    test "put/5 a successfull call via the HTTP client, returns a tuple with :ok and a %Response{} struct" do
      ClientBehaviourMock
      |> expect(:put, 1, fn "http://0.0.0.0/uri/put",
                            "{\"field\":\"value\"}",
                            @default_headers,
                            [timeout: 50_000, recv_timeout: 50_000] ->
        {:ok,
         Response.handle(
           body: "{\"valid_json\":\"yes\"}",
           headers: %{"Content-Type" => "application/json"},
           status_code: 499
         )}
      end)

      assert {:ok,
              %Response{
                body: %{valid_json: "yes"},
                headers: %{"Content-Type" => "application/json"},
                status_code: 499
              }} == HTTPet.put(:fake_service, "uri/put", %{field: "value"})
    end

    test "patch/5 a successfull call via the HTTP client, returns a tuple with :ok and a %Response{} struct" do
      ClientBehaviourMock
      |> expect(:patch, 1, fn "http://0.0.0.0/uri/patch",
                              "{\"field\":\"value\"}",
                              @default_headers,
                              [timeout: 50_000, recv_timeout: 50_000] ->
        {:ok,
         Response.handle(
           body: "{\"valid_json\":\"yes\"}",
           headers: %{"Content-Type" => "application/json"},
           status_code: 202
         )}
      end)

      assert {:ok,
              %Response{
                body: %{valid_json: "yes"},
                headers: %{"Content-Type" => "application/json"},
                status_code: 202
              }} == HTTPet.patch(:fake_service, "uri/patch", %{field: "value"})
    end

    test "put/5 a successfull call via the HTTP client, overrides service config via params" do
      ClientBehaviourMock
      |> expect(:put, 1, fn "http://0.0.0.0/uri/put",
                            "{\"field\":\"value\"}",
                            @default_headers,
                            [recv_timeout: 50_000, timeout: 40_000] ->
        {:ok,
         Response.handle(
           body: "{\"valid_json\":\"yes\"}",
           headers: %{"Content-Type" => "application/json"},
           status_code: 499
         )}
      end)

      assert {:ok,
              %Response{
                body: %{valid_json: "yes"},
                headers: %{"Content-Type" => "application/json"},
                status_code: 499
              }} ==
               HTTPet.put(:fake_service, "uri/put", %{field: "value"}, @default_headers,
                 timeout: 40_000
               )
    end

    test "request/5 a successfull call via the HTTP client, returns a tuple with :ok and a %Response{} struct" do
      ClientBehaviourMock
      |> expect(:request, 1, fn :get,
                                "http://0.0.0.0/uri/request",
                                "{\"field\":\"value\"}",
                                @default_headers,
                                [timeout: 50_000, recv_timeout: 50_000] ->
        {:ok,
         Response.handle(
           body: "{\"valid_json\":\"yes\"}",
           headers: %{"Content-Type" => "application/json"},
           status_code: 200
         )}
      end)

      assert {:ok,
              %Response{
                body: %{valid_json: "yes"},
                headers: %{"Content-Type" => "application/json"},
                status_code: 200
              }} == HTTPet.request(:fake_service, :get, "uri/request", %{field: "value"})
    end
  end
end
