import requests

image_path = r'D:\android projects\Grad_proj\backend\CANCER.jpg'
url = 'http://127.0.0.1:8000/detect/'

with open(image_path, 'rb') as f:
    files = {'file': f}
    response = requests.post(url, files=files)

data = response.json()
print("Disease Detected:", data.get('disease'))

# Safely check for image key
img_base64 = data.get('image')
if img_base64:
    print("Image Base64 Length:", len(img_base64))
else:
    print("No image returned.")