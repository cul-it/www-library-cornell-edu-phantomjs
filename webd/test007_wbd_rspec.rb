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

  it "should have a link to 'course help' which shows a form to search course info and searches on topic" do
    @link_text = "Course Help"
    @page_text = "Search Course Info and Reserves"
    @driver.get(@base_url + "/")
    element_present?(:link, @link_text).should == true
    @driver.find_element(:link, @link_text).click
    @body_text = @driver.find_element(:css, "BODY").text
    text_found?(@page_text, @body_text)

    element_present?(:id, "course-help-form").should == true
    sbox = @driver.find_element(:id, "searchBox")
    sbox.send_keys "Shakespeare"
    sbox.submit
    element_present?(:id, "edit-submit").should == true
    gobut = @driver.find_element(:id, "edit-submit")
    gobut.submit
    @body_text = @driver.find_element(:css, "BODY").text
    text_found?("ENGL 1127", @body_text)
  end
  
  it "should have a link to 'course help' which shows a form to search course info and searches on class number" do
    @link_text = "Course Help"
    @page_text = "Search Course Info and Reserves"
    @driver.get(@base_url + "/")
    element_present?(:link, @link_text).should == true
    @driver.find_element(:link, @link_text).click
    @body_text = @driver.find_element(:css, "BODY").text
    text_found?(@page_text, @body_text)

    element_present?(:id, "course-help-form").should == true
    sbox = @driver.find_element(:id, "searchBox")
    sbox.send_keys "ENGL 1105"
    sbox.submit
    element_present?(:id, "edit-submit").should == true
    gobut = @driver.find_element(:id, "edit-submit")
    gobut.submit
    @body_text = @driver.find_element(:css, "BODY").text
    text_found?("ENGL 1105: FWS:", @body_text)
  end
  it "should have a link to 'course help' which shows a form to search course info and searches on instructor" do
    @link_text = "Course Help"
    @page_text = "Search Course Info and Reserves"
    @driver.get(@base_url + "/")
    element_present?(:link, @link_text).should == true
    @driver.find_element(:link, @link_text).click
    @body_text = @driver.find_element(:css, "BODY").text
    text_found?(@page_text, @body_text)

    element_present?(:id, "course-help-form").should == true
    sbox = @driver.find_element(:id, "searchBox")
    sbox.send_keys "Correll"
    sbox.submit
    element_present?(:id, "edit-submit").should == true
    gobut = @driver.find_element(:id, "edit-submit")
    gobut.submit
    @body_text = @driver.find_element(:css, "BODY").text
    text_found?("PMA 2670:", @body_text)
  end

  it "should have a link to 'course help' which shows a form to search course info and searches on instructor who does not exist" do
    @link_text = "Course Help"
    @page_text = "Search Course Info and Reserves"
    @driver.get(@base_url + "/")
    element_present?(:link, @link_text).should == true
    @driver.find_element(:link, @link_text).click
    @body_text = @driver.find_element(:css, "BODY").text
    text_found?(@page_text, @body_text)

    element_present?(:id, "course-help-form").should == true
    sbox = @driver.find_element(:id, "searchBox")
    sbox.send_keys "zzzCorrell"
    sbox.submit
    element_present?(:id, "edit-submit").should == true
    gobut = @driver.find_element(:id, "edit-submit")
    gobut.submit
    @body_text = @driver.find_element(:css, "BODY").text
    text_found?("'zzzCorrell' not found", @body_text)
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
