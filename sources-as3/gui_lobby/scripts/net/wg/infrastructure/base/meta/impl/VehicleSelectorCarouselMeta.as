package net.wg.infrastructure.base.meta.impl
{
   import net.wg.data.constants.Errors;
   import net.wg.gui.components.carousels.CarouselEnvironment;
   
   public class VehicleSelectorCarouselMeta extends CarouselEnvironment
   {
       
      
      public var setFilter:Function;
      
      public function VehicleSelectorCarouselMeta()
      {
         super();
      }
      
      public function setFilterS(param1:int, param2:Boolean) : void
      {
         App.utils.asserter.assertNotNull(this.setFilter,"setFilter" + Errors.CANT_NULL);
         this.setFilter(param1,param2);
      }
   }
}
