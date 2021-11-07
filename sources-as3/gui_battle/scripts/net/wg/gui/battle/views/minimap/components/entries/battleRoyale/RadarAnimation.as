package net.wg.gui.battle.views.minimap.components.entries.battleRoyale
{
   import flash.display.Graphics;
   import flash.display.Sprite;
   
   public class RadarAnimation extends AnimatedItemWithFinishCallback
   {
      
      private static const LINE_COLOR:uint = 11075328;
      
      private static const LINE_ALPHA:Number = 0.3;
      
      private static const FILL_COLOR:uint = 6736896;
      
      private static const FILL_ALPHA:Number = 0.25;
      
      private static const KOEF_METER_TO_PX:Number = 0.06;
       
      
      public var circle0:Sprite = null;
      
      public var circle1:Sprite = null;
      
      public var circle2:Sprite = null;
      
      private var _radius:int = 0;
      
      public function RadarAnimation()
      {
         super();
      }
      
      private static function drawCircle(param1:Sprite, param2:int) : void
      {
         var _loc3_:Graphics = param1.graphics;
         _loc3_.clear();
         _loc3_.lineStyle(1,LINE_COLOR,LINE_ALPHA);
         _loc3_.beginFill(FILL_COLOR,FILL_ALPHA);
         _loc3_.drawCircle(0,0,param2 * KOEF_METER_TO_PX);
         _loc3_.endFill();
      }
      
      override public function dispose() : void
      {
         super.dispose();
         this.circle0 = null;
         this.circle1 = null;
         this.circle2 = null;
      }
      
      override public function play() : void
      {
         super.play();
         gotoAndPlay(1);
      }
      
      public function updateRadarRadius(param1:int) : void
      {
         if(this._radius != param1)
         {
            this._radius = param1;
            drawCircle(this.circle0,param1);
            drawCircle(this.circle1,param1);
            drawCircle(this.circle2,param1);
         }
         else
         {
            DebugUtils.LOG_ERROR("Redundant call \'updateRadarRadius\' with value = ",param1);
         }
      }
   }
}
