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

  it "should link to 'Borrow, Request, Renew, Return' which shows the text 'Borrow, Request, Renew, Return'" do
    @link_text = 'Borrow, Request, Renew, Return'
    @page_text = 'Borrow, Request, Renew, Return'
    @driver.get(@base_url + "/")
    element_present?(:partial_link_text, @link_text).should == true
    @driver.find_element(:partial_link_text, @link_text).click
    @body_text = @driver.find_element(:css, "BODY").text
    text_found?(@page_text, @body_text)
  end

  it "should link to 'Requests' which shows the text 'Borrowing and Delivery', and links to Faculty and Staff page." do
    @link_text = 'Borrow, Request, Renew, Return'
    @page_text = 'Borrow, Request, Renew, Return'
    @driver.get(@base_url + "/")
    element_present?(:partial_link_text, @link_text).should == true
    @driver.find_element(:partial_link_text, @link_text).click
    @body_text = @driver.find_element(:css, "BODY").text
    text_found?(@page_text, @body_text)
    @link_text = 'Faculty'
    @page_text = 'Cornell Faculty'
    element_present?(:partial_link_text, @link_text).should == true
    @driver.find_element(:partial_link_text, @link_text).click
    @body_text = @driver.find_element(:css, "BODY").text
    text_found?(@page_text, @body_text)
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
