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
    @id  = "searchBox"
    @driver.get(@base_url + "/")
    element_present?(:id, @id).should == true
    element_present?(:id, "course-help-form").should == true
    sbox = @driver.find_element(:id, "searchBox")
    sbox.send_keys "Shakespeare"
    sbox.submit
    @body_text = @driver.find_element(:css, "BODY").text
    text_found?("ENGL 1127", @body_text)
  end
  
  it "should have a link to 'course help' which shows a form to search course info and searches on class number" do
    @id  = "searchBox"
    @driver.get(@base_url + "/")
    element_present?(:id, @id).should == true
    element_present?(:id, "course-help-form").should == true
    sbox = @driver.find_element(:id, "searchBox")
    sbox.send_keys "ENGL 1105"
    sbox.submit
    @body_text = @driver.find_element(:css, "BODY").text
    text_found?("ENGL 1105: FWS:", @body_text)
  end

  it "should have a link to 'course help' which shows a form to search course info and searches on instructor" do
    @id  = "searchBox"
    @driver.get(@base_url + "/")
    element_present?(:id, @id).should == true
    element_present?(:id, "course-help-form").should == true
    sbox = @driver.find_element(:id, "searchBox")
    sbox.send_keys "Banerjee"
    sbox.submit
    @body_text = @driver.find_element(:css, "BODY").text
    text_found?("COML 3475:", @body_text)
  end

  it "should have a link to 'course help' which shows a form to search course info and searches on instructor who does not exist" do
    @id  = "searchBox"
    @driver.get(@base_url + "/")
    element_present?(:id, @id).should == true
    element_present?(:id, "course-help-form").should == true
    sbox = @driver.find_element(:id, "searchBox")
    sbox.send_keys "zzzBanerjee"
    sbox.submit
    @body_text = @driver.find_element(:css, "BODY").text
    text_found?("'zzzBanerjee'\nNo results found", @body_text)
  end
end
