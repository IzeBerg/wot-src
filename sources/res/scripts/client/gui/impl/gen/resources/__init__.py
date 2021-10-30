from gui.impl.gen_utils import DynAccessor
from .animations import Animations
from .areas import Areas
from .atlases import Atlases
from .dynamic_ids import DynamicIds
from .entries import Entries
from .images import Images
from .sounds import Sounds
from .strings import Strings
from .styles import Styles
from .videos import Videos
from .views import Views

class Resources(object):
    __slots__ = ()
    invalid = DynAccessor(0)
    animations = Animations()
    areas = Areas()
    atlases = Atlases()
    dynamic_ids = DynamicIds()
    entries = Entries()
    images = Images()
    sounds = Sounds()
    strings = Strings()
    styles = Styles()
    videos = Videos()
    views = Views()


R = Resources()