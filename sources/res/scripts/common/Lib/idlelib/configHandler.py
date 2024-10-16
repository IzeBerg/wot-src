from __future__ import print_function
import os, sys
from ConfigParser import ConfigParser
from Tkinter import TkVersion
from tkFont import Font, nametofont

class InvalidConfigType(Exception):
    pass


class InvalidConfigSet(Exception):
    pass


class InvalidFgBg(Exception):
    pass


class InvalidTheme(Exception):
    pass


class IdleConfParser(ConfigParser):

    def __init__(self, cfgFile, cfgDefaults=None):
        self.file = cfgFile
        ConfigParser.__init__(self, defaults=cfgDefaults)

    def Get(self, section, option, type=None, default=None, raw=False):
        if not self.has_option(section, option):
            return default
        else:
            if type == 'bool':
                return self.getboolean(section, option)
            if type == 'int':
                return self.getint(section, option)
            return self.get(section, option, raw=raw)

    def GetOptionList(self, section):
        if self.has_section(section):
            return self.options(section)
        else:
            return []

    def Load(self):
        self.read(self.file)


class IdleUserConfParser(IdleConfParser):

    def AddSection(self, section):
        if not self.has_section(section):
            self.add_section(section)

    def RemoveEmptySections(self):
        for section in self.sections():
            if not self.GetOptionList(section):
                self.remove_section(section)

    def IsEmpty(self):
        self.RemoveEmptySections()
        return not self.sections()

    def RemoveOption(self, section, option):
        if self.has_section(section):
            return self.remove_option(section, option)
        return False

    def SetOption(self, section, option, value):
        if self.has_option(section, option):
            if self.get(section, option) == value:
                return False
            else:
                self.set(section, option, value)
                return True

        else:
            if not self.has_section(section):
                self.add_section(section)
            self.set(section, option, value)
            return True

    def RemoveFile(self):
        if os.path.exists(self.file):
            os.remove(self.file)

    def Save(self):
        if not self.IsEmpty():
            fname = self.file
            try:
                cfgFile = open(fname, 'w')
            except IOError:
                os.unlink(fname)
                cfgFile = open(fname, 'w')

            with cfgFile:
                self.write(cfgFile)
        else:
            self.RemoveFile()


class IdleConf():

    def __init__(self):
        self.config_types = ('main', 'extensions', 'highlight', 'keys')
        self.defaultCfg = {}
        self.userCfg = {}
        self.cfg = {}
        self.CreateConfigHandlers()
        self.LoadCfgFiles()

    def CreateConfigHandlers(self):
        if __name__ != '__main__':
            idleDir = os.path.dirname(__file__)
        else:
            idleDir = os.path.abspath(sys.path[0])
        userDir = self.GetUserCfgDir()
        defCfgFiles = {}
        usrCfgFiles = {}
        for cfgType in self.config_types:
            defCfgFiles[cfgType] = os.path.join(idleDir, 'config-' + cfgType + '.def')
            usrCfgFiles[cfgType] = os.path.join(userDir, 'config-' + cfgType + '.cfg')

        for cfgType in self.config_types:
            self.defaultCfg[cfgType] = IdleConfParser(defCfgFiles[cfgType])
            self.userCfg[cfgType] = IdleUserConfParser(usrCfgFiles[cfgType])

    def GetUserCfgDir(self):
        cfgDir = '.idlerc'
        userDir = os.path.expanduser('~')
        if userDir != '~':
            if not os.path.exists(userDir):
                warn = '\n Warning: os.path.expanduser("~") points to\n ' + userDir + ',\n but the path does not exist.'
                try:
                    print(warn, file=sys.stderr)
                except IOError:
                    pass

                userDir = '~'
        if userDir == '~':
            userDir = os.getcwd()
        userDir = os.path.join(userDir, cfgDir)
        if not os.path.exists(userDir):
            try:
                os.mkdir(userDir)
            except (OSError, IOError):
                warn = '\n Warning: unable to create user config directory\n' + userDir + '\n Check path and permissions.\n Exiting!\n'
                print(warn, file=sys.stderr)
                raise SystemExit

        return userDir

    def GetOption(self, configType, section, option, default=None, type=None, warn_on_default=True, raw=False):
        try:
            if self.userCfg[configType].has_option(section, option):
                return self.userCfg[configType].Get(section, option, type=type, raw=raw)
        except ValueError:
            warning = '\n Warning: configHandler.py - IdleConf.GetOption -\n invalid %r value for configuration option %r\n from section %r: %r' % (
             type, option, section,
             self.userCfg[configType].Get(section, option, raw=raw))
            try:
                print(warning, file=sys.stderr)
            except IOError:
                pass

        try:
            if self.defaultCfg[configType].has_option(section, option):
                return self.defaultCfg[configType].Get(section, option, type=type, raw=raw)
        except ValueError:
            pass

        if warn_on_default:
            warning = '\n Warning: configHandler.py - IdleConf.GetOption -\n problem retrieving configuration option %r\n from section %r.\n returning default value: %r' % (
             option, section, default)
            try:
                print(warning, file=sys.stderr)
            except IOError:
                pass

        return default

    def SetOption(self, configType, section, option, value):
        self.userCfg[configType].SetOption(section, option, value)

    def GetSectionList(self, configSet, configType):
        if configType not in self.config_types:
            raise InvalidConfigType('Invalid configType specified')
        if configSet == 'user':
            cfgParser = self.userCfg[configType]
        elif configSet == 'default':
            cfgParser = self.defaultCfg[configType]
        else:
            raise InvalidConfigSet('Invalid configSet specified')
        return cfgParser.sections()

    def GetHighlight(self, theme, element, fgBg=None):
        if self.defaultCfg['highlight'].has_section(theme):
            themeDict = self.GetThemeDict('default', theme)
        else:
            themeDict = self.GetThemeDict('user', theme)
        fore = themeDict[(element + '-foreground')]
        if element == 'cursor':
            back = themeDict['normal-background']
        else:
            back = themeDict[(element + '-background')]
        highlight = {'foreground': fore, 'background': back}
        if not fgBg:
            return highlight
        if fgBg == 'fg':
            return highlight['foreground']
        if fgBg == 'bg':
            return highlight['background']
        raise InvalidFgBg('Invalid fgBg specified')

    def GetThemeDict(self, type, themeName):
        if type == 'user':
            cfgParser = self.userCfg['highlight']
        else:
            if type == 'default':
                cfgParser = self.defaultCfg['highlight']
            else:
                raise InvalidTheme('Invalid theme type specified')
            theme = {'normal-foreground': '#000000', 'normal-background': '#ffffff', 
               'keyword-foreground': '#000000', 
               'keyword-background': '#ffffff', 
               'builtin-foreground': '#000000', 
               'builtin-background': '#ffffff', 
               'comment-foreground': '#000000', 
               'comment-background': '#ffffff', 
               'string-foreground': '#000000', 
               'string-background': '#ffffff', 
               'definition-foreground': '#000000', 
               'definition-background': '#ffffff', 
               'hilite-foreground': '#000000', 
               'hilite-background': 'gray', 
               'break-foreground': '#ffffff', 
               'break-background': '#000000', 
               'hit-foreground': '#ffffff', 
               'hit-background': '#000000', 
               'error-foreground': '#ffffff', 
               'error-background': '#000000', 
               'cursor-foreground': '#000000', 
               'stdout-foreground': '#000000', 
               'stdout-background': '#ffffff', 
               'stderr-foreground': '#000000', 
               'stderr-background': '#ffffff', 
               'console-foreground': '#000000', 
               'console-background': '#ffffff'}
            for element in theme:
                if not cfgParser.has_option(themeName, element):
                    warning = '\n Warning: configHandler.IdleConf.GetThemeDict -\n problem retrieving theme element %r\n from theme %r.\n returning default color: %r' % (
                     element, themeName, theme[element])
                    try:
                        print(warning, file=sys.stderr)
                    except IOError:
                        pass

                theme[element] = cfgParser.Get(themeName, element, default=theme[element])

        return theme

    def CurrentTheme(self):
        default = self.GetOption('main', 'Theme', 'default', type='bool', default=True)
        if default:
            theme = self.GetOption('main', 'Theme', 'name2', default='')
        if default and not theme or not default:
            theme = self.GetOption('main', 'Theme', 'name', default='')
        source = self.defaultCfg if default else self.userCfg
        if source['highlight'].has_section(theme):
            return theme
        else:
            return 'IDLE Classic'

    def CurrentKeys(self):
        return self.GetOption('main', 'Keys', 'name', default='')

    def GetExtensions(self, active_only=True, editor_only=False, shell_only=False):
        extns = self.RemoveKeyBindNames(self.GetSectionList('default', 'extensions'))
        userExtns = self.RemoveKeyBindNames(self.GetSectionList('user', 'extensions'))
        for extn in userExtns:
            if extn not in extns:
                extns.append(extn)

        if active_only:
            activeExtns = []
            for extn in extns:
                if self.GetOption('extensions', extn, 'enable', default=True, type='bool'):
                    if editor_only or shell_only:
                        if editor_only:
                            option = 'enable_editor'
                        else:
                            option = 'enable_shell'
                        if self.GetOption('extensions', extn, option, default=True, type='bool', warn_on_default=False):
                            activeExtns.append(extn)
                    else:
                        activeExtns.append(extn)

            return activeExtns
        return extns

    def RemoveKeyBindNames(self, extnNameList):
        names = extnNameList
        kbNameIndicies = []
        for name in names:
            if name.endswith(('_bindings', '_cfgBindings')):
                kbNameIndicies.append(names.index(name))

        kbNameIndicies.sort(reverse=True)
        for index in kbNameIndicies:
            del names[index]

        return names

    def GetExtnNameForEvent(self, virtualEvent):
        extName = None
        vEvent = '<<' + virtualEvent + '>>'
        for extn in self.GetExtensions(active_only=0):
            for event in self.GetExtensionKeys(extn):
                if event == vEvent:
                    extName = extn

        return extName

    def GetExtensionKeys(self, extensionName):
        keysName = extensionName + '_cfgBindings'
        activeKeys = self.GetCurrentKeySet()
        extKeys = {}
        if self.defaultCfg['extensions'].has_section(keysName):
            eventNames = self.defaultCfg['extensions'].GetOptionList(keysName)
            for eventName in eventNames:
                event = '<<' + eventName + '>>'
                binding = activeKeys[event]
                extKeys[event] = binding

        return extKeys

    def __GetRawExtensionKeys(self, extensionName):
        keysName = extensionName + '_cfgBindings'
        extKeys = {}
        if self.defaultCfg['extensions'].has_section(keysName):
            eventNames = self.defaultCfg['extensions'].GetOptionList(keysName)
            for eventName in eventNames:
                binding = self.GetOption('extensions', keysName, eventName, default='').split()
                event = '<<' + eventName + '>>'
                extKeys[event] = binding

        return extKeys

    def GetExtensionBindings(self, extensionName):
        bindsName = extensionName + '_bindings'
        extBinds = self.GetExtensionKeys(extensionName)
        if self.defaultCfg['extensions'].has_section(bindsName):
            eventNames = self.defaultCfg['extensions'].GetOptionList(bindsName)
            for eventName in eventNames:
                binding = self.GetOption('extensions', bindsName, eventName, default='').split()
                event = '<<' + eventName + '>>'
                extBinds[event] = binding

        return extBinds

    def GetKeyBinding(self, keySetName, eventStr):
        eventName = eventStr[2:-2]
        binding = self.GetOption('keys', keySetName, eventName, default='').split()
        return binding

    def GetCurrentKeySet(self):
        result = self.GetKeySet(self.CurrentKeys())
        if sys.platform == 'darwin':
            for k, v in result.items():
                v2 = [ x.replace('<Alt-', '<Option-') for x in v ]
                if v != v2:
                    result[k] = v2

        return result

    def GetKeySet(self, keySetName):
        keySet = self.GetCoreKeys(keySetName)
        activeExtns = self.GetExtensions(active_only=1)
        for extn in activeExtns:
            extKeys = self.__GetRawExtensionKeys(extn)
            if extKeys:
                for event in extKeys:
                    if extKeys[event] in keySet.values():
                        extKeys[event] = ''
                    keySet[event] = extKeys[event]

        return keySet

    def IsCoreBinding(self, virtualEvent):
        return '<<' + virtualEvent + '>>' in self.GetCoreKeys()

    def GetCoreKeys(self, keySetName=None):
        keyBindings = {'<<copy>>': [
                      '<Control-c>', '<Control-C>'], 
           '<<cut>>': [
                     '<Control-x>', '<Control-X>'], 
           '<<paste>>': [
                       '<Control-v>', '<Control-V>'], 
           '<<beginning-of-line>>': [
                                   '<Control-a>', '<Home>'], 
           '<<center-insert>>': [
                               '<Control-l>'], 
           '<<close-all-windows>>': [
                                   '<Control-q>'], 
           '<<close-window>>': [
                              '<Alt-F4>'], 
           '<<do-nothing>>': [
                            '<Control-x>'], 
           '<<end-of-file>>': [
                             '<Control-d>'], 
           '<<python-docs>>': [
                             '<F1>'], 
           '<<python-context-help>>': [
                                     '<Shift-F1>'], 
           '<<history-next>>': [
                              '<Alt-n>'], 
           '<<history-previous>>': [
                                  '<Alt-p>'], 
           '<<interrupt-execution>>': [
                                     '<Control-c>'], 
           '<<view-restart>>': [
                              '<F6>'], 
           '<<restart-shell>>': [
                               '<Control-F6>'], 
           '<<open-class-browser>>': [
                                    '<Alt-c>'], 
           '<<open-module>>': [
                             '<Alt-m>'], 
           '<<open-new-window>>': [
                                 '<Control-n>'], 
           '<<open-window-from-file>>': [
                                       '<Control-o>'], 
           '<<plain-newline-and-indent>>': [
                                          '<Control-j>'], 
           '<<print-window>>': [
                              '<Control-p>'], 
           '<<redo>>': [
                      '<Control-y>'], 
           '<<remove-selection>>': [
                                  '<Escape>'], 
           '<<save-copy-of-window-as-file>>': [
                                             '<Alt-Shift-S>'], 
           '<<save-window-as-file>>': [
                                     '<Alt-s>'], 
           '<<save-window>>': [
                             '<Control-s>'], 
           '<<select-all>>': [
                            '<Alt-a>'], 
           '<<toggle-auto-coloring>>': [
                                      '<Control-slash>'], 
           '<<undo>>': [
                      '<Control-z>'], 
           '<<find-again>>': [
                            '<Control-g>', '<F3>'], 
           '<<find-in-files>>': [
                               '<Alt-F3>'], 
           '<<find-selection>>': [
                                '<Control-F3>'], 
           '<<find>>': [
                      '<Control-f>'], 
           '<<replace>>': [
                         '<Control-h>'], 
           '<<goto-line>>': [
                           '<Alt-g>'], 
           '<<smart-backspace>>': [
                                 '<Key-BackSpace>'], 
           '<<newline-and-indent>>': [
                                    '<Key-Return>', '<Key-KP_Enter>'], 
           '<<smart-indent>>': [
                              '<Key-Tab>'], 
           '<<indent-region>>': [
                               '<Control-Key-bracketright>'], 
           '<<dedent-region>>': [
                               '<Control-Key-bracketleft>'], 
           '<<comment-region>>': [
                                '<Alt-Key-3>'], 
           '<<uncomment-region>>': [
                                  '<Alt-Key-4>'], 
           '<<tabify-region>>': [
                               '<Alt-Key-5>'], 
           '<<untabify-region>>': [
                                 '<Alt-Key-6>'], 
           '<<toggle-tabs>>': [
                             '<Alt-Key-t>'], 
           '<<change-indentwidth>>': [
                                    '<Alt-Key-u>'], 
           '<<del-word-left>>': [
                               '<Control-Key-BackSpace>'], 
           '<<del-word-right>>': [
                                '<Control-Key-Delete>']}
        if keySetName:
            for event in keyBindings:
                binding = self.GetKeyBinding(keySetName, event)
                if binding:
                    keyBindings[event] = binding
                else:
                    warning = '\n Warning: configHandler.py - IdleConf.GetCoreKeys -\n problem retrieving key binding for event %r\n from key set %r.\n returning default value: %r' % (
                     event, keySetName, keyBindings[event])
                    try:
                        print(warning, file=sys.stderr)
                    except IOError:
                        pass

        return keyBindings

    def GetExtraHelpSourceList(self, configSet):
        helpSources = []
        if configSet == 'user':
            cfgParser = self.userCfg['main']
        else:
            if configSet == 'default':
                cfgParser = self.defaultCfg['main']
            else:
                raise InvalidConfigSet('Invalid configSet specified')
            options = cfgParser.GetOptionList('HelpFiles')
            for option in options:
                value = cfgParser.Get('HelpFiles', option, default=';')
                if value.find(';') == -1:
                    menuItem = ''
                    helpPath = ''
                else:
                    value = value.split(';')
                    menuItem = value[0].strip()
                    helpPath = value[1].strip()
                if menuItem and helpPath:
                    helpSources.append((menuItem, helpPath, option))

        helpSources.sort(key=lambda x: int(x[2]))
        return helpSources

    def GetAllExtraHelpSourcesList(self):
        allHelpSources = self.GetExtraHelpSourceList('default') + self.GetExtraHelpSourceList('user')
        return allHelpSources

    def GetFont(self, root, configType, section):
        family = self.GetOption(configType, section, 'font', default='courier')
        size = self.GetOption(configType, section, 'font-size', type='int', default='10')
        bold = self.GetOption(configType, section, 'font-bold', default=0, type='bool')
        if family == 'TkFixedFont':
            if TkVersion < 8.5:
                family = 'Courier'
            else:
                f = Font(name='TkFixedFont', exists=True, root=root)
                actualFont = Font.actual(f)
                family = actualFont['family']
                size = actualFont['size']
                if size <= 0:
                    size = 10
                bold = actualFont['weight'] == 'bold'
        return (
         family, size, 'bold' if bold else 'normal')

    def LoadCfgFiles(self):
        for key in self.defaultCfg:
            self.defaultCfg[key].Load()
            self.userCfg[key].Load()

    def SaveUserCfgFiles(self):
        for key in self.userCfg:
            self.userCfg[key].Save()


idleConf = IdleConf()
if __name__ == '__main__':
    from zlib import crc32
    line, crc = (
     0, 0)

    def sprint(obj):
        global crc
        global line
        txt = str(obj)
        line += 1
        crc = crc32(txt.encode(encoding='utf-8'), crc)
        print(txt)


    def dumpCfg(cfg):
        print('\n', cfg, '\n')
        for key in sorted(cfg.keys()):
            sections = cfg[key].sections()
            sprint(key)
            sprint(sections)
            for section in sections:
                options = cfg[key].options(section)
                sprint(section)
                sprint(options)
                for option in options:
                    sprint(option + ' = ' + cfg[key].Get(section, option))


    dumpCfg(idleConf.defaultCfg)
    dumpCfg(idleConf.userCfg)
    print('\nlines = ', line, ', crc = ', crc, sep='')