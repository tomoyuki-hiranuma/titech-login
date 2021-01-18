require 'selenium-webdriver'
require File.dirname(__FILE__) + '/loginInfo'

class TitechWeb
  LOGIN_URL = "https://portal.nap.gsic.titech.ac.jp/GetAccess/Login?Template=userpass_key&AUTHMETHOD=UserPassword"
  def login
    begin
      driver = Selenium::WebDriver.for :chrome
      driver.get LOGIN_URL
      login_info = LoginInfo.new()
      element_username = driver.find_element(:name, 'usr_name')
      element_username.send_keys login_info.username
      element_password = driver.find_element(:name, 'usr_password')
      element_password.send_keys login_info.password
      element_ok = driver.find_element(:name, 'OK')
      element_ok.click

      sleep 2

      el_pass1 = driver.find_element(:xpath, '//*[@id="authentication"]/tbody/tr[4]/th[1]').text
      el_pass2 = driver.find_element(:xpath, '//*[@id="authentication"]/tbody/tr[5]/th[1]').text
      el_pass3 = driver.find_element(:xpath, '//*[@id="authentication"]/tbody/tr[6]/th[1]').text
      input_pass1 = driver.find_element(:name, 'message3')
      input_pass1.send_keys login_info.matrix[el_pass1[1]][el_pass1[3]]
      input_pass2 = driver.find_element(:name, 'message4')
      input_pass2.send_keys login_info.matrix[el_pass2[1]][el_pass1[3]]
      input_pass3 = driver.find_element(:name, 'message5')
      input_pass3.send_keys login_info.matrix[el_pass3[1]][el_pass3[3]]
      element_login = driver.find_element(:name, 'OK')
      element_login.click
    ensure
      os.kill(driver.service.process.pid, signal.SIGTERM)
    end
  end
end


if __FILE__ == $0
  titech = TitechWeb.new()
  # titech.login()
  login_info = LoginInfo.new()
  print(login_info.matrix[:"A"])
end

