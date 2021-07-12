import pointcuts as _pointcuts

def configure_pointcuts(config):
    _pointcuts.OnBuyVehicle(config)
    _pointcuts.OnRestoreVehicle(config)
    _pointcuts.OnTechTreePopulate()