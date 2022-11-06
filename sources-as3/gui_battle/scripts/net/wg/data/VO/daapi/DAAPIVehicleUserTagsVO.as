package net.wg.data.VO.daapi
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class DAAPIVehicleUserTagsVO extends DAAPIDataClass
   {
       
      
      public var isEnemy:Boolean = false;
      
      public var userTags:Array = null;
      
      public var vehicleID:Number = -1;
      
      public function DAAPIVehicleUserTagsVO(param1:Object = null)
      {
         super(param1);
      }
      
      override public function toString() : String
      {
         return "[DAAPIVehicleUserTagsVO: vehicleID = " + this.vehicleID + " userTags = " + this.userTags + "]";
      }
      
      override protected function onDispose() : void
      {
         if(this.userTags)
         {
            this.userTags.splice(0,this.userTags.length);
            this.userTags = null;
         }
         super.onDispose();
      }
   }
}
