package net.wg.infrastructure.base.meta.impl
{
   import net.wg.data.constants.Errors;
   import net.wg.gui.components.containers.inject.GFInjectComponent;
   
   public class CarouselBannerInjectMeta extends GFInjectComponent
   {
       
      
      public var setIsExtended:Function;
      
      public function CarouselBannerInjectMeta()
      {
         super();
      }
      
      public function setIsExtendedS(param1:Boolean) : void
      {
         App.utils.asserter.assertNotNull(this.setIsExtended,"setIsExtended" + Errors.CANT_NULL);
         this.setIsExtended(param1);
      }
   }
}
