package net.wg.gui.lobby.vehiclePreview.data
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class VPAdditionalInfoVO extends DAAPIDataClass
   {
       
      
      public var objectSubtitle:String = "";
      
      public var objectTitle:String = "";
      
      public var descriptionTitle:String = "";
      
      public var descriptionText:String = "";
      
      public function VPAdditionalInfoVO(param1:Object)
      {
         super(param1);
      }
   }
}
