package net.wg.gui.lobby.vehicleCustomization.data
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class CustomizationSwitcherVO extends DAAPIDataClass
   {
       
      
      public var leftLabel:String = "";
      
      public var rightLabel:String = "";
      
      public var editableTooltip:String = "";
      
      public var rightEnabled:Boolean = true;
      
      public var selectedIndex:int = -1;
      
      public var isEditable:Boolean = false;
      
      public var popoverAlias:String = "";
      
      public function CustomizationSwitcherVO(param1:Object)
      {
         super(param1);
      }
   }
}
