package net.wg.gui.battle.views.destroyTimers.components.secondaryTimerFx
{
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class StunTimerFX implements IDisposable, ISecondaryTimerFX
   {
       
      
      private var _fxContainer:SecondaryTimerFXContainer;
      
      private var _disposed:Boolean = false;
      
      public function StunTimerFX()
      {
         super();
      }
      
      public function setFxContainer(param1:SecondaryTimerFXContainer) : void
      {
         this._fxContainer = param1;
      }
      
      public function dispose() : void
      {
         this._disposed = true;
         this._fxContainer = null;
      }
      
      public function show(param1:Boolean) : void
      {
         var _loc2_:String = !!param1 ? SecondaryTimerFXContainer.FX_MULTIPLE_HIT : SecondaryTimerFXContainer.FX_EXPLOSION;
         this._fxContainer.showFx(_loc2_);
      }
      
      public function hide() : void
      {
         this._fxContainer.hideAll();
      }
      
      public function isDisposed() : Boolean
      {
         return this._disposed;
      }
   }
}
