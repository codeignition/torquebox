require 'spec_helper'
require 'base64'

describe "authentication" do

  deploy <<-END.gsub(/^ {4}/,'')
    ---
    application:
      RACK_ROOT: #{File.dirname(__FILE__)}/../apps/rack/basic_auth
      RACK_ENV: development
    web:
      context: /basic-auth
    
    ruby:
      version: #{RUBY_VERSION[0,3]}
  END

  it "should work for HTTP basic authentication" do
    if Capybara.current_driver == :browser
      pending "because browsers can't add request headers"
    else
      credentials = "bmcwhirt@redhat.com:swordfish";
      encoded_credentials = Base64.encode64(credentials).strip
      add_request_header('Authorization', "Basic #{encoded_credentials}")
      visit "/basic-auth"
      element = page.find("#auth_header")
      element.should_not be_nil
      element.text.should == "Basic #{encoded_credentials}"
    end
  end

end
