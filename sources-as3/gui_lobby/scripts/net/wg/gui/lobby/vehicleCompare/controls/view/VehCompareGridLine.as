package net.wg.gui.lobby.vehicleCompare.controls.view
{
   import flash.display.Sprite;
   import net.wg.gui.lobby.vehicleCompare.interfaces.ITableGridLine;
   
   public class VehCompareGridLine extends Sprite implements ITableGridLine
   {
       
      
      public var bottomLine:Sprite = null;
      
      public var bg:Sprite = null;
      
      private var _leftPadding:int = 0;
      
      private var _rightPadding:int = 0;
      
      private var _width:int = 0;
      
      public function VehCompareGridLine()
      {
         super();
         cacheAsBitmap = true;
      }
      
      public function dispose() : void
      {
         this.bottomLine = null;
         this.bg = null;
      }
      
      public function setLeftLinePadding(param1:int) : void
      {
         if(this._leftPadding != param1)
         {
            this._leftPadding = param1;
            this.updateSize();
         }
      }
      
      public function setRightLinePadding(param1:int) : void
      {
         if(this._rightPadding != param1)
         {
            this._rightPadding = param1;
            this.updateSize();
         }
      }
      
      private function updateSize() : void
      {
         this.bg.x = this.bottomLine.x = this._leftPadding;
         this.bg.width = this.bottomLine.width = this._width - this._leftPadding - this._rightPadding;
      }
      
      override public function set width(param1:Number) : void
      {
         if(this._width != param1)
         {
            this._width = param1;
            this.updateSize();
         }
      }
   }
}
