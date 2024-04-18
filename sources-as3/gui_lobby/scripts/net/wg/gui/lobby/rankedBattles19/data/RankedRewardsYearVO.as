package net.wg.gui.lobby.rankedBattles19.data
{
   import net.wg.data.constants.Errors;
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class RankedRewardsYearVO extends DAAPIDataClass
   {
      
      private static const REWARDS_FIELD:String = "rewards";
       
      
      public var title:String = "";
      
      public var titleIcon:String = "";
      
      public var titleTooltip:String = "";
      
      public var compensation:String = "";
      
      public var points:int = -1;
      
      public var rewards:Vector.<RankedRewardYearItemVO> = null;
      
      public function RankedRewardsYearVO(param1:Object = null)
      {
         super(param1);
      }
      
      override protected function onDispose() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         if(this.rewards)
         {
            _loc1_ = this.rewards.length;
            _loc2_ = 0;
            while(_loc2_ < _loc1_)
            {
               this.rewards.pop().dispose();
               _loc2_++;
            }
            this.rewards = null;
         }
         super.onDispose();
      }
      
      override protected function onDataWrite(param1:String, param2:Object) : Boolean
      {
         var _loc3_:Array = null;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         if(param1 == REWARDS_FIELD)
         {
            if(param2)
            {
               _loc3_ = param2 as Array;
               App.utils.asserter.assert(Boolean(_loc3_),param1 + Errors.INVALID_TYPE);
               this.rewards = new Vector.<RankedRewardYearItemVO>();
               _loc4_ = _loc3_.length;
               _loc5_ = 0;
               while(_loc5_ < _loc4_)
               {
                  this.rewards.push(new RankedRewardYearItemVO(_loc3_[_loc5_]));
                  _loc5_++;
               }
            }
            return false;
         }
         return super.onDataWrite(param1,param2);
      }
   }
}
