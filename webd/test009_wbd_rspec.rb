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

  it "should link to 'Borrow, Renew, Return' which shows the text 'Borrow, Request, Renew, Return'" do
    @link_text = 'Borrow, Renew, Return'
    @page_text = 'Borrow, Renew, Return'
    @driver.get(@base_url + "/")
    element_present?(:partial_link_text, @link_text).should == true
    @driver.find_element(:partial_link_text, @link_text).click
    @body_text = @driver.find_element(:css, "BODY").text
    text_found?(@page_text, @body_text)
  end

  it "should link to 'Requests' which shows the text 'Borrowing and Delivery', and links to Faculty and Staff page." do
    @link_text = 'Borrow, Renew, Return'
    @page_text = 'Borrow, Renew, Return'
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

end
