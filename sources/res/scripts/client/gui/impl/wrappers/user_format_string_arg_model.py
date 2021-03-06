from gui.impl.gen.view_models.common.format_string_arg_model import FormatStringArgModel

class UserFormatStringArgModel(FormatStringArgModel):
    __slots__ = ()

    def __init__(self, value, name='', style=None, align=FormatStringArgModel.ALIGN_LEFT, hardSpace=False):
        super(UserFormatStringArgModel, self).__init__()
        self.setValue(value)
        self.setName(name)
        self.setAlign(align)
        self.setHardSpace(hardSpace)
        if style is not None:
            self.setStyle(style)
        return