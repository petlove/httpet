defmodule HTTPet.RequestHeaders do
  def add_defaults(headers) do
    current_trace_id = unless is_nil(tracer()), do: tracer().current_trace_id
    current_span_id = unless is_nil(tracer()), do: tracer().current_span_id

    default_headers = %{
      "Content-Type" => "application/json",
      "x-datadog-trace-id" => current_trace_id,
      "x-datadog-parent-id" => current_span_id
    }

    Map.merge(
      default_headers,
      headers
    )
  end

  defp tracer do
    Application.get_env(:httpet, :tracer)
  end
end
