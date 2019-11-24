require 'fileutils'

namespace :protos do
  input_path  = './app/protos'
  output_path = './app/rpc/definitions'

  desc "Compile *.proto files in #{input_path}"
  task :compile do
    FileUtils.mkdir_p(output_path) unless File.exist?(output_path)

    Dir[File.join(input_path, '**', '*.proto')].each do |proto_path|
      puts "=> Compiling '#{proto_path}' to '#{output_path}'..."
      `bundle exec grpc_tools_ruby_protoc -I #{input_path} --ruby_out=#{output_path} --grpc_out=#{output_path} #{proto_path}`
    end
  end
end
