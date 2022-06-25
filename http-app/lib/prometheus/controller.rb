module Prometheus
  module Controller
    # Create a Prometheus registry for our metrics.
    prometheus = Prometheus::Client.registry

    # Create a simple gauge metric for dubai temperature
    GAUGE_TEMP = Prometheus::Client::Gauge.new(
      :dubai_temperature,
      docstring: 'A guage for Dubai current temperature'
    )

    # Register the metric with the registry
    prometheus.register(GAUGE_TEMP)
  end
end
