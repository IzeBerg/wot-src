import base64

def base64UrlDecode(encodedValue):
    if isinstance(encodedValue, unicode):
        encodedValue = encodedValue.encode('ascii')
    rem = len(encodedValue) % 4
    if rem > 0:
        encodedValue += '=' * (4 - rem)
    return base64.urlsafe_b64decode(encodedValue)