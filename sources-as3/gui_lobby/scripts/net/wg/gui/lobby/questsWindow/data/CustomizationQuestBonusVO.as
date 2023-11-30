package net.wg.gui.lobby.questsWindow.data
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class CustomizationQuestBonusVO extends DAAPIDataClass
   {
       
      
      public var showPrice:Boolean = false;
      
      public var intCD:int = -1;
      
      public var value:int = -1;
      
      public var vehicleIntCD:int = -1;
      
      public var itemTypeID:int = -1;
      
      public var boundToCurrentVehicle:Boolean = false;
      
      public var boundVehicle:String = "";
      
      public var texture:String = "";
      
      public var valueStr:String = "";
      
      public var description:String = "";
      
      public function CustomizationQuestBonusVO(param1:Object = null)
      {
         super(param1);
      }
   }
}
