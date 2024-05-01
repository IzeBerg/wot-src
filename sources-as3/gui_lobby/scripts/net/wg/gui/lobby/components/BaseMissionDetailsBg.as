package net.wg.gui.lobby.components
{
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class BaseMissionDetailsBg extends Sprite implements IDisposable
   {
       
      
      public var statusBg:MovieClip;
      
      private var _disposed:Boolean = false;
      
      public function BaseMissionDetailsBg()
      {
         super();
         this.statusBg.gotoAndStop(0);
      }
      
      public final function dispose() : void
      {
         this.onDispose();
      }
      
      public function onDispose() : void
      {
         this._disposed = true;
         this.statusBg = null;
      }
      
      public function setStatus(param1:String) : void
      {
         this.statusBg.gotoAndStop(param1);
      }
      
      public function isDisposed() : Boolean
      {
         return this._disposed;
      }
   }
}
