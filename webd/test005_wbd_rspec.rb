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
    @link_text = "Help"
    @page_text = "Frequently Asked Questions"
    @driver.get(@base_url + "/")
    element_present?(:xpath,     "//section[@id = 'block-menu-block-2']/div/ul/li[2]/a").should == true
    hlink =  @driver.find_element(:xpath, "//section[@id = 'block-menu-block-2']/div/ul/li[2]/a").attribute("href")
    @driver.get(hlink)
    @body_text = @driver.find_element(:css, "BODY").text
    text_found?(@page_text, @body_text)
  end
  
end
