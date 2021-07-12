__all__ = [
 'MIMEMultipart']
from email.mime.base import MIMEBase

class MIMEMultipart(MIMEBase):

    def __init__(self, _subtype='mixed', boundary=None, _subparts=None, **_params):
        MIMEBase.__init__(self, 'multipart', _subtype, **_params)
        self._payload = []
        if _subparts:
            for p in _subparts:
                self.attach(p)

        if boundary:
            self.set_boundary(boundary)