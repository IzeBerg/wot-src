package net.wg.gui.battle.views.battleTimer
{
   import flash.display.MovieClip;
   import flash.text.TextField;
   import scaleform.gfx.TextFieldEx;
   
   public class BattleAnimationTimer extends BaseBattleTimer
   {
       
      
      public var minutesTF:TextField = null;
      
      public var secondsTF:TextField = null;
      
      public var background:MovieClip = null;
      
      public var shadow:MovieClip = null;
      
      protected var minutes:String = null;
      
      protected var seconds:String = null;
      
      private var _isCritical:Boolean = false;
      
      public function BattleAnimationTimer()
      {
         super();
         TextFieldEx.setNoTranslate(this.minutesTF,true);
         TextFieldEx.setNoTranslate(this.secondsTF,true);
      }
      
      override public function as_setColor(param1:Boolean) : void
      {
         if(this._isCritical != param1)
         {
            this.shadow.visible = !param1;
            if(param1)
            {
               this.background.play();
            }
            else
            {
               this.background.gotoAndStop(1);
            }
            this._isCritical = param1;
         }
      }
      
      override public function as_setTotalTime(param1:String, param2:String) : void
      {
         if(this.minutes != param1)
         {
            this.minutes = param1;
            this.minutesTF.text = param1;
         }
         if(this.seconds != param2)
         {
            this.seconds = param2;
            this.secondsTF.text = param2;
         }
      }
      
      override protected function onDispose() : void
      {
         this.background = null;
         this.minutesTF = null;
         this.secondsTF = null;
         this.shadow = null;
         super.onDispose();
      }
   }
}
