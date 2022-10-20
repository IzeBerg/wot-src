package net.wg.data.VO.daapi
{
   import flash.utils.getQualifiedClassName;
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class DAAPIVehicleStatsVO extends DAAPIDataClass
   {
       
      
      public var isEnemy:Boolean = false;
      
      public var vehicleID:Number = -1;
      
      public var frags:int = -1;
      
      public var damage:int = -1;
      
      public var chatCommand:String = "";
      
      public var chatCommandFlags:uint = 1.0;
      
      public var spottedStatus:uint = 1.0;
      
      public function DAAPIVehicleStatsVO(param1:Object = null)
      {
         super(param1);
      }
      
      override public function toString() : String
      {
         return "[" + getQualifiedClassName(this) + " > id: " + this.vehicleID + ", frags:" + this.frags + "]";
      }
   }
}
