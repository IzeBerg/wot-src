package net.wg.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;
   
   public interface IDamageInfoPanelMeta extends IEventDispatcher
   {
       
      
      function as_show(param1:Array, param2:int, param3:Boolean) : void;
      
      function as_hide() : void;
      
      function as_updateEngine(param1:int, param2:Boolean) : void;
      
      function as_hideEngine() : void;
      
      function as_updateAmmoBay(param1:int, param2:Boolean) : void;
      
      function as_hideAmmoBay() : void;
      
      function as_updateFuelTank(param1:int, param2:Boolean) : void;
      
      function as_hideFuelTank() : void;
      
      function as_updateRadio(param1:int, param2:Boolean) : void;
      
      function as_hideRadio() : void;
      
      function as_updateLeftTrack(param1:int, param2:Boolean) : void;
      
      function as_updateSecondLeftTrack(param1:int, param2:Boolean) : void;
      
      function as_hideLeftTrack() : void;
      
      function as_hideSecondLeftTrack() : void;
      
      function as_updateRightTrack(param1:int, param2:Boolean) : void;
      
      function as_updateSecondRightTrack(param1:int, param2:Boolean) : void;
      
      function as_hideRightTrack() : void;
      
      function as_hideSecondRightTrack() : void;
      
      function as_updateGun(param1:int, param2:Boolean) : void;
      
      function as_hideGun() : void;
      
      function as_updateTurretRotator(param1:int, param2:Boolean) : void;
      
      function as_hideTurretRotator() : void;
      
      function as_updateSurveyingDevice(param1:int, param2:Boolean) : void;
      
      function as_hideSurveyingDevice() : void;
      
      function as_updateWheel(param1:int, param2:Boolean) : void;
      
      function as_hideWheel() : void;
      
      function as_updateCommander(param1:int, param2:Boolean) : void;
      
      function as_hideCommander() : void;
      
      function as_updateFirstGunner(param1:int, param2:Boolean) : void;
      
      function as_updateSecondGunner(param1:int, param2:Boolean) : void;
      
      function as_hideFirstGunner() : void;
      
      function as_hideSecondGunner() : void;
      
      function as_updateDriver(param1:int, param2:Boolean) : void;
      
      function as_hideDriver() : void;
      
      function as_updateFirstRadioman(param1:int, param2:Boolean) : void;
      
      function as_updateSecondRadioman(param1:int, param2:Boolean) : void;
      
      function as_hideFirstRadioman() : void;
      
      function as_hideSecondRadioman() : void;
      
      function as_updateFirstLoader(param1:int, param2:Boolean) : void;
      
      function as_updateSecondLoader(param1:int, param2:Boolean) : void;
      
      function as_hideFirstLoader() : void;
      
      function as_hideSecondLoader() : void;
      
      function as_showFire(param1:Boolean) : void;
      
      function as_hideFire() : void;
   }
}
