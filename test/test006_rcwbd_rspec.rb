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
  
  it "should have a link to 'Ask a Librarian' which shows the text: " do
    page.open "/"
    page.click "link=Ask a Librarian"
    page.wait_for_page_to_load "30000"
    page.is_text_present("Visit Us").should be_true
    page.is_element_present("identifier=node-6").should be_true
  end
end
