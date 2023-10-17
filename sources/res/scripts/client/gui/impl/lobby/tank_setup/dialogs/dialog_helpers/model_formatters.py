

def initItemInfo(viewModel, device, currency):
    with viewModel.transaction() as (model):
        model.detailsDevice.setOverlayType(device.getHighlightType())
        model.detailsDevice.setLevel(device.level)
        model.detailsDevice.setDeviceName(device.name)
        model.detailsPriceBlock.setCurrencyName(currency)
        model.detailsPriceBlock.setCountDevice(device.inventoryCount)
        actualPrices = device.sellPrices.itemPrice.price
        model.detailsPriceBlock.setPriceDevice(actualPrices.toSignDict().get(currency, 0))