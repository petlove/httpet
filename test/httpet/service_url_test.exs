defmodule HTTPet.ServiceUrlTest do
  use ExUnit.Case, async: true

  alias HTTPet.ServiceUrl

  describe "build/2" do
    test "given a service registered on application's environment it returns an URI concatenated with host registered" do
      assert "http://0.0.0.0/custom/endpoint" ==
               ServiceUrl.build(:fake_service, "/custom/endpoint")
    end

    test "given a service not registered on application's environment it returns an URI concatenated with service as string as host" do
      assert "http://not_registered/custom/endpoint" ==
               ServiceUrl.build(:not_registered, "/custom/endpoint")
    end

    test "given a service without URI, returns the service registered" do
      assert "http://0.0.0.0" == ServiceUrl.build(:fake_service, "")
    end

    test "given a service without URI, returns the service as string as host" do
      assert "http://not_registered" == ServiceUrl.build(:not_registered, "")
    end

    test "given a service as string, returns the service as string as host" do
      assert "https://example.com" == ServiceUrl.build("https://example.com", "")
      assert "https://example.com/any" == ServiceUrl.build("https://example.com", "any")
    end
  end
end
