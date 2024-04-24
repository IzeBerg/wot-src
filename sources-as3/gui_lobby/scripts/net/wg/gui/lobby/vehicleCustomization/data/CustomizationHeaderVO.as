package net.wg.gui.lobby.vehicleCustomization.data
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class CustomizationHeaderVO extends DAAPIDataClass
   {
       
      
      public var tankTier:String = "";
      
      public var tankName:String = "";
      
      public var tankType:String = "";
      
      public var tankInfo:String = "";
      
      public var closeBtnTooltip:String = "";
      
      public var isElite:Boolean = false;
      
      public var isQuestProgressionInfoBtnVisible:Boolean = false;
      
      public function CustomizationHeaderVO(param1:Object)
      {
         super(param1);
      }
   }
}
