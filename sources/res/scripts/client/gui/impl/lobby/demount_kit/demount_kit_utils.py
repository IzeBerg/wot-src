import typing
from gui.impl import backport
from gui.impl.gen import R
if typing.TYPE_CHECKING:
    from gui.shared.gui_items.artefacts import OptionalDevice

def getDemountDialogTitle(item, forFitting=False, fromSlot=False):
    titleRes = R.strings.demount_kit.equipmentDemountFromSlot if fromSlot else R.strings.demount_kit.equipmentDemount
    titleRes = titleRes.confirmationForFitting.title if forFitting else titleRes.confirmation.title
    return backport.text(titleRes(), equipment=item.userName)