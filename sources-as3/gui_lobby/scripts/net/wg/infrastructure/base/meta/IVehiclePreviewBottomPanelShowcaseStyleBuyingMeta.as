package net.wg.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;
   
   public interface IVehiclePreviewBottomPanelShowcaseStyleBuyingMeta extends IEventDispatcher
   {
       
      
      function onBuyClickS() : void;
      
      function as_setData(param1:Object) : void;
      
      function as_updateTimeRemaining(param1:String) : void;
      
      function as_setBuyingTimeElapsed(param1:Boolean) : void;
   }
}
