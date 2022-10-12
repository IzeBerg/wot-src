package net.wg.infrastructure.base.meta.impl
{
   import net.wg.data.constants.Errors;
   import net.wg.gui.components.carousels.CarouselEnvironment;
   
   public class TankCarouselMeta extends CarouselEnvironment
   {
       
      
      public var restoreTank:Function;
      
      public var buyTank:Function;
      
      public var buySlot:Function;
      
      public var buyRentPromotion:Function;
      
      public var selectWotPlusVehicle:Function;
      
      public var getCarouselAlias:Function;
      
      public var setFilter:Function;
      
      public function TankCarouselMeta()
      {
         super();
      }
      
      public function restoreTankS() : void
      {
         App.utils.asserter.assertNotNull(this.restoreTank,"restoreTank" + Errors.CANT_NULL);
         this.restoreTank();
      }
      
      public function buyTankS() : void
      {
         App.utils.asserter.assertNotNull(this.buyTank,"buyTank" + Errors.CANT_NULL);
         this.buyTank();
      }
      
      public function buySlotS() : void
      {
         App.utils.asserter.assertNotNull(this.buySlot,"buySlot" + Errors.CANT_NULL);
         this.buySlot();
      }
      
      public function buyRentPromotionS(param1:int) : void
      {
         App.utils.asserter.assertNotNull(this.buyRentPromotion,"buyRentPromotion" + Errors.CANT_NULL);
         this.buyRentPromotion(param1);
      }
      
      public function selectWotPlusVehicleS(param1:int) : void
      {
         App.utils.asserter.assertNotNull(this.selectWotPlusVehicle,"selectWotPlusVehicle" + Errors.CANT_NULL);
         this.selectWotPlusVehicle(param1);
      }
      
      public function getCarouselAliasS() : String
      {
         App.utils.asserter.assertNotNull(this.getCarouselAlias,"getCarouselAlias" + Errors.CANT_NULL);
         return this.getCarouselAlias();
      }
      
      public function setFilterS(param1:int) : void
      {
         App.utils.asserter.assertNotNull(this.setFilter,"setFilter" + Errors.CANT_NULL);
         this.setFilter(param1);
      }
   }
}
