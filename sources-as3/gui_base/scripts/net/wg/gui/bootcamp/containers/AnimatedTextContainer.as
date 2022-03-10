package net.wg.gui.bootcamp.containers
{
   import flash.display.MovieClip;
   import flash.text.TextField;
   import net.wg.gui.bootcamp.interfaces.IAnimatedRenderer;
   
   public class AnimatedTextContainer extends MovieClip implements IAnimatedRenderer
   {
       
      
      public var textField:TextField;
      
      private var _disposed:Boolean = false;
      
      public function AnimatedTextContainer()
      {
         super();
      }
      
      public final function dispose() : void
      {
         this._disposed = true;
         this.onDispose();
      }
      
      protected function onDispose() : void
      {
         this.textField = null;
      }
      
      public function get contentHeight() : int
      {
         return this.textField.textHeight;
      }
      
      public function get contentWidth() : int
      {
         return this.textField.textWidth;
      }
      
      public function get text() : String
      {
         return this.textField.text;
      }
      
      public function set text(param1:String) : void
      {
         this.textField.text = param1;
      }
      
      public function set htmlText(param1:String) : void
      {
         this.textField.htmlText = param1;
      }
      
      public function set textColor(param1:int) : void
      {
         this.textField.textColor = param1;
      }
      
      public function set autoSize(param1:String) : void
      {
         this.textField.autoSize = param1;
      }
      
      public function isDisposed() : Boolean
      {
         return this._disposed;
      }
   }
}
