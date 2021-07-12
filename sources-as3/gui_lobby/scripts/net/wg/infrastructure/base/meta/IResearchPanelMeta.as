package net.wg.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;
   
   public interface IResearchPanelMeta extends IEventDispatcher
   {
       
      
      function goToResearchS() : void;
      
      function addVehToCompareS() : void;
      
      function as_updateCurrentVehicle(param1:Object) : void;
      
      function as_setEarnedXP(param1:Number) : void;
      
      function as_setElite(param1:Boolean) : void;
      
      function as_setIGRLabel(param1:Boolean, param2:String) : void;
      
      function as_actionIGRDaysLeft(param1:Boolean, param2:String) : void;
      
      function as_setNavigationEnabled(param1:Boolean) : void;
   }
}
