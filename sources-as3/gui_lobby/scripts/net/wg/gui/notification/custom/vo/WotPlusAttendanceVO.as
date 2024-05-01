package net.wg.gui.notification.custom.vo
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   import net.wg.gui.lobby.components.data.AwardItemRendererExVO;
   
   public class WotPlusAttendanceVO extends DAAPIDataClass
   {
      
      private static const REWARDS_FIELD_NAME:String = "rewards";
       
      
      public var endText:String = "";
      
      public var rewards:Array = null;
      
      public function WotPlusAttendanceVO(param1:Object = null)
      {
         super(param1);
      }
      
      override protected function onDataWrite(param1:String, param2:Object) : Boolean
      {
         var _loc3_:Array = null;
         var _loc4_:Object = null;
         if(param1 == REWARDS_FIELD_NAME)
         {
            _loc3_ = param2 as Array;
            this.rewards = [];
            for each(_loc4_ in _loc3_)
            {
               this.rewards.push(new AwardItemRendererExVO(_loc4_));
            }
            return false;
         }
         return true;
      }
      
      override protected function onDispose() : void
      {
         this.rewards = null;
         super.onDispose();
      }
   }
}
