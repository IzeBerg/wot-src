package net.wg.gui.lobby.vehicleCustomization.data.seasonBar
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class CustomizationSeasonBarRendererVO extends DAAPIDataClass
   {
       
      
      public var nameText:String = "";
      
      public var nameSelectedText:String = "";
      
      public var seasonImageSrc:String = "";
      
      public var seasonBGImageSrc:String = "";
      
      public var seasonShineImageSrc:String = "";
      
      public var isFilled:Boolean = false;
      
      public var forceAnim:Boolean = false;
      
      public var tooltip:String = "";
      
      public function CustomizationSeasonBarRendererVO(param1:Object)
      {
         super(param1);
      }
   }
}
