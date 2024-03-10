import os
import re
import time
import requests
from selenium import webdriver
from selenium.webdriver.common.by import By
from selenium.webdriver.chrome.options import Options

def create_driver(driverUrl):
	opts = Options()
	return webdriver.Remote(command_executor=driverUrl, options=opts)

def get_scrapable_items(apiUrl):
	res = (requests.get(apiUrl + "/api/items?scrapable=true")).json()
	if not res["success"]: return []
	return res["items"]

def scan_item(driver, item):
	data = { "item_id": item["item_id"], "status": "OK", "price": item["price"] }

	url = item["url"]
	xpath = item["xpath"]

	driver.get(url)
	elements = driver.find_elements(By.XPATH, xpath)

	# temp fix for price is repeated issue i.e. 12991299
	# other possible fix: could replace the xpath to the correct one
	def price_fix(priceText):
		midpoint = len(priceText) // 2
		left = priceText[:midpoint]
		right = priceText[midpoint:]
		return left if left == right else priceText

	if not elements:
		data["status"] = "XPATH_ERROR"
	else:
		price = re.sub(r'[^\d+]', "", elements[0].text)
		data["price"] = int(price_fix(price))
	
	return data

def run(driver, apiUrl):
	items = get_scrapable_items(apiUrl)
	data = []

	if len(items) <= 0: 
		print("no items to scan")
		return

	start = time.time()
	for item in items:
		newItemData = scan_item(driver, item)
		data.append(newItemData)
	end = time.time()

	requests.put(apiUrl + "/api/update/prices", json=data)

	print(f"scanned {len(data)} items")
	print("time elapsed: ", format(end - start, ".2f"), "seconds")

def main():
	apiUrl = os.getenv("API_URL") or "http://localhost:3300"
	driverUrl = os.getenv("DRIVER_URL") or "http://localhost:4444"

	driver = None

	try:
		driver = create_driver(driverUrl)
		while True:
			print("scan started")
			run(driver, apiUrl)
			print("scan ended")
			time.sleep(60.0)

	except KeyboardInterrupt:
		print("quitting scanner...")

	except Exception as e:
		print(f"an error occurred: {e}")

	finally:
		if driver is not None:
			driver.quit()
			print("webdriver quit successfully.")

if __name__ == "__main__":
	main()
	print("scanner exit")
