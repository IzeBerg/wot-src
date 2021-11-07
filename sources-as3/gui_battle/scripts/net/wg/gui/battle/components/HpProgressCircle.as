package net.wg.gui.battle.components
{
   public class HpProgressCircle extends BaseProgressCircle
   {
      
      public static const TEAM_KILLER_STATE:String = "teamkiller";
      
      public static const PLATOON_STATE:String = "platoon";
      
      public static const PLATOON_COLORBLIND_STATE:String = "platoonColorblind";
      
      public static const HIDING_STATE:String = "hiding";
       
      
      private var _isAoI:Boolean = false;
      
      public function HpProgressCircle()
      {
         super();
      }
      
      public function setType(param1:String, param2:Boolean, param3:Boolean) : void
      {
         this._isAoI = param2;
         colorblindMode = param3;
         var _loc4_:String = state;
         state = this.getCorrectState(param1);
         if(_loc4_ == state)
         {
            return;
         }
         gotoAndStop(state);
         curFrame = SEMI_LAST_FRAME;
         progressCircle.gotoAndStop(SEMI_LAST_FRAME);
      }
      
      override protected function getCorrectState(param1:String) : String
      {
         if(param1 == ENEMY_STATE && colorblindMode)
         {
            param1 = COLORBLIND_STATE;
         }
         else if(param1 == ENEMY_STATE && !this._isAoI)
         {
            param1 = HIDING_STATE;
         }
         else if(param1 == PLATOON_STATE && colorblindMode)
         {
            param1 = PLATOON_COLORBLIND_STATE;
         }
         return param1;
      }
   }
}
