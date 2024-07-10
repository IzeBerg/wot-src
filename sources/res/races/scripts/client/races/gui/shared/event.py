from gui.shared.event_bus import SharedEvent

class RacesEvent(SharedEvent):
    OPEN_RACES = 'openRaces'
    ON_RACE_FIRST_LIGHTS = 'onRaceFirstLights'
    ON_RACE_LAST_LIGHTS = 'onRaceLastLights'
    ON_OPEN_F1_HELP = 'onOpenF1Helper'
    ON_RACE_FINISHED = 'onRaceFinished'