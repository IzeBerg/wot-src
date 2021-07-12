package net.wg.infrastructure.base.meta.impl
{
   import net.wg.data.constants.Errors;
   import net.wg.gui.components.carousels.ScrollCarousel;
   
   public class CarouselEnvironmentMeta extends ScrollCarousel
   {
       
      
      public var selectVehicle:Function;
      
      public var resetFilters:Function;
      
      public function CarouselEnvironmentMeta()
      {
         super();
      }
      
      public function selectVehicleS(param1:int) : void
      {
         App.utils.asserter.assertNotNull(this.selectVehicle,"selectVehicle" + Errors.CANT_NULL);
         this.selectVehicle(param1);
      }
      
      public function resetFiltersS() : void
      {
         App.utils.asserter.assertNotNull(this.resetFilters,"resetFilters" + Errors.CANT_NULL);
         this.resetFilters();
      }
   }
}
