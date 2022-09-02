package net.wg.gui.battle.views.minimap.components.entries.vehicle
{
   import flash.display.MovieClip;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class MarkerTopAnimation extends MovieClip implements IDisposable
   {
       
      
      public var anim:MovieClip = null;
      
      private var _isDisposed:Boolean = false;
      
      public function MarkerTopAnimation()
      {
         super();
      }
      
      public final function dispose() : void
      {
         App.utils.asserter.assert(!this._isDisposed,"MarkerTopAnimation is already disposed!");
         this._isDisposed = true;
         this.anim = null;
      }
      
      public function isDisposed() : Boolean
      {
         return this._isDisposed;
      }
      
      public function playAnim(param1:String) : void
      {
         gotoAndStop(param1);
         this.anim.play();
      }
   }
}
