__all__ = [
 'MIMEText']
from email.encoders import encode_7or8bit
from email.mime.nonmultipart import MIMENonMultipart

class MIMEText(MIMENonMultipart):

    def __init__(self, _text, _subtype='plain', _charset='us-ascii'):
        MIMENonMultipart.__init__(self, 'text', _subtype, **{'charset': _charset})
        self.set_payload(_text, _charset)