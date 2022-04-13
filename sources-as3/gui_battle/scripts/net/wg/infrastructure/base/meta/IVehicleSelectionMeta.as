package net.wg.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;
   
   public interface IVehicleSelectionMeta extends IEventDispatcher
   {
       
      
      function setSelectionParamsS(param1:int, param2:int, param3:int, param4:int, param5:Boolean) : void;
      
      function handleRightMouseBtnS() : void;
      
      function handleMouseOverUIS(param1:Boolean) : void;
      
      function handleMouseWheelS(param1:int) : void;
      
      function as_setEnabled(param1:Boolean) : void;
   }
}
