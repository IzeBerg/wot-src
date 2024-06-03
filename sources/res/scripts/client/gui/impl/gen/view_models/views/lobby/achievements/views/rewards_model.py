from gui.impl.gen.view_models.views.lobby.dog_tags.animated_dog_tag_component import AnimatedDogTagComponent

class RewardsModel(AnimatedDogTagComponent):
    __slots__ = ()

    def __init__(self, properties=7, commands=0):
        super(RewardsModel, self).__init__(properties=properties, commands=commands)

    def _initialize(self):
        super(RewardsModel, self)._initialize()