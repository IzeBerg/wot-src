package net.wg.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;
   
   public interface IVehicleCompareCartPopoverMeta extends IEventDispatcher
   {
       
      
      function removeS(param1:Number) : void;
      
      function removeAllS() : void;
      
      function gotoCompareViewS() : void;
      
      function as_setInitData(param1:Object) : void;
      
      function as_getDP() : Object;
      
      function as_updateToCmpBtnProps(param1:Object) : void;
      
      function as_updateClearBtnProps(param1:Object) : void;
   }
}
