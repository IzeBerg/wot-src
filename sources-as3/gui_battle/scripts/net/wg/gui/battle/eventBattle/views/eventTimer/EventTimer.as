package net.wg.gui.battle.eventBattle.views.eventTimer
{
   import flash.display.MovieClip;
   import flash.text.TextField;
   import net.wg.data.constants.InvalidationType;
   import net.wg.infrastructure.base.meta.IEventTimerMeta;
   import net.wg.infrastructure.base.meta.impl.EventTimerMeta;
   
   public class EventTimer extends EventTimerMeta implements IEventTimerMeta
   {
      
      private static const STATE_VALIDATION:uint = InvalidationType.SYSTEM_FLAGS_BORDER << 1;
      
      private static const MARGIN_Y:uint = 13;
      
      private static const STATE_SMALL:String = "small";
      
      private static const STATE_BIG:String = "big";
      
      private static const HIEGHT_BIG:int = 130;
      
      private static const HIEGHT_SMALL:int = 57;
       
      
      public var timer:TimerMovie = null;
      
      public var progressBar:MovieClip = null;
      
      public var titleTF:TextField = null;
      
      private var _state:int = -1;
      
      private var _timerHeight:int = 0;
      
      public function EventTimer()
      {
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.mouseChildren = false;
         this.mouseEnabled = false;
         this.progressBar.visible = false;
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(STATE_VALIDATION))
         {
            this.progressBar.y = this._timerHeight;
            this.titleTF.y = !!this.progressBar.visible ? Number(this._timerHeight + MARGIN_Y) : Number(this.progressBar.y + MARGIN_Y);
         }
      }
      
      override protected function onDispose() : void
      {
         this.timer.dispose();
         this.timer = null;
         this.progressBar = null;
         this.titleTF = null;
         super.onDispose();
      }
      
      public function as_updateTime(param1:String) : void
      {
         this.timer.setText(param1);
      }
      
      public function as_setTimerState(param1:int) : void
      {
         if(this._state != param1)
         {
            this._state = param1;
            if(param1 == 0)
            {
               this.timer.frameLabel = STATE_SMALL;
               this._timerHeight = HIEGHT_SMALL;
            }
            else
            {
               this.timer.frameLabel = STATE_BIG;
               this._timerHeight = HIEGHT_BIG;
            }
            invalidate(STATE_VALIDATION);
         }
      }
      
      public function as_playFx() : void
      {
         this.timer.playFx();
      }
      
      public function as_updateTitle(param1:String) : void
      {
         this.titleTF.htmlText = param1;
      }
      
      public function as_updateProgressBar(param1:Number, param2:Boolean) : void
      {
         this.progressBar.visible = param2;
         if(param2)
         {
            this.progressBar.gotoAndStop(param1);
         }
         invalidate(STATE_VALIDATION);
      }
   }
}
