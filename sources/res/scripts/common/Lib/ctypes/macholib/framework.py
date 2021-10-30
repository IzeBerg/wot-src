import re
__all__ = [
 'framework_info']
STRICT_FRAMEWORK_RE = re.compile('(?x)\n(?P<location>^.*)(?:^|/)\n(?P<name>\n    (?P<shortname>\\w+).framework/\n    (?:Versions/(?P<version>[^/]+)/)?\n    (?P=shortname)\n    (?:_(?P<suffix>[^_]+))?\n)$\n')

def framework_info(filename):
    is_framework = STRICT_FRAMEWORK_RE.match(filename)
    if not is_framework:
        return None
    else:
        return is_framework.groupdict()


def test_framework_info():

    def d(location=None, name=None, shortname=None, version=None, suffix=None):
        return dict(location=location, name=name, shortname=shortname, version=version, suffix=suffix)

    return


if __name__ == '__main__':
    test_framework_info()