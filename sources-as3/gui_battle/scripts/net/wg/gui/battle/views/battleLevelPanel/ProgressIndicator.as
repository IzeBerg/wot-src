package net.wg.gui.battle.views.battleLevelPanel
{
   import flash.display.MovieClip;
   import net.wg.data.constants.Values;
   import scaleform.clik.controls.StatusIndicator;
   
   public class ProgressIndicator extends StatusIndicator
   {
      
      private static const TRACK_WIDTH_MIN:uint = 1;
       
      
      public var track:MovieClip = null;
      
      public var bg:MovieClip = null;
      
      public function ProgressIndicator()
      {
         super();
      }
      
      override public function invalidateSize() : void
      {
         super.invalidateSize();
         invalidateData();
      }
      
      override public function setActualSize(param1:Number, param2:Number) : void
      {
         super.setActualSize(param1,param2);
         this.bg.width = _width;
         this.bg.height = _height;
         scaleX = scaleY = 1;
      }
      
      override protected function updatePosition() : void
      {
         if(!enabled)
         {
            return;
         }
         this.track.width = this.calculateTrackWidth(_value);
         this.track.visible = value > 0;
      }
      
      public function calculateTrackWidthDelta(param1:Number) : int
      {
         var _loc2_:int = this.calculateTrackWidth(param1) - this.trackWidth;
         return Math.max(_loc2_,Values.ZERO);
      }
      
      private function calculateTrackWidth(param1:Number) : int
      {
         var _loc2_:Number = (param1 - _minimum) / (_maximum - _minimum);
         var _loc3_:int = Math.max(TRACK_WIDTH_MIN,Math.round(_loc2_ * this.bg.width));
         if(_loc3_ > this.bg.width)
         {
            _loc3_ = this.bg.width;
         }
         return _loc3_;
      }
      
      public function get trackWidth() : int
      {
         return !!this.track.visible ? int(this.track.width) : int(Values.ZERO);
      }
   }
}
