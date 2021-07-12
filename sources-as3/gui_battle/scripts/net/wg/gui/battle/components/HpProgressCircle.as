package net.wg.gui.battle.components
{
   public class HpProgressCircle extends BaseProgressCircle
   {
      
      public static const TEAM_KILLER_STATE:String = "teamkiller";
      
      public static const PLATOON_STATE:String = "platoon";
      
      public static const PLATOON_COLORBLIND_STATE:String = "platoonColorblind";
      
      public static const HIDING_STATE:String = "hiding";
       
      
      private var _prevState:String = "";
      
      private var _isAoI:Boolean = false;
      
      private var _originalState:String = "";
      
      public function HpProgressCircle()
      {
         super();
      }
      
      public function setType(param1:String) : void
      {
         this._originalState = param1;
         state = this.getCorrectState(param1);
         if(this._prevState == state)
         {
            return;
         }
         gotoAndStop(state);
         curFrame = SEMI_LAST_FRAME;
         progressCircle.gotoAndStop(SEMI_LAST_FRAME);
      }
      
      public function setIsAoI(param1:Boolean) : void
      {
         this._isAoI = param1;
         this.setType(this._originalState);
      }
      
      public function setColorBlindMode(param1:Boolean) : void
      {
         colorblindMode = param1;
         this.setType(this._originalState);
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
