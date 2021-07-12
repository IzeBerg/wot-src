package net.wg.gui.battle.battleRoyale.data
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class VehicleCounterVO extends DAAPIDataClass
   {
       
      
      public var count:int = -1;
      
      public var description:String = "";
      
      public var icon:String = "";
      
      public var squads:String = "";
      
      public function VehicleCounterVO(param1:Object = null)
      {
         super(param1);
      }
   }
}
