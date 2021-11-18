package net.wg.gui.lobby.vehiclePreview.data
{
   import net.wg.data.daapi.base.DAAPIUpdatableDataClass;
   
   public class VPVehicleCarouselVO extends DAAPIUpdatableDataClass
   {
       
      
      public var id:int = -1;
      
      public var intCD:int = -1;
      
      public var icon:String = "";
      
      public var iconAlt:String = "";
      
      public var label:String = "";
      
      public var tankType:String = "";
      
      public var level:String = "";
      
      public var nation:Number = 0;
      
      public var hasCompensation:Boolean = false;
      
      public function VPVehicleCarouselVO(param1:Object)
      {
         super(param1);
      }
   }
}
