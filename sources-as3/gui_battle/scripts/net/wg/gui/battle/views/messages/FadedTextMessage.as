package net.wg.gui.battle.views.messages
{
   import flash.display.DisplayObject;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.geom.Point;
   import flash.text.TextField;
   import flash.text.TextFormatAlign;
   import flash.utils.getQualifiedClassName;
   import flash.utils.getTimer;
   import net.wg.gui.battle.views.messages.VO.FadingMessageListSettingsVO;
   import net.wg.gui.battle.views.messages.components.TextMessageRenderer;
   import net.wg.gui.battle.views.messages.events.MessageEvent;
   
   public class FadedTextMessage extends EventDispatcher implements IMessage
   {
       
      
      private var _displayObjects:Vector.<DisplayObject>;
      
      private var _endFadeTime:int;
      
      private var _tfOffset:Point;
      
      private var _bgOffset:Point;
      
      private var _disposed:Boolean = false;
      
      private var _x:Number;
      
      private var _y:Number;
      
      private var _lifeTime:int;
      
      private var _fadeTime:int;
      
      private var _inverseFadeTime:Number;
      
      private var _key:String;
      
      private var _useHtml:Boolean = false;
      
      private var _textField:TextField;
      
      private var _backround:DisplayObject;
      
      private var _textRightPadding:Number;
      
      private var _textBottomPadding:Number;
      
      private var _pool:FadedMessagesPool;
      
      private var _isEnterFrameEnable:Boolean = false;
      
      public function FadedTextMessage(param1:FadedMessagesPool, param2:FadingMessageListSettingsVO)
      {
         super();
         this._pool = param1;
         this._lifeTime = param2.lifeTime;
         this.fadeTime = param2.alphaSpeed;
         this._displayObjects = new Vector.<DisplayObject>(2,true);
         this._tfOffset = new Point();
         this._bgOffset = new Point();
         this._useHtml = param2.useHtml;
         this._textRightPadding = param2.textRightPadding;
         this._textBottomPadding = param2.textBottomPadding;
      }
      
      override public function toString() : String
      {
         return "[FadedTextMessage] " + (this._textField != null ? this._textField.text : "");
      }
      
      public function close() : void
      {
         this.clear();
         dispatchEvent(new MessageEvent(Event.CLOSE,this));
      }
      
      public function deleteFromPool() : void
      {
         this._pool.deleteItem(this);
      }
      
      public final function dispose() : void
      {
         if(this._disposed && App.instance)
         {
            App.utils.asserter.assert(false,"(" + getQualifiedClassName(this) + ") already disposed!");
         }
         this.onDispose();
         this._disposed = true;
      }
      
      public function getDisplayObjects() : Vector.<DisplayObject>
      {
         return this._displayObjects;
      }
      
      public function getExtendedInfo() : String
      {
         var _loc1_:Number = this._textField != null ? Number(this._textField.alpha) : Number(-1);
         var _loc2_:Number = this._backround != null ? Number(this._backround.alpha) : Number(-1);
         var _loc3_:String = this._textField != null ? this._textField.text : "";
         return App.utils.JSON.encode({
            "_endFadeTime":this._endFadeTime,
            "_disposed":this._disposed,
            "_lifeTime":this._lifeTime,
            "_fadeTime":this._fadeTime,
            "_inverseFadeTime":this._inverseFadeTime,
            "_isEnterFrameEnable":this._isEnterFrameEnable,
            "tfAlpha":_loc1_,
            "bgAlpha":_loc2_,
            "tfTextx":_loc3_
         });
      }
      
      public function setData(param1:String, param2:String, param3:Boolean = false, param4:uint = 0) : void
      {
         this._key = param1;
         if(param3 && this._textField.textColor != param4)
         {
            this._textField.textColor = param4;
         }
         if(this._useHtml)
         {
            this._textField.htmlText = param2;
         }
         else
         {
            this._textField.text = param2;
         }
         this.updateTextField();
         if(this._backround != null)
         {
            this._backround.width = this._textField.textWidth + this._textRightPadding;
            this._backround.height = this._textField.height + this._textBottomPadding;
         }
      }
      
      public function setRenderer(param1:String) : void
      {
         var _loc2_:TextMessageRenderer = App.utils.classFactory.getComponent(param1,TextMessageRenderer);
         var _loc3_:int = 0;
         if(_loc2_.background != null)
         {
            this._backround = _loc2_.background;
            this._bgOffset.x = this._backround.x;
            this._bgOffset.y = this._backround.y;
            var _loc4_:* = _loc3_++;
            this._displayObjects[_loc4_] = this._backround;
         }
         this._textField = _loc2_.textField;
         this._tfOffset.x = this._textField.x;
         this._tfOffset.y = this._textField.y;
         this._displayObjects[_loc3_] = this._textField;
         _loc2_.dispose();
      }
      
      public function show() : void
      {
         if(this._backround != null)
         {
            this._backround.alpha = 1;
         }
         this._textField.alpha = 1;
         if(this._lifeTime > 0)
         {
            App.utils.scheduler.scheduleTask(this.onEndLifeHandler,this._lifeTime);
         }
      }
      
      protected function onDispose() : void
      {
         this.clear();
         this._pool = null;
         this._textField = null;
         this._backround = null;
         this._tfOffset = null;
         this._bgOffset = null;
         this._displayObjects.fixed = false;
         this._displayObjects.splice(0,this._displayObjects.length);
         this._displayObjects = null;
      }
      
      private function clear() : void
      {
         App.utils.scheduler.cancelTask(this.onEndLifeHandler);
         this._isEnterFrameEnable = false;
      }
      
      private function updateTextField() : void
      {
         var _loc1_:Number = this._textField.width;
         App.utils.commons.updateTextFieldSize(this._textField,true,false);
         switch(this._textField.defaultTextFormat.align)
         {
            case TextFormatAlign.CENTER:
            case TextFormatAlign.JUSTIFY:
               this._tfOffset.x += _loc1_ - this._textField.width >> 1;
               break;
            case TextFormatAlign.RIGHT:
               this._tfOffset.x += _loc1_ - this._textField.width;
               break;
            case TextFormatAlign.LEFT:
         }
      }
      
      private function onEndLifeHandler() : void
      {
         if(this._fadeTime > 0)
         {
            this._endFadeTime = getTimer() + this._fadeTime;
            this._isEnterFrameEnable = true;
            App.utils.scheduler.scheduleOnNextFrame(this.onEnterFrameHandler);
         }
         else
         {
            this.close();
         }
      }
      
      private function onEnterFrameHandler() : void
      {
         if(!this._isEnterFrameEnable)
         {
            return;
         }
         var _loc1_:int = getTimer();
         var _loc2_:Number = (this._endFadeTime - _loc1_) * this._inverseFadeTime;
         this._textField.alpha = _loc2_;
         if(this._backround != null)
         {
            this._backround.alpha = _loc2_;
         }
         if(_loc2_ <= 0)
         {
            this.close();
         }
         else
         {
            App.utils.scheduler.scheduleOnNextFrame(this.onEnterFrameHandler);
         }
      }
      
      public function get x() : Number
      {
         return this._x;
      }
      
      public function set x(param1:Number) : void
      {
         this._x = param1;
         this._textField.x = this._x + this._tfOffset.x;
         if(this._backround != null)
         {
            this._backround.x = this._x + this._bgOffset.x;
         }
      }
      
      public function get y() : Number
      {
         return this._y;
      }
      
      public function set y(param1:Number) : void
      {
         this._y = param1;
         this._textField.y = this._y + this._tfOffset.y;
         if(this._backround != null)
         {
            this._backround.y = this._y + this._bgOffset.y;
         }
      }
      
      public function get key() : String
      {
         return this._key;
      }
      
      public function get width() : Number
      {
         if(this._backround != null)
         {
            return this._backround.width;
         }
         return this._textField.width;
      }
      
      public function get height() : Number
      {
         if(this._backround != null)
         {
            return this._backround.height;
         }
         return this._textField.height;
      }
      
      public function set lifeTime(param1:int) : void
      {
         this._lifeTime = param1;
      }
      
      public function set fadeTime(param1:int) : void
      {
         this._fadeTime = param1;
         this._inverseFadeTime = 1 / this._fadeTime;
      }
      
      public function set useHtml(param1:Boolean) : void
      {
         this._useHtml = param1;
      }
      
      public function set textRightPadding(param1:Number) : void
      {
         this._textRightPadding = param1;
      }
      
      public function set textBottomPadding(param1:Number) : void
      {
         this._textBottomPadding = param1;
      }
   }
}
