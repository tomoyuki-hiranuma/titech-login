require 'selenium-webdriver'
require File.dirname(__FILE__) + '/loginInfo'

class TitechWeb
  LOGIN_URL = "https://portal.titech.ac.jp/"
  
  def initialize(open_time)
    @open_time = open_time
  end

  def login
    begin
      driver = Selenium::WebDriver.for :chrome
      driver.get LOGIN_URL
      login_info = LoginInfo.new()

      driver.find_element(:xpath, '//*[@id="portal-form"]/form[2]/input').click
      sleep 1

      driver.find_element(:name, 'usr_name').send_keys login_info.username
      driver.find_element(:name, 'usr_password').send_keys login_info.password
      driver.find_element(:name, 'OK').click

      sleep 2

      el_pass1 = driver.find_element(:xpath, '//*[@id="authentication"]/tbody/tr[4]/th[1]').text
      el_pass2 = driver.find_element(:xpath, '//*[@id="authentication"]/tbody/tr[5]/th[1]').text
      el_pass3 = driver.find_element(:xpath, '//*[@id="authentication"]/tbody/tr[6]/th[1]').text

      input_pass1 = driver.find_element(:name, 'message3')
      input_pass1.send_keys login_info.matrix[el_pass1[1]][0][el_pass1[3].to_i]

      input_pass2 = driver.find_element(:name, 'message4')
      input_pass2.send_keys login_info.matrix[el_pass2[1]][0][el_pass2[3].to_i]

      input_pass3 = driver.find_element(:name, 'message5')
      input_pass3.send_keys login_info.matrix[el_pass3[1]][0][el_pass3[3].to_i]

      sleep 2

      driver.find_element(:name, 'OK').click

      # sleep 1
    ensure

      sleep @open_time
    end
  end
end


if __FILE__ == $0
  titech = TitechWeb.new(ARGV[0].to_i)
  titech.login()
end

