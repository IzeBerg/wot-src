package net.wg.gui.battle.views.newbieHint.containers
{
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   
   public class HintComponentContainer extends MovieClip
   {
       
      
      public var shape:DisplayObject;
      
      protected var _width:int;
      
      protected var _height:int;
      
      protected var _offsetX:int;
      
      protected var _offsetY:int;
      
      public function HintComponentContainer()
      {
         super();
      }
      
      public function dispose() : void
      {
         this.shape = null;
      }
      
      public function setSize(param1:int, param2:int) : void
      {
         this._width = param1;
         this._height = param2;
         this.updateSize();
      }
      
      public function setOffset(param1:int, param2:int = 0) : void
      {
         this._offsetX = param1;
         this._offsetY = param2;
         this.updateOffset();
      }
      
      protected function updateSize() : void
      {
         this.content.width = this._width;
         this.content.height = this._height;
      }
      
      protected function updateOffset() : void
      {
         this.content.x = this._offsetX;
         this.content.y = this._offsetY;
      }
      
      protected function get content() : DisplayObject
      {
         return this.shape;
      }
   }
}
