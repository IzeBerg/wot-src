package net.wg.gui.lobby.vehicleCustomization.data.customizationPanel
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class CustomizationCarouselBookmarkVO extends DAAPIDataClass
   {
       
      
      public var bookmarkName:String = "";
      
      public var bookmarkIndex:int = -1;
      
      public function CustomizationCarouselBookmarkVO(param1:Object)
      {
         super(param1);
      }
   }
}
