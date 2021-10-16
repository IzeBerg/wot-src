package net.wg.gui.battle.views.actionMarkers
{
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.TimerEvent;
   import flash.text.TextField;
   import flash.utils.Timer;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class RepliedMarkerIcon extends Sprite implements IDisposable
   {
      
      private static const DEFAULT_DELAY:int = 3000;
      
      private static const TICKS:int = 1;
      
      private static const REPLY_ANIMATION:String = "replyAnimation";
      
      private static const DEFAULT:String = "default";
       
      
      public var txtLabel:TextField = null;
      
      public var personIcon:MovieClip = null;
      
      private var _timer:Timer;
      
      public function RepliedMarkerIcon()
      {
         super();
         this._timer = new Timer(DEFAULT_DELAY,TICKS);
         this._timer.addEventListener(TimerEvent.TIMER_COMPLETE,this.onTimerCompleteHandler);
      }
      
      public function playIconAnimation() : void
      {
         this.personIcon.gotoAndPlay(REPLY_ANIMATION);
         this._timer.start();
      }
      
      public final function dispose() : void
      {
         this._timer.stop();
         this._timer.removeEventListener(TimerEvent.TIMER_COMPLETE,this.onTimerCompleteHandler);
         this._timer = null;
         this.txtLabel = null;
         this.personIcon.stop();
         this.personIcon = null;
      }
      
      private function onTimerCompleteHandler(param1:TimerEvent = null) : void
      {
         this._timer.stop();
         if(this.personIcon != null)
         {
            this.personIcon.gotoAndStop(DEFAULT);
         }
      }
   }
}
