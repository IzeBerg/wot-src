package net.wg.gui.battle.random.views.teamBasesPanel
{
   import flash.display.Sprite;
   import net.wg.gui.battle.views.vehicleMarkers.events.TimelineEvent;
   
   public class TeamCaptureProgressReset extends TeamCaptureFeel
   {
      
      private static const BITMAP_SRC:String = "CaptureBaseLine_";
      
      private static const TWEEN_COMPLETE_FRAME:int = 50;
       
      
      public var resetSplashTween:Sprite = null;
      
      private var _isAnimating:Boolean = false;
      
      public function TeamCaptureProgressReset()
      {
         super();
         stop();
         visible = false;
         addFrameScript(TWEEN_COMPLETE_FRAME,this.onTweenComplete);
         addEventListener(TimelineEvent.TWEEN_COMPLETE,this.onTweenCompleteHandler);
      }
      
      override public function onDispose() : void
      {
         stop();
         removeEventListener(TimelineEvent.TWEEN_COMPLETE,this.onTweenCompleteHandler);
         this.resetSplashTween = null;
         super.onDispose();
      }
      
      override protected function getFillTarget() : Sprite
      {
         return this.resetSplashTween;
      }
      
      override protected function getBitmapSrcPrefix() : String
      {
         return BITMAP_SRC;
      }
      
      public function show(param1:Number, param2:Number) : void
      {
         visible = true;
         if(!this._isAnimating)
         {
            gotoAndPlay(0);
         }
         this._isAnimating = true;
         x = param1;
         scaleX = param2;
      }
      
      private function onTweenComplete() : void
      {
         stop();
         dispatchEvent(new TimelineEvent(TimelineEvent.TWEEN_COMPLETE));
      }
      
      public function get isAnimating() : Boolean
      {
         return this._isAnimating;
      }
      
      private function onTweenCompleteHandler(param1:TimelineEvent) : void
      {
         this._isAnimating = false;
      }
   }
}
