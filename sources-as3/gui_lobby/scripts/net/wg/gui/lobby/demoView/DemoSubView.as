package net.wg.gui.lobby.demoView
{
   import flash.display.Sprite;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class DemoSubView extends Sprite implements IDisposable
   {
      
      private static const BORDER:int = 10;
      
      private static const COUNTER_HEIGHT:int = 25;
       
      
      public var button0:DemoButton = null;
      
      public var button1:DemoButton = null;
      
      public var button2:DemoButton = null;
      
      public var button3:DemoButton = null;
      
      private var _width:int = 0;
      
      private var _height:int = 0;
      
      private var _color:uint = 0;
      
      public function DemoSubView()
      {
         super();
         this.button0.setColor(16689834);
         this.button1.setColor(14013435);
         this.button2.setColor(11206570);
         this.button3.setColor(16777129);
         this.button0.height = 25;
         this.button1.height = 25;
      }
      
      public function dispose() : void
      {
         this.button0.dispose();
         this.button0 = null;
         this.button1.dispose();
         this.button1 = null;
         this.button2.dispose();
         this.button2 = null;
         this.button3.dispose();
         this.button3 = null;
      }
      
      public function layout() : void
      {
         graphics.clear();
         graphics.beginFill(this._color);
         graphics.drawRect(0,0,this._width,this._height);
         graphics.endFill();
         var _loc1_:int = this._width - (BORDER << 1);
         this.button0.width = _loc1_;
         this.button1.width = _loc1_;
         this.button2.width = _loc1_;
         this.button3.width = _loc1_;
         var _loc2_:int = this._height - (BORDER << 1) - (COUNTER_HEIGHT << 1) >> 1;
         this.button2.height = _loc2_;
         this.button3.height = _loc2_;
         this.button0.layout();
         this.button1.layout();
         this.button2.layout();
         this.button3.layout();
         this.button3.y = this.button2.y + this.button2.height;
      }
      
      public function setColor(param1:uint) : void
      {
         this._color = param1;
      }
      
      override public function set width(param1:Number) : void
      {
         this._width = param1;
      }
      
      override public function set height(param1:Number) : void
      {
         this._height = param1;
      }
   }
}
