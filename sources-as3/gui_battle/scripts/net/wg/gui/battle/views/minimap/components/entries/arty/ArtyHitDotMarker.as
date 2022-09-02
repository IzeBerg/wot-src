package net.wg.gui.battle.views.minimap.components.entries.arty
{
   import fl.motion.easing.Exponential;
   import flash.display.BlendMode;
   import flash.display.LineScaleMode;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import net.wg.data.constants.Time;
   import net.wg.gui.battle.views.minimap.MinimapEntryController;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   import scaleform.clik.motion.Tween;
   
   public class ArtyHitDotMarker extends Sprite implements IDisposable
   {
      
      private static const HIT_CIRCLE_BORDER_COLOR:uint = 16745482;
      
      private static const HIT_CIRCLE_RADIUS:uint = 14;
       
      
      public var hitPointMC:MovieClip;
      
      private var _baseDisposed:Boolean = false;
      
      private var _fadeOutTween:Tween = null;
      
      public function ArtyHitDotMarker()
      {
         super();
         this.alpha = 0;
         this.blendMode = BlendMode.ADD;
         this.graphics.lineStyle(1,HIT_CIRCLE_BORDER_COLOR,1,false,LineScaleMode.NONE);
         this.graphics.drawCircle(0,0,HIT_CIRCLE_RADIUS);
         MinimapEntryController.instance.registerNonScalableEntry(this.hitPointMC);
      }
      
      public final function dispose() : void
      {
         if(this._baseDisposed)
         {
            return;
         }
         this.onDispose();
         this._baseDisposed = true;
      }
      
      public function isDisposed() : Boolean
      {
         return this._baseDisposed;
      }
      
      public function show(param1:Number) : void
      {
         this.clearTweens();
         this.alpha = 1;
         this._fadeOutTween = new Tween(param1 * Time.MILLISECOND_IN_SECOND,this,{"alpha":0},{
            "ease":Exponential.easeIn,
            "fastTransform":false,
            "paused":false
         });
      }
      
      protected function onDispose() : void
      {
         MinimapEntryController.instance.unregisterNonScalableEntry(this.hitPointMC);
         this.clearTweens();
         this.graphics.clear();
         this.hitPointMC = null;
      }
      
      private function clearTweens() : void
      {
         if(this._fadeOutTween != null)
         {
            this._fadeOutTween.dispose();
            this._fadeOutTween = null;
         }
      }
   }
}
