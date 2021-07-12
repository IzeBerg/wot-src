package net.wg.gui.battle.battleloading.vo
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class VehicleDataVO extends DAAPIDataClass
   {
       
      
      public var vehiclesInfo:Array = null;
      
      public function VehicleDataVO(param1:Object)
      {
         super(param1);
      }
      
      override protected function onDispose() : void
      {
         this.vehiclesInfo.splice(0,this.vehiclesInfo.length);
         this.vehiclesInfo = null;
         super.onDispose();
      }
   }
}
