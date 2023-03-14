from flask import Flask

from flask import Blueprint, Response,render_template
from flask import request
from PIL import Image
from urllib.request import urlopen




import json

    
import pytesseract

app = Flask(__name__)

@app.route("/")
def hello_world():
    return "<a>ocr_home</a>"


@app.post("/ocr")
def ocr():
    # ocr
    attach = request.files.get("attach", None)
    print("file ocr1file ocr1file ocr1file ocr1file ocr1file ocr1file ocr1file ocr1file ocr1file ocr1file ocr1")
    
    if attach:
        extensionLocation=attach.filename.rfind(".")
        extension=attach.filename[extensionLocation+1:]
        attach.save("account-attachments/test."+extension)
        print(extension)

    else:
        print("file not uploaded 1")
    pytesseract.pytesseract.tesseract_cmd=r'/usr/local/Cellar/tesseract/5.3.0/bin/tesseract'
    message=pytesseract.image_to_string(Image.open("account-attachments/test."+extension),lang="kor")
    message=message.split()
    cropNo="cropNo"
    for v in message:
        if len(v)==12 and v[3]=="-" and v[6]=="-" and v[:2].isdigit()==True and v[-5:].isdigit()==True and v[4:6].isdigit()==True:
            print(v)
            cropNo=v
    
            print("cropNo:"+cropNo)

    return cropNo



@app.get("/searchByCorpNo")
def searchByCorpNo():
    
    docNo = request.args.get("docNo", None)
    url = "https://bizno.net/api/fapi?key=a2lqdTI5MTJAbmF2ZXIuY29t&gb=1&q="+docNo+"&type=json"  # JSON 결과
    
    response = urlopen(url)
    
    data_json = json.loads(response.read())
    
    # ㅇ이름
    print(data_json['items'][0]['company'])
    return data_json['items'][0]['company']


