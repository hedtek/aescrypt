require 'tmpdir'
require 'securerandom'
require 'tempfile'
require 'zip'

module Aescrypt
  class Wrapper
    def encrypt_file(file, password: nil)
      execute(file: file, password: password)
    end

    def encrypt_files(files, password: nil, file_prefix: nil)
      zip_file = Dir.tmpdir + "/#{SecureRandom.uuid}.zip"
      Zip::File.open(zip_file, Zip::File::CREATE) do |zipfile|
        files.each do |filename|
          if file_prefix
            zipfile.add(File.basename(filename), "#{file_prefix}/#{filename}")
          else
            zipfile.add(File.basename(filename), filename)
          end
        end
      end

      execute(file: zip_file, password: password)
    ensure
      File.delete(zip_file)
    end

    def encrypt_string(data, password: nil)
      temp_file = Tempfile.new('encrypted_string')
      temp_file.write(data)
      temp_file.close
      execute(file: temp_file.path, password: password)
    ensure
      temp_file.unlink
    end

    private

    def bundled_binary
      File.dirname(__FILE__) + "/../bin/aescrypt"
    end

    def environment
      {"PATH" => File.dirname(__FILE__) + "/../bin"}
    end

    def execute(options = {})
      out_file = options[:out_file] || Dir.tmpdir + "/#{SecureRandom.uuid}.aes"
      if options[:password].nil? || options[:password].strip == ""
        password = SecureRandom.base64
      else
        password = options[:password]
      end

      input_file = options[:file]
      system(environment, bundled_binary, "-e", "-p", password, "-o", out_file, input_file)
      {
        password: password,
        file: out_file
      }
    end
  end
end
