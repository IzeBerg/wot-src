package net.wg.gui.battle.historicalBattles.consumablesPanel
{
   import fl.motion.easing.Linear;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import net.wg.gui.battle.historicalBattles.consumablesPanel.events.HBProgressBarEvent;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   import scaleform.clik.motion.Tween;
   
   public class HBProgressBar extends Sprite implements IDisposable
   {
      
      private static const TWEEN_DURATION:uint = 300;
      
      private static const FILL_MAX_WIDTH:uint = 39;
      
      private static const LIGHT_X_SHIFT:int = 1;
      
      private static const GLOW_ANIM_LABEL:String = "start";
       
      
      public var fill:MovieClip = null;
      
      public var marker:MovieClip = null;
      
      public var glow:MovieClip = null;
      
      private var _tweens:Vector.<Tween>;
      
      private var _disposed:Boolean = false;
      
      public function HBProgressBar()
      {
         this._tweens = new Vector.<Tween>();
         super();
         this.glow.addFrameScript(this.glow.totalFrames - 1,this.onGlowTweenComplete);
         this.setProgress(0);
      }
      
      public function clearTweens() : void
      {
         var _loc1_:Tween = null;
         if(this._tweens.length > 0)
         {
            for each(_loc1_ in this._tweens)
            {
               _loc1_.dispose();
               _loc1_ = null;
            }
            this._tweens.length = 0;
         }
      }
      
      public final function dispose() : void
      {
         this._disposed = true;
         this.clearTweens();
         this._tweens = null;
         this.glow.addFrameScript(this.glow.totalFrames - 1,null);
         this.glow = null;
         this.fill = null;
         this.marker = null;
      }
      
      public function isDisposed() : Boolean
      {
         return this._disposed;
      }
      
      public function setProgress(param1:Number) : void
      {
         var _loc2_:Boolean = false;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         this.clearTweens();
         if(param1 >= 1)
         {
            this.fill.visible = true;
            this.fill.width = FILL_MAX_WIDTH;
            this._tweens.push(new Tween(TWEEN_DURATION,this.marker,{"alpha":0},{
               "ease":Linear.easeIn,
               "onComplete":this.onMarkerHideTweenComplete
            }));
            this.glow.visible = true;
            this.glow.gotoAndPlay(GLOW_ANIM_LABEL);
         }
         else
         {
            _loc2_ = param1 > 0;
            this.marker.visible = this.fill.visible = _loc2_;
            if(_loc2_)
            {
               _loc3_ = FILL_MAX_WIDTH * param1;
               _loc4_ = _loc3_ + LIGHT_X_SHIFT;
               this._tweens.push(new Tween(TWEEN_DURATION,this.fill,{"width":_loc3_},{"ease":Linear.easeIn}));
               this._tweens.push(new Tween(TWEEN_DURATION,this.marker,{"x":_loc4_},{"ease":Linear.easeIn}));
            }
            else
            {
               this.marker.x = 1;
               this.fill.width = 1;
            }
         }
      }
      
      private function onMarkerHideTweenComplete() : void
      {
         this.marker.visible = false;
         this.marker.alpha = 1;
      }
      
      private function onGlowTweenComplete() : void
      {
         this.glow.visible = false;
         dispatchEvent(new Event(HBProgressBarEvent.PROGRESS_COMPLETED));
      }
   }
}
