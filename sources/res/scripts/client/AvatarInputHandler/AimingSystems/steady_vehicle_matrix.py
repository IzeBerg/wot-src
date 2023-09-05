import math_utils, BigWorld, Math
from cgf_obsolete_script.py_component import Component

class SteadyVehicleMatrixCalculator(Component):
    outputMProv = property(lambda self: self.__outputMProv)
    stabilisedMProv = property(lambda self: self.__stabilisedMProv)

    def __init__(self):
        self.__outputMProv = Math.WGCombinedMP()
        self.__stabilisedMProv = Math.WGAdaptiveMatrixProvider()

    def __relinkToIdentity(self):
        self.__outputMProv.rotationSrc = math_utils.createIdentityMatrix()
        self.__outputMProv.translationSrc = self.__outputMProv.rotationSrc
        self.__stabilisedMProv.target = self.__outputMProv.rotationSrc

    def relinkSources(self):
        vehicle = BigWorld.player().getVehicleAttached()
        if vehicle is None or vehicle.isHidden:
            self.__relinkToIdentity()
            return
        else:
            typeDescriptor = vehicle.typeDescriptor
            if typeDescriptor.isPitchHullAimingAvailable:
                self.__outputMProv.rotationSrc = vehicle.filter.groundPlacingMatrixFiltered
                self.__outputMProv.translationSrc = vehicle.filter.stabilisedMatrix
            else:
                self.__outputMProv.rotationSrc = vehicle.filter.stabilisedMatrix
                self.__outputMProv.translationSrc = self.__outputMProv.rotationSrc
            self.__stabilisedMProv.target = vehicle.filter.stabilisedMatrix
            return