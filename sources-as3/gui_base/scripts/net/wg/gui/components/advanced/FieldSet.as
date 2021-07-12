package net.wg.gui.components.advanced
{
   import flash.display.Sprite;
   import flash.geom.Rectangle;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import net.wg.infrastructure.base.UIComponentEx;
   
   public class FieldSet extends UIComponentEx
   {
       
      
      public var textField:TextField;
      
      public var bg:Sprite;
      
      public var line:Sprite;
      
      private var startScale:Object;
      
      private var _margin:Number = 8;
      
      private var _showLabel:Boolean = true;
      
      public function FieldSet()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         var _loc1_:* = null;
         this.textField = null;
         this.bg = null;
         this.line = null;
         for(_loc1_ in this.startScale)
         {
            delete this.startScale[_loc1_];
         }
         this.startScale = null;
         super.onDispose();
      }
      
      override public function toString() : String
      {
         return "[WG FieldSet " + name + "]";
      }
      
      [Inspectable(defaultValue="",verbose="1")]
      public function get label() : String
      {
         return this.textField.text;
      }
      
      public function set label(param1:String) : void
      {
         this.textField.text = param1;
         this.textField.autoSize = TextFieldAutoSize.LEFT;
         invalidate();
      }
      
      [Inspectable(defaultValue="true",verbose="1")]
      public function get showLabel() : Boolean
      {
         return this._showLabel;
      }
      
      public function set showLabel(param1:Boolean) : void
      {
         if(this._showLabel == param1)
         {
            return;
         }
         this._showLabel = param1;
         this.textField.visible = this._showLabel;
         invalidate();
      }
      
      [Inspectable(defaultValue="8",verbose="1")]
      public function get margin() : Number
      {
         return this._margin;
      }
      
      public function set margin(param1:Number) : void
      {
         if(this._margin == param1)
         {
            return;
         }
         this._margin = param1;
         invalidate();
      }
      
      override protected function preInitialize() : void
      {
         super.preInitialize();
      }
      
      override protected function initialize() : void
      {
         super.initialize();
      }
      
      override protected function configUI() : void
      {
         this.startScale = new Object();
         this.startScale.sX = this.scaleX;
         this.startScale.sY = this.scaleY;
         setActualScale(1,1);
         this.bg.scale9Grid = null;
         this.bg.scale9Grid = new Rectangle(32,12,155,176);
         this.bg.scaleX = this.startScale.sX;
         this.bg.scaleY = this.startScale.sY;
         setSize(actualWidth,actualWidth);
         _originalWidth = actualWidth;
         _originalHeight = actualHeight;
         super.configUI();
         invalidateSize();
      }
      
      override protected function draw() : void
      {
         if(this.showLabel)
         {
            this.line.x = this.textField.x + this.textField.textWidth + this.margin;
         }
         else
         {
            this.line.x = 10;
         }
         this.line.width = this.bg.width - 10 - this.line.x + 1;
      }
   }
}
