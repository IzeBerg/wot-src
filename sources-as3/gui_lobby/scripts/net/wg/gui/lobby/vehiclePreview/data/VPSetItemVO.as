package net.wg.gui.lobby.vehiclePreview.data
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class VPSetItemVO extends DAAPIDataClass
   {
       
      
      public var slotIndex:int = -1;
      
      public var count:String = "";
      
      public var icon:String = "";
      
      public var iconAlt:String = "";
      
      public var tooltipType:String = "";
      
      public var tooltip:String = "";
      
      public var id:String = "";
      
      public var type:String = "";
      
      public var overlayType:String = "";
      
      public var rawData:Object = null;
      
      public var hasCompensation:Boolean = false;
      
      public function VPSetItemVO(param1:Object)
      {
         super(param1);
      }
   }
}
