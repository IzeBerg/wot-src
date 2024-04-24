package net.wg.gui.lobby.vehiclePreview.additionalInfo
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class VehicleInfoDescVO extends DAAPIDataClass
   {
       
      
      public var nationFlag:String = "";
      
      public var level:String = "";
      
      public var typeImageSrc:String = "";
      
      public var isElite:Boolean = false;
      
      public var name:String = "";
      
      public function VehicleInfoDescVO(param1:Object = null)
      {
         super(param1);
      }
   }
}
