package net.wg.gui.components.containers
{
   import flash.display.MovieClip;
   import net.wg.gui.components.interfaces.IAnimatedButtonRenderer;
   import scaleform.clik.controls.Button;
   
   public class AnimatedButtonContainer extends MovieClip implements IAnimatedButtonRenderer
   {
       
      
      public var content:Button;
      
      private var _disposed:Boolean = false;
      
      public function AnimatedButtonContainer()
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
         this.content.dispose();
         this.content = null;
      }
      
      public function get button() : Button
      {
         return this.content;
      }
      
      public function set button(param1:Button) : void
      {
         this.content = param1;
      }
      
      public function get contentWidth() : int
      {
         return this.content.width;
      }
      
      public function get contentHeight() : int
      {
         return this.content.height;
      }
      
      public function get text() : String
      {
         return this.content.label;
      }
      
      public function set text(param1:String) : void
      {
         this.content.label = param1;
      }
      
      public function set htmlText(param1:String) : void
      {
      }
      
      public function isDisposed() : Boolean
      {
         return this._disposed;
      }
      
      public function set maxLinesNumber(param1:int) : void
      {
      }
   }
}
