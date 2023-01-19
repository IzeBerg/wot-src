package net.wg.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;
   
   public interface ITankCarouselMeta extends IEventDispatcher
   {
       
      
      function restoreTankS() : void;
      
      function buyTankS() : void;
      
      function buySlotS() : void;
      
      function buyRentPromotionS(param1:int) : void;
      
      function selectWotPlusVehicleS(param1:int) : void;
      
      function getCarouselAliasS() : String;
      
      function setFilterS(param1:int) : void;
      
      function as_rowCount(param1:int) : void;
      
      function as_setSmallDoubleCarousel(param1:Boolean) : void;
      
      function as_useExtendedCarousel(param1:Boolean) : void;
      
      function as_scrollToSlot(param1:int) : void;
   }
}
