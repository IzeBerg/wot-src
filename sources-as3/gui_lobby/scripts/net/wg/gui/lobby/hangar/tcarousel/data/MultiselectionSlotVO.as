package net.wg.gui.lobby.hangar.tcarousel.data
{
   import net.wg.data.daapi.base.DAAPIUpdatableDataClass;
   
   public class MultiselectionSlotVO extends DAAPIUpdatableDataClass
   {
       
      
      public var inventoryId:int = -1;
      
      public var indexStr:String = "";
      
      public var formattedStatusStr:String = "";
      
      public var stat:String = "";
      
      public var stateLevel:String = "";
      
      public var vehicleName:String = "";
      
      public var vehicleIcon:String = "";
      
      public var vehicleType:String = "";
      
      public var vehicleLevel:int = -1;
      
      public var isElite:Boolean = false;
      
      public var isActivated:Boolean = false;
      
      public var showAlert:Boolean = false;
      
      public var alertTooltip:String = "";
      
      public function MultiselectionSlotVO(param1:Object)
      {
         super(param1);
      }
   }
}
