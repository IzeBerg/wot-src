package net.wg.gui.lobby.vehicleCompare.data
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class VehCompareCrewLevelVO extends DAAPIDataClass
   {
       
      
      public var label:String = "";
      
      public var id:int = -1;
      
      public var tooltip:String = "";
      
      public var showAlert:Boolean = false;
      
      public function VehCompareCrewLevelVO(param1:Object)
      {
         super(param1);
      }
   }
}
