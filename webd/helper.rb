module DriverHelper 

 def text_found?(what,where)
   ttext = Regexp.new(what.force_encoding('UTF-8'))
   btext = where.delete("^\u{0000}-\u{007F}").force_encoding('UTF-8')
   btext.should =~ ttext
 end

 def _before() 
   @default_driver = :phantomjs 
   @drivervalue = ENV::has_key?('DRIVER') ? ENV['DRIVER'].to_sym  : @default_driver 
   @driver = Selenium::WebDriver.for @drivervalue 
   #@driver = Selenium::WebDriver.for :phantomjs 
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
