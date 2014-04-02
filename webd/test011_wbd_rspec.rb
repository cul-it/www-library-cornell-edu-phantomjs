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

  it "should have a link to 'Library Services' which shows the various service related links." do
    page_texts = [
     {"ptext"=>"Borrowing and Delivery","pcount"=>1}, 
     {"ptext"=>"Computing and Equipment","pcount"=>1},
     {"ptext"=>"Cool Tools","pcount"=>1}, 
     {"ptext"=>"Disability Services","pcount"=>1}, 
     {"ptext"=>"Library Spaces","pcount"=>1},
     ]
    @link_text = "Library Services"
    @driver.get(@base_url + "/")
    element_present?(:link, @link_text).should be_true,"expected to find '#{@link_text}' as link text and did not"
    @driver.find_element(:link, @link_text).click
    @body_text = @driver.find_element(:css, "BODY").text
    page_texts.each do |l|
      text_found?(l['ptext'], @body_text)
      links_present?( l['ptext'],l['pcount']).should be_true ,"expected #{l['pcount']} links for #{l['ptext']}, got #{links_present(l['ptext'])}"
    end
  end
  if false
  it "should have a standard links, and they are duplicated in the footer" do
    @link_text = "Services"
    @driver.get(@base_url + "/")
    element_present?(:link, @link_text).should be_true,"expected to find '#{@link_text}' as link text and did not"
    @driver.find_element(:link, @link_text).click
    @driver.manage.window.move_to(300, 400)
    @driver.manage.window.resize_to(1024, 600)
    #@driver.manage.window.maximize
    page_texts = [
     {"ptext"=>"Home","pcount"=>4}, 
     {"ptext"=>"Feedback","pcount"=>1}, 
     {"ptext"=>"About Us","pcount"=>2}, 
     {"ptext"=>"Research","pcount"=>3}, 
     {"ptext"=>"Libraries","pcount"=>2}, 
     {"ptext"=>"Hours and Maps","pcount"=>2}, 
     {"ptext"=>"Courses","pcount"=>2}, 
     {"ptext"=>"Services","pcount"=>4}, 
     {"ptext"=>"Ask a Librarian","pcount"=>2}, 
     ]
    @driver.save_screenshot("home1024.png")
    element_present?(:class,'navbar-toggle').should be_true,"expected to find icon bar and did not"
    nb = @driver.find_element(:class,'navbar-toggle')
    nb.displayed?.should be_false ,"nav bar should NOT be visible"
    element_present?(:tag_name,'footer').should be_true,"expected to find footer and did not"
    @body_text = @driver.find_element(:css, "BODY").text
    page_texts.each do |l|
      text_found?(l['ptext'], @body_text).should be_true, "expected to find  #{l['ptext']} and did not"
      links_present?( l['ptext'],l['pcount']).should be_true ,"expected #{l['pcount']} links for #{l['ptext']}, got #{links_present(l['ptext'])}"
    end
  end

 it "should have standard links, when the size is like a mobile, and they are duplicated in the footer" do
    @link_text = "Services"
    @driver.get(@base_url + "/")
    element_present?(:link, @link_text).should be_true,"expected to find '#{@link_text}' as link text and did not"
    @driver.manage.window.move_to(300, 400)
    @driver.manage.window.resize_to(300, 400)
    #@driver.manage.window.maximize
    page_texts = [
     {"ptext"=>"Home","pcount"=>2},
     {"ptext"=>"Feedback","pcount"=>1},
     {"ptext"=>"About Us","pcount"=>1},
     {"ptext"=>"Research","pcount"=>5},
     {"ptext"=>"Libraries","pcount"=>1},
     {"ptext"=>"Hours and Maps","pcount"=>1},
     {"ptext"=>"Courses","pcount"=>2},
     {"ptext"=>"Services","pcount"=>4},
     {"ptext"=>"Ask a Librarian","pcount"=>2},
     ]
    @driver.save_screenshot("home300.png")
    element_present?(:class,'navbar-toggle').should be_true,"expected to find icon bar and did not"
    nb = @driver.find_element(:class,'navbar-toggle')
    nb.displayed?.should be_true,"nav bar should be visible"
    element_present?(:tag_name,'footer').should be_true,"expected to find footer and did not"
    @body_text = @driver.find_element(:css, "BODY").text
    page_texts.each do |l|
      text_found?(l['ptext'], @body_text).should be_true, "expected to find  #{l['ptext']} and did not"
      links_present?( l['ptext'],l['pcount']).should be_true ,"expected #{l['pcount']} links for #{l['ptext']}, got #{links_present(l['ptext'])}"
    end
  end
  end

  
  def links_present(t)
     @driver.find_elements(:partial_link_text, t).size 
    rescue Selenium::WebDriver::Error::NoSuchElementError
       0 
  end

  def links_present?(t, c)
     a = @driver.find_elements(:partial_link_text, t)

     @driver.find_elements(:partial_link_text, t).size ==  c  ?
        true
      : 
        false
    #rescue Selenium::WebDriver::Error::NoSuchElementError
    #    false
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
