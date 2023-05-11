package net.wg.data.VO.daapi
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class DAAPITriggeredCommandVO extends DAAPIDataClass
   {
       
      
      public var vehicleID:Number = 0;
      
      public var chatCommandName:String = "";
      
      public function DAAPITriggeredCommandVO(param1:Object)
      {
         super(param1);
      }
      
      override public function toString() : String
      {
         return "[DAAPITriggeredCommandVO] > id: " + this.vehicleID + ", chatCommandName:" + this.chatCommandName + "]";
      }
   }
}
