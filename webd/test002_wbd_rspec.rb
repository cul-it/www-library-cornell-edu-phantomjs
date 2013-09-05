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

  
  it "should have a link to 'Libraries', and that page should contain 'Inside the Library'" do
    @link_text = "Libraries"
    @page_text = "Inside the Library"
    @driver.get(@base_url + "/")
    element_present?(:link, @link_text).should == true
    @driver.find_element(:link, @link_text).click
    @body_text = @driver.find_element(:css, "BODY").text
    text_found?(@page_text, @body_text)
    text_found?("Africana Library", @body_text)
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
