package net.wg.gui.lobby.components.data
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class VehicleButtonVO extends DAAPIDataClass
   {
       
      
      public var shopIconPath:String = "";
      
      public var compareBtnVisible:Boolean = true;
      
      public var goToVehicleViewBtnVisible:Boolean = true;
      
      public var compareBtnEnabled:Boolean = false;
      
      public var compareBtnLabel:String = "";
      
      public var compareBtnTooltip:String = "";
      
      public var previewBtnEnabled:Boolean = false;
      
      public var previewBtnLabel:String = "";
      
      public var isPremium:Boolean = false;
      
      public var vehicleId:uint = 0;
      
      public var vehicleState:uint = 0;
      
      public var isInInventory:Boolean = false;
      
      public var cmHandlerType:String = "";
      
      public var previewAlias:String = "";
      
      public function VehicleButtonVO(param1:Object)
      {
         super(param1);
      }
   }
}
