import unittest, Tkinter as tkinter
from Tkinter import TclError
import ttk
from test.test_support import requires, run_unittest, have_unicode, u
import sys
from test_functions import MockTclObj
from support import AbstractTkTest, tcl_version, get_tk_patchlevel, simulate_mouse_click
from widget_tests import add_standard_options, noconv, noconv_meth, AbstractWidgetTest, StandardOptionsTests, IntegerSizeTests, PixelSizeTests, setUpModule
requires('gui')

class StandardTtkOptionsTests(StandardOptionsTests):

    def test_class(self):
        widget = self.create()
        self.assertEqual(widget['class'], '')
        errmsg = 'attempt to change read-only option'
        if get_tk_patchlevel() < (8, 6, 0, 'beta', 3):
            errmsg = 'Attempt to change read-only option'
        self.checkInvalidParam(widget, 'class', 'Foo', errmsg=errmsg)
        widget2 = self.create(class_='Foo')
        self.assertEqual(widget2['class'], 'Foo')

    def test_padding(self):
        widget = self.create()
        self.checkParam(widget, 'padding', 0, expected=('0', ))
        self.checkParam(widget, 'padding', 5, expected=('5', ))
        self.checkParam(widget, 'padding', (5, 6), expected=('5', '6'))
        self.checkParam(widget, 'padding', (5, 6, 7), expected=('5', '6', '7'))
        self.checkParam(widget, 'padding', (5, 6, 7, 8), expected=('5', '6', '7', '8'))
        self.checkParam(widget, 'padding', ('5p', '6p', '7p', '8p'))
        self.checkParam(widget, 'padding', (), expected='')

    def test_style(self):
        widget = self.create()
        self.assertEqual(widget['style'], '')
        errmsg = 'Layout Foo not found'
        if hasattr(self, 'default_orient'):
            errmsg = 'Layout %s.Foo not found' % getattr(self, 'default_orient').title()
        self.checkInvalidParam(widget, 'style', 'Foo', errmsg=errmsg)
        widget2 = self.create(class_='Foo')
        self.assertEqual(widget2['class'], 'Foo')


class WidgetTest(AbstractTkTest, unittest.TestCase):

    def setUp(self):
        super(WidgetTest, self).setUp()
        self.widget = ttk.Button(self.root, width=0, text='Text')
        self.widget.pack()
        self.widget.wait_visibility()

    def test_identify(self):
        self.widget.update_idletasks()
        self.assertEqual(self.widget.identify(self.widget.winfo_width() // 2, self.widget.winfo_height() // 2), 'label')
        self.assertEqual(self.widget.identify(-1, -1), '')
        self.assertRaises(tkinter.TclError, self.widget.identify, None, 5)
        self.assertRaises(tkinter.TclError, self.widget.identify, 5, None)
        self.assertRaises(tkinter.TclError, self.widget.identify, 5, '')
        return

    def test_widget_state(self):
        self.assertEqual(self.widget.state(), ())
        self.assertEqual(self.widget.instate(['!disabled']), True)
        self.assertEqual(self.widget.state(['disabled']), ('!disabled', ))
        self.assertEqual(self.widget.state(['disabled']), ())
        self.assertEqual(self.widget.state(['!disabled', 'active']), ('!active', 'disabled'))
        self.assertEqual(self.widget.state(['!disabled', 'active']), ())
        self.assertEqual(self.widget.state(['active', '!disabled']), ())

        def test_cb(arg1, **kw):
            return (
             arg1, kw)

        self.assertEqual(self.widget.instate(['!disabled'], test_cb, 'hi', **{'msg': 'there'}), (
         'hi', {'msg': 'there'}))
        currstate = self.widget.state()
        self.assertRaises(tkinter.TclError, self.widget.instate, [
         'badstate'])
        self.assertRaises(tkinter.TclError, self.widget.instate, [
         'disabled', 'badstate'])
        self.assertEqual(currstate, self.widget.state())
        self.widget.state(['active', '!disabled'])
        self.assertEqual(self.widget.state(), ('active', ))


class AbstractToplevelTest(AbstractWidgetTest, PixelSizeTests):
    _conv_pixels = noconv_meth


@add_standard_options(StandardTtkOptionsTests)
class FrameTest(AbstractToplevelTest, unittest.TestCase):
    OPTIONS = ('borderwidth', 'class', 'cursor', 'height', 'padding', 'relief', 'style',
               'takefocus', 'width')

    def create(self, **kwargs):
        return ttk.Frame(self.root, **kwargs)


@add_standard_options(StandardTtkOptionsTests)
class LabelFrameTest(AbstractToplevelTest, unittest.TestCase):
    OPTIONS = ('borderwidth', 'class', 'cursor', 'height', 'labelanchor', 'labelwidget',
               'padding', 'relief', 'style', 'takefocus', 'text', 'underline', 'width')

    def create(self, **kwargs):
        return ttk.LabelFrame(self.root, **kwargs)

    def test_labelanchor(self):
        widget = self.create()
        self.checkEnumParam(widget, 'labelanchor', 'e', 'en', 'es', 'n', 'ne', 'nw', 's', 'se', 'sw', 'w', 'wn', 'ws', errmsg='Bad label anchor specification {}')
        self.checkInvalidParam(widget, 'labelanchor', 'center')

    def test_labelwidget(self):
        widget = self.create()
        label = ttk.Label(self.root, text='Mupp', name='foo')
        self.checkParam(widget, 'labelwidget', label, expected='.foo')
        label.destroy()


class AbstractLabelTest(AbstractWidgetTest):

    def checkImageParam(self, widget, name):
        image = tkinter.PhotoImage(master=self.root, name='image1')
        image2 = tkinter.PhotoImage(master=self.root, name='image2')
        self.checkParam(widget, name, image, expected=('image1', ))
        self.checkParam(widget, name, 'image1', expected=('image1', ))
        self.checkParam(widget, name, (image,), expected=('image1', ))
        self.checkParam(widget, name, (image, 'active', image2), expected=('image1',
                                                                           'active',
                                                                           'image2'))
        self.checkParam(widget, name, 'image1 active image2', expected=('image1', 'active',
                                                                        'image2'))
        self.checkInvalidParam(widget, name, 'spam', errmsg='image "spam" doesn\'t exist')

    def test_compound(self):
        widget = self.create()
        self.checkEnumParam(widget, 'compound', 'none', 'text', 'image', 'center', 'top', 'bottom', 'left', 'right')

    def test_state(self):
        widget = self.create()
        self.checkParams(widget, 'state', 'active', 'disabled', 'normal')

    def test_width(self):
        widget = self.create()
        self.checkParams(widget, 'width', 402, -402, 0)


@add_standard_options(StandardTtkOptionsTests)
class LabelTest(AbstractLabelTest, unittest.TestCase):
    OPTIONS = ('anchor', 'background', 'borderwidth', 'class', 'compound', 'cursor',
               'font', 'foreground', 'image', 'justify', 'padding', 'relief', 'state',
               'style', 'takefocus', 'text', 'textvariable', 'underline', 'width',
               'wraplength')
    _conv_pixels = noconv_meth

    def create(self, **kwargs):
        return ttk.Label(self.root, **kwargs)

    def test_font(self):
        widget = self.create()
        self.checkParam(widget, 'font', '-Adobe-Helvetica-Medium-R-Normal--*-120-*-*-*-*-*-*')


@add_standard_options(StandardTtkOptionsTests)
class ButtonTest(AbstractLabelTest, unittest.TestCase):
    OPTIONS = ('class', 'command', 'compound', 'cursor', 'default', 'image', 'padding',
               'state', 'style', 'takefocus', 'text', 'textvariable', 'underline',
               'width')

    def create(self, **kwargs):
        return ttk.Button(self.root, **kwargs)

    def test_default(self):
        widget = self.create()
        self.checkEnumParam(widget, 'default', 'normal', 'active', 'disabled')

    def test_invoke(self):
        success = []
        btn = ttk.Button(self.root, command=lambda : success.append(1))
        btn.invoke()
        self.assertTrue(success)


@add_standard_options(StandardTtkOptionsTests)
class CheckbuttonTest(AbstractLabelTest, unittest.TestCase):
    OPTIONS = ('class', 'command', 'compound', 'cursor', 'image', 'offvalue', 'onvalue',
               'padding', 'state', 'style', 'takefocus', 'text', 'textvariable',
               'underline', 'variable', 'width')

    def create(self, **kwargs):
        return ttk.Checkbutton(self.root, **kwargs)

    def test_offvalue(self):
        widget = self.create()
        self.checkParams(widget, 'offvalue', 1, 2.3, '', 'any string')

    def test_onvalue(self):
        widget = self.create()
        self.checkParams(widget, 'onvalue', 1, 2.3, '', 'any string')

    def test_invoke(self):
        success = []

        def cb_test():
            success.append(1)
            return 'cb test called'

        cbtn = ttk.Checkbutton(self.root, command=cb_test)
        self.assertEqual(cbtn.state(), ('alternate', ))
        self.assertRaises(tkinter.TclError, cbtn.tk.globalgetvar, cbtn['variable'])
        res = cbtn.invoke()
        self.assertEqual(res, 'cb test called')
        self.assertEqual(cbtn['onvalue'], cbtn.tk.globalgetvar(cbtn['variable']))
        self.assertTrue(success)
        cbtn['command'] = ''
        res = cbtn.invoke()
        self.assertFalse(str(res))
        self.assertLessEqual(len(success), 1)
        self.assertEqual(cbtn['offvalue'], cbtn.tk.globalgetvar(cbtn['variable']))


@add_standard_options(IntegerSizeTests, StandardTtkOptionsTests)
class EntryTest(AbstractWidgetTest, unittest.TestCase):
    OPTIONS = ('background', 'class', 'cursor', 'exportselection', 'font', 'foreground',
               'invalidcommand', 'justify', 'show', 'state', 'style', 'takefocus',
               'textvariable', 'validate', 'validatecommand', 'width', 'xscrollcommand')

    def setUp(self):
        super(EntryTest, self).setUp()
        self.entry = self.create()

    def create(self, **kwargs):
        return ttk.Entry(self.root, **kwargs)

    def test_invalidcommand(self):
        widget = self.create()
        self.checkCommandParam(widget, 'invalidcommand')

    def test_show(self):
        widget = self.create()
        self.checkParam(widget, 'show', '*')
        self.checkParam(widget, 'show', '')
        self.checkParam(widget, 'show', ' ')

    def test_state(self):
        widget = self.create()
        self.checkParams(widget, 'state', 'disabled', 'normal', 'readonly')

    def test_validate(self):
        widget = self.create()
        self.checkEnumParam(widget, 'validate', 'all', 'key', 'focus', 'focusin', 'focusout', 'none')

    def test_validatecommand(self):
        widget = self.create()
        self.checkCommandParam(widget, 'validatecommand')

    def test_bbox(self):
        self.assertIsBoundingBox(self.entry.bbox(0))
        self.assertRaises(tkinter.TclError, self.entry.bbox, 'noindex')
        self.assertRaises(tkinter.TclError, self.entry.bbox, None)
        return

    def test_identify(self):
        self.entry.pack()
        self.entry.wait_visibility()
        self.entry.update_idletasks()
        if sys.platform == 'darwin':
            self.assertIn(self.entry.identify(5, 5), ('textarea', 'Combobox.button'))
        else:
            self.assertEqual(self.entry.identify(5, 5), 'textarea')
        self.assertEqual(self.entry.identify(-1, -1), '')
        self.assertRaises(tkinter.TclError, self.entry.identify, None, 5)
        self.assertRaises(tkinter.TclError, self.entry.identify, 5, None)
        self.assertRaises(tkinter.TclError, self.entry.identify, 5, '')
        return

    def test_validation_options(self):
        success = []
        test_invalid = lambda : success.append(True)
        self.entry['validate'] = 'none'
        self.entry['validatecommand'] = lambda : False
        self.entry['invalidcommand'] = test_invalid
        self.entry.validate()
        self.assertTrue(success)
        self.entry['invalidcommand'] = ''
        self.entry.validate()
        self.assertEqual(len(success), 1)
        self.entry['invalidcommand'] = test_invalid
        self.entry['validatecommand'] = lambda : True
        self.entry.validate()
        self.assertEqual(len(success), 1)
        self.entry['validatecommand'] = ''
        self.entry.validate()
        self.assertEqual(len(success), 1)
        self.entry['validatecommand'] = True
        self.assertRaises(tkinter.TclError, self.entry.validate)

    def test_validation(self):
        validation = []

        def validate(to_insert):
            if not 'a' <= to_insert.lower() <= 'z':
                validation.append(False)
                return False
            validation.append(True)
            return True

        self.entry['validate'] = 'key'
        self.entry['validatecommand'] = (self.entry.register(validate), '%S')
        self.entry.insert('end', 1)
        self.entry.insert('end', 'a')
        self.assertEqual(validation, [False, True])
        self.assertEqual(self.entry.get(), 'a')

    def test_revalidation(self):

        def validate(content):
            for letter in content:
                if not 'a' <= letter.lower() <= 'z':
                    return False

            return True

        self.entry['validatecommand'] = (
         self.entry.register(validate), '%P')
        self.entry.insert('end', 'avocado')
        self.assertEqual(self.entry.validate(), True)
        self.assertEqual(self.entry.state(), ())
        self.entry.delete(0, 'end')
        self.assertEqual(self.entry.get(), '')
        self.entry.insert('end', 'a1b')
        self.assertEqual(self.entry.validate(), False)
        self.assertEqual(self.entry.state(), ('invalid', ))
        self.entry.delete(1)
        self.assertEqual(self.entry.validate(), True)
        self.assertEqual(self.entry.state(), ())


@add_standard_options(IntegerSizeTests, StandardTtkOptionsTests)
class ComboboxTest(EntryTest, unittest.TestCase):
    OPTIONS = ('background', 'class', 'cursor', 'exportselection', 'font', 'foreground',
               'height', 'invalidcommand', 'justify', 'postcommand', 'show', 'state',
               'style', 'takefocus', 'textvariable', 'validate', 'validatecommand',
               'values', 'width', 'xscrollcommand')

    def setUp(self):
        super(ComboboxTest, self).setUp()
        self.combo = self.create()

    def create(self, **kwargs):
        return ttk.Combobox(self.root, **kwargs)

    def test_height(self):
        widget = self.create()
        self.checkParams(widget, 'height', 100, 101.2, 102.6, -100, 0, '1i')

    def _show_drop_down_listbox(self):
        width = self.combo.winfo_width()
        self.combo.event_generate('<ButtonPress-1>', x=width - 5, y=5)
        self.combo.event_generate('<ButtonRelease-1>', x=width - 5, y=5)
        self.combo.update_idletasks()

    def test_virtual_event(self):
        success = []
        self.combo['values'] = [
         1]
        self.combo.bind('<<ComboboxSelected>>', lambda evt: success.append(True))
        self.combo.pack()
        self.combo.wait_visibility()
        height = self.combo.winfo_height()
        self._show_drop_down_listbox()
        self.combo.update()
        self.combo.event_generate('<Return>')
        self.combo.update()
        self.assertTrue(success)

    def test_postcommand(self):
        success = []
        self.combo['postcommand'] = lambda : success.append(True)
        self.combo.pack()
        self.combo.wait_visibility()
        self._show_drop_down_listbox()
        self.assertTrue(success)
        self.combo['postcommand'] = ''
        self._show_drop_down_listbox()
        self.assertEqual(len(success), 1)

    def test_values(self):

        def check_get_current(getval, currval):
            self.assertEqual(self.combo.get(), getval)
            self.assertEqual(self.combo.current(), currval)

        self.assertEqual(self.combo['values'], () if tcl_version < (8, 5) else '')
        check_get_current('', -1)
        self.checkParam(self.combo, 'values', 'mon tue wed thur', expected=('mon',
                                                                            'tue',
                                                                            'wed',
                                                                            'thur'))
        self.checkParam(self.combo, 'values', ('mon', 'tue', 'wed', 'thur'))
        self.checkParam(self.combo, 'values', (42, 3.14, '', 'any string'))
        self.checkParam(self.combo, 'values', () if tcl_version < (8, 5) else '')
        self.combo['values'] = [
         'a', 1, 'c']
        self.combo.set('c')
        check_get_current('c', 2)
        self.combo.current(0)
        check_get_current('a', 0)
        self.combo.set('d')
        check_get_current('d', -1)
        self.combo.set('')
        self.combo['values'] = (1, 2, '', 3)
        check_get_current('', 2)
        self.combo.configure(values=[1, '', 2])
        self.assertEqual(self.combo['values'], ('1', '', '2') if self.wantobjects else '1 {} 2')
        self.combo['values'] = [
         'a b', 'a\tb', 'a\nb']
        self.assertEqual(self.combo['values'], ('a b', 'a\tb', 'a\nb') if self.wantobjects else '{a b} {a\tb} {a\nb}')
        self.combo['values'] = [
         'a\\tb', '"a"', '} {']
        self.assertEqual(self.combo['values'], ('a\\tb', '"a"', '} {') if self.wantobjects else 'a\\\\tb {"a"} \\}\\ \\{')
        self.assertRaises(tkinter.TclError, self.combo.current, len(self.combo['values']))
        self.assertRaises(tkinter.TclError, self.combo.current, '')
        combo2 = ttk.Combobox(self.root, values=[1, 2, ''])
        self.assertEqual(combo2['values'], ('1', '2', '') if self.wantobjects else '1 2 {}')
        combo2.destroy()


@add_standard_options(IntegerSizeTests, StandardTtkOptionsTests)
class PanedWindowTest(AbstractWidgetTest, unittest.TestCase):
    OPTIONS = ('class', 'cursor', 'height', 'orient', 'style', 'takefocus', 'width')

    def setUp(self):
        super(PanedWindowTest, self).setUp()
        self.paned = self.create()

    def create(self, **kwargs):
        return ttk.PanedWindow(self.root, **kwargs)

    def test_orient(self):
        widget = self.create()
        self.assertEqual(str(widget['orient']), 'vertical')
        errmsg = 'attempt to change read-only option'
        if get_tk_patchlevel() < (8, 6, 0, 'beta', 3):
            errmsg = 'Attempt to change read-only option'
        self.checkInvalidParam(widget, 'orient', 'horizontal', errmsg=errmsg)
        widget2 = self.create(orient='horizontal')
        self.assertEqual(str(widget2['orient']), 'horizontal')

    def test_add(self):
        label = ttk.Label(self.paned)
        child = ttk.Label(label)
        self.assertRaises(tkinter.TclError, self.paned.add, child)
        label.destroy()
        child.destroy()
        label = ttk.Label(self.root)
        child = ttk.Label(label)
        self.assertRaises(tkinter.TclError, self.paned.add, child)
        child.destroy()
        label.destroy()
        good_child = ttk.Label(self.root)
        self.paned.add(good_child)
        self.assertRaises(tkinter.TclError, self.paned.add, good_child)
        other_child = ttk.Label(self.paned)
        self.paned.add(other_child)
        self.assertEqual(self.paned.pane(0), self.paned.pane(1))
        self.assertRaises(tkinter.TclError, self.paned.pane, 2)
        good_child.destroy()
        other_child.destroy()
        self.assertRaises(tkinter.TclError, self.paned.pane, 0)

    def test_forget(self):
        self.assertRaises(tkinter.TclError, self.paned.forget, None)
        self.assertRaises(tkinter.TclError, self.paned.forget, 0)
        self.paned.add(ttk.Label(self.root))
        self.paned.forget(0)
        self.assertRaises(tkinter.TclError, self.paned.forget, 0)
        return

    def test_insert(self):
        self.assertRaises(tkinter.TclError, self.paned.insert, None, 0)
        self.assertRaises(tkinter.TclError, self.paned.insert, 0, None)
        self.assertRaises(tkinter.TclError, self.paned.insert, 0, 0)
        child = ttk.Label(self.root)
        child2 = ttk.Label(self.root)
        child3 = ttk.Label(self.root)
        self.assertRaises(tkinter.TclError, self.paned.insert, 0, child)
        self.paned.insert('end', child2)
        self.paned.insert(0, child)
        self.assertEqual(self.paned.panes(), (str(child), str(child2)))
        self.paned.insert(0, child2)
        self.assertEqual(self.paned.panes(), (str(child2), str(child)))
        self.paned.insert('end', child3)
        self.assertEqual(self.paned.panes(), (
         str(child2), str(child), str(child3)))
        panes = self.paned.panes()
        self.paned.insert('end', child3)
        self.assertEqual(panes, self.paned.panes())
        self.paned.insert(child2, child3)
        self.assertEqual(self.paned.panes(), (
         str(child3), str(child2), str(child)))
        return

    def test_pane(self):
        self.assertRaises(tkinter.TclError, self.paned.pane, 0)
        child = ttk.Label(self.root)
        self.paned.add(child)
        self.assertIsInstance(self.paned.pane(0), dict)
        self.assertEqual(self.paned.pane(0, weight=None), 0 if self.wantobjects else '0')
        self.assertEqual(self.paned.pane(0, 'weight'), 0 if self.wantobjects else '0')
        self.assertEqual(self.paned.pane(0), self.paned.pane(str(child)))
        self.assertRaises(tkinter.TclError, self.paned.pane, 0, badoption='somevalue')
        return

    def test_sashpos(self):
        self.assertRaises(tkinter.TclError, self.paned.sashpos, None)
        self.assertRaises(tkinter.TclError, self.paned.sashpos, '')
        self.assertRaises(tkinter.TclError, self.paned.sashpos, 0)
        child = ttk.Label(self.paned, text='a')
        self.paned.add(child, weight=1)
        self.assertRaises(tkinter.TclError, self.paned.sashpos, 0)
        child2 = ttk.Label(self.paned, text='b')
        self.paned.add(child2)
        self.assertRaises(tkinter.TclError, self.paned.sashpos, 1)
        self.paned.pack(expand=True, fill='both')
        self.paned.wait_visibility()
        curr_pos = self.paned.sashpos(0)
        self.paned.sashpos(0, 1000)
        self.assertNotEqual(curr_pos, self.paned.sashpos(0))
        self.assertIsInstance(self.paned.sashpos(0), int)
        return


@add_standard_options(StandardTtkOptionsTests)
class RadiobuttonTest(AbstractLabelTest, unittest.TestCase):
    OPTIONS = ('class', 'command', 'compound', 'cursor', 'image', 'padding', 'state',
               'style', 'takefocus', 'text', 'textvariable', 'underline', 'value',
               'variable', 'width')

    def create(self, **kwargs):
        return ttk.Radiobutton(self.root, **kwargs)

    def test_value(self):
        widget = self.create()
        self.checkParams(widget, 'value', 1, 2.3, '', 'any string')

    def test_invoke(self):
        success = []

        def cb_test():
            success.append(1)
            return 'cb test called'

        myvar = tkinter.IntVar(self.root)
        cbtn = ttk.Radiobutton(self.root, command=cb_test, variable=myvar, value=0)
        cbtn2 = ttk.Radiobutton(self.root, command=cb_test, variable=myvar, value=1)
        if self.wantobjects:
            conv = lambda x: x
        else:
            conv = int
        res = cbtn.invoke()
        self.assertEqual(res, 'cb test called')
        self.assertEqual(conv(cbtn['value']), myvar.get())
        self.assertEqual(myvar.get(), conv(cbtn.tk.globalgetvar(cbtn['variable'])))
        self.assertTrue(success)
        cbtn2['command'] = ''
        res = cbtn2.invoke()
        self.assertEqual(str(res), '')
        self.assertLessEqual(len(success), 1)
        self.assertEqual(conv(cbtn2['value']), myvar.get())
        self.assertEqual(myvar.get(), conv(cbtn.tk.globalgetvar(cbtn['variable'])))
        self.assertEqual(str(cbtn['variable']), str(cbtn2['variable']))


class MenubuttonTest(AbstractLabelTest, unittest.TestCase):
    OPTIONS = ('class', 'compound', 'cursor', 'direction', 'image', 'menu', 'padding',
               'state', 'style', 'takefocus', 'text', 'textvariable', 'underline',
               'width')

    def create(self, **kwargs):
        return ttk.Menubutton(self.root, **kwargs)

    def test_direction(self):
        widget = self.create()
        self.checkEnumParam(widget, 'direction', 'above', 'below', 'left', 'right', 'flush')

    def test_menu(self):
        widget = self.create()
        menu = tkinter.Menu(widget, name='menu')
        self.checkParam(widget, 'menu', menu, conv=str)
        menu.destroy()


@add_standard_options(StandardTtkOptionsTests)
class ScaleTest(AbstractWidgetTest, unittest.TestCase):
    OPTIONS = ('class', 'command', 'cursor', 'from', 'length', 'orient', 'style', 'takefocus',
               'to', 'value', 'variable')
    _conv_pixels = noconv_meth
    default_orient = 'horizontal'

    def setUp(self):
        super(ScaleTest, self).setUp()
        self.scale = self.create()
        self.scale.pack()
        self.scale.update()

    def create(self, **kwargs):
        return ttk.Scale(self.root, **kwargs)

    def test_from(self):
        widget = self.create()
        self.checkFloatParam(widget, 'from', 100, 14.9, 15.1, conv=False)

    def test_length(self):
        widget = self.create()
        self.checkPixelsParam(widget, 'length', 130, 131.2, 135.6, '5i')

    def test_to(self):
        widget = self.create()
        self.checkFloatParam(widget, 'to', 300, 14.9, 15.1, -10, conv=False)

    def test_value(self):
        widget = self.create()
        self.checkFloatParam(widget, 'value', 300, 14.9, 15.1, -10, conv=False)

    def test_custom_event(self):
        failure = [
         1, 1, 1]
        funcid = self.scale.bind('<<RangeChanged>>', lambda evt: failure.pop())
        self.scale['from'] = 10
        self.scale['from_'] = 10
        self.scale['to'] = 3
        self.assertFalse(failure)
        failure = [
         1, 1, 1]
        self.scale.configure(from_=2, to=5)
        self.scale.configure(from_=0, to=-2)
        self.scale.configure(to=10)
        self.assertFalse(failure)

    def test_get(self):
        if self.wantobjects:
            conv = lambda x: x
        else:
            conv = float
        scale_width = self.scale.winfo_width()
        self.assertEqual(self.scale.get(scale_width, 0), self.scale['to'])
        self.assertEqual(conv(self.scale.get(0, 0)), conv(self.scale['from']))
        self.assertEqual(self.scale.get(), self.scale['value'])
        self.scale['value'] = 30
        self.assertEqual(self.scale.get(), self.scale['value'])
        self.assertRaises(tkinter.TclError, self.scale.get, '', 0)
        self.assertRaises(tkinter.TclError, self.scale.get, 0, '')

    def test_set(self):
        if self.wantobjects:
            conv = lambda x: x
        else:
            conv = float
        max = conv(self.scale['to'])
        new_max = max + 10
        self.scale.set(new_max)
        self.assertEqual(conv(self.scale.get()), max)
        min = conv(self.scale['from'])
        self.scale.set(min - 1)
        self.assertEqual(conv(self.scale.get()), min)
        var = tkinter.DoubleVar(self.root)
        self.scale['variable'] = var
        var.set(max + 5)
        self.assertEqual(conv(self.scale.get()), var.get())
        self.assertEqual(conv(self.scale.get()), max + 5)
        del var
        self.scale['value'] = max + 10
        self.assertEqual(conv(self.scale.get()), max + 10)
        self.assertEqual(conv(self.scale.get()), conv(self.scale['value']))
        self.assertEqual(conv(self.scale.get(0, 0)), min)
        self.assertEqual(conv(self.scale.get(self.scale.winfo_width(), 0)), max)
        self.assertRaises(tkinter.TclError, self.scale.set, None)
        return


@add_standard_options(StandardTtkOptionsTests)
class ProgressbarTest(AbstractWidgetTest, unittest.TestCase):
    OPTIONS = ('class', 'cursor', 'orient', 'length', 'mode', 'maximum', 'phase', 'style',
               'takefocus', 'value', 'variable')
    _conv_pixels = noconv_meth
    default_orient = 'horizontal'

    def create(self, **kwargs):
        return ttk.Progressbar(self.root, **kwargs)

    def test_length(self):
        widget = self.create()
        self.checkPixelsParam(widget, 'length', 100.1, 56.7, '2i')

    def test_maximum(self):
        widget = self.create()
        self.checkFloatParam(widget, 'maximum', 150.2, 77.7, 0, -10, conv=False)

    def test_mode(self):
        widget = self.create()
        self.checkEnumParam(widget, 'mode', 'determinate', 'indeterminate')

    def test_phase(self):
        pass

    def test_value(self):
        widget = self.create()
        self.checkFloatParam(widget, 'value', 150.2, 77.7, 0, -10, conv=False)


@unittest.skipIf(sys.platform == 'darwin', 'ttk.Scrollbar is special on MacOSX')
@add_standard_options(StandardTtkOptionsTests)
class ScrollbarTest(AbstractWidgetTest, unittest.TestCase):
    OPTIONS = ('class', 'command', 'cursor', 'orient', 'style', 'takefocus')
    default_orient = 'vertical'

    def create(self, **kwargs):
        return ttk.Scrollbar(self.root, **kwargs)


@add_standard_options(IntegerSizeTests, StandardTtkOptionsTests)
class NotebookTest(AbstractWidgetTest, unittest.TestCase):
    OPTIONS = ('class', 'cursor', 'height', 'padding', 'style', 'takefocus', 'width')

    def setUp(self):
        super(NotebookTest, self).setUp()
        self.nb = self.create(padding=0)
        self.child1 = ttk.Label(self.root)
        self.child2 = ttk.Label(self.root)
        self.nb.add(self.child1, text='a')
        self.nb.add(self.child2, text='b')

    def create(self, **kwargs):
        return ttk.Notebook(self.root, **kwargs)

    def test_tab_identifiers(self):
        self.nb.forget(0)
        self.nb.hide(self.child2)
        self.assertRaises(tkinter.TclError, self.nb.tab, self.child1)
        self.assertEqual(self.nb.index('end'), 1)
        self.nb.add(self.child2)
        self.assertEqual(self.nb.index('end'), 1)
        self.nb.select(self.child2)
        self.assertTrue(self.nb.tab('current'))
        self.nb.add(self.child1, text='a')
        self.nb.pack()
        self.nb.wait_visibility()
        if sys.platform == 'darwin':
            tb_idx = '@20,5'
        else:
            tb_idx = '@5,5'
        self.assertEqual(self.nb.tab(tb_idx), self.nb.tab('current'))
        for i in range(5, 100, 5):
            try:
                if self.nb.tab('@%d, 5' % i, text=None) == 'a':
                    break
            except tkinter.TclError:
                pass

        else:
            self.fail("Tab with text 'a' not found")

        return

    def test_add_and_hidden(self):
        self.assertRaises(tkinter.TclError, self.nb.hide, -1)
        self.assertRaises(tkinter.TclError, self.nb.hide, 'hi')
        self.assertRaises(tkinter.TclError, self.nb.hide, None)
        self.assertRaises(tkinter.TclError, self.nb.add, None)
        self.assertRaises(tkinter.TclError, self.nb.add, ttk.Label(self.root), unknown='option')
        tabs = self.nb.tabs()
        self.nb.hide(self.child1)
        self.nb.add(self.child1)
        self.assertEqual(self.nb.tabs(), tabs)
        child = ttk.Label(self.root)
        self.nb.add(child, text='c')
        tabs = self.nb.tabs()
        curr = self.nb.index('current')
        child2_index = self.nb.index(self.child2)
        self.nb.hide(self.child2)
        self.nb.add(self.child2)
        self.assertEqual(self.nb.tabs(), tabs)
        self.assertEqual(self.nb.index(self.child2), child2_index)
        self.assertEqual(str(self.child2), self.nb.tabs()[child2_index])
        self.assertEqual(self.nb.index('current'), curr + 1)
        return

    def test_forget(self):
        self.assertRaises(tkinter.TclError, self.nb.forget, -1)
        self.assertRaises(tkinter.TclError, self.nb.forget, 'hi')
        self.assertRaises(tkinter.TclError, self.nb.forget, None)
        tabs = self.nb.tabs()
        child1_index = self.nb.index(self.child1)
        self.nb.forget(self.child1)
        self.assertNotIn(str(self.child1), self.nb.tabs())
        self.assertEqual(len(tabs) - 1, len(self.nb.tabs()))
        self.nb.add(self.child1)
        self.assertEqual(self.nb.index(self.child1), 1)
        self.assertNotEqual(child1_index, self.nb.index(self.child1))
        return

    def test_index(self):
        self.assertRaises(tkinter.TclError, self.nb.index, -1)
        self.assertRaises(tkinter.TclError, self.nb.index, None)
        self.assertIsInstance(self.nb.index('end'), int)
        self.assertEqual(self.nb.index(self.child1), 0)
        self.assertEqual(self.nb.index(self.child2), 1)
        self.assertEqual(self.nb.index('end'), 2)
        return

    def test_insert(self):
        tabs = self.nb.tabs()
        self.nb.insert(1, tabs[0])
        self.assertEqual(self.nb.tabs(), (tabs[1], tabs[0]))
        self.nb.insert(self.child1, self.child2)
        self.assertEqual(self.nb.tabs(), tabs)
        self.nb.insert('end', self.child1)
        self.assertEqual(self.nb.tabs(), (tabs[1], tabs[0]))
        self.nb.insert('end', 0)
        self.assertEqual(self.nb.tabs(), tabs)
        self.assertRaises(tkinter.TclError, self.nb.insert, 2, tabs[0])
        self.assertRaises(tkinter.TclError, self.nb.insert, -1, tabs[0])
        child3 = ttk.Label(self.root)
        self.nb.insert(1, child3)
        self.assertEqual(self.nb.tabs(), (tabs[0], str(child3), tabs[1]))
        self.nb.forget(child3)
        self.assertEqual(self.nb.tabs(), tabs)
        self.nb.insert(self.child1, child3)
        self.assertEqual(self.nb.tabs(), (str(child3),) + tabs)
        self.nb.forget(child3)
        self.assertRaises(tkinter.TclError, self.nb.insert, 2, child3)
        self.assertRaises(tkinter.TclError, self.nb.insert, -1, child3)
        self.assertRaises(tkinter.TclError, self.nb.insert, 'end', None)
        self.assertRaises(tkinter.TclError, self.nb.insert, None, 0)
        self.assertRaises(tkinter.TclError, self.nb.insert, None, None)
        return

    def test_select(self):
        self.nb.pack()
        self.nb.wait_visibility()
        success = []
        tab_changed = []
        self.child1.bind('<Unmap>', lambda evt: success.append(True))
        self.nb.bind('<<NotebookTabChanged>>', lambda evt: tab_changed.append(True))
        self.assertEqual(self.nb.select(), str(self.child1))
        self.nb.select(self.child2)
        self.assertTrue(success)
        self.assertEqual(self.nb.select(), str(self.child2))
        self.nb.update()
        self.assertTrue(tab_changed)

    def test_tab(self):
        self.assertRaises(tkinter.TclError, self.nb.tab, -1)
        self.assertRaises(tkinter.TclError, self.nb.tab, 'notab')
        self.assertRaises(tkinter.TclError, self.nb.tab, None)
        self.assertIsInstance(self.nb.tab(self.child1), dict)
        self.assertEqual(self.nb.tab(self.child1, text=None), 'a')
        self.assertEqual(self.nb.tab(self.child1, 'text'), 'a')
        self.nb.tab(self.child1, text='abc')
        self.assertEqual(self.nb.tab(self.child1, text=None), 'abc')
        self.assertEqual(self.nb.tab(self.child1, 'text'), 'abc')
        return

    def test_tabs(self):
        self.assertEqual(len(self.nb.tabs()), 2)
        self.nb.forget(self.child1)
        self.nb.forget(self.child2)
        self.assertEqual(self.nb.tabs(), ())

    def test_traversal(self):
        self.nb.pack()
        self.nb.wait_visibility()
        self.nb.select(0)
        simulate_mouse_click(self.nb, 5, 5)
        self.nb.focus_force()
        self.nb.event_generate('<Control-Tab>')
        self.assertEqual(self.nb.select(), str(self.child2))
        self.nb.focus_force()
        self.nb.event_generate('<Shift-Control-Tab>')
        self.assertEqual(self.nb.select(), str(self.child1))
        self.nb.focus_force()
        self.nb.event_generate('<Shift-Control-Tab>')
        self.assertEqual(self.nb.select(), str(self.child2))
        self.nb.tab(self.child1, text='a', underline=0)
        self.nb.enable_traversal()
        self.nb.focus_force()
        simulate_mouse_click(self.nb, 5, 5)
        if sys.platform == 'darwin':
            self.nb.event_generate('<Option-a>')
        else:
            self.nb.event_generate('<Alt-a>')
        self.assertEqual(self.nb.select(), str(self.child1))


@add_standard_options(StandardTtkOptionsTests)
class TreeviewTest(AbstractWidgetTest, unittest.TestCase):
    OPTIONS = ('class', 'columns', 'cursor', 'displaycolumns', 'height', 'padding',
               'selectmode', 'show', 'style', 'takefocus', 'xscrollcommand', 'yscrollcommand')

    def setUp(self):
        super(TreeviewTest, self).setUp()
        self.tv = self.create(padding=0)

    def create(self, **kwargs):
        return ttk.Treeview(self.root, **kwargs)

    def test_columns(self):
        widget = self.create()
        self.checkParam(widget, 'columns', 'a b c', expected=('a', 'b', 'c'))
        self.checkParam(widget, 'columns', ('a', 'b', 'c'))
        self.checkParam(widget, 'columns', () if tcl_version < (8, 5) else '')

    def test_displaycolumns(self):
        widget = self.create()
        widget['columns'] = ('a', 'b', 'c')
        self.checkParam(widget, 'displaycolumns', 'b a c', expected=('b', 'a', 'c'))
        self.checkParam(widget, 'displaycolumns', ('b', 'a', 'c'))
        self.checkParam(widget, 'displaycolumns', '#all', expected=('#all', ))
        self.checkParam(widget, 'displaycolumns', (2, 1, 0))
        self.checkInvalidParam(widget, 'displaycolumns', ('a', 'b', 'd'), errmsg='Invalid column index d')
        self.checkInvalidParam(widget, 'displaycolumns', (1, 2, 3), errmsg='Column index 3 out of bounds')
        self.checkInvalidParam(widget, 'displaycolumns', (1, -2), errmsg='Column index -2 out of bounds')

    def test_height(self):
        widget = self.create()
        self.checkPixelsParam(widget, 'height', 100, -100, 0, '3c', conv=False)
        self.checkPixelsParam(widget, 'height', 101.2, 102.6, conv=noconv)

    def test_selectmode(self):
        widget = self.create()
        self.checkEnumParam(widget, 'selectmode', 'none', 'browse', 'extended')

    def test_show(self):
        widget = self.create()
        self.checkParam(widget, 'show', 'tree headings', expected=('tree', 'headings'))
        self.checkParam(widget, 'show', ('tree', 'headings'))
        self.checkParam(widget, 'show', ('headings', 'tree'))
        self.checkParam(widget, 'show', 'tree', expected=('tree', ))
        self.checkParam(widget, 'show', 'headings', expected=('headings', ))

    def test_bbox(self):
        self.tv.pack()
        self.assertEqual(self.tv.bbox(''), '')
        self.tv.wait_visibility()
        self.tv.update()
        item_id = self.tv.insert('', 'end')
        children = self.tv.get_children()
        self.assertTrue(children)
        bbox = self.tv.bbox(children[0])
        self.assertIsBoundingBox(bbox)
        self.tv['columns'] = [
         'test']
        self.tv.column('test', width=50)
        bbox_column0 = self.tv.bbox(children[0], 0)
        root_width = self.tv.column('#0', width=None)
        if not self.wantobjects:
            root_width = int(root_width)
        self.assertEqual(bbox_column0[0], bbox[0] + root_width)
        child1 = self.tv.insert(item_id, 'end')
        self.assertEqual(self.tv.bbox(child1), '')
        return

    def test_children(self):
        self.assertEqual(self.tv.get_children(), ())
        item_id = self.tv.insert('', 'end')
        self.assertIsInstance(self.tv.get_children(), tuple)
        self.assertEqual(self.tv.get_children()[0], item_id)
        child2 = self.tv.insert('', 'end')
        child3 = self.tv.insert('', 'end')
        self.tv.set_children(child2, item_id, child3)
        self.assertEqual(self.tv.get_children(child2), (item_id, child3))
        self.assertRaises(tkinter.TclError, self.tv.set_children, child3, child2)
        self.tv.set_children(child2)
        self.assertEqual(self.tv.get_children(child2), ())
        self.tv.set_children('')
        self.assertEqual(self.tv.get_children(), ())

    def test_column(self):
        self.assertIsInstance(self.tv.column('#0'), dict)
        if self.wantobjects:
            self.assertIsInstance(self.tv.column('#0', width=None), int)
        self.tv.column('#0', width=10)
        self.assertEqual(self.tv.column('#0', 'width'), 10 if self.wantobjects else '10')
        self.assertEqual(self.tv.column('#0', width=None), 10 if self.wantobjects else '10')
        self.assertRaises(tkinter.TclError, self.tv.column, '#0', id='X')
        self.assertRaises(tkinter.TclError, self.tv.column, 'invalid')
        invalid_kws = [{'unknown_option': 'some value'}, {'stretch': 'wrong'}, {'anchor': 'wrong'}, {'width': 'wrong'}, {'minwidth': 'wrong'}]
        for kw in invalid_kws:
            self.assertRaises(tkinter.TclError, self.tv.column, '#0', **kw)

        return

    def test_delete(self):
        self.assertRaises(tkinter.TclError, self.tv.delete, '#0')
        item_id = self.tv.insert('', 'end')
        item2 = self.tv.insert(item_id, 'end')
        self.assertEqual(self.tv.get_children(), (item_id,))
        self.assertEqual(self.tv.get_children(item_id), (item2,))
        self.tv.delete(item_id)
        self.assertFalse(self.tv.get_children())
        self.assertRaises(tkinter.TclError, self.tv.reattach, item_id, '', 'end')
        item1 = self.tv.insert('', 'end')
        item2 = self.tv.insert('', 'end')
        self.assertEqual(self.tv.get_children(), (item1, item2))
        self.tv.delete(item1, item2)
        self.assertFalse(self.tv.get_children())

    def test_detach_reattach(self):
        item_id = self.tv.insert('', 'end')
        item2 = self.tv.insert(item_id, 'end')
        prev = self.tv.get_children()
        self.tv.detach()
        self.assertEqual(prev, self.tv.get_children())
        self.assertEqual(self.tv.get_children(), (item_id,))
        self.assertEqual(self.tv.get_children(item_id), (item2,))
        self.tv.detach(item_id)
        self.assertFalse(self.tv.get_children())
        self.tv.reattach(item_id, '', 'end')
        self.assertEqual(self.tv.get_children(), (item_id,))
        self.assertEqual(self.tv.get_children(item_id), (item2,))
        self.tv.move(item2, '', 'end')
        self.assertEqual(self.tv.get_children(), (item_id, item2))
        self.assertEqual(self.tv.get_children(item_id), ())
        self.assertRaises(tkinter.TclError, self.tv.reattach, 'nonexistent', '', 'end')
        self.assertRaises(tkinter.TclError, self.tv.detach, 'nonexistent')
        self.assertRaises(tkinter.TclError, self.tv.reattach, item2, 'otherparent', 'end')
        self.assertRaises(tkinter.TclError, self.tv.reattach, item2, '', 'invalid')
        self.tv.detach(item_id, item2)
        self.assertEqual(self.tv.get_children(), ())
        self.assertEqual(self.tv.get_children(item_id), ())

    def test_exists(self):
        self.assertEqual(self.tv.exists('something'), False)
        self.assertEqual(self.tv.exists(''), True)
        self.assertEqual(self.tv.exists({}), False)
        self.assertRaises(tkinter.TclError, self.tv.exists, None)
        return

    def test_focus(self):
        self.assertEqual(self.tv.focus(), '')
        item1 = self.tv.insert('', 'end')
        self.tv.focus(item1)
        self.assertEqual(self.tv.focus(), item1)
        self.tv.delete(item1)
        self.assertEqual(self.tv.focus(), '')
        self.assertRaises(tkinter.TclError, self.tv.focus, 'hi')

    def test_heading(self):
        self.assertIsInstance(self.tv.heading('#0'), dict)
        self.tv.heading('#0', text='hi')
        self.assertEqual(self.tv.heading('#0', 'text'), 'hi')
        self.assertEqual(self.tv.heading('#0', text=None), 'hi')
        self.assertRaises(tkinter.TclError, self.tv.heading, '#0', background=None)
        self.assertRaises(tkinter.TclError, self.tv.heading, '#0', anchor=1)
        return

    def test_heading_callback(self):

        def simulate_heading_click(x, y):
            simulate_mouse_click(self.tv, x, y)
            self.tv.update()

        success = []
        self.tv.pack()
        self.tv.wait_visibility()
        self.tv.heading('#0', command=lambda : success.append(True))
        self.tv.column('#0', width=100)
        self.tv.update()
        simulate_heading_click(5, 5)
        if not success:
            self.fail("The command associated to the treeview heading wasn't invoked.")
        success = []
        commands = self.tv.master._tclCommands
        self.tv.heading('#0', command=str(self.tv.heading('#0', command=None)))
        self.assertEqual(commands, self.tv.master._tclCommands)
        simulate_heading_click(5, 5)
        if not success:
            self.fail("The command associated to the treeview heading wasn't invoked.")
        return

    def test_index(self):
        self.assertRaises(tkinter.TclError, self.tv.index, 'what')
        self.assertEqual(self.tv.index(''), 0)
        item1 = self.tv.insert('', 'end')
        item2 = self.tv.insert('', 'end')
        c1 = self.tv.insert(item1, 'end')
        c2 = self.tv.insert(item1, 'end')
        self.assertEqual(self.tv.index(item1), 0)
        self.assertEqual(self.tv.index(c1), 0)
        self.assertEqual(self.tv.index(c2), 1)
        self.assertEqual(self.tv.index(item2), 1)
        self.tv.move(item2, '', 0)
        self.assertEqual(self.tv.index(item2), 0)
        self.assertEqual(self.tv.index(item1), 1)
        self.tv.detach(item1)
        self.assertEqual(self.tv.index(c2), 1)
        self.tv.detach(c1)
        self.assertEqual(self.tv.index(c2), 0)
        self.tv.delete(item1)
        self.assertRaises(tkinter.TclError, self.tv.index, c2)

    def test_insert_item(self):
        self.assertRaises(tkinter.TclError, self.tv.insert, 'none', 'end')
        self.assertRaises(tkinter.TclError, self.tv.insert, '', 'end', open='')
        self.assertRaises(tkinter.TclError, self.tv.insert, '', 'end', open='please')
        self.assertFalse(self.tv.delete(self.tv.insert('', 'end', open=True)))
        self.assertFalse(self.tv.delete(self.tv.insert('', 'end', open=False)))
        self.assertRaises(tkinter.TclError, self.tv.insert, '', 'middle')
        itemid = self.tv.insert('', 'end', 'first-item')
        self.assertEqual(itemid, 'first-item')
        self.assertRaises(tkinter.TclError, self.tv.insert, '', 'end', 'first-item')
        self.assertRaises(tkinter.TclError, self.tv.insert, '', 'end', MockTclObj('first-item'))
        value = 'ába'
        item = self.tv.insert('', 'end', values=(value,))
        self.assertEqual(self.tv.item(item, 'values'), (value,) if self.wantobjects else value)
        self.assertEqual(self.tv.item(item, values=None), (value,) if self.wantobjects else value)
        self.tv.item(item, values=self.root.splitlist(self.tv.item(item, values=None)))
        self.assertEqual(self.tv.item(item, values=None), (value,) if self.wantobjects else value)
        self.assertIsInstance(self.tv.item(item), dict)
        self.tv.item(item, values='')
        self.assertFalse(self.tv.item(item, values=None))
        item = self.tv.insert('', 'end', tags=[1, 2, value])
        self.assertEqual(self.tv.item(item, tags=None), ('1', '2', value) if self.wantobjects else '1 2 %s' % value)
        self.tv.item(item, tags=[])
        self.assertFalse(self.tv.item(item, tags=None))
        self.tv.item(item, tags=(1, 2))
        self.assertEqual(self.tv.item(item, tags=None), ('1', '2') if self.wantobjects else '1 2')
        item = self.tv.insert('', 'end', values=('a b c',
         '%s %s' % (value, value)))
        self.assertEqual(self.tv.item(item, values=None), ('a b c', '%s %s' % (value, value)) if self.wantobjects else '{a b c} {%s %s}' % (value, value))
        self.assertEqual(self.tv.item(self.tv.insert('', 'end', text='Label here'), text=None), 'Label here')
        self.assertEqual(self.tv.item(self.tv.insert('', 'end', text=value), text=None), value)
        itemid = self.tv.insert('', 'end', 0)
        self.assertEqual(itemid, '0')
        itemid = self.tv.insert('', 'end', 0.0)
        self.assertEqual(itemid, '0.0')
        self.assertRaises(tkinter.TclError, self.tv.insert, '', 'end', False)
        self.assertRaises(tkinter.TclError, self.tv.insert, '', 'end', '')
        return

    def test_selection(self):
        self.assertRaises(tkinter.TclError, self.tv.selection_set, 'none')
        self.assertRaises(tkinter.TclError, self.tv.selection_add, 'none')
        self.assertRaises(tkinter.TclError, self.tv.selection_remove, 'none')
        self.assertRaises(tkinter.TclError, self.tv.selection_toggle, 'none')
        item1 = self.tv.insert('', 'end')
        item2 = self.tv.insert('', 'end')
        c1 = self.tv.insert(item1, 'end')
        c2 = self.tv.insert(item1, 'end')
        c3 = self.tv.insert(item1, 'end')
        self.assertEqual(self.tv.selection(), ())
        self.tv.selection_set((c1, item2))
        self.assertEqual(self.tv.selection(), (c1, item2))
        self.tv.selection_set(c2)
        self.assertEqual(self.tv.selection(), (c2,))
        self.tv.selection_add((c1, item2))
        self.assertEqual(self.tv.selection(), (c1, c2, item2))
        self.tv.selection_add(item1)
        self.assertEqual(self.tv.selection(), (item1, c1, c2, item2))
        self.tv.selection_remove((item1, c3))
        self.assertEqual(self.tv.selection(), (c1, c2, item2))
        self.tv.selection_remove(c2)
        self.assertEqual(self.tv.selection(), (c1, item2))
        self.tv.selection_toggle((c1, c3))
        self.assertEqual(self.tv.selection(), (c3, item2))
        self.tv.selection_toggle(item2)
        self.assertEqual(self.tv.selection(), (c3,))
        self.tv.insert('', 'end', id='with spaces')
        self.tv.selection_set('with spaces')
        self.assertEqual(self.tv.selection(), ('with spaces', ))
        self.tv.insert('', 'end', id='{brace')
        self.tv.selection_set('{brace')
        self.assertEqual(self.tv.selection(), ('{brace', ))
        if have_unicode:
            self.tv.insert('', 'end', id=u('unicode\\u20ac'))
            self.tv.selection_set(u('unicode\\u20ac'))
            self.assertEqual(self.tv.selection(), (u('unicode\\u20ac'),))
        self.tv.insert('', 'end', id='bytes€')
        self.tv.selection_set('bytes€')
        self.assertEqual(self.tv.selection(), (
         u('bytes\\u20ac') if have_unicode else 'bytes€',))

    def test_set(self):
        self.tv['columns'] = [
         'A', 'B']
        item = self.tv.insert('', 'end', values=['a', 'b'])
        self.assertEqual(self.tv.set(item), {'A': 'a', 'B': 'b'})
        self.tv.set(item, 'B', 'a')
        self.assertEqual(self.tv.item(item, values=None), ('a', 'a') if self.wantobjects else 'a a')
        self.tv['columns'] = [
         'B']
        self.assertEqual(self.tv.set(item), {'B': 'a'})
        self.tv.set(item, 'B', 'b')
        self.assertEqual(self.tv.set(item, column='B'), 'b')
        self.assertEqual(self.tv.item(item, values=None), ('b', 'a') if self.wantobjects else 'b a')
        self.tv.set(item, 'B', 123)
        self.assertEqual(self.tv.set(item, 'B'), 123 if self.wantobjects else '123')
        self.assertEqual(self.tv.item(item, values=None), (123, 'a') if self.wantobjects else '123 a')
        self.assertEqual(self.tv.set(item), {'B': 123} if self.wantobjects else {'B': '123'})
        self.assertRaises(tkinter.TclError, self.tv.set, item, 'A')
        self.assertRaises(tkinter.TclError, self.tv.set, item, 'A', 'b')
        self.assertRaises(tkinter.TclError, self.tv.set, 'notme')
        return

    def test_tag_bind(self):
        events = []
        item1 = self.tv.insert('', 'end', tags=['call'])
        item2 = self.tv.insert('', 'end', tags=['call'])
        self.tv.tag_bind('call', '<ButtonPress-1>', lambda evt: events.append(1))
        self.tv.tag_bind('call', '<ButtonRelease-1>', lambda evt: events.append(2))
        self.tv.pack()
        self.tv.wait_visibility()
        self.tv.update()
        pos_y = set()
        found = set()
        for i in range(0, 100, 10):
            if len(found) == 2:
                break
            item_id = self.tv.identify_row(i)
            if item_id and item_id not in found:
                pos_y.add(i)
                found.add(item_id)

        self.assertEqual(len(pos_y), 2)
        for y in pos_y:
            simulate_mouse_click(self.tv, 0, y)

        self.assertEqual(len(events), 4)
        for evt in zip(events[::2], events[1::2]):
            self.assertEqual(evt, (1, 2))

    def test_tag_configure(self):
        self.assertRaises(TypeError, self.tv.tag_configure)
        self.assertRaises(tkinter.TclError, self.tv.tag_configure, 'test', sky='blue')
        self.tv.tag_configure('test', foreground='blue')
        self.assertEqual(str(self.tv.tag_configure('test', 'foreground')), 'blue')
        self.assertEqual(str(self.tv.tag_configure('test', foreground=None)), 'blue')
        self.assertIsInstance(self.tv.tag_configure('test'), dict)
        return

    def test_tag_has(self):
        item1 = self.tv.insert('', 'end', text='Item 1', tags=['tag1'])
        item2 = self.tv.insert('', 'end', text='Item 2', tags=['tag2'])
        self.assertRaises(TypeError, self.tv.tag_has)
        self.assertRaises(TclError, self.tv.tag_has, 'tag1', 'non-existing')
        self.assertTrue(self.tv.tag_has('tag1', item1))
        self.assertFalse(self.tv.tag_has('tag1', item2))
        self.assertFalse(self.tv.tag_has('tag2', item1))
        self.assertTrue(self.tv.tag_has('tag2', item2))
        self.assertFalse(self.tv.tag_has('tag3', item1))
        self.assertFalse(self.tv.tag_has('tag3', item2))
        self.assertEqual(self.tv.tag_has('tag1'), (item1,))
        self.assertEqual(self.tv.tag_has('tag2'), (item2,))
        self.assertEqual(self.tv.tag_has('tag3'), ())


@add_standard_options(StandardTtkOptionsTests)
class SeparatorTest(AbstractWidgetTest, unittest.TestCase):
    OPTIONS = ('class', 'cursor', 'orient', 'style', 'takefocus')
    default_orient = 'horizontal'

    def create(self, **kwargs):
        return ttk.Separator(self.root, **kwargs)


@add_standard_options(StandardTtkOptionsTests)
class SizegripTest(AbstractWidgetTest, unittest.TestCase):
    OPTIONS = ('class', 'cursor', 'style', 'takefocus')

    def create(self, **kwargs):
        return ttk.Sizegrip(self.root, **kwargs)


tests_gui = (
 ButtonTest, CheckbuttonTest, ComboboxTest, EntryTest,
 FrameTest, LabelFrameTest, LabelTest, MenubuttonTest,
 NotebookTest, PanedWindowTest, ProgressbarTest,
 RadiobuttonTest, ScaleTest, ScrollbarTest, SeparatorTest,
 SizegripTest, TreeviewTest, WidgetTest)
if __name__ == '__main__':
    run_unittest(*tests_gui)