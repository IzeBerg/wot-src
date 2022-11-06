package net.wg.gui.battle.halloween.minimap
{
   import flash.display.MovieClip;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class HWBuffCircle extends MovieClip implements IDisposable
   {
       
      
      public var content:MovieClip = null;
      
      private var _disposed:Boolean = false;
      
      public function HWBuffCircle()
      {
         super();
         stop();
      }
      
      public function setColor(param1:String) : void
      {
         this.content.gotoAndStop(param1);
      }
      
      public final function dispose() : void
      {
         this._disposed = true;
         this.content = null;
      }
      
      public function isDisposed() : Boolean
      {
         return this._disposed;
      }
   }
}
