package net.wg.gui.battle.battleloading.vo
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class VehStatusVO extends DAAPIDataClass
   {
       
      
      public var vehicleID:Number = 0;
      
      public var status:int = 0;
      
      public var vehiclesIDs:Array = null;
      
      public function VehStatusVO(param1:Object)
      {
         super(param1);
      }
      
      override protected function onDispose() : void
      {
         if(this.vehiclesIDs)
         {
            this.vehiclesIDs.splice(0,this.vehiclesIDs.length);
            this.vehiclesIDs = null;
         }
         super.onDispose();
      }
   }
}
