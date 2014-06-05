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

  it "should have a link to 'Hours and Maps' which shows hours, and has a showOption Button" do
    @link_text = "Hours and Maps"
    @page_text = "Today's Hours"
    @driver.get(@base_url + "/")
    element_present?(:link, @link_text).should == true
    @driver.find_element(:link, @link_text).click
    @body_text = @driver.find_element(:css, "BODY").text
    text_found?(@page_text, @body_text)
    text_found?("Africana Library", @body_text)
    element_present?(:id, "showOption").should == true
  end
  
end
