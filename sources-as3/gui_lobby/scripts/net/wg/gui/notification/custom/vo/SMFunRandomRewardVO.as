package net.wg.gui.notification.custom.vo
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   import net.wg.gui.lobby.components.AwardItemRendererEx;
   import net.wg.gui.lobby.components.data.AwardItemRendererExVO;
   
   public class SMFunRandomRewardVO extends DAAPIDataClass
   {
      
      private static const MAIN_REWARD_FIELD_NAME:String = "mainReward";
      
      private static const REWARDS_FIELD_NAME:String = "rewards";
       
      
      public var mainReward:AwardItemRendererExVO = null;
      
      public var rewards:Array = null;
      
      public var bgIcon:String = "";
      
      public function SMFunRandomRewardVO(param1:Object = null)
      {
         super(param1);
      }
      
      override protected function onDataWrite(param1:String, param2:Object) : Boolean
      {
         var _loc3_:Array = null;
         var _loc4_:Object = null;
         if(param1 == MAIN_REWARD_FIELD_NAME)
         {
            if(param2)
            {
               this.mainReward = new AwardItemRendererExVO(param2);
            }
            return false;
         }
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
         return super.onDataWrite(param1,param2);
      }
      
      override protected function onDispose() : void
      {
         var _loc1_:AwardItemRendererEx = null;
         if(this.rewards != null)
         {
            for each(_loc1_ in this.rewards)
            {
               _loc1_.dispose();
            }
            this.rewards.length = 0;
            this.rewards = null;
         }
         if(this.mainReward != null)
         {
            this.mainReward.dispose();
            this.mainReward = null;
         }
         super.onDispose();
      }
   }
}
