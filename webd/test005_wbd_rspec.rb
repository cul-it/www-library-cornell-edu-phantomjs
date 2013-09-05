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

  
  it "should have a link to 'Help' which shows text 'Frequently Asked Questions'" do
    verify {
    @driver.get(@base_url + "/")
    @driver.find_element(:link, "Help").click
    # Warning: assertTextPresent may require manual changes
    #@driver.find_element(:css, "BODY").text.should =~ /^[\s\S]*Welcome[\s\S]*$/
    #@driver.find_element(:css, "BODY").text.should =~ welcome 
    # make sure regular exp char set, and body char set match
    ttext = Regexp.new("Frequently Asked Questions".force_encoding('UTF-8'))
    btext = @driver.find_element(:css, "BODY").text.delete!("^\u{0000}-\u{007F}").force_encoding('UTF-8')
    btext.should =~ ttext 
    }
    #@driver.find_element(:css, "BODY").text.should =~ welcome 
    #element_present?(:id, "showOption").should == true
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
