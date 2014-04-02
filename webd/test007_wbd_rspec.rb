require "selenium-webdriver"
require "rspec"
require_relative "helper"
include RSpec::Expectations

  @courses
describe "The website" do
  include DriverHelper

  before(:each) do
   _before
  end
  
  after(:each) do
    _after
  end

  it "should have a link to 'course help' which shows a form to search course info and searches on topic", :shakespeare => true  do
    @id  = "searchBox"
    @driver.get(@base_url + "/")
    element_present?(:id, @id).should == true
    element_present?(:id, "course-help-form").should == true
    sbox = @driver.find_element(:id, "searchBox")
    gbot = @driver.find_element(:id, "edit-submit")
    sbox.send_keys "Shakespeare"
    gbot.click
    @body_text = @driver.find_element(:css, "BODY").text
    text_found?("ENGL 3475", @body_text)
  end
  
  it "should have a link to 'course help' which shows a form to search course info and searches on class number", :engl_1105 =>true do
    @id  = "searchBox"
    @driver.get(@base_url + "/")
    element_present?(:id, @id).should == true
    element_present?(:id, "course-help-form").should == true
    sbox = @driver.find_element(:id, "searchBox")
    gbot = @driver.find_element(:id, "edit-submit")
    sbox.send_keys "ENGL 1105"
    #sbox.submit
    gbot.click
    @body_text = @driver.find_element(:css, "BODY").text
    text_found?("ENGL 1105: FWS:", @body_text)
  end

  it "should have a link to 'course help' which shows a form to search course info and searches on instructor" do
    @id  = "searchBox"
    @driver.get(@base_url + "/")
    element_present?(:id, @id).should == true
    element_present?(:id, "course-help-form").should == true
    sbox = @driver.find_element(:id, "searchBox")
    gbot = @driver.find_element(:id, "edit-submit")
    sbox.send_keys "Banerjee"
    #sbox.submit
    gbot.click
    @body_text = @driver.find_element(:css, "BODY").text
    text_found?("COML 3475:", @body_text)
  end

  it "should have a link to 'course help' which shows a form to search course info and searches on instructor who does not exist" do
    @id  = "searchBox"
    @driver.get(@base_url + "/")
    element_present?(:id, @id).should == true
    element_present?(:id, "course-help-form").should == true
    sbox = @driver.find_element(:id, "searchBox")
    gbot = @driver.find_element(:id, "edit-submit")
    sbox.send_keys "zzzBanerjee"
    #sbox.submit
    gbot.click
    @body_text = @driver.find_element(:css, "BODY").text
    text_found?("'zzzBanerjee' not found", @body_text)
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
