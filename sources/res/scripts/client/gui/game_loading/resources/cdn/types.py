import typing
from gui.game_loading.resources.cdn.models import ConfigSequenceModel, ConfigSlideModel, LocalSlideModel, LocalSequenceModel
SequenceType = typing.Union[(ConfigSequenceModel, LocalSequenceModel)]
SlideType = typing.Union[(ConfigSlideModel, LocalSlideModel)]