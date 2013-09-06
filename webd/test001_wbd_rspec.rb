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

  it "should link to About Us,which leads to the aboutus page, containing 'Welcome', and some images." do
      @link_text = "About Us"
      @page_text = "Welcome"
      @driver.get(@base_url + "/")
      images = @driver.find_elements(:tag_name => "img")
      broken_images = images.reject do |image|
        @driver.execute_script("return arguments[0].complete && typeof arguments[0].naturalWidth != \"undefined\" && arguments[0].naturalWidth > 0", image)
      end
      broken_images.size.should eql(0) 
      element_present?(:link, @link_text).should == true
      @driver.find_element(:link, @link_text).click
      text_found?(@page_text,@driver.find_element(:css, "BODY").text)
      images = @driver.find_elements(:tag_name => "img")
      broken_images = images.reject do |image|
        @driver.execute_script("return arguments[0].complete && typeof arguments[0].naturalWidth != \"undefined\" && arguments[0].naturalWidth > 0", image)
      end
      broken_images.size.should eql(0) 
  end


  def element_present?(how, what)
    @driver.find_element(how, what)
    true
  rescue Selenium::WebDriver::Error::NoSuchElementError
    false
  end
  
  def alert_present?()
    @driver.switch_to.alert
    true
  rescue Selenium::WebDriver::Error::NoAlertPresentError
    false
  end
  
  def verify(&blk)
    yield
  rescue ExpectationNotMetError => ex
    @verification_errors << ex
  end
  
  def close_alert_and_get_its_text(how, what)
    alert = @driver.switch_to().alert()
    alert_text = alert.text
    if (@accept_next_alert) then
      alert.accept()
    else
      alert.dismiss()
    end
    alert_text
  ensure
    @accept_next_alert = true
  end
end
