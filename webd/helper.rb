module DriverHelper 

 def text_found?(what,where)
   ttext = Regexp.new(what.force_encoding('UTF-8'))
   btext = where.delete("^\u{0000}-\u{007F}").force_encoding('UTF-8')
   btext.should =~ ttext
 end
def links_present(t)
     @driver.find_elements(:partial_link_text, t).size
    rescue Selenium::WebDriver::Error::NoSuchElementError
       0
  end

  def links_present?(t, c)
     a = @driver.find_elements(:partial_link_text, t)

     @driver.find_elements(:partial_link_text, t).size >=  c  ?
        true
      :
        false
    #rescue Selenium::WebDriver::Error::NoSuchElementError
    #    false
  end

 def _before() 
   #@driver = Selenium::WebDriver.for :firefox
   @driver = Selenium::WebDriver.for :phantomjs 
  @default_base_url = 'http://beta.library.cornell.edu' 
   @base_url = ENV::has_key?('BASE_URL') ? ENV['BASE_URL']  : @default_base_url 
   @accept_next_alert = true
   @driver.manage.timeouts.implicit_wait = 30
   @verification_errors = []
 end

 def _after
    @driver.quit
    @verification_errors.should == []
 end


end
