import time
from selenium import webdriver
from selenium.webdriver.chrome.options import Options
import pandas as pd

def line_prepender(filename, line):
    with open(filename, 'r+') as f:
        content = f.read()
        f.seek(0, 0)
        f.write(line.rstrip('\r\n') + '\n' + content)

chrome_options = Options()
chrome_options.add_argument("--disable-extensions")
chrome_options.add_argument("--disable-gpu")
chrome_options.add_argument("--no-sandbox") # linux only
chrome_options.add_argument("--headless")
driver = webdriver.Chrome(options=chrome_options)

m_email = '###########'
m_pass = '###############'
driver.get("https://zzap.ru/user/logon.aspx")
#print("on website")
time.sleep(20)
email_in = driver.find_element_by_xpath('//*[@id="ctl00_BodyPlace_LogonFormCallbackPanel_LogonFormLayout_AddrEmail1TextBox_I"]')
email_in.send_keys(m_email)
pass_in = driver.find_element_by_xpath('//*[@id="ctl00_BodyPlace_LogonFormCallbackPanel_LogonFormLayout_PasswordTextBox_I"]')
pass_in.send_keys(m_pass)
print('credentials in')
time.sleep(1)
butt_in = driver.find_element_by_xpath('//*[@id="ctl00_BodyPlace_LogonFormCallbackPanel_LogonFormLayout_LogonButton"]')
butt_in.click()
print("logged in")
time.sleep(1)
driver.get('https://zzap.ru/user/templates.aspx')
time.sleep(3)
link = driver.find_element_by_xpath('/html/body/center/form/div[4]/div[2]/table/tbody/tr/td/div[2]/div/table/tbody/tr[2]/td[5]/table/tbody/tr[2]/td[2]/a').get_attribute('href')
print(link)
df = pd.read_excel("./ready.xlsx")
df.to_csv("./ready.csv", sep=",")
line_prepender('ready.csv', 'id,manufacturer,SKU,name,amount,price,useless,useless,useless,desc,useless,useless,useless,useless,useless,not a scam,useless,useless,guarantees')

m_email = 'MorfJesus'
m_pass = '##############'
driver.get('http://34.90.64.141/wp/wordpress/wp-admin/')
email_in = driver.find_element_by_xpath('//*[@id="user_login"]')
email_in.send_keys(m_email)
pass_in = driver.find_element_by_xpath('//*[@id="user_pass"]')
pass_in.send_keys(m_pass)
time.sleep(1)
butt_in = driver.find_element_by_xpath('//*[@id="wp-submit"]')
butt_in.click()
driver.get('http://34.90.64.141/wp/wordpress/wp-admin/edit.php?post_type=product&page=product_importer')
driver.find_element_by_xpath('//*[@id="wpbody-content"]/div[4]/div/form/div/a').click() #go to advanced settings
time.sleep(1)
driver.find_element_by_xpath('//*[@id="woocommerce-importer-file-url"]').send_keys('wp-content/uploads/2020/03/lol-4.csv') #path to file (preferably not hardcode but w/e)
driver.find_element_by_xpath('//*[@id="woocommerce-importer-update-existing"]').click() #only update
driver.find_element_by_xpath('//*[@id="woocommerce-importer-map-preferences"]').click() #use previous settings
driver.find_element_by_xpath('//*[@id="wpbody-content"]/div[4]/div/form/div/button').click() #go to next page
time.sleep(1)
driver.find_element_by_xpath('//*[@id="wpbody-content"]/div[4]/div/form/div/button').click() #start importing

while not(driver.find_elements_by_xpath('//*[@id="wpbody-content"]/div[4]/div/div/div/a')):
	time.sleep(5)

driver.get('http://34.90.64.141/wp/wordpress/wp-admin/edit.php?post_type=product&page=product_importer')
driver.find_element_by_xpath('//*[@id="wpbody-content"]/div[4]/div/form/div/a').click() #go to advanced settings
time.sleep(1)
driver.find_element_by_xpath('//*[@id="woocommerce-importer-file-url"]').send_keys('wp-content/uploads/2020/03/lol-4.csv') #path to file (preferably not hardcode but w/e)
driver.find_element_by_xpath('//*[@id="woocommerce-importer-map-preferences"]').click() #use previous settings
driver.find_element_by_xpath('//*[@id="wpbody-content"]/div[4]/div/form/div/button').click() #go to next page
time.sleep(1)
driver.find_element_by_xpath('//*[@id="wpbody-content"]/div[4]/div/form/div/button').click() #start importing
