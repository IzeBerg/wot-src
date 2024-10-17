from halloween_common.halloween_constants import ENEMY_ROLE_TAG_PREFIX
_HWROLE_PREFIX_LEN = len(ENEMY_ROLE_TAG_PREFIX)
g_vehicleRoleHelper = None

def getVehicleRole(vehicleType):
    return g_vehicleRoleHelper.getVehicleRole(vehicleType)


class HWVehicleRoleHelper(object):

    def __init__(self, *args, **kwargs):
        super(HWVehicleRoleHelper, self).__init__(*args, **kwargs)
        self.__vehicleRoles = {}

    def getVehicleRole(self, vehicleType):
        compactDescr = vehicleType.compactDescr
        role = self.__vehicleRoles.get(compactDescr)
        if role is not None:
            return self.__getReturnValue(role)
        else:
            role = self.__extractVehicleRole(vehicleType)
            self.__vehicleRoles[compactDescr] = role
            return self.__getReturnValue(role)

    def __extractVehicleRole(self, vehicleType):
        for tag in vehicleType.tags:
            if tag.startswith(ENEMY_ROLE_TAG_PREFIX):
                return tag[_HWROLE_PREFIX_LEN:]

        return ''

    def __getReturnValue(self, role):
        if role is None or role == '':
            return
        return role


g_vehicleRoleHelper = HWVehicleRoleHelper()