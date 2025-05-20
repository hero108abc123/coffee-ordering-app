from selenium import webdriver
from selenium.webdriver.chrome.options import Options
from bs4 import BeautifulSoup
import time
import json

# Thiết lập chế độ headless cho trình duyệt
options = Options()
options.add_argument("--headless")
driver = webdriver.Chrome(options=options)  # Cần đảm bảo chromedriver đã được cài

# Mở trang menu Highlands Coffee
url = 'https://www.highlandscoffee.com.vn/vi/thuc-don.html'
driver.get(url)

# Chờ vài giây cho trang load đầy đủ JS
time.sleep(5)

# Parse HTML bằng BeautifulSoup
soup = BeautifulSoup(driver.page_source, 'html.parser')

# Đóng trình duyệt sau khi lấy dữ liệu
driver.quit()

# Tìm tất cả sản phẩm trong menu
products = soup.select('.product_item')  # hoặc class khác nếu cấu trúc thay đổi
menu_data = []

for idx, item in enumerate(products, 1):
    name = item.select_one('.product_name').get_text(strip=True) if item.select_one('.product_name') else "Không rõ tên"
    image = item.select_one('img')['src'] if item.select_one('img') else "https://via.placeholder.com/150"
    description = item.select_one('.product_description').get_text(strip=True) if item.select_one('.product_description') else "Không có mô tả"
    
    # Giả lập một số thông tin khác
    coffee = {
        "id": idx,
        "image": image,
        "name": name,
        "type": "Ice/Hot",
        "rate": 4.5,
        "review": 100,
        "description": description,
        "price": 45000,  # Không có giá thật từ website
        "category": "Coffee",  # Có thể phân loại sau
    }
    menu_data.append(coffee)

# Ghi dữ liệu ra file JSON
with open("highlands_menu.json", "w", encoding="utf-8") as f:
    json.dump(menu_data, f, ensure_ascii=False, indent=2)

print(f"Đã crawl được {len(menu_data)} món từ menu Highlands Coffee.")
