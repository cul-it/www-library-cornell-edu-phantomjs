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

  it "should have a link to 'My Account' which shows your patron info" do
    @link_text = "My Account"
    @page_text = "Renew your books"
    @driver.get(@base_url + "/")
    expect(element_present?(:link, @link_text)).to  eql(true)
    @driver.find_element(:link, @link_text).click
    @body_text = @driver.find_element(:css, "BODY").text
    text_found?(@page_text, @body_text)

    @link_text = "Login"
    expect(element_present?(:link, @link_text)).to  eql(true)
    @driver.find_element(:link, @link_text).click

    element_present?(:name, "login").should == true
    sbox = @driver.find_element(:id, "netid")
    sbox.send_keys "your netid"
    sbox = @driver.find_element(:id, "password")
    sbox.send_keys "your password"
    sbox = @driver.find_element(:id, "realm")
    option = sbox.find_elements(:tag_name => "option").find { |o| o.text == "NetID" }
    raise "could not find the right option" if option.nil?
    option.click 
    element_present?(:name, "Submit").should == true
    gobut = @driver.find_element(:name, "Submit")
    gobut.submit
    @body_text = @driver.find_element(:css, "BODY").text
    text_found?("Your name", @body_text)
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
