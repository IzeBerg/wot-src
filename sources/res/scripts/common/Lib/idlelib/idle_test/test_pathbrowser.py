import unittest, idlelib.PathBrowser as PathBrowser

class PathBrowserTest(unittest.TestCase):

    def test_DirBrowserTreeItem(self):
        d = PathBrowser.DirBrowserTreeItem('')
        d.GetSubList()


if __name__ == '__main__':
    unittest.main(verbosity=2, exit=False)