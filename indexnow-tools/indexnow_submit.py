import json
import pathlib
import urllib.request
import xml.etree.ElementTree as ET

ROOT = pathlib.Path(__file__).resolve().parent.parent
HOST = "yiyuan-jichang.lat"
KEY = (pathlib.Path(__file__).resolve().parent / "key.txt").read_text(encoding="utf-8").strip()
SITEMAP = ROOT / "sitemap.xml"
NS = {"sm": "http://www.sitemaps.org/schemas/sitemap/0.9"}

tree = ET.parse(SITEMAP)
urls = [node.text for node in tree.findall("sm:url/sm:loc", NS) if node.text]
payload = json.dumps({
    "host": HOST,
    "key": KEY,
    "keyLocation": f"https://{HOST}/{KEY}.txt",
    "urlList": urls,
}).encode("utf-8")

request = urllib.request.Request(
    "https://api.indexnow.org/indexnow",
    data=payload,
    headers={"Content-Type": "application/json; charset=utf-8"},
    method="POST",
)
with urllib.request.urlopen(request, timeout=30) as response:
    print(f"Submitted {len(urls)} URLs. HTTP status: {response.status}")
