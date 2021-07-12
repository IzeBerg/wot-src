package net.wg.gui.lobby.vehiclePreview.data
{
   import net.wg.data.daapi.base.DAAPIUpdatableDataClass;
   
   public class VPPackItemVO extends DAAPIUpdatableDataClass
   {
       
      
      public var value:String = "";
      
      public var icon:String = "";
      
      public var description:String = "";
      
      public var hasCompensation:Boolean;
      
      public var overlayType:String = "";
      
      public function VPPackItemVO(param1:Object)
      {
         super(param1);
      }
   }
}
