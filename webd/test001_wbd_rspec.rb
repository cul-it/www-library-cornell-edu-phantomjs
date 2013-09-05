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
  
  it "should have a home page, and link to 'About Us',which leads to the aboutus page" do
    verify {
    @driver.get(@base_url + "/")
    @driver.find_element(:link, "About Us")
    @driver.find_element(:link, "About Us").click
    }
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
