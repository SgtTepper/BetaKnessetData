import time
from pathlib import Path

import requests as requests
from bs4 import BeautifulSoup
from selenium import webdriver
from selenium.webdriver.chrome.options import Options
from webdriver_manager.chrome import ChromeDriverManager
from selenium.webdriver.chrome.service import Service as ChromiumService
from webdriver_manager.chrome import ChromeDriverManager
from webdriver_manager.core.utils import ChromeType
from selenium_stealth import stealth
import mammoth


def convert_doc_to_html(doc_file_path):
    docx_data = Path(doc_file_path).read_bytes()
    result = mammoth.convert_to_html(docx_data)
    html = result.value  # The generated HTML
    return html


def setup_selenium():
    # Configure Chrome options
    chrome_options = Options()

    # Create a new Chrome driver instance
    driver = webdriver.Chrome(
        service=ChromiumService(
            ChromeDriverManager(chrome_type=ChromeType.CHROMIUM).install()
        ),
        options=chrome_options,
    )

    stealth(
        driver,
        languages=["en-US", "en"],
        vendor="Google Inc.",
        platform="Win32",
        webgl_vendor="Intel Inc.",
        renderer="Intel Iris OpenGL Engine",
        fix_hairline=True,
    )
    return driver


def get_driver():
    driver = setup_selenium()
    driver.get("https://main.knesset.gov.il/Pages/default.aspx")
    time.sleep(3)
    driver.get(
        "https://main.knesset.gov.il/Activity/Legislation/Laws/Pages/LawAboutSite.aspx"
    )
    return driver


driver = None


def extract_docs(docs_id):
    global driver
    if not driver:
        driver = get_driver()
    url = f"https://main.knesset.gov.il/Activity/Legislation/Laws/Pages/LawBill.aspx?t=LawReshumot&lawitemid={docs_id}"

    driver.get(url)

    text_html = driver.page_source

    soup = BeautifulSoup(text_html, features="lxml")

    doc_css_selector = "div.LawDocLawsGroupDiv a"

    links = []
    for link in soup.select(doc_css_selector):
        doc, doc_url = (link.string, link.attrs["href"])
        print(doc, doc_url)
        links.append((doc, doc_url))

    return links
