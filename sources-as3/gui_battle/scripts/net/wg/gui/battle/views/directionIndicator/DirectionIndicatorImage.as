package net.wg.gui.battle.views.directionIndicator
{
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class DirectionIndicatorImage extends Sprite implements IDisposable
   {
       
      
      public var green:DisplayObject;
      
      public var red:DisplayObject;
      
      public var purple:DisplayObject;
      
      public var yellow:DisplayObject;
      
      private var _disposed:Boolean = false;
      
      public function DirectionIndicatorImage()
      {
         super();
         this.green.visible = false;
         this.red.visible = false;
         this.purple.visible = false;
         this.yellow.visible = false;
      }
      
      public final function dispose() : void
      {
         this._disposed = true;
         this.green = null;
         this.red = null;
         this.purple = null;
      }
      
      public function setShape(param1:String) : void
      {
         this.green.visible = param1 == DirectionIndicatorShape.SHAPE_GREEN;
         this.red.visible = param1 == DirectionIndicatorShape.SHAPE_RED;
         this.purple.visible = param1 == DirectionIndicatorShape.SHAPE_PURPLE;
         this.yellow.visible = param1 == DirectionIndicatorShape.SHAPE_YELLOW;
      }
      
      public function setArrowPositionY(param1:int) : void
      {
         this.green.y = this.red.y = this.purple.y = param1;
         this.yellow = null;
      }
      
      public function isDisposed() : Boolean
      {
         return this._disposed;
      }
   }
}
