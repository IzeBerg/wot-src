package net.wg.gui.bootcamp.messageWindow.containers
{
   import flash.display.Sprite;
   import net.wg.data.constants.Values;
   import net.wg.gui.bootcamp.interfaces.IAnimatedRenderer;
   
   public class AnimatedShapeContainer extends Sprite implements IAnimatedRenderer
   {
       
      
      private var _disposed:Boolean = false;
      
      public function AnimatedShapeContainer()
      {
         super();
      }
      
      public final function dispose() : void
      {
         this._disposed = true;
      }
      
      public function get contentWidth() : int
      {
         return 0;
      }
      
      public function get contentHeight() : int
      {
         return 0;
      }
      
      public function get text() : String
      {
         return Values.EMPTY_STR;
      }
      
      public function set text(param1:String) : void
      {
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
