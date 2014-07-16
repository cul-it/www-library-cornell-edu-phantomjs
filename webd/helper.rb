module DriverHelper 

 def text_found?(what,where)
   ttext = Regexp.new(what.dup.force_encoding('UTF-8'))
   btext = where.delete("^\u{0000}-\u{007F}").force_encoding('UTF-8')
   expect(btext).to  match (ttext)
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
 
 def _before() 
   #@driver = Selenium::WebDriver.for :firefox
   @driver = Selenium::WebDriver.for :phantomjs 
  @default_base_url = 'https://www.library.cornell.edu' 
   @base_url = ENV::has_key?('BASE_URL') ? ENV['BASE_URL']  : @default_base_url 
   @accept_next_alert = true
   @driver.manage.timeouts.implicit_wait = 2 
   @verification_errors = []
   @driver.manage.window.resize_to(1024, 600)
 end

 def _after
    @driver.quit
    @verification_errors.should == []
 end


end
