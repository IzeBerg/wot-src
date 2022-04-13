package net.wg.gui.lobby.tankman.vo
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class VehicleSelectionItemVO extends DAAPIDataClass
   {
       
      
      public var id:int = -1;
      
      public var type:String = "";
      
      public var name:String = "";
      
      public function VehicleSelectionItemVO(param1:Object)
      {
         super(param1);
      }
   }
}
