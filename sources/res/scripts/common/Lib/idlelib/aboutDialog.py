import os
from sys import version
from Tkinter import *
from idlelib import textView

class AboutDialog(Toplevel):

    def __init__(self, parent, title, _htest=False):
        Toplevel.__init__(self, parent)
        self.configure(borderwidth=5)
        self.geometry('+%d+%d' % (
         parent.winfo_rootx() + 30,
         parent.winfo_rooty() + (30 if not _htest else 100)))
        self.bg = '#707070'
        self.fg = '#ffffff'
        self.CreateWidgets()
        self.resizable(height=FALSE, width=FALSE)
        self.title(title)
        self.transient(parent)
        self.grab_set()
        self.protocol('WM_DELETE_WINDOW', self.Ok)
        self.parent = parent
        self.buttonOk.focus_set()
        self.bind('<Return>', self.Ok)
        self.bind('<Escape>', self.Ok)
        self.wait_window()

    def CreateWidgets(self):
        release = version[:version.index(' ')]
        frameMain = Frame(self, borderwidth=2, relief=SUNKEN)
        frameButtons = Frame(self)
        frameButtons.pack(side=BOTTOM, fill=X)
        frameMain.pack(side=TOP, expand=TRUE, fill=BOTH)
        self.buttonOk = Button(frameButtons, text='Close', command=self.Ok)
        self.buttonOk.pack(padx=5, pady=5)
        frameBg = Frame(frameMain, bg=self.bg)
        frameBg.pack(expand=TRUE, fill=BOTH)
        labelTitle = Label(frameBg, text='IDLE', fg=self.fg, bg=self.bg, font=('courier',
                                                                               24,
                                                                               'bold'))
        labelTitle.grid(row=0, column=0, sticky=W, padx=10, pady=10)
        byline = "Python's Integrated DeveLopment Environment" + '\n\n\n\n\n'
        labelDesc = Label(frameBg, text=byline, justify=LEFT, fg=self.fg, bg=self.bg)
        labelDesc.grid(row=2, column=0, sticky=W, columnspan=3, padx=10, pady=5)
        labelEmail = Label(frameBg, text='email:  idle-dev@python.org', justify=LEFT, fg=self.fg, bg=self.bg)
        labelEmail.grid(row=6, column=0, columnspan=2, sticky=W, padx=10, pady=0)
        labelWWW = Label(frameBg, text='https://docs.python.org/' + version[:3] + '/library/idle.html', justify=LEFT, fg=self.fg, bg=self.bg)
        labelWWW.grid(row=7, column=0, columnspan=2, sticky=W, padx=10, pady=0)
        Frame(frameBg, borderwidth=1, relief=SUNKEN, height=2, bg=self.bg).grid(row=8, column=0, sticky=EW, columnspan=3, padx=5, pady=5)
        labelPythonVer = Label(frameBg, text='Python version:  ' + release, fg=self.fg, bg=self.bg)
        labelPythonVer.grid(row=9, column=0, sticky=W, padx=10, pady=0)
        tkVer = self.tk.call('info', 'patchlevel')
        labelTkVer = Label(frameBg, text='Tk version:  ' + tkVer, fg=self.fg, bg=self.bg)
        labelTkVer.grid(row=9, column=1, sticky=W, padx=2, pady=0)
        py_button_f = Frame(frameBg, bg=self.bg)
        py_button_f.grid(row=10, column=0, columnspan=2, sticky=NSEW)
        buttonLicense = Button(py_button_f, text='License', width=8, highlightbackground=self.bg, command=self.ShowLicense)
        buttonLicense.pack(side=LEFT, padx=10, pady=10)
        buttonCopyright = Button(py_button_f, text='Copyright', width=8, highlightbackground=self.bg, command=self.ShowCopyright)
        buttonCopyright.pack(side=LEFT, padx=10, pady=10)
        buttonCredits = Button(py_button_f, text='Credits', width=8, highlightbackground=self.bg, command=self.ShowPythonCredits)
        buttonCredits.pack(side=LEFT, padx=10, pady=10)
        Frame(frameBg, borderwidth=1, relief=SUNKEN, height=2, bg=self.bg).grid(row=11, column=0, sticky=EW, columnspan=3, padx=5, pady=5)
        idle_v = Label(frameBg, text='IDLE version:   ' + release, fg=self.fg, bg=self.bg)
        idle_v.grid(row=12, column=0, sticky=W, padx=10, pady=0)
        idle_button_f = Frame(frameBg, bg=self.bg)
        idle_button_f.grid(row=13, column=0, columnspan=3, sticky=NSEW)
        idle_about_b = Button(idle_button_f, text='README', width=8, highlightbackground=self.bg, command=self.ShowIDLEAbout)
        idle_about_b.pack(side=LEFT, padx=10, pady=10)
        idle_news_b = Button(idle_button_f, text='NEWS', width=8, highlightbackground=self.bg, command=self.ShowIDLENEWS)
        idle_news_b.pack(side=LEFT, padx=10, pady=10)
        idle_credits_b = Button(idle_button_f, text='Credits', width=8, highlightbackground=self.bg, command=self.ShowIDLECredits)
        idle_credits_b.pack(side=LEFT, padx=10, pady=10)

    def ShowLicense(self):
        self.display_printer_text('About - License', license)

    def ShowCopyright(self):
        self.display_printer_text('About - Copyright', copyright)

    def ShowPythonCredits(self):
        self.display_printer_text('About - Python Credits', credits)

    def ShowIDLECredits(self):
        self.display_file_text('About - Credits', 'CREDITS.txt', 'utf-8')

    def ShowIDLEAbout(self):
        self.display_file_text('About - Readme', 'README.txt', 'ascii')

    def ShowIDLENEWS(self):
        self.display_file_text('About - NEWS', 'NEWS.txt', 'utf-8')

    def display_printer_text(self, title, printer):
        printer._Printer__setup()
        text = ('\n').join(printer._Printer__lines)
        textView.view_text(self, title, text)

    def display_file_text(self, title, filename, encoding=None):
        fn = os.path.join(os.path.abspath(os.path.dirname(__file__)), filename)
        textView.view_file(self, title, fn, encoding)

    def Ok(self, event=None):
        self.grab_release()
        self.destroy()


if __name__ == '__main__':
    import unittest
    unittest.main('idlelib.idle_test.test_helpabout', verbosity=2, exit=False)
    from idlelib.idle_test.htest import run
    run(AboutDialog)