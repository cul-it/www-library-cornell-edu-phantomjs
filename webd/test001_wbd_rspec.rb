require "selenium-webdriver"
require "rspec"
include RSpec::Expectations
require_relative "helper"


describe "The website" do

  include DriverHelper

  before(:each) do
   _before
  end
  
  after(:each) do
    _after
  end

  it "should link to About Us,which leads to the aboutus page, containing 'Welcome'" do
      @link_text = "About Us"
      @page_text = "Welcome"
      @driver.get(@base_url + "/")
      element_present?(:link, @link_text).should == true
      @driver.find_element(:link, @link_text).click
      text_found?(@page_text,@driver.find_element(:css, "BODY").text)
  end

end
