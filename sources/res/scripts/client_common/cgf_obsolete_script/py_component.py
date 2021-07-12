from cgf_obsolete_script.auto_properties import AutoPropertyInitMetaclass

class Component(object):
    __metaclass__ = AutoPropertyInitMetaclass

    def activate(self):
        pass

    def deactivate(self):
        pass

    def destroy(self):
        pass