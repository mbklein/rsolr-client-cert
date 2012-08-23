require 'openssl'

module RSolr
  module ClientCert
    class Error < Exception; end
      
    class Connection
      attr_reader :ssl_client_cert, :ssl_client_key
      
      def initialize opts = {}
        @ssl_client_cert = extract_client_cert(opts)
        @ssl_client_key = extract_client_key(opts)
      end
      
      def execute client, request_context
        old_proxy = RestClient.proxy
        begin
          RestClient.proxy = request_context[:proxy]
          resource = RestClient::Resource.new(
            request_context[:uri].to_s,
            :open_timeout     =>  request_context[:open_timeout],
            :timeout          =>  request_context[:read_timeout],
            :ssl_client_cert  =>  ssl_client_cert,
            :ssl_client_key   =>  ssl_client_key
          )
          result = {}
          signature = [request_context[:method], request_context[:data], request_context[:headers]].compact
          resource.send(*signature) { |response, request, http_result, &block|
            result = {
              :status => response.net_http_res.code.to_i,
              :headers => response.net_http_res.to_hash,
              :body => response.net_http_res.body
            }
          }
          result
        ensure
          RestClient.proxy = old_proxy
        end
      end
      
      protected
      
      def extract_key_class(key_text)
        if key_text =~ /BEGIN (.+) PRIVATE KEY/
          OpenSSL::PKey.const_get($1.to_sym)
        else
          raise Error, "Cannot determine key type"
        end
      end
    
      def extract_client_key(opts)
        if opts[:ssl_client_key]
          opts[:ssl_client_key]
        elsif opts[:ssl_key_file]
          key_text = File.read(opts[:ssl_key_file])
          key_class = extract_key_class(key_text)
          key_class.new(key_text, opts[:ssl_key_pass].to_s)
        else
          raise Error, "No :ssl_client_key or :ssl_key_file provided"
        end
      end
    
      def extract_client_cert(opts)
        if opts[:ssl_client_cert]
          opts[:ssl_client_cert]
        elsif opts[:ssl_cert_file]
          OpenSSL::X509::Certificate.new(File.read(opts[:ssl_cert_file]))
        else
          raise Error, "No :ssl_client_key or :ssl_key_file provided"
        end
      end
    end
  end
end
