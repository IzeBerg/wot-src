package net.wg.gui.battle.battleRoyale.views.components
{
   import flash.display.MovieClip;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class BattleRoyaleIconContent extends MovieClip implements IDisposable
   {
       
      
      public var animation:MovieClip = null;
      
      private var _disposed:Boolean = false;
      
      public function BattleRoyaleIconContent()
      {
         super();
      }
      
      public final function dispose() : void
      {
         this.animation.stop();
         this.animation = null;
         this.onDispose();
      }
      
      protected function onDispose() : void
      {
         this._disposed = true;
      }
      
      public function isDisposed() : Boolean
      {
         return this._disposed;
      }
   }
}
