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

  it "should link to About Us,which leads to the aboutus page, containing 'Welcome', and some images." do
      @link_text = "About Us"
      @page_text = "Welcome"
      @driver.get(@base_url + "/")
      images = @driver.find_elements(:tag_name => "img")
      broken_images = images.reject do |image|
        @driver.execute_script("return arguments[0].complete && typeof arguments[0].naturalWidth != \"undefined\" && arguments[0].naturalWidth > 0", image)
      end
      expect(broken_images.size).to eql(0), "Should have no broken images on home page"
      expect(element_present?(:link, @link_text)).to eql(true),"Should be a link to #{@link_text}"
      @driver.find_element(:link, @link_text).click
      text_found?(@page_text,@driver.find_element(:css, "BODY").text)
      images = @driver.find_elements(:tag_name => "img")
      broken_images = images.reject do |image|
        @driver.execute_script("return arguments[0].complete && typeof arguments[0].naturalWidth != \"undefined\" && arguments[0].naturalWidth > 0", image)
      end
      #expect(broken_images.size).to eql(0), "Should have no broken images on Aboutus page"
  end

end
