package net.wg.gui.lobby.vehiclePreview.data
{
   import net.wg.data.daapi.base.DAAPIUpdatableDataClass;
   
   public class VPCompensationVO extends DAAPIUpdatableDataClass
   {
       
      
      public var iconInfo:String = "";
      
      public var description:String = "";
      
      public var value:String = "";
      
      public var tooltip:String = "";
      
      public function VPCompensationVO(param1:Object)
      {
         super(param1);
      }
   }
}
