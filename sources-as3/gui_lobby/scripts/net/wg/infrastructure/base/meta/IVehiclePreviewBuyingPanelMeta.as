package net.wg.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;
   
   public interface IVehiclePreviewBuyingPanelMeta extends IEventDispatcher
   {
       
      
      function onBuyOrResearchClickS() : void;
      
      function onCarouselVehicleSelectedS(param1:int) : void;
      
      function onOfferSelectedS(param1:String) : void;
      
      function showTooltipS(param1:String, param2:String) : void;
      
      function updateDataS(param1:Boolean) : void;
      
      function onCouponSelectedS(param1:Boolean) : void;
      
      function as_setBuyData(param1:Object) : void;
      
      function as_setSetItemsData(param1:Object) : void;
      
      function as_setCoupon(param1:Object) : void;
      
      function as_setSetVehiclesData(param1:Object) : void;
      
      function as_setOffersData(param1:Array) : void;
      
      function as_setSetTitleTooltip(param1:String) : void;
      
      function as_updateLeftTime(param1:String, param2:Boolean) : void;
   }
}
