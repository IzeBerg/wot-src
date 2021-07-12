package net.wg.gui.prebattle.battleSession
{
   import flash.display.MovieClip;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import net.wg.infrastructure.base.UIComponentEx;
   import scaleform.clik.constants.InvalidationType;
   
   public class TopInfo extends UIComponentEx
   {
      
      public static const TIMER_GAP:int = 2;
       
      
      public var attackDirection:MovieClip;
      
      public var firstTeamText:TextField;
      
      public var winTeamsText:TextField;
      
      public var secondTeamText:TextField;
      
      public var startTimeText:TextField;
      
      public var startTimeValue:TextField;
      
      public function TopInfo()
      {
         super();
      }
      
      override protected function initialize() : void
      {
         super.initialize();
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
