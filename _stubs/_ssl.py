# Stubs Generator
# import _ssl
# <module '_ssl' (built-in)>

ALERT_DESCRIPTION_ACCESS_DENIED = 49
ALERT_DESCRIPTION_BAD_CERTIFICATE = 42
ALERT_DESCRIPTION_BAD_CERTIFICATE_HASH_VALUE = 114
ALERT_DESCRIPTION_BAD_CERTIFICATE_STATUS_RESPONSE = 113
ALERT_DESCRIPTION_BAD_RECORD_MAC = 20
ALERT_DESCRIPTION_CERTIFICATE_EXPIRED = 45
ALERT_DESCRIPTION_CERTIFICATE_REVOKED = 44
ALERT_DESCRIPTION_CERTIFICATE_UNKNOWN = 46
ALERT_DESCRIPTION_CERTIFICATE_UNOBTAINABLE = 111
ALERT_DESCRIPTION_CLOSE_NOTIFY = 0
ALERT_DESCRIPTION_DECODE_ERROR = 50
ALERT_DESCRIPTION_DECOMPRESSION_FAILURE = 30
ALERT_DESCRIPTION_DECRYPT_ERROR = 51
ALERT_DESCRIPTION_HANDSHAKE_FAILURE = 40
ALERT_DESCRIPTION_ILLEGAL_PARAMETER = 47
ALERT_DESCRIPTION_INSUFFICIENT_SECURITY = 71
ALERT_DESCRIPTION_INTERNAL_ERROR = 80
ALERT_DESCRIPTION_NO_RENEGOTIATION = 100
ALERT_DESCRIPTION_PROTOCOL_VERSION = 70
ALERT_DESCRIPTION_RECORD_OVERFLOW = 22
ALERT_DESCRIPTION_UNEXPECTED_MESSAGE = 10
ALERT_DESCRIPTION_UNKNOWN_CA = 48
ALERT_DESCRIPTION_UNKNOWN_PSK_IDENTITY = 115
ALERT_DESCRIPTION_UNRECOGNIZED_NAME = 112
ALERT_DESCRIPTION_UNSUPPORTED_CERTIFICATE = 43
ALERT_DESCRIPTION_UNSUPPORTED_EXTENSION = 110
ALERT_DESCRIPTION_USER_CANCELLED = 90
CERT_NONE = 0
CERT_OPTIONAL = 1
CERT_REQUIRED = 2
HAS_ALPN = False
HAS_ECDH = True
HAS_NPN = True
HAS_SNI = True
HAS_TLS_UNIQUE = True
HAS_TLSv1_3 = False
OPENSSL_VERSION = 'OpenSSL 1.0.1t  3 May 2016'
OPENSSL_VERSION_INFO = (1, 0, 1, 20, 15)
OPENSSL_VERSION_NUMBER = 268439887L
OP_ALL = -2147482625
OP_CIPHER_SERVER_PREFERENCE = 4194304
OP_NO_COMPRESSION = 131072
OP_NO_SSLv2 = 16777216
OP_NO_SSLv3 = 33554432
OP_NO_TLSv1 = 67108864
OP_NO_TLSv1_1 = 268435456
OP_NO_TLSv1_2 = 134217728
OP_NO_TLSv1_3 = 0
OP_SINGLE_DH_USE = 1048576
OP_SINGLE_ECDH_USE = 524288
PROTOCOL_SSLv23 = 2
PROTOCOL_SSLv3 = 1
PROTOCOL_TLS = 2
PROTOCOL_TLSv1 = 3
PROTOCOL_TLSv1_1 = 4
PROTOCOL_TLSv1_2 = 5
def RAND_add(*args, **kwargs): pass
def RAND_egd(*args, **kwargs): pass
def RAND_status(*args, **kwargs): pass

class BaseException(object):
	def __delattr__(*args, **kwargs): pass
	__doc__ = 'Common base class for all exceptions'
	def __format__(*args, **kwargs): pass
	def __getattribute__(*args, **kwargs): pass
	def __getitem__(*args, **kwargs): pass
	def __getslice__(*args, **kwargs): pass
	def __hash__(*args, **kwargs): pass
	def __init__(*args, **kwargs): pass
	def __new__(*args, **kwargs): pass
	def __reduce__(*args, **kwargs): pass
	def __reduce_ex__(*args, **kwargs): pass
	def __repr__(*args, **kwargs): pass
	def __setattr__(*args, **kwargs): pass
	def __setstate__(*args, **kwargs): pass
	def __sizeof__(*args, **kwargs): pass
	def __str__(*args, **kwargs): pass
	def __subclasshook__(*args, **kwargs): pass
	def __unicode__(*args, **kwargs): pass
	args = property(lambda self: None)
	message = property(lambda self: None)


class Exception(BaseException):
	def __delattr__(*args, **kwargs): pass
	__doc__ = 'Common base class for all non-exit exceptions.'
	def __format__(*args, **kwargs): pass
	def __getattribute__(*args, **kwargs): pass
	def __getitem__(*args, **kwargs): pass
	def __getslice__(*args, **kwargs): pass
	def __hash__(*args, **kwargs): pass
	def __init__(*args, **kwargs): pass
	def __new__(*args, **kwargs): pass
	def __reduce__(*args, **kwargs): pass
	def __reduce_ex__(*args, **kwargs): pass
	def __repr__(*args, **kwargs): pass
	def __setattr__(*args, **kwargs): pass
	def __setstate__(*args, **kwargs): pass
	def __sizeof__(*args, **kwargs): pass
	def __str__(*args, **kwargs): pass
	def __subclasshook__(*args, **kwargs): pass
	def __unicode__(*args, **kwargs): pass
	args = property(lambda self: None)
	message = property(lambda self: None)


class StandardError(Exception):
	def __delattr__(*args, **kwargs): pass
	__doc__ = 'Base class for all standard Python exceptions that do not represent\ninterpreter exiting.'
	def __format__(*args, **kwargs): pass
	def __getattribute__(*args, **kwargs): pass
	def __getitem__(*args, **kwargs): pass
	def __getslice__(*args, **kwargs): pass
	def __hash__(*args, **kwargs): pass
	def __init__(*args, **kwargs): pass
	def __new__(*args, **kwargs): pass
	def __reduce__(*args, **kwargs): pass
	def __reduce_ex__(*args, **kwargs): pass
	def __repr__(*args, **kwargs): pass
	def __setattr__(*args, **kwargs): pass
	def __setstate__(*args, **kwargs): pass
	def __sizeof__(*args, **kwargs): pass
	def __str__(*args, **kwargs): pass
	def __subclasshook__(*args, **kwargs): pass
	def __unicode__(*args, **kwargs): pass
	args = property(lambda self: None)
	message = property(lambda self: None)


class EnvironmentError(StandardError):
	def __delattr__(*args, **kwargs): pass
	__doc__ = 'Base class for I/O related errors.'
	def __format__(*args, **kwargs): pass
	def __getattribute__(*args, **kwargs): pass
	def __getitem__(*args, **kwargs): pass
	def __getslice__(*args, **kwargs): pass
	def __hash__(*args, **kwargs): pass
	def __init__(*args, **kwargs): pass
	def __new__(*args, **kwargs): pass
	def __reduce__(*args, **kwargs): pass
	def __reduce_ex__(*args, **kwargs): pass
	def __repr__(*args, **kwargs): pass
	def __setattr__(*args, **kwargs): pass
	def __setstate__(*args, **kwargs): pass
	def __sizeof__(*args, **kwargs): pass
	def __str__(*args, **kwargs): pass
	def __subclasshook__(*args, **kwargs): pass
	def __unicode__(*args, **kwargs): pass
	args = property(lambda self: None)
	errno = property(lambda self: None)
	filename = property(lambda self: None)
	message = property(lambda self: None)
	strerror = property(lambda self: None)


class IOError(EnvironmentError):
	def __delattr__(*args, **kwargs): pass
	__doc__ = 'I/O operation failed.'
	def __format__(*args, **kwargs): pass
	def __getattribute__(*args, **kwargs): pass
	def __getitem__(*args, **kwargs): pass
	def __getslice__(*args, **kwargs): pass
	def __hash__(*args, **kwargs): pass
	def __init__(*args, **kwargs): pass
	def __new__(*args, **kwargs): pass
	def __reduce__(*args, **kwargs): pass
	def __reduce_ex__(*args, **kwargs): pass
	def __repr__(*args, **kwargs): pass
	def __setattr__(*args, **kwargs): pass
	def __setstate__(*args, **kwargs): pass
	def __sizeof__(*args, **kwargs): pass
	def __str__(*args, **kwargs): pass
	def __subclasshook__(*args, **kwargs): pass
	def __unicode__(*args, **kwargs): pass
	args = property(lambda self: None)
	errno = property(lambda self: None)
	filename = property(lambda self: None)
	message = property(lambda self: None)
	strerror = property(lambda self: None)


class error(IOError):
	def __delattr__(*args, **kwargs): pass
	__doc__ = None
	def __format__(*args, **kwargs): pass
	def __getattribute__(*args, **kwargs): pass
	def __getitem__(*args, **kwargs): pass
	def __getslice__(*args, **kwargs): pass
	def __hash__(*args, **kwargs): pass
	def __init__(*args, **kwargs): pass
	__module__ = 'socket'
	def __new__(*args, **kwargs): pass
	def __reduce__(*args, **kwargs): pass
	def __reduce_ex__(*args, **kwargs): pass
	def __repr__(*args, **kwargs): pass
	def __setattr__(*args, **kwargs): pass
	def __setstate__(*args, **kwargs): pass
	def __sizeof__(*args, **kwargs): pass
	def __str__(*args, **kwargs): pass
	def __subclasshook__(*args, **kwargs): pass
	def __unicode__(*args, **kwargs): pass
	__weakref__ = property(lambda self: None)
	args = property(lambda self: None)
	errno = property(lambda self: None)
	filename = property(lambda self: None)
	message = property(lambda self: None)
	strerror = property(lambda self: None)


class SSLError(error):
	def __delattr__(*args, **kwargs): pass
	__doc__ = 'An error occurred in the SSL implementation.'
	def __format__(*args, **kwargs): pass
	def __getattribute__(*args, **kwargs): pass
	def __getitem__(*args, **kwargs): pass
	def __getslice__(*args, **kwargs): pass
	def __hash__(*args, **kwargs): pass
	def __init__(*args, **kwargs): pass
	__module__ = 'ssl'
	def __new__(*args, **kwargs): pass
	def __reduce__(*args, **kwargs): pass
	def __reduce_ex__(*args, **kwargs): pass
	def __repr__(*args, **kwargs): pass
	def __setattr__(*args, **kwargs): pass
	def __setstate__(*args, **kwargs): pass
	def __sizeof__(*args, **kwargs): pass
	def __str__(*args, **kwargs): pass
	def __subclasshook__(*args, **kwargs): pass
	def __unicode__(*args, **kwargs): pass
	__weakref__ = property(lambda self: None)
	args = property(lambda self: None)
	errno = property(lambda self: None)
	filename = property(lambda self: None)
	message = property(lambda self: None)
	strerror = property(lambda self: None)


class SSLEOFError(SSLError):
	def __delattr__(*args, **kwargs): pass
	__doc__ = 'SSL/TLS connection terminated abruptly.'
	def __format__(*args, **kwargs): pass
	def __getattribute__(*args, **kwargs): pass
	def __getitem__(*args, **kwargs): pass
	def __getslice__(*args, **kwargs): pass
	def __hash__(*args, **kwargs): pass
	def __init__(*args, **kwargs): pass
	__module__ = 'ssl'
	def __new__(*args, **kwargs): pass
	def __reduce__(*args, **kwargs): pass
	def __reduce_ex__(*args, **kwargs): pass
	def __repr__(*args, **kwargs): pass
	def __setattr__(*args, **kwargs): pass
	def __setstate__(*args, **kwargs): pass
	def __sizeof__(*args, **kwargs): pass
	def __str__(*args, **kwargs): pass
	def __subclasshook__(*args, **kwargs): pass
	def __unicode__(*args, **kwargs): pass
	__weakref__ = property(lambda self: None)
	args = property(lambda self: None)
	errno = property(lambda self: None)
	filename = property(lambda self: None)
	message = property(lambda self: None)
	strerror = property(lambda self: None)


class SSLSyscallError(SSLError):
	def __delattr__(*args, **kwargs): pass
	__doc__ = 'System error when attempting SSL operation.'
	def __format__(*args, **kwargs): pass
	def __getattribute__(*args, **kwargs): pass
	def __getitem__(*args, **kwargs): pass
	def __getslice__(*args, **kwargs): pass
	def __hash__(*args, **kwargs): pass
	def __init__(*args, **kwargs): pass
	__module__ = 'ssl'
	def __new__(*args, **kwargs): pass
	def __reduce__(*args, **kwargs): pass
	def __reduce_ex__(*args, **kwargs): pass
	def __repr__(*args, **kwargs): pass
	def __setattr__(*args, **kwargs): pass
	def __setstate__(*args, **kwargs): pass
	def __sizeof__(*args, **kwargs): pass
	def __str__(*args, **kwargs): pass
	def __subclasshook__(*args, **kwargs): pass
	def __unicode__(*args, **kwargs): pass
	__weakref__ = property(lambda self: None)
	args = property(lambda self: None)
	errno = property(lambda self: None)
	filename = property(lambda self: None)
	message = property(lambda self: None)
	strerror = property(lambda self: None)


class SSLWantReadError(SSLError):
	def __delattr__(*args, **kwargs): pass
	__doc__ = 'Non-blocking SSL socket needs to read more data\nbefore the requested operation can be completed.'
	def __format__(*args, **kwargs): pass
	def __getattribute__(*args, **kwargs): pass
	def __getitem__(*args, **kwargs): pass
	def __getslice__(*args, **kwargs): pass
	def __hash__(*args, **kwargs): pass
	def __init__(*args, **kwargs): pass
	__module__ = 'ssl'
	def __new__(*args, **kwargs): pass
	def __reduce__(*args, **kwargs): pass
	def __reduce_ex__(*args, **kwargs): pass
	def __repr__(*args, **kwargs): pass
	def __setattr__(*args, **kwargs): pass
	def __setstate__(*args, **kwargs): pass
	def __sizeof__(*args, **kwargs): pass
	def __str__(*args, **kwargs): pass
	def __subclasshook__(*args, **kwargs): pass
	def __unicode__(*args, **kwargs): pass
	__weakref__ = property(lambda self: None)
	args = property(lambda self: None)
	errno = property(lambda self: None)
	filename = property(lambda self: None)
	message = property(lambda self: None)
	strerror = property(lambda self: None)


class SSLWantWriteError(SSLError):
	def __delattr__(*args, **kwargs): pass
	__doc__ = 'Non-blocking SSL socket needs to write more data\nbefore the requested operation can be completed.'
	def __format__(*args, **kwargs): pass
	def __getattribute__(*args, **kwargs): pass
	def __getitem__(*args, **kwargs): pass
	def __getslice__(*args, **kwargs): pass
	def __hash__(*args, **kwargs): pass
	def __init__(*args, **kwargs): pass
	__module__ = 'ssl'
	def __new__(*args, **kwargs): pass
	def __reduce__(*args, **kwargs): pass
	def __reduce_ex__(*args, **kwargs): pass
	def __repr__(*args, **kwargs): pass
	def __setattr__(*args, **kwargs): pass
	def __setstate__(*args, **kwargs): pass
	def __sizeof__(*args, **kwargs): pass
	def __str__(*args, **kwargs): pass
	def __subclasshook__(*args, **kwargs): pass
	def __unicode__(*args, **kwargs): pass
	__weakref__ = property(lambda self: None)
	args = property(lambda self: None)
	errno = property(lambda self: None)
	filename = property(lambda self: None)
	message = property(lambda self: None)
	strerror = property(lambda self: None)


class SSLZeroReturnError(SSLError):
	def __delattr__(*args, **kwargs): pass
	__doc__ = 'SSL/TLS session closed cleanly.'
	def __format__(*args, **kwargs): pass
	def __getattribute__(*args, **kwargs): pass
	def __getitem__(*args, **kwargs): pass
	def __getslice__(*args, **kwargs): pass
	def __hash__(*args, **kwargs): pass
	def __init__(*args, **kwargs): pass
	__module__ = 'ssl'
	def __new__(*args, **kwargs): pass
	def __reduce__(*args, **kwargs): pass
	def __reduce_ex__(*args, **kwargs): pass
	def __repr__(*args, **kwargs): pass
	def __setattr__(*args, **kwargs): pass
	def __setstate__(*args, **kwargs): pass
	def __sizeof__(*args, **kwargs): pass
	def __str__(*args, **kwargs): pass
	def __subclasshook__(*args, **kwargs): pass
	def __unicode__(*args, **kwargs): pass
	__weakref__ = property(lambda self: None)
	args = property(lambda self: None)
	errno = property(lambda self: None)
	filename = property(lambda self: None)
	message = property(lambda self: None)
	strerror = property(lambda self: None)

SSL_ERROR_EOF = 8
SSL_ERROR_INVALID_ERROR_CODE = 10
SSL_ERROR_SSL = 1
SSL_ERROR_SYSCALL = 5
SSL_ERROR_WANT_CONNECT = 7
SSL_ERROR_WANT_READ = 2
SSL_ERROR_WANT_WRITE = 3
SSL_ERROR_WANT_X509_LOOKUP = 4
SSL_ERROR_ZERO_RETURN = 6
VERIFY_CRL_CHECK_CHAIN = 12
VERIFY_CRL_CHECK_LEAF = 4
VERIFY_DEFAULT = 0
VERIFY_X509_STRICT = 32
_OPENSSL_API_VERSION = (1, 0, 1, 20, 15)

class _SSLContext(object):
	def __delattr__(*args, **kwargs): pass
	__doc__ = None
	def __format__(*args, **kwargs): pass
	def __getattribute__(*args, **kwargs): pass
	def __hash__(*args, **kwargs): pass
	def __init__(*args, **kwargs): pass
	def __new__(*args, **kwargs): pass
	def __reduce__(*args, **kwargs): pass
	def __reduce_ex__(*args, **kwargs): pass
	def __repr__(*args, **kwargs): pass
	def __setattr__(*args, **kwargs): pass
	def __sizeof__(*args, **kwargs): pass
	def __str__(*args, **kwargs): pass
	def __subclasshook__(*args, **kwargs): pass
	def _set_alpn_protocols(*args, **kwargs): pass
	def _set_npn_protocols(*args, **kwargs): pass
	def _wrap_socket(*args, **kwargs): pass
	def cert_store_stats(*args, **kwargs): pass
	check_hostname = property(lambda self: None)
	def get_ca_certs(*args, **kwargs): pass
	def load_cert_chain(*args, **kwargs): pass
	def load_dh_params(*args, **kwargs): pass
	def load_verify_locations(*args, **kwargs): pass
	options = property(lambda self: None)
	def session_stats(*args, **kwargs): pass
	def set_ciphers(*args, **kwargs): pass
	def set_default_verify_paths(*args, **kwargs): pass
	def set_ecdh_curve(*args, **kwargs): pass
	def set_servername_callback(*args, **kwargs): pass
	verify_flags = property(lambda self: None)
	verify_mode = property(lambda self: None)


class _SSLSocket(object):
	def __delattr__(*args, **kwargs): pass
	__doc__ = None
	def __format__(*args, **kwargs): pass
	def __getattribute__(*args, **kwargs): pass
	def __hash__(*args, **kwargs): pass
	def __init__(*args, **kwargs): pass
	def __new__(*args, **kwargs): pass
	def __reduce__(*args, **kwargs): pass
	def __reduce_ex__(*args, **kwargs): pass
	def __repr__(*args, **kwargs): pass
	def __setattr__(*args, **kwargs): pass
	def __sizeof__(*args, **kwargs): pass
	def __str__(*args, **kwargs): pass
	def __subclasshook__(*args, **kwargs): pass
	def cipher(*args, **kwargs): pass
	def compression(*args, **kwargs): pass
	context = property(lambda self: None)
	def do_handshake(*args, **kwargs): pass
	def peer_certificate(*args, **kwargs): pass
	def pending(*args, **kwargs): pass
	def read(*args, **kwargs): pass
	def selected_npn_protocol(*args, **kwargs): pass
	def shutdown(*args, **kwargs): pass
	def tls_unique_cb(*args, **kwargs): pass
	def version(*args, **kwargs): pass
	def write(*args, **kwargs): pass

__doc__ = 'Implementation module for SSL socket operations.  See the socket module\nfor documentation.'
__name__ = '_ssl'
__package__ = None
def _test_decode_cert(*args, **kwargs): pass
def enum_certificates(*args, **kwargs): pass
def enum_crls(*args, **kwargs): pass
err_codes_to_names = {(20, 378): u'WRONG_CURVE', (20, 183): u'NO_CIPHERS_SPECIFIED', (20, 236): u'UNABLE_TO_DECODE_DH_CERTS', (20, 1049): u'TLSV1_ALERT_ACCESS_DENIED', (20, 1110): u'TLSV1_UNSUPPORTED_EXTENSION', (20, 387): u'ONLY_DTLS_1_2_ALLOWED_IN_SUITEB_MODE', (20, 312): u'READ_TIMEOUT_EXPIRED', (20, 373): u'INAPPROPRIATE_FALLBACK', (20, 162): u'MISSING_DH_DSA_CERT', (20, 223): u'PSK_IDENTITY_NOT_FOUND', (20, 1044): u'SSLV3_ALERT_CERTIFICATE_REVOKED', (20, 1022): u'TLSV1_ALERT_RECORD_OVERFLOW', (20, 299): u'SSL2_CONNECTION_ID_TOO_LONG', (20, 352): u'BAD_SRTP_MKI_VALUE', (20, 157): u'TLS_INVALID_ECPOINTFORMAT_LIST', (20, 202): u'PEER_ERROR_NO_CERTIFICATE', (9, 107): u'NOT_PROC_TYPE', (20, 294): u'KRB5_S_TKT_NYV', (20, 339): u'NO_RENEGOTIATION', (20, 136): u'CHALLENGE_IS_DIFFERENT', (20, 197): u'OLD_SESSION_CIPHER_NOT_RETURNED', (20, 114): u'BAD_MESSAGE_TYPE', (9, 120): u'EXPECTING_PUBLIC_KEY_BLOB', (20, 273): u'SSL_SESSION_ID_CONTEXT_TOO_LONG', (20, 334): u'DTLS_MESSAGE_TOO_BIG', (20, 251): u'UNKNOWN_PKEY_TYPE', (11, 109): u'UNKNOWN_NID', (20, 109): u'BAD_DH_PUB_KEY_LENGTH', (20, 268): u'X509_LIB', (20, 185): u'NO_CIPHER_MATCH', (20, 246): u'UNKNOWN_ALERT_TYPE', (11, 126): u'PUBLIC_KEY_ENCODE_ERROR', (20, 1112): u'TLSV1_UNRECOGNIZED_NAME', (20, 383): u'WRONG_CERTIFICATE_TYPE', (20, 180): u'NO_CERTIFICATE_SPECIFIED', (20, 225): u'PSK_NO_SERVER_CB', (20, 384): u'BAD_VALUE', (20, 317): u'ECC_CERT_NOT_FOR_KEY_AGREEMENT', (20, 362): u'SRTP_COULD_NOT_ALLOCATE_PROFILES', (20, 167): u'MISSING_EXPORT_TMP_RSA_KEY', (20, 220): u'SIGNATURE_FOR_NON_SIGNING_CERTIFICATE', (20, 296): u'MESSAGE_TOO_LONG', (20, 357): u'INVALID_SRP_USERNAME', (20, 146): u'DATA_LENGTH_TOO_LONG', (20, 207): u'PROTOCOL_IS_SHUTDOWN', (9, 102): u'BAD_END_LINE', (11, 130): u'NO_CRL_NUMBER', (20, 283): u'ILLEGAL_PADDING', (20, 336): u'RENEGOTIATION_ENCODING_ERR', (20, 141): u'COMPRESSION_FAILURE', (11, 103): u'LOADING_CERT_DIR', (20, 119): u'BAD_RSA_ENCRYPT', (9, 123): u'KEYBLOB_TOO_SHORT', (20, 278): u'INVALID_PURPOSE', (20, 323): u'ECC_CERT_SHOULD_HAVE_SHA1_SIGNATURE', (20, 248): u'UNKNOWN_CIPHER_RETURNED', (11, 104): u'LOADING_DEFAULTS', (11, 115): u'KEY_TYPE_MISMATCH', (20, 257): u'UNSUPPORTED_COMPRESSION_ALGORITHM', (20, 190): u'NO_PRIVATE_KEY_ASSIGNED', (20, 235): u'TRIED_TO_USE_UNSUPPORTED_CIPHER', (11, 125): u'PUBLIC_KEY_DECODE_ERROR', (20, 380): u'ILLEGAL_SUITEB_DIGEST', (20, 169): u'MISSING_RSA_ENCRYPTING_CERT', (20, 230): u'SSL_LIBRARY_HAS_NO_CIPHERS', (20, 1043): u'SSLV3_ALERT_UNSUPPORTED_CERTIFICATE', (20, 389): u'NO_PEM_EXTENSIONS', (20, 306): u'BAD_ECPOINT', (20, 367): u'TLS_ILLEGAL_EXPORTER_LABEL', (20, 164): u'MISSING_DH_RSA_CERT', (20, 209): u'PUBLIC_KEY_IS_NOT_RSA', (9, 108): u'NO_START_LINE', (20, 301): u'SSL_SESSION_ID_CALLBACK_FAILED', (20, 346): u'MULTIPLE_SGC_RESTARTS', (20, 151): u'ERROR_IN_RECEIVED_CIPHER_LIST', (20, 204): u'PEER_ERROR_UNSUPPORTED_CERTIFICATE_TYPE', (20, 121): u'BAD_RSA_MODULUS_LENGTH', (11, 114): u'CANT_CHECK_DH_KEY', (20, 280): u'INVALID_COMMAND', (20, 341): u'INVALID_COMPRESSION_ALGORITHM', (20, 130): u'BN_LIB', (20, 116): u'BAD_PROTOCOL_VERSION_NUMBER', (9, 118): u'BIO_WRITE_FAILURE', (20, 267): u'WRONG_VERSION_NUMBER', (20, 320): u'SSL3_EXT_INVALID_SERVERNAME_TYPE', (20, 253): u'UNKNOWN_REMOTE_ERROR_TYPE', (11, 119): u'INVALID_FIELD_NAME', (20, 103): u'BAD_CHANGE_CIPHER_SPEC', (20, 262): u'WRONG_MESSAGE_TYPE', (20, 179): u'NO_CERTIFICATE_SET', (20, 232): u'TLS_CLIENT_CERT_REQ_WITH_ANON_CIPHER', (11, 120): u'UNKNOWN_TRUST_ID', (20, 399): u'EE_KEY_TOO_SMALL', (20, 369): u'USE_SRTP_NOT_NEGOTIATED', (20, 174): u'MISSING_VERIFY_MESSAGE', (20, 219): u'SHORT_READ', (20, 1040): u'SSLV3_ALERT_HANDSHAKE_FAILURE', (20, 311): u'MISSING_TMP_ECDH_KEY', (20, 364): u'SRTP_UNKNOWN_PROTECTION_PROFILE', (20, 153): u'EXTRA_DATA_IN_MESSAGE', (20, 214): u'RECORD_TOO_LARGE', (9, 111): u'READ_KEY', (11, 132): u'NEWER_CRL_NOT_NEWER', (20, 290): u'KRB5_S_BAD_TICKET', (20, 351): u'BAD_SRP_S_LENGTH', (20, 148): u'DH_PUBLIC_VALUE_LENGTH_IS_WRONG', (20, 193): u'NO_SHARED_CIPHER', (20, 126): u'BAD_STATE', (9, 124): u'PVK_DATA_TOO_SHORT', (11, 131): u'CRL_VERIFY_FAILURE', (20, 285): u'KRB5', (20, 330): u'NO_GOST_CERTIFICATE_SENT_BY_PEER', (20, 135): u'CERT_LENGTH_MISMATCH', (20, 105): u'BAD_HELLO_REQUEST', (9, 113): u'UNSUPPORTED_CIPHER', (20, 264): u'WRONG_SIGNATURE_LENGTH', (20, 325): u'INVALID_TICKET_KEYS_LENGTH', (20, 242): u'UNABLE_TO_LOAD_SSL3_MD5_ROUTINES', (20, 1071): u'TLSV1_ALERT_INSUFFICIENT_SECURITY', (20, 100): u'APP_DATA_IN_HANDSHAKE', (20, 379): u'ONLY_TLS_1_2_ALLOWED_IN_SUITEB_MODE', (20, 176): u'NO_CERTIFICATES_RETURNED', (20, 237): u'UNABLE_TO_EXTRACT_PUBLIC_KEY', (20, 1050): u'TLSV1_ALERT_DECODE_ERROR', (20, 1111): u'TLSV1_CERTIFICATE_UNOBTAINABLE', (20, 396): u'VERSION_TOO_LOW', (20, 313): u'UNABLE_TO_DECODE_ECDH_CERTS', (20, 374): u'ECDH_REQUIRED_FOR_SUITEB_MODE', (20, 163): u'MISSING_DH_KEY', (20, 216): u'REUSE_CERT_LENGTH_NOT_ZERO', (20, 1045): u'SSLV3_ALERT_CERTIFICATE_EXPIRED', (20, 1090): u'TLSV1_ALERT_USER_CANCELLED', (20, 308): u'COOKIE_MISMATCH', (20, 353): u'BAD_SRTP_PROTECTION_PROFILE_LIST', (20, 158): u'INVALID_CHALLENGE_LENGTH', (20, 203): u'PEER_ERROR_NO_CIPHER', (9, 106): u'NOT_ENCRYPTED', (20, 295): u'KRB5_S_TKT_SKEW', (20, 348): u'BAD_SRP_B_LENGTH', (20, 137): u'CIPHER_CODE_WRONG_LENGTH', (20, 198): u'PACKET_LENGTH_TOO_LONG', (20, 115): u'BAD_PACKET_LENGTH', (9, 127): u'CIPHER_IS_NULL', (20, 274): u'LIBRARY_BUG', (20, 335): u'RENEGOTIATE_EXT_TOO_LONG', (20, 132): u'CA_DN_TOO_LONG', (11, 108): u'UNABLE_TO_GET_CERTS_PUBLIC_KEY', (20, 110): u'BAD_DH_P_LENGTH', (20, 269): u'X509_VERIFICATION_SETUP_PROBLEMS', (20, 186): u'NO_CLIENT_CERT_RECEIVED', (20, 247): u'UNKNOWN_CERTIFICATE_TYPE', (11, 113): u'INVALID_DIRECTORY', (20, 1113): u'TLSV1_BAD_CERTIFICATE_STATUS_RESPONSE', (20, 376): u'NO_SHARED_SIGATURE_ALGORITHMS', (20, 181): u'NO_CIPHERS_AVAILABLE', (20, 226): u'CLIENTHELLO_TLSEXT', (20, 385): u'INVALID_NULL_CMD_NAME', (20, 318): u'ECC_CERT_NOT_FOR_SIGNING', (20, 363): u'SRTP_PROTECTION_PROFILE_LIST_TOO_LONG', (20, 160): u'LENGTH_TOO_SHORT', (20, 221): u'SSL23_DOING_SESSION_ID_REUSE', (20, 1020): u'SSLV3_ALERT_BAD_RECORD_MAC', (20, 297): u'ONLY_TLS_ALLOWED_IN_FIPS_MODE', (20, 358): u'MISSING_SRP_PARAM', (20, 147): u'DECRYPTION_FAILED', (20, 200): u'PEER_ERROR', (9, 101): u'BAD_DECRYPT', (20, 292): u'KRB5_S_RD_REQ', (20, 337): u'RENEGOTIATION_MISMATCH', (20, 142): u'COMPRESSION_LIBRARY_ERROR', (11, 102): u'ERR_ASN1_LIB', (20, 112): u'BAD_DSA_SIGNATURE', (9, 122): u'KEYBLOB_HEADER_PARSE_ERROR', (11, 128): u'IDP_MISMATCH', (20, 279): u'INVALID_TRUST', (20, 332): u'BAD_HANDSHAKE_LENGTH', (20, 249): u'UNKNOWN_CIPHER_TYPE', (11, 107): u'UNABLE_TO_FIND_PARAMETERS_IN_CHAIN', (20, 258): u'UNSUPPORTED_PROTOCOL', (20, 191): u'NO_PROTOCOLS_AVAILABLE', (20, 244): u'UNEXPECTED_MESSAGE', (11, 124): u'METHOD_NOT_SUPPORTED', (20, 381): u'MISSING_ECDSA_SIGNING_CERT', (20, 170): u'MISSING_RSA_SIGNING_CERT', (20, 231): u'SSL_SESSION_ID_IS_DIFFERENT', (20, 390): u'BAD_DATA', (20, 307): u'COMPRESSION_ID_NOT_WITHIN_PRIVATE_RANGE', (20, 360): u'SIGNATURE_ALGORITHMS_ERROR', (20, 165): u'MISSING_DSA_SIGNING_CERT', (20, 210): u'PUBLIC_KEY_NOT_RSA', (20, 302): u'SSL_SESSION_ID_CONFLICT', (20, 347): u'BAD_SRP_A_LENGTH', (20, 144): u'CONNECTION_TYPE_NOT_SET', (20, 205): u'PRE_MAC_LENGTH_TOO_LONG', (20, 122): u'BAD_RSA_SIGNATURE', (20, 281): u'DECRYPTION_FAILED_OR_BAD_RECORD_MAC', (20, 342): u'REQUIRED_COMPRESSSION_ALGORITHM_MISSING', (20, 131): u'CA_DN_LENGTH_MISMATCH', (20, 1080): u'TLSV1_ALERT_INTERNAL_ERROR', (20, 117): u'BAD_RESPONSE_ARGUMENT', (9, 117): u'BAD_VERSION_NUMBER', (20, 276): u'UNINITIALIZED', (20, 321): u'SSL3_EXT_INVALID_ECPOINTFORMAT', (20, 254): u'UNKNOWN_SSL_VERSION', (11, 118): u'BASE64_DECODE_ERROR', (20, 263): u'WRONG_NUMBER_OF_KEY_BITS', (20, 188): u'NO_METHOD_SPECIFIED', (20, 233): u'TLS_PEER_DID_NOT_RESPOND_WITH_CERTIFICATE_LIST', (11, 123): u'INVALID_TRUST', (11, 101): u'CERT_ALREADY_IN_HASH_TABLE', (20, 392): u'PEM_NAME_TOO_SHORT', (20, 370): u'WRONG_SIGNATURE_TYPE', (20, 175): u'NON_SSLV2_INITIAL_PACKET', (20, 228): u'SSL_CTX_HAS_NO_DEFAULT_SSL_VERSION', (20, 1041): u'SSLV3_ALERT_NO_CERTIFICATE', (20, 304): u'BAD_ECC_CERT', (20, 365): u'TLS_HEARTBEAT_PEER_DOESNT_ACCEPT', (20, 154): u'GOT_A_FIN_BEFORE_A_CCS', (20, 215): u'REQUIRED_CIPHER_MISSING', (11, 121): u'UNKNOWN_PURPOSE_ID', (9, 110): u'PUBLIC_KEY_NO_RSA', (20, 291): u'KRB5_S_INIT', (20, 344): u'OLD_SESSION_COMPRESSION_ALGORITHM_NOT_RETURNED', (20, 149): u'DIGEST_CHECK_FAILED', (20, 194): u'NO_VERIFY_CALLBACK', (20, 127): u'BAD_WRITE_RETRY', (20, 286): u'KRB5_C_CC_PRINC', (20, 331): u'NO_CLIENT_CERT_METHOD', (20, 128): u'BIO_NOT_SET', (20, 106): u'BAD_DATA_RETURNED_BY_CALLBACK', (9, 112): u'SHORT_HEADER', (11, 129): u'ISSUER_MISMATCH', (20, 265): u'WRONG_SIGNATURE_SIZE', (20, 326): u'UNSUPPORTED_DIGEST_TYPE', (20, 243): u'UNABLE_TO_LOAD_SSL3_SHA1_ROUTINES', (11, 117): u'UNKNOWN_KEY_TYPE', (20, 101): u'BAD_ALERT_RECORD', (20, 260): u'WRITE_BIO_NOT_SET', (20, 177): u'NO_CERTIFICATE_ASSIGNED', (20, 238): u'UNABLE_TO_FIND_DH_PARAMETERS', (20, 1051): u'TLSV1_ALERT_DECRYPT_ERROR', (20, 397): u'CA_KEY_TOO_SMALL', (20, 314): u'UNABLE_TO_FIND_ECDH_PARAMETERS', (20, 172): u'MISSING_TMP_RSA_KEY', (20, 217): u'REUSE_CERT_TYPE_NOT_ZERO', (20, 1046): u'SSLV3_ALERT_CERTIFICATE_UNKNOWN', (20, 309): u'DUPLICATE_COMPRESSION_ID', (20, 354): u'EMPTY_SRTP_PROTECTION_PROFILE_LIST', (20, 159): u'LENGTH_MISMATCH', (20, 212): u'READ_WRONG_PACKET_TYPE', (9, 105): u'NOT_DEK_INFO', (20, 288): u'KRB5_C_INIT', (20, 349): u'BAD_SRP_G_LENGTH', (20, 138): u'CIPHER_OR_HASH_UNAVAILABLE', (20, 199): u'PEER_DID_NOT_RETURN_A_CERTIFICATE', (20, 124): u'BAD_SSL_FILETYPE', (9, 126): u'UNSUPPORTED_KEY_COMPONENTS', (20, 275): u'SERVERHELLO_TLSEXT', (20, 328): u'INVALID_STATUS_RESPONSE', (20, 133): u'CCS_RECEIVED_EARLY', (11, 111): u'UNSUPPORTED_ALGORITHM', (20, 111): u'BAD_DIGEST_LENGTH', (9, 115): u'ERROR_CONVERTING_PRIVATE_KEY', (20, 270): u'PATH_TOO_LONG', (20, 187): u'NO_COMPRESSION_SPECIFIED', (20, 240): u'UNABLE_TO_FIND_SSL_METHOD', (11, 112): u'WRONG_LOOKUP_TYPE', (20, 1114): u'TLSV1_BAD_CERTIFICATE_HASH_VALUE', (20, 377): u'CERT_CB_ERROR', (20, 182): u'NO_CIPHERS_PASSED', (20, 227): u'PARSE_TLSEXT', (20, 1048): u'TLSV1_ALERT_UNKNOWN_CA', (20, 386): u'UNKNOWN_CMD_NAME', (20, 319): u'SSL3_EXT_INVALID_SERVERNAME', (20, 372): u'SSL_NEGATIVE_LENGTH', (20, 161): u'LIBRARY_HAS_NO_CIPHERS', (20, 222): u'SSL3_SESSION_ID_TOO_SHORT', (20, 1021): u'TLSV1_ALERT_DECRYPTION_FAILED', (20, 298): u'RECORD_TOO_SMALL', (20, 359): u'NO_SRTP_PROFILES', (20, 156): u'HTTP_REQUEST', (20, 201): u'PEER_ERROR_CERTIFICATE', (20, 1030): u'SSLV3_ALERT_DECOMPRESSION_FAILURE', (9, 100): u'BAD_BASE64_DECODE', (20, 293): u'KRB5_S_TKT_EXPIRED', (20, 338): u'UNSAFE_LEGACY_RENEGOTIATION_DISABLED', (20, 143): u'CONNECTION_ID_IS_DIFFERENT', (20, 196): u'NULL_SSL_METHOD_PASSED', (20, 113): u'BAD_MAC_DECODE', (9, 121): u'INCONSISTENT_HEADER', (20, 272): u'ATTEMPT_TO_REUSE_SESSION_IN_DIFFERENT_CONTEXT', (20, 333): u'BAD_MAC_LENGTH', (20, 250): u'UNKNOWN_KEY_EXCHANGE_TYPE', (11, 106): u'SHOULD_RETRY', (20, 108): u'BAD_DH_G_LENGTH', (20, 259): u'UNSUPPORTED_SSL_VERSION', (20, 184): u'NO_CIPHER_LIST', (20, 245): u'UNEXPECTED_RECORD', (11, 127): u'CRL_ALREADY_DELTA', (20, 382): u'MISSING_ECDH_CERT', (20, 171): u'MISSING_TMP_DH_KEY', (20, 224): u'PSK_NO_CLIENT_CB', (20, 391): u'PEM_NAME_BAD_PREFIX', (20, 316): u'BAD_PSK_IDENTITY_HINT_LENGTH', (20, 361): u'SRP_A_CALC', (20, 166): u'MISSING_EXPORT_TMP_DH_KEY', (20, 211): u'READ_BIO_NOT_SET', (20, 1010): u'SSLV3_ALERT_UNEXPECTED_MESSAGE', (20, 303): u'SSL_SESSION_ID_HAS_BAD_LENGTH', (20, 356): u'GOT_NEXT_PROTO_WITHOUT_EXTENSION', (20, 145): u'DATA_BETWEEN_CCS_AND_FINISHED', (20, 206): u'PROBLEMS_MAPPING_CIPHER_FUNCTIONS', (20, 123): u'BAD_SIGNATURE', (9, 103): u'BAD_IV_CHARS', (20, 282): u'ERROR_GENERATING_TMP_RSA_KEY', (20, 343): u'COMPRESSION_DISABLED', (20, 140): u'COMPRESSED_LENGTH_TOO_LONG', (11, 100): u'BAD_X509_FILETYPE', (20, 118): u'BAD_RSA_DECRYPT', (9, 116): u'BAD_MAGIC_NUMBER', (20, 277): u'SESSION_ID_CONTEXT_UNINITIALIZED', (20, 322): u'ECC_CERT_SHOULD_HAVE_RSA_SIGNATURE', (20, 255): u'UNKNOWN_STATE', (11, 105): u'NO_CERT_SET_FOR_US_TO_VERIFY', (20, 256): u'UNSUPPORTED_CIPHER', (20, 189): u'NO_PRIVATEKEY', (20, 234): u'TLS_RSA_ENCRYPTED_VALUE_LENGTH_IS_WRONG', (11, 122): u'WRONG_TYPE', (20, 371): u'BAD_SRP_PARAMETERS', (20, 168): u'MISSING_RSA_CERTIFICATE', (20, 229): u'SSL_HANDSHAKE_FAILURE', (20, 1042): u'SSLV3_ALERT_BAD_CERTIFICATE', (20, 388): u'INVALID_SERVERINFO_DATA', (20, 305): u'BAD_ECDSA_SIGNATURE', (20, 366): u'TLS_HEARTBEAT_PENDING', (20, 155): u'HTTPS_PROXY_REQUEST', (20, 208): u'PUBLIC_KEY_ENCRYPT_ERROR', (9, 109): u'PROBLEMS_GETTING_PASSWORD', (20, 300): u'SSL3_SESSION_ID_TOO_LONG', (20, 345): u'SCSV_RECEIVED_WHEN_RENEGOTIATING', (20, 150): u'ENCRYPTED_LENGTH_TOO_LONG', (20, 195): u'NULL_SSL_CTX', (20, 120): u'BAD_RSA_E_LENGTH', (20, 287): u'KRB5_C_GET_CRED', (20, 340): u'INCONSISTENT_COMPRESSION', (20, 129): u'BLOCK_CIPHER_PAD_IS_WRONG', (20, 1086): u'TLSV1_ALERT_INAPPROPRIATE_FALLBACK', (20, 107): u'BAD_DECOMPRESSION', (9, 119): u'EXPECTING_PRIVATE_KEY_BLOB', (20, 266): u'WRONG_SSL_VERSION', (20, 327): u'OPAQUE_PRF_INPUT_TOO_LONG', (20, 252): u'UNKNOWN_PROTOCOL', (11, 116): u'KEY_VALUES_MISMATCH', (20, 102): u'BAD_AUTHENTICATION_TYPE', (20, 261): u'WRONG_CIPHER_RETURNED', (20, 178): u'NO_CERTIFICATE_RETURNED', (20, 239): u'UNABLE_TO_FIND_PUBLIC_KEY_PARAMETERS', (20, 1060): u'TLSV1_ALERT_EXPORT_RESTRICTION', (20, 398): u'CA_MD_TOO_WEAK', (20, 315): u'UNSUPPORTED_ELLIPTIC_CURVE', (20, 368): u'UNKNOWN_DIGEST', (20, 173): u'MISSING_TMP_RSA_PKEY', (20, 218): u'REUSE_CIPHER_LIST_NOT_ZERO', (20, 1047): u'SSLV3_ALERT_ILLEGAL_PARAMETER', (20, 1100): u'TLSV1_ALERT_NO_RENEGOTIATION', (20, 310): u'ECGROUP_TOO_LARGE_FOR_CIPHER', (20, 355): u'GOT_NEXT_PROTO_BEFORE_A_CCS', (20, 152): u'EXCESSIVE_MESSAGE_SIZE', (20, 213): u'RECORD_LENGTH_MISMATCH', (9, 104): u'BAD_PASSWORD_READ', (20, 289): u'KRB5_C_MK_REQ', (20, 350): u'BAD_SRP_N_LENGTH', (20, 139): u'CIPHER_TABLE_SRC_ERROR', (20, 192): u'NO_PUBLICKEY', (20, 125): u'BAD_SSL_SESSION_ID_LENGTH', (9, 125): u'PVK_TOO_SHORT', (20, 284): u'KEY_ARG_TOO_LONG', (20, 329): u'UNSUPPORTED_STATUS_TYPE', (20, 134): u'CERTIFICATE_VERIFY_FAILED', (11, 110): u'AKID_MISMATCH', (20, 104): u'BAD_CHECKSUM', (9, 114): u'UNSUPPORTED_ENCRYPTION', (20, 271): u'BAD_LENGTH', (20, 324): u'NO_REQUIRED_DIGEST', (20, 241): u'UNABLE_TO_LOAD_SSL2_MD5_ROUTINES', (20, 1070): u'TLSV1_ALERT_PROTOCOL_VERSION'}
err_names_to_codes = {u'BAD_SRTP_PROTECTION_PROFILE_LIST': (20, 353), u'DH_PUBLIC_VALUE_LENGTH_IS_WRONG': (20, 148), u'PEER_ERROR_NO_CERTIFICATE': (20, 202), u'DTLS_MESSAGE_TOO_BIG': (20, 334), u'INVALID_SRP_USERNAME': (20, 357), u'BAD_VALUE': (20, 384), u'RENEGOTIATE_EXT_TOO_LONG': (20, 335), u'SSLV3_ALERT_CERTIFICATE_REVOKED': (20, 1044), u'SSL_SESSION_ID_CALLBACK_FAILED': (20, 301), u'NO_CERTIFICATE_SET': (20, 179), u'CONNECTION_ID_IS_DIFFERENT': (20, 143), u'KRB5_S_RD_REQ': (20, 292), u'SSL_LIBRARY_HAS_NO_CIPHERS': (20, 230), u'TLS_ILLEGAL_EXPORTER_LABEL': (20, 367), u'PACKET_LENGTH_TOO_LONG': (20, 198), u'NO_CERTIFICATES_RETURNED': (20, 176), u'NULL_SSL_CTX': (20, 195), u'READ_WRONG_PACKET_TYPE': (20, 212), u'DECRYPTION_FAILED': (20, 147), u'ECC_CERT_NOT_FOR_KEY_AGREEMENT': (20, 317), u'SIGNATURE_ALGORITHMS_ERROR': (20, 360), u'CCS_RECEIVED_EARLY': (20, 133), u'TLS_INVALID_ECPOINTFORMAT_LIST': (20, 157), u'NO_CIPHER_MATCH': (20, 185), u'WRONG_CURVE': (20, 378), u'UNKNOWN_CERTIFICATE_TYPE': (20, 247), u'CIPHER_IS_NULL': (9, 127), u'BAD_SSL_FILETYPE': (20, 124), u'BAD_MESSAGE_TYPE': (20, 114), u'CA_DN_TOO_LONG': (20, 132), u'SSL3_SESSION_ID_TOO_LONG': (20, 300), u'COMPRESSED_LENGTH_TOO_LONG': (20, 140), u'BAD_PACKET_LENGTH': (20, 115), u'TLSV1_ALERT_DECRYPT_ERROR': (20, 1051), u'PVK_TOO_SHORT': (9, 125), u'SSLV3_ALERT_ILLEGAL_PARAMETER': (20, 1047), u'ERROR_CONVERTING_PRIVATE_KEY': (9, 115), u'SCSV_RECEIVED_WHEN_RENEGOTIATING': (20, 345), u'KRB5_S_TKT_SKEW': (20, 295), u'INVALID_NULL_CMD_NAME': (20, 385), u'BAD_DH_PUB_KEY_LENGTH': (20, 109), u'TLSV1_ALERT_DECODE_ERROR': (20, 1050), u'BAD_SRP_N_LENGTH': (20, 350), u'PUBLIC_KEY_NOT_RSA': (20, 210), u'MISSING_SRP_PARAM': (20, 358), u'EXPECTING_PUBLIC_KEY_BLOB': (9, 120), u'SSLV3_ALERT_CERTIFICATE_UNKNOWN': (20, 1046), u'WRONG_SIGNATURE_TYPE': (20, 370), u'METHOD_NOT_SUPPORTED': (11, 124), u'TLSV1_BAD_CERTIFICATE_HASH_VALUE': (20, 1114), u'BN_LIB': (20, 130), u'MISSING_EXPORT_TMP_DH_KEY': (20, 166), u'ECDH_REQUIRED_FOR_SUITEB_MODE': (20, 374), u'KRB5_S_TKT_NYV': (20, 294), u'EMPTY_SRTP_PROTECTION_PROFILE_LIST': (20, 354), u'UNSUPPORTED_SSL_VERSION': (20, 259), u'PEM_NAME_BAD_PREFIX': (20, 391), u'UNKNOWN_KEY_TYPE': (11, 117), u'WRITE_BIO_NOT_SET': (20, 260), u'NOT_PROC_TYPE': (9, 107), u'EXCESSIVE_MESSAGE_SIZE': (20, 152), u'UNABLE_TO_EXTRACT_PUBLIC_KEY': (20, 237), u'UNSUPPORTED_ELLIPTIC_CURVE': (20, 315), u'SSLV3_ALERT_UNEXPECTED_MESSAGE': (20, 1010), u'MISSING_DH_RSA_CERT': (20, 164), u'CIPHER_OR_HASH_UNAVAILABLE': (20, 138), u'BAD_RSA_SIGNATURE': (20, 122), u'PEM_NAME_TOO_SHORT': (20, 392), u'UNKNOWN_CMD_NAME': (20, 386), u'UNABLE_TO_LOAD_SSL2_MD5_ROUTINES': (20, 241), u'TLSV1_ALERT_PROTOCOL_VERSION': (20, 1070), u'USE_SRTP_NOT_NEGOTIATED': (20, 369), u'KEYBLOB_HEADER_PARSE_ERROR': (9, 122), u'UNSAFE_LEGACY_RENEGOTIATION_DISABLED': (20, 338), u'UNINITIALIZED': (20, 276), u'UNABLE_TO_FIND_SSL_METHOD': (20, 240), u'HTTP_REQUEST': (20, 156), u'KRB5_C_INIT': (20, 288), u'UNSUPPORTED_COMPRESSION_ALGORITHM': (20, 257), u'HTTPS_PROXY_REQUEST': (20, 155), u'INVALID_COMMAND': (20, 280), u'BAD_ECPOINT': (20, 306), u'NON_SSLV2_INITIAL_PACKET': (20, 175), u'COMPRESSION_ID_NOT_WITHIN_PRIVATE_RANGE': (20, 307), u'X509_VERIFICATION_SETUP_PROBLEMS': (20, 269), u'SSL23_DOING_SESSION_ID_REUSE': (20, 221), u'SSLV3_ALERT_NO_CERTIFICATE': (20, 1041), u'TLSV1_UNRECOGNIZED_NAME': (20, 1112), u'BAD_DECOMPRESSION': (20, 107), u'TLSV1_ALERT_RECORD_OVERFLOW': (20, 1022), u'NO_CERT_SET_FOR_US_TO_VERIFY': (11, 105), u'REUSE_CERT_TYPE_NOT_ZERO': (20, 217), u'KEY_ARG_TOO_LONG': (20, 284), u'UNKNOWN_NID': (11, 109), u'OPAQUE_PRF_INPUT_TOO_LONG': (20, 327), u'NO_PRIVATEKEY': (20, 189), u'BAD_SSL_SESSION_ID_LENGTH': (20, 125), u'TLSV1_ALERT_INSUFFICIENT_SECURITY': (20, 1071), u'NO_SHARED_CIPHER': (20, 193), u'TLS_PEER_DID_NOT_RESPOND_WITH_CERTIFICATE_LIST': (20, 233), u'CERT_ALREADY_IN_HASH_TABLE': (11, 101), u'INVALID_SERVERINFO_DATA': (20, 388), u'CLIENTHELLO_TLSEXT': (20, 226), u'CRL_ALREADY_DELTA': (11, 127), u'UNKNOWN_ALERT_TYPE': (20, 246), u'REQUIRED_COMPRESSSION_ALGORITHM_MISSING': (20, 342), u'BAD_STATE': (20, 126), u'ONLY_TLS_ALLOWED_IN_FIPS_MODE': (20, 297), u'SSL2_CONNECTION_ID_TOO_LONG': (20, 299), u'INVALID_FIELD_NAME': (11, 119), u'MISSING_RSA_ENCRYPTING_CERT': (20, 169), u'UNABLE_TO_FIND_DH_PARAMETERS': (20, 238), u'CRL_VERIFY_FAILURE': (11, 131), u'MISSING_VERIFY_MESSAGE': (20, 174), u'SIGNATURE_FOR_NON_SIGNING_CERTIFICATE': (20, 220), u'BAD_CHANGE_CIPHER_SPEC': (20, 103), u'DH_KEY_TOO_SMALL': (20, 372), u'APP_DATA_IN_HANDSHAKE': (20, 100), u'UNKNOWN_PROTOCOL': (20, 252), u'SSL3_EXT_INVALID_ECPOINTFORMAT': (20, 321), u'RECORD_TOO_LARGE': (20, 214), u'BAD_VERSION_NUMBER': (9, 117), u'UNKNOWN_DIGEST': (20, 368), u'WRONG_SIGNATURE_SIZE': (20, 265), u'WRONG_MESSAGE_TYPE': (20, 262), u'WRONG_LOOKUP_TYPE': (11, 112), u'CA_MD_TOO_WEAK': (20, 398), u'SESSION_ID_CONTEXT_UNINITIALIZED': (20, 277), u'TLS_HEARTBEAT_PEER_DOESNT_ACCEPT': (20, 365), u'UNABLE_TO_DECODE_DH_CERTS': (20, 236), u'BAD_AUTHENTICATION_TYPE': (20, 102), u'UNSUPPORTED_PROTOCOL': (20, 258), u'GOT_NEXT_PROTO_BEFORE_A_CCS': (20, 355), u'MESSAGE_TOO_LONG': (20, 296), u'GOT_NEXT_PROTO_WITHOUT_EXTENSION': (20, 356), u'NO_CIPHER_LIST': (20, 184), u'NO_METHOD_SPECIFIED': (20, 188), u'LENGTH_TOO_SHORT': (20, 160), u'BAD_HANDSHAKE_LENGTH': (20, 332), u'UNKNOWN_PURPOSE_ID': (11, 121), u'DIGEST_CHECK_FAILED': (20, 149), u'UNKNOWN_STATE': (20, 255), u'UNEXPECTED_MESSAGE': (20, 244), u'CA_KEY_TOO_SMALL': (20, 397), u'PROTOCOL_IS_SHUTDOWN': (20, 207), u'ECC_CERT_SHOULD_HAVE_SHA1_SIGNATURE': (20, 323), u'SSLV3_ALERT_BAD_CERTIFICATE': (20, 1042), u'NO_REQUIRED_DIGEST': (20, 324), u'KEYBLOB_TOO_SHORT': (9, 123), u'SSLV3_ALERT_BAD_RECORD_MAC': (20, 1020), u'GOT_A_FIN_BEFORE_A_CCS': (20, 154), u'INVALID_TICKET_KEYS_LENGTH': (20, 325), u'ECC_CERT_NOT_FOR_SIGNING': (20, 318), u'ILLEGAL_PADDING': (20, 283), u'EXTRA_DATA_IN_MESSAGE': (20, 153), u'MISSING_EXPORT_TMP_RSA_KEY': (20, 167), u'PROBLEMS_GETTING_PASSWORD': (9, 109), u'LIBRARY_HAS_NO_CIPHERS': (20, 161), u'LENGTH_MISMATCH': (20, 159), u'BAD_PSK_IDENTITY_HINT_LENGTH': (20, 316), u'PVK_DATA_TOO_SHORT': (9, 124), u'CONNECTION_TYPE_NOT_SET': (20, 144), u'UNABLE_TO_DECODE_ECDH_CERTS': (20, 313), u'BAD_WRITE_RETRY': (20, 127), u'WRONG_CIPHER_RETURNED': (20, 261), u'BAD_SIGNATURE': (20, 123), u'BAD_SRP_A_LENGTH': (20, 347), u'MISSING_RSA_SIGNING_CERT': (20, 170), u'SSL3_EXT_INVALID_SERVERNAME_TYPE': (20, 320), u'KRB5_C_CC_PRINC': (20, 286), u'KRB5': (20, 285), u'UNKNOWN_CIPHER_RETURNED': (20, 248), u'LOADING_CERT_DIR': (11, 103), u'PEER_ERROR_NO_CIPHER': (20, 203), u'AKID_MISMATCH': (11, 110), u'SHORT_HEADER': (9, 112), u'LIBRARY_BUG': (20, 274), u'KRB5_C_MK_REQ': (20, 289), u'REUSE_CIPHER_LIST_NOT_ZERO': (20, 218), u'NO_CRL_NUMBER': (11, 130), u'KRB5_C_GET_CRED': (20, 287), u'KRB5_S_BAD_TICKET': (20, 290), u'MISSING_TMP_ECDH_KEY': (20, 311), u'UNSUPPORTED_STATUS_TYPE': (20, 329), u'VERSION_TOO_LOW': (20, 396), u'DUPLICATE_COMPRESSION_ID': (20, 309), u'UNKNOWN_PKEY_TYPE': (20, 251), u'SSL_SESSION_ID_IS_DIFFERENT': (20, 231), u'BAD_ALERT_RECORD': (20, 101), u'TLSV1_UNSUPPORTED_EXTENSION': (20, 1110), u'BAD_DECRYPT': (9, 101), u'SRTP_PROTECTION_PROFILE_LIST_TOO_LONG': (20, 363), u'NO_PEM_EXTENSIONS': (20, 389), u'OLD_SESSION_COMPRESSION_ALGORITHM_NOT_RETURNED': (20, 344), u'KEY_VALUES_MISMATCH': (11, 116), u'NO_GOST_CERTIFICATE_SENT_BY_PEER': (20, 330), u'NO_PUBLICKEY': (20, 192), u'ONLY_TLS_1_2_ALLOWED_IN_SUITEB_MODE': (20, 379), u'WRONG_TYPE': (11, 122), u'BAD_CHECKSUM': (20, 104), u'KEY_TYPE_MISMATCH': (11, 115), u'BAD_BASE64_DECODE': (9, 100), u'BAD_SRP_G_LENGTH': (20, 349), u'TLSV1_ALERT_INTERNAL_ERROR': (20, 1080), u'SSL_NEGATIVE_LENGTH': (20, 372), u'BAD_LENGTH': (20, 271), u'ERR_ASN1_LIB': (11, 102), u'NEWER_CRL_NOT_NEWER': (11, 132), u'WRONG_VERSION_NUMBER': (20, 267), u'NO_COMPRESSION_SPECIFIED': (20, 187), u'SSL_HANDSHAKE_FAILURE': (20, 229), u'NOT_ENCRYPTED': (9, 106), u'BAD_END_LINE': (9, 102), u'PUBLIC_KEY_IS_NOT_RSA': (20, 209), u'BAD_DH_G_LENGTH': (20, 108), u'INVALID_TRUST': (11, 123), u'INCONSISTENT_HEADER': (9, 121), u'ERROR_GENERATING_TMP_RSA_KEY': (20, 282), u'SSL3_EXT_INVALID_SERVERNAME': (20, 319), u'UNSUPPORTED_ALGORITHM': (11, 111), u'SSLV3_ALERT_UNSUPPORTED_CERTIFICATE': (20, 1043), u'PSK_IDENTITY_NOT_FOUND': (20, 223), u'UNABLE_TO_GET_CERTS_PUBLIC_KEY': (11, 108), u'INVALID_PURPOSE': (20, 278), u'INVALID_DIRECTORY': (11, 113), u'SSL_CTX_HAS_NO_DEFAULT_SSL_VERSION': (20, 228), u'RECORD_LENGTH_MISMATCH': (20, 213), u'SSL_SESSION_ID_CONFLICT': (20, 302), u'INCONSISTENT_COMPRESSION': (20, 340), u'SERVERHELLO_TLSEXT': (20, 275), u'SSL3_SESSION_ID_TOO_SHORT': (20, 222), u'NO_CIPHERS_SPECIFIED': (20, 183), u'KRB5_S_INIT': (20, 291), u'TLSV1_ALERT_USER_CANCELLED': (20, 1090), u'ONLY_DTLS_1_2_ALLOWED_IN_SUITEB_MODE': (20, 387), u'WRONG_SSL_VERSION': (20, 266), u'TLSV1_ALERT_UNKNOWN_CA': (20, 1048), u'SRP_A_CALC': (20, 361), u'SRTP_COULD_NOT_ALLOCATE_PROFILES': (20, 362), u'BAD_RSA_MODULUS_LENGTH': (20, 121), u'COMPRESSION_FAILURE': (20, 141), u'INVALID_STATUS_RESPONSE': (20, 328), u'TLS_RSA_ENCRYPTED_VALUE_LENGTH_IS_WRONG': (20, 234), u'INVALID_COMPRESSION_ALGORITHM': (20, 341), u'READ_TIMEOUT_EXPIRED': (20, 312), u'UNABLE_TO_LOAD_SSL3_MD5_ROUTINES': (20, 242), u'PRE_MAC_LENGTH_TOO_LONG': (20, 205), u'PROBLEMS_MAPPING_CIPHER_FUNCTIONS': (20, 206), u'BAD_DIGEST_LENGTH': (20, 111), u'PEER_ERROR_UNSUPPORTED_CERTIFICATE_TYPE': (20, 204), u'UNABLE_TO_FIND_PUBLIC_KEY_PARAMETERS': (20, 239), u'NO_VERIFY_CALLBACK': (20, 194), u'BAD_SRP_S_LENGTH': (20, 351), u'SHORT_READ': (20, 219), u'NO_SHARED_SIGATURE_ALGORITHMS': (20, 376), u'SSL_SESSION_ID_HAS_BAD_LENGTH': (20, 303), u'X509_LIB': (20, 268), u'TRIED_TO_USE_UNSUPPORTED_CIPHER': (20, 235), u'PUBLIC_KEY_ENCODE_ERROR': (11, 126), u'TLSV1_CERTIFICATE_UNOBTAINABLE': (20, 1111), u'CERTIFICATE_VERIFY_FAILED': (20, 134), u'WRONG_NUMBER_OF_KEY_BITS': (20, 263), u'KRB5_S_TKT_EXPIRED': (20, 293), u'TLSV1_ALERT_INAPPROPRIATE_FALLBACK': (20, 1086), u'UNKNOWN_SSL_VERSION': (20, 254), u'TLSV1_ALERT_ACCESS_DENIED': (20, 1049), u'BAD_RSA_E_LENGTH': (20, 120), u'ISSUER_MISMATCH': (11, 129), u'MISSING_DH_DSA_CERT': (20, 162), u'MISSING_ECDH_CERT': (20, 382), u'MISSING_TMP_RSA_KEY': (20, 172), u'BAD_RSA_DECRYPT': (20, 118), u'NO_CERTIFICATE_SPECIFIED': (20, 180), u'OLD_SESSION_CIPHER_NOT_RETURNED': (20, 197), u'MISSING_RSA_CERTIFICATE': (20, 168), u'UNABLE_TO_FIND_ECDH_PARAMETERS': (20, 314), u'PEER_ERROR': (20, 200), u'ILLEGAL_SUITEB_DIGEST': (20, 380), u'RENEGOTIATION_ENCODING_ERR': (20, 336), u'INAPPROPRIATE_FALLBACK': (20, 373), u'PSK_NO_SERVER_CB': (20, 225), u'PUBLIC_KEY_DECODE_ERROR': (11, 125), u'PSK_NO_CLIENT_CB': (20, 224), u'UNABLE_TO_LOAD_SSL3_SHA1_ROUTINES': (20, 243), u'NO_CLIENT_CERT_METHOD': (20, 331), u'BAD_PROTOCOL_VERSION_NUMBER': (20, 116), u'CA_DN_LENGTH_MISMATCH': (20, 131), u'COMPRESSION_LIBRARY_ERROR': (20, 142), u'EE_KEY_TOO_SMALL': (20, 399), u'MISSING_TMP_DH_KEY': (20, 171), u'UNSUPPORTED_DIGEST_TYPE': (20, 326), u'SSLV3_ALERT_CERTIFICATE_EXPIRED': (20, 1045), u'UNKNOWN_KEY_EXCHANGE_TYPE': (20, 250), u'NO_START_LINE': (9, 108), u'ERROR_IN_RECEIVED_CIPHER_LIST': (20, 151), u'PATH_TOO_LONG': (20, 270), u'MISSING_DH_KEY': (20, 163), u'READ_KEY': (9, 111), u'BAD_SRP_B_LENGTH': (20, 348), u'CHALLENGE_IS_DIFFERENT': (20, 136), u'SHOULD_RETRY': (11, 106), u'SSLV3_ALERT_DECOMPRESSION_FAILURE': (20, 1030), u'TLSV1_BAD_CERTIFICATE_STATUS_RESPONSE': (20, 1113), u'CERT_CB_ERROR': (20, 377), u'DATA_BETWEEN_CCS_AND_FINISHED': (20, 145), u'NO_PRIVATE_KEY_ASSIGNED': (20, 190), u'BAD_DSA_SIGNATURE': (20, 112), u'NULL_SSL_METHOD_PASSED': (20, 196), u'BAD_SRP_PARAMETERS': (20, 371), u'PEER_ERROR_CERTIFICATE': (20, 201), u'CIPHER_CODE_WRONG_LENGTH': (20, 137), u'BAD_ECDSA_SIGNATURE': (20, 305), u'BAD_ECC_CERT': (20, 304), u'BAD_MAGIC_NUMBER': (9, 116), u'BAD_SRTP_MKI_VALUE': (20, 352), u'BASE64_DECODE_ERROR': (11, 118), u'CIPHER_TABLE_SRC_ERROR': (20, 139), u'COMPRESSION_DISABLED': (20, 343), u'UNSUPPORTED_ENCRYPTION': (9, 114), u'MISSING_ECDSA_SIGNING_CERT': (20, 381), u'MISSING_DSA_SIGNING_CERT': (20, 165), u'SRTP_UNKNOWN_PROTECTION_PROFILE': (20, 364), u'PARSE_TLSEXT': (20, 227), u'REQUIRED_CIPHER_MISSING': (20, 215), u'NO_CLIENT_CERT_RECEIVED': (20, 186), u'ATTEMPT_TO_REUSE_SESSION_IN_DIFFERENT_CONTEXT': (20, 272), u'TLS_HEARTBEAT_PENDING': (20, 366), u'MISSING_TMP_RSA_PKEY': (20, 173), u'NO_CERTIFICATE_ASSIGNED': (20, 177), u'NO_SRTP_PROFILES': (20, 359), u'REUSE_CERT_LENGTH_NOT_ZERO': (20, 216), u'LOADING_DEFAULTS': (11, 104), u'BAD_X509_FILETYPE': (11, 100), u'BIO_NOT_SET': (20, 128), u'BIO_WRITE_FAILURE': (9, 118), u'NO_PROTOCOLS_AVAILABLE': (20, 191), u'CERT_LENGTH_MISMATCH': (20, 135), u'UNKNOWN_TRUST_ID': (11, 120), u'NO_CIPHERS_PASSED': (20, 182), u'TLS_CLIENT_CERT_REQ_WITH_ANON_CIPHER': (20, 232), u'PEER_DID_NOT_RETURN_A_CERTIFICATE': (20, 199), u'PUBLIC_KEY_NO_RSA': (9, 110), u'CANT_CHECK_DH_KEY': (11, 114), u'BAD_DATA': (20, 390), u'BAD_DATA_RETURNED_BY_CALLBACK': (20, 106), u'DECRYPTION_FAILED_OR_BAD_RECORD_MAC': (20, 281), u'BAD_IV_CHARS': (9, 103), u'NO_CIPHERS_AVAILABLE': (20, 181), u'DATA_LENGTH_TOO_LONG': (20, 146), u'BAD_MAC_LENGTH': (20, 333), u'BAD_HELLO_REQUEST': (20, 105), u'ECC_CERT_SHOULD_HAVE_RSA_SIGNATURE': (20, 322), u'UNSUPPORTED_KEY_COMPONENTS': (9, 126), u'UNSUPPORTED_CIPHER': (20, 256), u'RECORD_TOO_SMALL': (20, 298), u'ENCRYPTED_LENGTH_TOO_LONG': (20, 150), u'NO_RENEGOTIATION': (20, 339), u'BAD_RESPONSE_ARGUMENT': (20, 117), u'SSLV3_ALERT_HANDSHAKE_FAILURE': (20, 1040), u'NOT_DEK_INFO': (9, 105), u'BAD_RSA_ENCRYPT': (20, 119), u'WRONG_CERTIFICATE_TYPE': (20, 383), u'UNKNOWN_REMOTE_ERROR_TYPE': (20, 253), u'MULTIPLE_SGC_RESTARTS': (20, 346), u'RENEGOTIATION_MISMATCH': (20, 337), u'READ_BIO_NOT_SET': (20, 211), u'WRONG_SIGNATURE_LENGTH': (20, 264), u'IDP_MISMATCH': (11, 128), u'UNKNOWN_CIPHER_TYPE': (20, 249), u'TLSV1_ALERT_DECRYPTION_FAILED': (20, 1021), u'BAD_DH_P_LENGTH': (20, 110), u'SSL_SESSION_ID_CONTEXT_TOO_LONG': (20, 273), u'NO_CERTIFICATE_RETURNED': (20, 178), u'PUBLIC_KEY_ENCRYPT_ERROR': (20, 208), u'TLSV1_ALERT_EXPORT_RESTRICTION': (20, 1060), u'BAD_MAC_DECODE': (20, 113), u'BAD_PASSWORD_READ': (9, 104), u'TLSV1_ALERT_NO_RENEGOTIATION': (20, 1100), u'INVALID_CHALLENGE_LENGTH': (20, 158), u'UNABLE_TO_FIND_PARAMETERS_IN_CHAIN': (11, 107), u'EXPECTING_PRIVATE_KEY_BLOB': (9, 119), u'ECGROUP_TOO_LARGE_FOR_CIPHER': (20, 310), u'BLOCK_CIPHER_PAD_IS_WRONG': (20, 129), u'UNEXPECTED_RECORD': (20, 245), u'COOKIE_MISMATCH': (20, 308)}
def get_default_verify_paths(*args, **kwargs): pass
lib_codes_to_names = {20L: u'SSL', 9L: u'PEM', 11L: u'X509'}
def nid2obj(*args, **kwargs): pass
def txt2obj(*args, **kwargs): pass