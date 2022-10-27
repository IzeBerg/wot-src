package net.wg.gui.battle.views.staticMarkers.halloween
{
   import flash.display.MovieClip;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class HWBuffActionLine extends MovieClip implements IDisposable
   {
      
      private static const SPAWNED_FRAME:int = 2;
      
      private static const SPAWN_FRAME:int = 1;
       
      
      public var content:MovieClip = null;
      
      private var _disposed:Boolean = false;
      
      public function HWBuffActionLine()
      {
         super();
      }
      
      public function setIsSpawned(param1:Boolean) : void
      {
         this.content.gotoAndStop(!!param1 ? SPAWNED_FRAME : SPAWN_FRAME);
      }
      
      public function isDisposed() : Boolean
      {
         return this._disposed;
      }
      
      public function dispose() : void
      {
         this._disposed = true;
         this.content = null;
      }
   }
}
