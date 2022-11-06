package net.wg.gui.lobby.vehicleCustomization.data.customizationPanel
{
   import flash.geom.Point;
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class CustomizationCarouselArrowVO extends DAAPIDataClass
   {
       
      
      public var index:int = -1;
      
      public var enabled:Boolean = false;
      
      public var position:Point = null;
      
      public function CustomizationCarouselArrowVO(param1:Object = null)
      {
         super(param1);
      }
   }
}
