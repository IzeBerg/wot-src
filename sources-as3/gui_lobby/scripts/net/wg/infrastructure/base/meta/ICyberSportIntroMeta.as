package net.wg.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;
   
   public interface ICyberSportIntroMeta extends IEventDispatcher
   {
       
      
      function requestVehicleSelectionS() : void;
      
      function startAutoMatchingS() : void;
      
      function showSelectorPopupS() : void;
      
      function showStaticTeamStaffS() : void;
      
      function as_setSelectedVehicle(param1:Object) : void;
      
      function as_setTexts(param1:Object) : void;
      
      function as_setNoVehicles(param1:String) : void;
   }
}
