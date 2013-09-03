#require "rubygems"
#gem "rspec"
#gem "selenium-client"
require "selenium/client"
#require "selenium/rspec/spec_helper"
#require "spec/test/unit"

describe "test001" do
  attr_reader :selenium_driver
  alias :page :selenium_driver

  before(:all) do
    @verification_errors = []
    @selenium_driver = Selenium::Client::Driver.new \
      :host => "localhost",
      :port => 4444,
      :browser => "*chrome",
      :url => "http://www.library.cornell.edu/",
      :timeout_in_second => 60
  end

  before(:each) do
    @selenium_driver.start_new_browser_session
  end
  
  append_after(:each) do
    @selenium_driver.close_current_browser_session
    @verification_errors.should == []
  end
  
  it "test_test001" do
    page.open "/"
    page.click "link=About Us"
    page.wait_for_page_to_load "30000"
  end
end
