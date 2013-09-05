module DriverHelper 

 def text_found?(what,where)
   ttext = Regexp.new(what.force_encoding('UTF-8'))
   btext = where.delete("^\u{0000}-\u{007F}").force_encoding('UTF-8')
   btext.should =~ ttext
 end

 def _before() 
   @driver = Selenium::WebDriver.for :phantomjs
   #@base_url = "http://main7.test.library.cornell.edu/"
   @base_url = "http://main.test.library.cornell.edu/"
   @accept_next_alert = true
   @driver.manage.timeouts.implicit_wait = 30
   @verification_errors = []
 end

 def _after
    @driver.quit
    @verification_errors.should == []
 end


end
