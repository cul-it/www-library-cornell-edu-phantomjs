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

  it "should have a link to various pages which shows the at the top and bottom of page." do
    page_texts = [
     {"ptext"=>"Citation","pcount"=>2}, 
     #{"ptext"=>"Ask a Librarian","pcount"=>3}, # some prob with same value for firefox, and phantomjs
     {"ptext"=>"Current Awareness","pcount"=>2},
     {"ptext"=>"Introduction to Research","pcount"=>2}, 
     {"ptext"=>"Library Guides","pcount"=>1}, 
     {"ptext"=>"Research Consultation","pcount"=>2},
     {"ptext"=>"NEWS","pcount"=>0}, 
     {"ptext"=>"LIBESCOPE","pcount"=>0} ]
    @link_text = "Research"
    @driver.get(@base_url + "/")
    element_present?(:link, @link_text).should be_true,"expected to find '#{@link_text}' as link text and did not"
    @driver.find_element(:link, @link_text).click
    @body_text = @driver.find_element(:css, "BODY").text
    page_texts.each do |l|
      text_found?(l['ptext'], @body_text)
      links_present?( l['ptext'],l['pcount']).should be_true ,"expected #{l['pcount']} links for #{l['ptext']}, got #{links_present(l['ptext'])}"
    end
  end

  it "should have standard links, and they are duplicated in the footer" do
    @driver.get(@base_url + "/")
    @driver.manage.window.move_to(300, 400)
    @driver.manage.window.resize_to(1024, 600)
    #@driver.manage.window.maximize
    page_texts = [
     {"ptext"=>"Home","pcount"=>2}, 
     {"ptext"=>"Feedback","pcount"=>1}, 
     {"ptext"=>"About Us","pcount"=>2}, 
     {"ptext"=>"Research","pcount"=>6}, 
     {"ptext"=>"Libraries and Hours","pcount"=>1}, 
     {"ptext"=>"Courses","pcount"=>3}, 
     {"ptext"=>"Services","pcount"=>5}, 
     {"ptext"=>"Ask a Librarian","pcount"=>3}, 
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
    @driver.get(@base_url + "/")
    @driver.manage.window.move_to(300, 400)
    @driver.manage.window.resize_to(300, 400)
    #@driver.manage.window.maximize
    page_texts = [
     {"ptext"=>"Feedback","pcount"=>1},
     {"ptext"=>"Libraries","pcount"=>1},
     {"ptext"=>"Menu","pcount"=>1},
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
