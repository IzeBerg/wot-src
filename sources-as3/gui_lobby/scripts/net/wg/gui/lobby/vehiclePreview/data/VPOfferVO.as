package net.wg.gui.lobby.vehiclePreview.data
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class VPOfferVO extends DAAPIDataClass
   {
       
      
      public var id:String = "";
      
      public var label:String = "";
      
      public var tooltipData:String = "";
      
      public var active:Boolean;
      
      public function VPOfferVO(param1:Object)
      {
         super(param1);
      }
   }
}
