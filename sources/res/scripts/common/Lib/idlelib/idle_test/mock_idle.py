from idlelib.idle_test.mock_tk import Text

class Editor(object):

    def __init__(self, flist=None, filename=None, key=None, root=None):
        self.text = Text()
        self.undo = UndoDelegator()

    def get_selection_indices(self):
        first = self.text.index('1.0')
        last = self.text.index('end')
        return (first, last)


class UndoDelegator(object):

    def undo_block_start(*args):
        pass

    def undo_block_stop(*args):
        pass