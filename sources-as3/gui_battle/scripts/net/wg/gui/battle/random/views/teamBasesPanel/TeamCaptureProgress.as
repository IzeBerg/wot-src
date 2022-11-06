package net.wg.gui.battle.random.views.teamBasesPanel
{
   import flash.display.Sprite;
   
   public class TeamCaptureProgress extends TeamCaptureFeel
   {
      
      private static const DEF_SCALE:Number = 0.01;
       
      
      public var barColor:Sprite = null;
      
      private var _isAnimating:Boolean = true;
      
      public function TeamCaptureProgress()
      {
         super();
         this.animate(false);
         this.scaleX = DEF_SCALE;
      }
      
      override public function onDispose() : void
      {
         stop();
         this.barColor = null;
         super.onDispose();
      }
      
      override protected function getFillTarget() : Sprite
      {
         return this.barColor;
      }
      
      override protected function getBitmapSrcPrefix() : String
      {
         return TeamCaptureFeel.BITMAP_SRC_CAPTURE_LINE;
      }
      
      public function animate(param1:Boolean) : void
      {
         if(this._isAnimating == param1)
         {
            return;
         }
         this._isAnimating = param1;
         if(this._isAnimating)
         {
            play();
         }
         else
         {
            gotoAndStop(1);
         }
      }
   }
}
