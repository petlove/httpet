defmodule HTTPet.ServiceUrlTest do
  use ExUnit.Case

  alias HTTPet.ServiceUrl

  describe "build/2" do
    test "given a service registered on application's environment it returns an URI concatenated with host registered" do
      #
    end

    test "given a service not registered on application's environment it returns an URI concatenated with service as string as host" do
      #
    end

    test "given a service without URI, returns the service registered" do
      #
    end

    test "given a service without URI, returns the service as string as host" do
      #
    end

    test "" do
      #
    end
  end
end
