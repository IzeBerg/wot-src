import BigWorld, Event

class HBBattleFeedbackComponent(BigWorld.DynamicScriptComponent):
    onVehicleHeal = Event.Event()

    @classmethod
    def unpackHBActionApplied(cls, packedEffect):
        return (packedEffect >> 24 & 65535, packedEffect >> 12 & 4095, packedEffect & 255)