# rsolr-client-cert [![Build Status](https://secure.travis-ci.org/mbklein/rsolr-client-cert.png)](http://travis-ci.org/mbklein/rsolr-client-cert)

<b>rsolr-client-cert</b> provides client certificate authentication for [RSolr](https://github.com/mwmitchell/rsolr).

## Installation

    gem install rsolr-client-cert
    
## Usage

    require 'rubygems'
    require 'rsolr/client_cert'
    
    client = RSolr::ClientCert.connect :url => 'http://solrserver.com', :ssl_cert_file => '/path/to/certificate.crt', 
      :ssl_key_file => '/path/to/keyfile.key', :ssl_key_pass => 'SuPeRseKrItPaSsWoRd!!11!'

Or, to create the certificate/key objects manually:

    @my_cert = OpenSSL::X509::Certificate.new(cert_pem)
    @my_key = OpenSSL::PKey::RSA.new(key_pem, key_pass)
    client = RSolr::ClientCert.connect :url => 'http://solrserver.com', :ssl_client_cert => @my_cert, 
      :ssl_client_key => @my_key

Any options that don't start with `:ssl_` will be passed through to `RSolr::Client`. See the 
[RSolr README](https://github.com/mwmitchell/rsolr/blob/master/README.rdoc) for additional valid
options.

## Contributing

* Fork the project.
* Make your feature addition or bug fix.
* Add tests for it. This is important so I don't break it in a future version unintentionally.
* Commit. Please do not mess with rakefile, version, or history. If you want to have your own version, 
  that is fine but bump version in a commit by itself I can ignore when I pull.
* Send me a pull request. Bonus points for topic branches.

## Version History

- <b>0.5.0</b> Initial release
- <b>0.5.1</b> Add additional HTTP method support, as well as all RSolr request_context parameters
- <b>0.5.2</b> Fix block scoping issue under Ruby 1.9.x