package net.wg.gui.lobby.demoView
{
   import flash.display.Sprite;
   import flash.text.TextField;
   import flash.text.TextFieldType;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class DemoButton extends Sprite implements IDisposable
   {
      
      private static const BORDER_OFFSET:int = 4;
       
      
      public var textField:TextField = null;
      
      private var _width:Number = 0;
      
      private var _height:Number = 0;
      
      private var _color:uint = 0;
      
      public function DemoButton()
      {
         super();
         this.textField.type = TextFieldType.INPUT;
      }
      
      public function dispose() : void
      {
         this.textField = null;
      }
      
      public function layout() : void
      {
         this.updateBG();
         this.textField.width = this._width - BORDER_OFFSET;
         this.textField.height = this._height - BORDER_OFFSET;
      }
      
      public function setColor(param1:uint) : void
      {
         this._color = param1;
      }
      
      public function setText(param1:String) : void
      {
         this.textField.htmlText = param1;
      }
      
      private function updateBG() : void
      {
         graphics.clear();
         graphics.beginFill(this._color);
         graphics.drawRect(0,0,this._width,this._height);
         graphics.endFill();
      }
      
      override public function set height(param1:Number) : void
      {
         this._height = param1;
      }
      
      override public function set width(param1:Number) : void
      {
         this._width = param1;
      }
   }
}
