package net.wg.gui.prebattle.battleSession
{
   import flash.display.MovieClip;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import net.wg.data.constants.Values;
   import net.wg.infrastructure.base.UIComponentEx;
   import scaleform.clik.constants.InvalidationType;
   
   public class TopInfo extends UIComponentEx
   {
      
      public static const TIMER_GAP:int = 2;
      
      private static const UNIT_INFO_X_GAP_FIRST:int = -2;
      
      private static const UNIT_INFO_X_GAP_SECOND:uint = 3;
      
      private static const CHAR_COMMA:String = ", ";
       
      
      public var attackDirection:MovieClip;
      
      public var firstTeamText:TextField;
      
      public var winTeamsText:TextField;
      
      public var secondTeamText:TextField;
      
      public var startTimeText:TextField;
      
      public var startTimeValue:TextField;
      
      public var unitInfo:BSUnitInfo;
      
      private var _initialFirstTeamTextX:int = 0;
      
      public function TopInfo()
      {
         super();
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         this._initialFirstTeamTextX = this.firstTeamText.x;
         this.startTimeText.autoSize = this.startTimeValue.autoSize = TextFieldAutoSize.LEFT;
      }
      
      override protected function onDispose() : void
      {
         this.attackDirection = null;
         this.firstTeamText = null;
         this.winTeamsText = null;
         this.secondTeamText = null;
         this.startTimeText = null;
         this.startTimeValue = null;
         this.unitInfo.dispose();
         this.unitInfo = null;
         super.onDispose();
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(InvalidationType.LAYOUT))
         {
            this.updateTimerPosition();
         }
      }
      
      public function updateUnitInfoData(param1:int, param2:int, param3:uint) : void
      {
         var _loc5_:String = null;
         var _loc4_:Boolean = param1 > Values.DEFAULT_INT && param2 > Values.ZERO && param3 > Values.ZERO;
         if(_loc4_)
         {
            this.unitInfo.updateData(param1,param2);
            _loc5_ = CHAR_COMMA + App.utils.locale.makeString(PREBATTLE.TITLE_BATTLESESSION_UNIT);
            if(param3 == 1)
            {
               this.firstTeamText.appendText(_loc5_);
               this.firstTeamText.x = this._initialFirstTeamTextX - this.unitInfo.width >> 0;
               this.unitInfo.x = this.firstTeamText.x + this.firstTeamText.width + UNIT_INFO_X_GAP_FIRST >> 0;
            }
            else
            {
               this.secondTeamText.appendText(_loc5_);
               this.firstTeamText.x = this._initialFirstTeamTextX;
               this.unitInfo.x = this.secondTeamText.x + this.secondTeamText.textWidth + UNIT_INFO_X_GAP_SECOND >> 0;
            }
         }
         this.unitInfo.visible = _loc4_;
      }
      
      protected function updateTimerPosition() : void
      {
         var _loc1_:int = this.startTimeText.width + this.startTimeValue.width + TIMER_GAP >> 1;
         this.startTimeText.x = -_loc1_;
         this.startTimeValue.x = this.startTimeText.x + this.startTimeText.width + TIMER_GAP | 0;
      }
      
      public function set winnerIfDraw(param1:int) : void
      {
         this.attackDirection.gotoAndStop(param1 + 1);
      }
   }
}
