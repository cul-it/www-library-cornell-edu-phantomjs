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
    @link_text = "Login"
    element_present?(:partial_link_text, @link_text).should == true
    @driver.find_element(:partial_link_text, @link_text).click
    # Make sure we are on the login screen
    element_present?(:id, 'netid').should == true
    element_present?(:id, 'password').should == true
    element_present?(:name, 'Submit').should == true
    @driver.find_element(:id, 'netid').send_keys 'es287'
    @driver.find_element(:id, 'password').send_keys 'Hunyb3@r'
    @driver.find_element(:name, 'Submit').click
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
