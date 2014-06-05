require "selenium-webdriver"
require "rspec"
require_relative "helper"
include RSpec::Expectations

describe "The website" do
  include DriverHelper

  before(:each) do
   _before
  end
  
  after(:each) do
    _after
  end

  
  it "should have a link to 'My Account' which links to My Account entry page" do
    @link_text = "My Account"
    @page_text = "Renew your books"
    @driver.get(@base_url + "/")
    element_present?(:link, @link_text).should == true
    @driver.find_element(:link, @link_text).click
    @body_text = @driver.find_element(:css, "BODY").text
    text_found?(@page_text, @body_text)
  end
  
  it "should have a link to 'My Account' which links to My Account page, which links to myacct" do
    @link_text = "My Account"
    @page_text = "Renew your books"
    @driver.get(@base_url + "/")
    element_present?(:link, @link_text).should == true
    @driver.find_element(:link, @link_text).click
    @body_text = @driver.find_element(:css, "BODY").text
    text_found?(@page_text, @body_text)
    @link_text = "Login with your NetID or GuestID"
    element_present?(:partial_link_text, @link_text).should == true
    @driver.find_element(:partial_link_text, @link_text).click
    # Make sure we are on the login screen
    element_present?(:id, 'netid').should == true
    element_present?(:id, 'password').should == true
    element_present?(:name, 'Submit').should == true
    password = ENV['PASSWORD'] 
    user = ENV['USER'] 
    uname = ENV['UNAME'] 
    user.should_not be_nil,"You should specify the USER environment variable to test the MyAccount feature"
    password.should_not be_nil,"You should specify the PASSWORD environment variable to test the MyAccount feature"
    uname.should_not be_nil,"You should specify the UNAME (User full) name environment variable to test the MyAccount feature"
    uname.should_not eql(''),"You should specify the UNAME (User full) name environment variable to test the MyAccount feature"
    @driver.find_element(:id, 'netid').send_keys user 
    @driver.find_element(:id, 'password').send_keys password 
    @driver.find_element(:name, 'Submit').click
    #@driver.save_screenshot("home_#{user}.png")
    @body_text = @driver.find_element(:css, "BODY").text
    text = @body_text
    text_found?(uname, text)
  end
end
