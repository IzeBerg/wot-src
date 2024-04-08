package net.wg.gui.components.containers
{
   import flash.display.Sprite;
   import net.wg.data.constants.Values;
   import net.wg.gui.components.interfaces.IAnimatedRenderer;
   
   public class AnimatedEmptyContainer extends Sprite implements IAnimatedRenderer
   {
       
      
      private var _disposed:Boolean;
      
      public function AnimatedEmptyContainer()
      {
         super();
      }
      
      public final function dispose() : void
      {
         this._disposed = true;
      }
      
      public function get contentWidth() : int
      {
         return Values.ZERO;
      }
      
      public function get contentHeight() : int
      {
         return Values.ZERO;
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
