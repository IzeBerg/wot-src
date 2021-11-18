package net.wg.gui.lobby.vehicleCustomization.data.propertiesSheet
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class CustomizationPropertiesSheetRendererVO extends DAAPIDataClass
   {
       
      
      public var iconSrc:String = "";
      
      public var iconHoverSrc:String = "";
      
      public var iconDisableSrc:String = "";
      
      public var disableTooltip:String = "";
      
      public var rendererLnk:String = "";
      
      public var animatedTransition:Boolean = false;
      
      public var actionBtnLabel:String = "";
      
      public var actionType:int = -1;
      
      public var buttonMode:Boolean = true;
      
      public var enabled:Boolean = true;
      
      public var needNotify:Boolean = false;
      
      public var notifyText:String = "";
      
      public function CustomizationPropertiesSheetRendererVO(param1:Object)
      {
         super(param1);
      }
   }
}
