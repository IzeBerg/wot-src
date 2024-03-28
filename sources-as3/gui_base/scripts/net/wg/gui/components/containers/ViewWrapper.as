package net.wg.gui.components.containers
{
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.InteractiveObject;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.text.TextField;
   import flash.text.TextFieldType;
   import net.wg.infrastructure.events.ExternalCursorEvent;
   import scaleform.gfx.TextFieldEx;
   
   public class ViewWrapper extends BaseWrapper
   {
      
      private static var _drawDebug:Boolean = false;
      
      private static const HIT_AREA_SPRITE:String = "hitAreaSprite";
       
      
      private var _inputTF:TextField = null;
      
      private var _bitmap:Bitmap = null;
      
      private var _debugSprite:Sprite = null;
      
      private var _hitAreaTopLeft:Point;
      
      private var _hitAreaBottomRight:Point;
      
      private var _width:uint = 0;
      
      private var _height:uint = 0;
      
      private var _cursor:String = "arrow";
      
      public function ViewWrapper()
      {
         super();
         this._hitAreaTopLeft = new Point();
         this._hitAreaBottomRight = new Point();
         this.addGFBitmap();
         this.addInputTF();
         this.addHitArea();
         mouseEnabled = true;
         tabChildren = false;
         tabEnabled = true;
         App.cursor.registerExternalComponent(this,this._cursor);
      }
      
      override public function caretPosChanged(param1:Number, param2:Number) : void
      {
         var _loc3_:Number = NaN;
         App.utils.asserter.assert(contains(this._inputTF),"_inputTF must be on stage during text input");
         _loc3_ = this._inputTF.x;
         this._inputTF.x = param1 - this._inputTF.textWidth;
         this._inputTF.y = param2;
         this._inputTF.width -= this._inputTF.x - _loc3_;
      }
      
      override public function dispose() : void
      {
         App.cursor.unregisterExternalComponent(this);
         if(this._bitmap.bitmapData)
         {
            this._bitmap.bitmapData.dispose();
            this._bitmap.bitmapData = null;
         }
         this._bitmap = null;
         this._inputTF = null;
         this._hitAreaTopLeft = null;
         this._hitAreaBottomRight = null;
         this._debugSprite = null;
         removeChild(hitArea);
         hitArea = null;
         super.dispose();
      }
      
      override public function freezeUntilResize() : void
      {
         this._bitmap.cacheAsBitmap = true;
      }
      
      override public function inputEnded() : void
      {
         var _loc1_:InteractiveObject = App.utils.focusHandler.getFocus(0);
         if(_loc1_ == this._inputTF)
         {
            App.utils.focusHandler.setFocus(this);
         }
         this._inputTF.text = "";
         removeChild(this._inputTF);
      }
      
      override public function inputStarted(param1:Number, param2:Number, param3:Number, param4:Number) : void
      {
         addChild(this._inputTF);
         this._inputTF.x = param1;
         this._inputTF.y = param2;
         this._inputTF.width = param3;
         this._inputTF.height = param4;
         var _loc5_:InteractiveObject = App.utils.focusHandler.getFocus(0);
         if(_loc5_ == this)
         {
            App.utils.focusHandler.setFocus(this._inputTF);
         }
      }
      
      override public function setCursor(param1:String) : void
      {
         if(this._cursor == param1)
         {
            return;
         }
         this._cursor = param1;
         dispatchEvent(new ExternalCursorEvent(this._cursor));
      }
      
      override public function setHitAreaPaddings(param1:int, param2:int, param3:int, param4:int) : void
      {
         this._hitAreaTopLeft.x = param4;
         this._hitAreaTopLeft.y = param1;
         this._hitAreaBottomRight.x = param2;
         this._hitAreaBottomRight.y = param3;
         this.updateHitArea();
         this.updateDebugGraphics();
         dispatchEvent(new Event(Event.RESIZE));
      }
      
      override public function setScale(param1:Number) : void
      {
         scaleX = scaleY = param1;
      }
      
      override public function setSize(param1:uint, param2:uint) : void
      {
         this._width = param1;
         this._height = param2;
         if(this._bitmap.bitmapData)
         {
            this._bitmap.width = param1;
            this._bitmap.height = param2;
         }
         this.updateHitArea();
         this.updateDebugGraphics();
         dispatchEvent(new Event(Event.RESIZE));
      }
      
      override public function setTexture(param1:BitmapData) : void
      {
         var _loc2_:BitmapData = this._bitmap.bitmapData;
         this._bitmap.cacheAsBitmap = false;
         this._bitmap.bitmapData = param1;
         this._bitmap.width = this._width;
         this._bitmap.height = this._height;
         if(_loc2_)
         {
            _loc2_.dispose();
         }
      }
      
      override protected function focusChanged(param1:Boolean) : void
      {
         this.updateDebugGraphics();
      }
      
      private function updateHitArea() : void
      {
         var _loc1_:int = this._width - (this._hitAreaTopLeft.x + this._hitAreaBottomRight.x) / scaleX | 0;
         var _loc2_:int = this._height - (this._hitAreaTopLeft.y + this._hitAreaBottomRight.y) / scaleY | 0;
         var _loc3_:int = this._hitAreaTopLeft.x / scaleX | 0;
         var _loc4_:int = this._hitAreaTopLeft.y / scaleY | 0;
         _loc1_ = Math.max(_loc1_,0);
         _loc2_ = Math.max(_loc2_,0);
         _loc3_ = _loc3_ + _loc1_ > this._width ? int(0) : int(_loc3_);
         _loc4_ = _loc4_ + _loc2_ > this._height ? int(0) : int(_loc4_);
         hitArea.x = _loc3_;
         hitArea.y = _loc4_;
         hitArea.width = _loc1_;
         hitArea.height = _loc2_;
      }
      
      private function updateDebugGraphics() : void
      {
         if(!_drawDebug)
         {
            this._inputTF.alpha = 0;
            graphics.clear();
            if(this._debugSprite)
            {
               removeChild(this._debugSprite);
               this._debugSprite = null;
            }
            return;
         }
         if(this._width == 0 || this._height == 0)
         {
            return;
         }
         if(!this._debugSprite)
         {
            addChildAt(this._debugSprite = new Sprite(),getChildIndex(this._bitmap) + 1);
            this._debugSprite.mouseEnabled = false;
         }
         this._inputTF.alpha = 1;
         graphics.clear();
         graphics.beginFill(16776960,0.3);
         graphics.drawRect(0,0,this._width,this._height);
         graphics.endFill();
         this._debugSprite.graphics.clear();
         if(focused)
         {
            this._debugSprite.graphics.lineStyle(5,16777215,0.5);
            this._debugSprite.graphics.drawRect(0,0,this._width,this._height);
            this._debugSprite.graphics.endFill();
         }
         if(hitArea.width == 0 || hitArea.height == 0)
         {
            return;
         }
         graphics.beginFill(255,0.3);
         graphics.drawRect(hitArea.x,hitArea.y,hitArea.width,hitArea.height);
         graphics.endFill();
      }
      
      private function addGFBitmap() : void
      {
         addChild(this._bitmap = new Bitmap());
      }
      
      private function addInputTF() : void
      {
         this._inputTF = new TextField();
         this._inputTF.maxChars = 1;
         this._inputTF.alpha = 0;
         this._inputTF.type = TextFieldType.INPUT;
         this._inputTF.selectable = false;
         this._inputTF.borderColor = 65280;
         this._inputTF.border = true;
         TextFieldEx.setNoTranslate(this._inputTF,true);
      }
      
      private function addHitArea() : void
      {
         var _loc1_:Sprite = new Sprite();
         _loc1_.name = HIT_AREA_SPRITE;
         _loc1_.graphics.clear();
         _loc1_.graphics.beginFill(16711680,0);
         _loc1_.graphics.drawRect(0,0,1,1);
         _loc1_.graphics.endFill();
         addChild(_loc1_);
         hitArea = _loc1_;
      }
      
      override public function get hitRect() : Rectangle
      {
         return new Rectangle(hitArea.x,hitArea.y,hitArea.width * scaleX,hitArea.height * scaleY);
      }
      
      override public function get drawDebug() : Boolean
      {
         return _drawDebug;
      }
      
      override public function set drawDebug(param1:Boolean) : void
      {
         _drawDebug = param1;
         this.updateDebugGraphics();
      }
      
      override public function get width() : Number
      {
         return this._width * scaleX;
      }
      
      override public function set width(param1:Number) : void
      {
         this.setSize(param1 / scaleX,this._height);
      }
      
      override public function get height() : Number
      {
         return this._height * scaleY;
      }
      
      override public function set height(param1:Number) : void
      {
         this.setSize(this._width,param1 / scaleY);
      }
   }
}
