package net.wg.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;
   
   public interface IVehiclePreviewEventProgressionBuyingPanelMeta extends IEventDispatcher
   {
       
      
      function onBuyClickS() : void;
      
      function showTooltipS(param1:String, param2:String) : void;
      
      function as_setData(param1:Object) : void;
      
      function as_setSetItemsData(param1:Object) : void;
   }
}
