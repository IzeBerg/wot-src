package net.wg.gui.battle.views.destroyTimers.components.secondaryTimerFx
{
   import flash.display.MovieClip;
   import flash.utils.Dictionary;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class SecondaryTimerFXContainer extends MovieClip implements IDisposable
   {
      
      public static const FX_MULTIPLE_HIT:String = "fxMultipleHit";
      
      public static const FX_EXPLOSION:String = "fxExplosion";
      
      private static const LABEL_SHOW:String = "show";
       
      
      public var multipleHitFX:MovieClip;
      
      public var explosionFX:MovieClip;
      
      private var _fxMap:Dictionary;
      
      private var _disposed:Boolean = false;
      
      public function SecondaryTimerFXContainer()
      {
         super();
         this.mapFxAnimations();
      }
      
      private function mapFxAnimations() : void
      {
         this._fxMap = new Dictionary();
         this._fxMap[FX_EXPLOSION] = this.explosionFX;
         this._fxMap[FX_MULTIPLE_HIT] = this.multipleHitFX;
      }
      
      public function dispose() : void
      {
         this._disposed = true;
         App.utils.data.cleanupDynamicObject(this._fxMap);
         this._fxMap = null;
      }
      
      public function showFx(param1:String) : void
      {
         this.hideAll();
         var _loc2_:MovieClip = this._fxMap[param1];
         _loc2_.gotoAndPlay(LABEL_SHOW);
      }
      
      public function hideAll() : void
      {
         var _loc1_:* = null;
         var _loc2_:MovieClip = null;
         for(_loc1_ in this._fxMap)
         {
            _loc2_ = this._fxMap[_loc1_];
            _loc2_.gotoAndStop(1);
         }
      }
      
      public function isDisposed() : Boolean
      {
         return this._disposed;
      }
   }
}
