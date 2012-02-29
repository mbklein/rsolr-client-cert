require 'rsolr'
require "rsolr/client_cert/version"
require 'rsolr/client_cert/connection'

module RSolr
  module ClientCert

    def self.connect(opts)
      grouped_opts = opts.group_by { |k,v| k.to_s =~ /^ssl_/ ? :ssl : :solr }
      solr_opts = Hash[grouped_opts[:solr]]
      ssl_opts = Hash[grouped_opts[:ssl]]
      connection = Connection.new ssl_opts
      client_class = opts.delete(:client_class) || RSolr::Client
      client_class.new connection, solr_opts
    end

  end
end
