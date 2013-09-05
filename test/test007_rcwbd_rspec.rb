#require "rubygems"
#gem "rspec"
#gem "selenium-client"
require "selenium/client"
#require "selenium/rspec/spec_helper"
#require "spec/test/unit"

describe "The website" do
  attr_reader :selenium_driver
  alias :page :selenium_driver

  before(:all) do
    @verification_errors = []
    @selenium_driver = Selenium::Client::Driver.new \
      :host => "localhost",
      :port => 4444,
      #:browser => "*chrome",
      :browser => "*firefox",
      :url => "http://main.test.library.cornell.edu/",
      :timeout_in_second => 60
  end

  before(:each) do
    @selenium_driver.start_new_browser_session
  end
  
  append_after(:each) do
    @selenium_driver.close_current_browser_session
    @verification_errors.should == []
  end
  
  it "should have a link to 'course help' which shows " do
    page.open "/"
    page.click "link=Course Help"
    page.wait_for_page_to_load "30000"
    page.is_text_present("Search Course Info and Reserves").should be_true
    page.is_element_present("identifier=course-help-form").should be_true
    page.type 'searchBox', 'Shakespeare'
    page.submit 'course-help-form'
    page.wait_for_page_to_load "30000"
    page.title.should eql("Course Help Search Result | Cornell University Library")
    page.is_text_present('COML 3480: Shakespeare and Europe').should be_true
  end
end
