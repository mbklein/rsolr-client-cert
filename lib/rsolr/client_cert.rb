require 'rsolr'
require "rsolr/client_cert/version"
require 'rsolr/client_cert/connection'

module RSolr
  module ClientCert

    def self.connect(opts)
      ssl_opts = {}
      opts.each_pair { |k,v| ssl_opts[k] = opts.delete(k) if k.to_s =~ /^ssl_/ }
      connection = Connection.new ssl_opts
      client_class = opts.delete(:client_class) || RSolr::Client
      client_class.new connection, opts
    end

  end
end
