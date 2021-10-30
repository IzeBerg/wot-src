import pointcuts as _pointcuts

def configure_pointcuts(config):
    _pointcuts.MakeTankUnavailableInCarousel(config)
    _pointcuts.VehicleTooltipStatus(config)