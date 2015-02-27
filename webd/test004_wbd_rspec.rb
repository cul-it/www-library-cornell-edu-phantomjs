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

  it "should have a link to 'My Account' which links to My Account entry page" do
    @link_text = "My Account"
    @page_text = "Login with your NetID or GuestID"
    @driver.get(@base_url + "/")
    element_present?(:partial_link_text, @link_text).should == true
    @driver.find_element(:partial_link_text, @link_text).click
    @body_text = @driver.find_element(:css, "BODY").text
    text_found?(@page_text, @body_text)
  end
  
  it "should have a link to 'My Account' which links to My Account page, which links to myacct" do
    @link_text = "My Account"
    @page_text = "Login with your NetID or GuestID"
    @driver.get(@base_url + "/")
    element_present?(:partial_link_text, @link_text).should == true
    @driver.find_element(:partial_link_text, @link_text).click
    @body_text = @driver.find_element(:css, "BODY").text
    text_found?(@page_text, @body_text)
    @link_text = "Login with your NetID or GuestID"
    element_present?(:partial_link_text, @link_text).should == true
    @driver.find_element(:partial_link_text, @link_text).click
    # Make sure we are on the login screen
    element_present?(:id, 'netid').should == true
    element_present?(:id, 'password').should == true
    element_present?(:name, 'Submit').should == true
    password = ENV['MYACC_PASSWORD'] 
    user = ENV['MYACC_USER'] 
    uname = ENV['MYACC_UNAME'] 
    user.should_not be_nil,"You should specify the MYACC_USER environment variable to test the MyAccount feature"
    password.should_not be_nil,"You should specify the MYACC_PASSWORD environment variable to test the MyAccount feature"
    uname.should_not be_nil,"You should specify the MYACC_UNAME (User full) name environment variable to test the MyAccount feature"
    uname.should_not eql(''),"You should specify the MYACC_UNAME (User full) name environment variable to test the MyAccount feature"
    @driver.find_element(:id, 'netid').send_keys user 
    @driver.find_element(:id, 'password').send_keys password 
    @driver.find_element(:name, 'Submit').click
    #@driver.save_screenshot("home_#{user}.png")
    @body_text = @driver.find_element(:css, "BODY").text
    text = @body_text
    text_found?(uname, text)
  end

  it "should have a link to 'My Account' which goes to myacctpage, and has a save all to cit manager" do
    @link_text = "My Account"
    @page_text = "Login with your NetID or GuestID"
    @driver.get(@base_url + "/")
    element_present?(:partial_link_text, @link_text).should == true
    @driver.find_element(:partial_link_text, @link_text).click
    @body_text = @driver.find_element(:css, "BODY").text
    text_found?(@page_text, @body_text)
    @link_text = "Login with your NetID or GuestID"
    element_present?(:partial_link_text, @link_text).should == true
    @driver.find_element(:partial_link_text, @link_text).click
    # Make sure we are on the login screen
    element_present?(:id, 'netid').should == true
    element_present?(:id, 'password').should == true
    element_present?(:name, 'Submit').should == true
    password = ENV['MYACC_PASSWORD'] 
    user = ENV['MYACC_USER'] 
    uname = ENV['MYACC_UNAME'] 
    user.should_not be_nil,"You should specify the MYACC_USER environment variable to test the MyAccount feature"
    password.should_not be_nil,"You should specify the MYACC_PASSWORD environment variable to test the MyAccount feature"
    uname.should_not be_nil,"You should specify the MYACC_UNAME (User full) name environment variable to test the MyAccount feature"
    uname.should_not eql(''),"You should specify the MYACC_UNAME (User full) name environment variable to test the MyAccount feature"
    @driver.find_element(:id, 'netid').send_keys user 
    @driver.find_element(:id, 'password').send_keys password 
    @driver.find_element(:name, 'Submit').click
    #@driver.save_screenshot("home_webauth_#{user}.png")
    @body_text = @driver.find_element(:css, "BODY").text
    text = @body_text
    text_found?(uname, text)
    @driver.find_element(:id, 'cbottona').click
    #@driver.save_screenshot("home_cbottona_#{user}.png")
    #print @driver.inspect
    #print @driver.browser.inspect
    #a = @driver.switch_to.alert
    #a.accept 
    @body_text = @driver.find_element(:css, "BODY").text
    text = @body_text
    #print text
    text_found?("RefWorks", text)
    refuser = ENV['REF_USER'] 
    refpword = ENV['REF_PASSWORD'] 
    refuser.should_not be_nil,"You should specify the REF_USER environment variable to test the Save to Refworks feature"
    refpword.should_not be_nil,"You should specify the REF_PASSWORD environment variable to test the Save to Refworks feature"
    @driver.find_element(:id, 'LoginName').send_keys refuser 
    @driver.find_element(:id, 'Password').send_keys refpword 
    @driver.find_element(:id, 'group-login-btn').click
    sleep(30)
    element_present?(:id,'bib_create').should == true
  end

  it "should have a link to 'My Account' which goes to myacctpage, and has a save checked to cit manager" do
    @link_text = "My Account"
    @page_text = "Login with your NetID or GuestID"
    @driver.get(@base_url + "/")
    element_present?(:partial_link_text, @link_text).should == true
    @driver.find_element(:partial_link_text, @link_text).click
    @body_text = @driver.find_element(:css, "BODY").text
    text_found?(@page_text, @body_text)
    @link_text = "Login with your NetID or GuestID"
    element_present?(:partial_link_text, @link_text).should == true
    @driver.find_element(:partial_link_text, @link_text).click
    # Make sure we are on the login screen
    element_present?(:id, 'netid').should == true
    element_present?(:id, 'password').should == true
    element_present?(:name, 'Submit').should == true
    password = ENV['MYACC_PASSWORD'] 
    user = ENV['MYACC_USER'] 
    uname = ENV['MYACC_UNAME'] 
    user.should_not be_nil,"You should specify the MYACC_USER environment variable to test the MyAccount feature"
    password.should_not be_nil,"You should specify the MYACC_PASSWORD environment variable to test the MyAccount feature"
    uname.should_not be_nil,"You should specify the MYACC_UNAME (User full) name environment variable to test the MyAccount feature"
    uname.should_not eql(''),"You should specify the MYACC_UNAME (User full) name environment variable to test the MyAccount feature"
    @driver.find_element(:id, 'netid').send_keys user 
    @driver.find_element(:id, 'password').send_keys password 
    @driver.find_element(:name, 'Submit').click
    #@driver.save_screenshot("home_webauth_#{user}.png")
    @driver.manage.window.resize_to(1024, 600) 
    @body_text = @driver.find_element(:css, "BODY").text
    text = @body_text
    text_found?(uname, text)
    print @driver.find_element(:css, "BODY").inspect
    element_present?(:class, "pa-item-title").should be_true, "title element should be present in my account listings"
    element_present?(:class, "pa-item-au").should be_true, "author element should be present in my account listings" 
    element_present?(:class, "pa-item-callno").should be_true, "callno element should be present in my account listings"

    a = @driver.find_element(:id,'item_0_renew')
    sleep 10
    a.click  
    b = @driver.find_element(:id,'item_1_renew')
    b.click  
    @driver.find_element(:id, 'cbotton').click
    #@driver.save_screenshot("home_cbottona_#{user}.png")
    #print @driver.inspect
    #print @driver.browser.inspect
    #if driver is firefox must explicitly make alert go away.
    if @driver.browser != :phantomjs 
      a = @driver.switch_to.alert
      a.accept 
    end
    @body_text = @driver.find_element(:css, "BODY").text
    text = @body_text
    #print text
    text_found?("RefWorks", text)
    refuser = ENV['REF_USER'] 
    refpword = ENV['REF_PASSWORD'] 
    refuser.should_not be_nil,"You should specify the REF_USER environment variable to test the Save to Refworks feature"
    refpword.should_not be_nil,"You should specify the REF_PASSWORD environment variable to test the Save to Refworks feature"
    @driver.find_element(:id, 'LoginName').send_keys refuser 
    @driver.find_element(:id, 'Password').send_keys refpword 
    @driver.find_element(:id, 'group-login-btn').click
    sleep(10)
    element_present?(:id,'bib_create').should == true
    @body_text = @driver.find_element(:css, "BODY").text
    last = @driver.find_element(:id, 'last_imported_widget').text
    text = last 
    #print last 
    #Very fragile
    text.start_with?('Last Imported').should  == true 
    #text.should  == "Last Imported(23)"
  end
end
