package net.wg.gui.battle.battleloading.vo
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class VehInfoWithSortedIDVO extends DAAPIDataClass
   {
       
      
      public var vehicleInfo:Object = null;
      
      public var vehiclesIDs:Array = null;
      
      public function VehInfoWithSortedIDVO(param1:Object)
      {
         super(param1);
      }
      
      override protected function onDispose() : void
      {
         this.vehicleInfo = App.utils.data.cleanupDynamicObject(this.vehicleInfo);
         if(this.vehiclesIDs)
         {
            this.vehiclesIDs.splice(0,this.vehiclesIDs.length);
            this.vehiclesIDs = null;
         }
         super.onDispose();
      }
   }
}
