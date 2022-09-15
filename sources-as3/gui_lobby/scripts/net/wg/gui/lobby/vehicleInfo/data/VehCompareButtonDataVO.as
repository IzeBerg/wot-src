package net.wg.gui.lobby.vehicleInfo.data
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class VehCompareButtonDataVO extends DAAPIDataClass
   {
       
      
      public var label:String = "";
      
      public var tooltip:String = "";
      
      public var visible:Boolean = false;
      
      public var enabled:Boolean = false;
      
      public function VehCompareButtonDataVO(param1:Object)
      {
         super(param1);
      }
   }
}
