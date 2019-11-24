require 'bookmarks_services_pb'

Gruf.configure do |config|
  config.server_binding_url = "#{ENV.fetch('GRPC_SERVER_HOST', '0.0.0.0')}:#{ENV.fetch('PORT', 9001)}"

  config.backtrace_on_error    = !Rails.env.production?
  config.use_exception_message = !Rails.env.production?

  unless Rails.env.production?
    config.logger = Logger.new(STDOUT)
    config.grpc_logger = Logger.new(STDOUT)
  end

  config.interceptors.use(
    Gruf::Interceptors::Instrumentation::RequestLogging::Interceptor,
    formatter: :plain,
    log_parameters: true
  )
end
