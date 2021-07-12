package net.wg.gui.lobby.vehiclePreview.data
{
   public class VPPageVO extends VPPageBaseVO
   {
       
      
      public var vehicleLevel:String = "";
      
      public var vehicleName:String = "";
      
      public var isVehicleElite:Boolean;
      
      public var vehicleType:String = "";
      
      public var nationFlagIcon:String = "";
      
      public var roleText:String = "";
      
      public var roleId:int = -1;
      
      public var compareBtnTooltip:String = "";
      
      public var showCompareBtn:Boolean;
      
      public var listDesc:String = "";
      
      public var isMultinational:Boolean;
      
      public function VPPageVO(param1:Object)
      {
         super(param1);
      }
   }
}
