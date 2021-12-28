package net.wg.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;
   
   public interface IAmmunitionPanelMeta extends IEventDispatcher
   {
       
      
      function showRepairDialogS() : void;
      
      function showCustomizationS() : void;
      
      function toRentContinueS() : void;
      
      function showChangeNationS() : void;
      
      function onNYBonusPanelClickedS() : void;
      
      function as_setWarningState(param1:Boolean) : void;
      
      function as_updateVehicleStatus(param1:Object) : void;
      
      function as_setCustomizationBtnCounter(param1:int) : void;
   }
}
