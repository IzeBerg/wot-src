package net.wg.gui.lobby.battleRoyale.vehicleInfoView.data
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class VehicleInfoViewVO extends DAAPIDataClass
   {
       
      
      public var vehTitle:String = "";
      
      public var vehTypeIcon:String = "";
      
      public var btnCloseLabel:String = "";
      
      public var infoIconSource:String = "";
      
      public var tutorialText:String = "";
      
      public var infoText:String = "";
      
      public function VehicleInfoViewVO(param1:Object = null)
      {
         super(param1);
      }
   }
}
