package net.wg.white_tiger.gui.battle.views.wtBossWidget.components
{
   import net.wg.gui.battle.components.BattleUIComponent;
   import net.wg.gui.battle.eventBattle.views.eventTimer.EventCaptureTimer;
   
   public class Generator extends BattleUIComponent
   {
      
      private static const FRAME_LABEL_ONLINE:String = "online";
      
      private static const FRAME_LABEL_CAPTURING:String = "capture";
      
      private static const FRAME_LABEL_OFFLINE:String = "offline";
       
      
      public var eventCaptureTimer:EventCaptureTimer = null;
      
      private var _progress:Number = -1;
      
      private var _numInvaders:Number = -1;
      
      private var _totalTime:Number = -1;
      
      public function Generator()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         this.eventCaptureTimer.dispose();
         this.eventCaptureTimer = null;
         super.onDispose();
      }
      
      override protected function configUI() : void
      {
         this.setGeneratorOnline();
         super.configUI();
      }
      
      public function resetGeneratorTimer() : void
      {
         if(this.eventCaptureTimer != null)
         {
            this.eventCaptureTimer.resetTimer();
         }
         this.setGeneratorOnline();
      }
      
      public function setGeneratorCapturing() : void
      {
         if(currentFrameLabel != FRAME_LABEL_CAPTURING)
         {
            gotoAndStop(FRAME_LABEL_CAPTURING);
         }
      }
      
      public function setGeneratorOffline() : void
      {
         if(currentFrameLabel != FRAME_LABEL_OFFLINE)
         {
            gotoAndStop(FRAME_LABEL_OFFLINE);
         }
      }
      
      public function setGeneratorOnline() : void
      {
         if(currentFrameLabel != FRAME_LABEL_ONLINE)
         {
            gotoAndStop(FRAME_LABEL_ONLINE);
         }
      }
      
      public function updateCaptureTimer(param1:Number, param2:Number, param3:Number, param4:Number) : void
      {
         var _loc5_:Number = this._progress > 0 ? Number(param2 - this._progress) : Number(0);
         if(param3 != this._numInvaders)
         {
            this.resetGeneratorTimer();
            this._numInvaders = param3;
         }
         if(_loc5_ < 0)
         {
            this.resetGeneratorTimer();
         }
         if(this._totalTime == -1)
         {
            if(param2 <= 1)
            {
               this._totalTime = param1;
            }
            else
            {
               this._totalTime = param1 / (1 - param2 / 100);
            }
            this._totalTime = Math.round(this._totalTime);
         }
         this.setGeneratorCapturing();
         this.eventCaptureTimer.updateCaptureTimer(param1,this._totalTime,param4);
         this._progress = param2;
      }
   }
}
