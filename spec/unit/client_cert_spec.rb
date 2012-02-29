require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')
require 'rsolr/client_cert'

describe RSolr::ClientCert do
  
  before :all do
    @fixture_dir = File.expand_path('../../fixtures',__FILE__)
    @cert_file = File.join(@fixture_dir,'certificate.crt')
    @key_pass = 'SuPeRseKrItPaSsWoRd!!11!'
  end
  
  it "should provide an SSL certificate connection with an RSA keyfile" do
    solr = RSolr::ClientCert.connect :url => 'https://example.edu/solr', :ssl_cert_file => @cert_file, 
      :ssl_key_file => File.join(@fixture_dir, 'rsa_key.key'), :ssl_key_pass => @key_pass
    solr.connection.ssl_client_cert.should be_a OpenSSL::X509::Certificate
    solr.connection.ssl_client_key.should be_a OpenSSL::PKey::RSA
  end
  
  it "should provide an SSL certificate connection with an RSA keyfile" do
    solr = RSolr::ClientCert.connect :url => 'https://example.edu/solr', :ssl_cert_file => @cert_file, 
      :ssl_key_file => File.join(@fixture_dir, 'dsa_key.key'), :ssl_key_pass => @key_pass
    solr.connection.ssl_client_cert.should be_a OpenSSL::X509::Certificate
    solr.connection.ssl_client_key.should be_a OpenSSL::PKey::DSA
  end
  
end