from typing import NamedTuple, List, Optional
from gui.impl.dialogs.sub_views.common.simple_text import ImageSubstitution
IconSetData = NamedTuple('IconSetData', [
 (
  'iconRes', long),
 (
  'label', Optional[str]),
 (
  'imageSubstitutions', Optional[List[ImageSubstitution]])])