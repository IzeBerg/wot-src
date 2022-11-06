package net.wg.gui.lobby.techtree.controls
{
   import flash.display.Sprite;
   import flash.text.TextField;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class AnimatedTextLabel extends Sprite implements IDisposable
   {
       
      
      public var labelTF:TextField = null;
      
      private var _disposed:Boolean = false;
      
      public function AnimatedTextLabel()
      {
         super();
      }
      
      public final function dispose() : void
      {
         this._disposed = true;
         this.onDispose();
      }
      
      public function isDisposed() : Boolean
      {
         return this._disposed;
      }
      
      protected function onDispose() : void
      {
         this.labelTF = null;
      }
      
      public function get text() : String
      {
         return this.labelTF.text;
      }
      
      public function set text(param1:String) : void
      {
         this.labelTF.text = param1;
      }
   }
}
