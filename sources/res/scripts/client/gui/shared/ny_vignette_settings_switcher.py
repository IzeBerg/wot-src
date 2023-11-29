import BigWorld
_NY_VIGNETTE_INTENSITY = 0.7
_VIEWS_TO_VIGNETTE_CHANGE = {
 'hangar',
 'heroVehiclePreviewPage',
 'vehiclePreviewPage',
 'ny_navigation'}
_defaultVignetteIntensity = None

def _isVignetteView(viewName):
    return viewName in _VIEWS_TO_VIGNETTE_CHANGE


def checkVignetteSettings(viewName):
    global _defaultVignetteIntensity
    vignetteSettings = BigWorld.WGRenderSettings().getVignetteSettings()
    if _defaultVignetteIntensity is None:
        _defaultVignetteIntensity = vignetteSettings.w
    vignetteSettings.w = _NY_VIGNETTE_INTENSITY if _isVignetteView(viewName) else _defaultVignetteIntensity
    BigWorld.WGRenderSettings().setVignetteSettings(vignetteSettings)
    return