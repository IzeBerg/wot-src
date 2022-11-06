package net.wg.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;
   
   public interface IVehicleSellDialogMeta extends IEventDispatcher
   {
       
      
      function setDialogSettingsS(param1:Boolean) : void;
      
      function sellS() : void;
      
      function setUserInputS(param1:String) : void;
      
      function setCrewDismissalS(param1:Boolean) : void;
      
      function onSelectionChangedS(param1:int, param2:Boolean, param3:String) : void;
      
      function as_setData(param1:Object) : void;
      
      function as_visibleControlBlock(param1:Boolean) : void;
      
      function as_enableButton(param1:Boolean) : void;
      
      function as_setControlQuestionData(param1:Boolean, param2:String, param3:String) : void;
      
      function as_setTotal(param1:int, param2:Object) : void;
      
      function as_updateAccountMoney(param1:String, param2:int) : void;
   }
}
