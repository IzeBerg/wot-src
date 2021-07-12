package net.wg.gui.battle.views.vehicleMessages
{
   import flash.display.DisplayObject;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.geom.Point;
   import flash.text.TextField;
   import flash.text.TextFormatAlign;
   import flash.utils.getTimer;
   import net.wg.data.constants.Errors;
   import net.wg.gui.battle.views.messages.IMessage;
   import net.wg.gui.battle.views.messages.VO.FadingMessageListSettingsVO;
   import net.wg.gui.battle.views.messages.components.TextMessageRenderer;
   import net.wg.gui.battle.views.messages.events.MessageEvent;
   
   public class VehicleMessage extends EventDispatcher implements IMessage
   {
      
      private static const MAX_ALPHA:Number = 1;
      
      private static const MIN_WIDTH:int = 315;
      
      private static const REGULAR_WIDTH:int = 496;
      
      private static const MIN_STAGE_WIDTH:int = 1366;
      
      private static const TEXTFIELD_PADDING:Number = 5;
      
      private static const CLASS_NAME_STR:String = "[VehicleMessage] ";
      
      private static const EMPTY_STR:String = "";
       
      
      private var _textField:TextField;
      
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
      
      private var _textRightPadding:Number;
      
      private var _textBottomPadding:Number;
      
      private var _isEnterFrameEnable:Boolean = false;
      
      private var _useMinWidth:Boolean = false;
      
      private var _showed:Boolean = false;
      
      private var _used:Boolean = false;
      
      public function VehicleMessage(param1:FadingMessageListSettingsVO)
      {
         super();
         this._lifeTime = param1.lifeTime;
         this.fadeTime = param1.alphaSpeed;
         this._displayObjects = new Vector.<DisplayObject>(1,true);
         this._tfOffset = new Point();
         this._bgOffset = new Point();
         this._useHtml = param1.useHtml;
         this._textRightPadding = param1.textRightPadding;
         this._textBottomPadding = param1.textBottomPadding;
      }
      
      public function updateStage() : void
      {
         this.updateTextField();
      }
      
      override public function toString() : String
      {
         return CLASS_NAME_STR + (this._textField != null ? this._textField.text : EMPTY_STR);
      }
      
      public function close() : void
      {
         this.clear();
         dispatchEvent(new MessageEvent(Event.CLOSE,this));
      }
      
      public final function dispose() : void
      {
         if(this._disposed && App.instance)
         {
            App.utils.asserter.assert(false,Errors.ALREADY_DISPOSED);
         }
         this.onDispose();
         this._disposed = true;
      }
      
      public function getDisplayObjects() : Vector.<DisplayObject>
      {
         return this._displayObjects;
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
      }
      
      public function setRenderer(param1:String) : void
      {
         var _loc2_:TextMessageRenderer = App.utils.classFactory.getComponent(param1,TextMessageRenderer);
         this._textField = _loc2_.textField;
         this._tfOffset.x = this._textField.x;
         this._tfOffset.y = this._textField.y;
         this._displayObjects[0] = this._textField;
         _loc2_.dispose();
      }
      
      public function show() : void
      {
         this._used = true;
         this._showed = true;
         this._textField.alpha = MAX_ALPHA;
         if(this._lifeTime > 0)
         {
            App.utils.scheduler.scheduleTask(this.onEndLifeHandler,this._lifeTime);
         }
      }
      
      protected function onDispose() : void
      {
         this.clear();
         this._textField = null;
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
         this._used = false;
         this._showed = false;
      }
      
      private function updateTextField() : void
      {
         this._useMinWidth = App.appWidth <= MIN_STAGE_WIDTH;
         var _loc1_:Number = this._textField.width;
         if(this._useMinWidth)
         {
            this._textField.width = MIN_WIDTH;
         }
         else
         {
            this._textField.width = REGULAR_WIDTH;
         }
         this._textField.height = this._textField.textHeight + TEXTFIELD_PADDING | 0;
         switch(this._textField.defaultTextFormat.align)
         {
            case TextFormatAlign.CENTER:
            case TextFormatAlign.JUSTIFY:
               this._tfOffset.x += _loc1_ - this._textField.width >> 1;
               break;
            case TextFormatAlign.RIGHT:
               this._tfOffset.x += _loc1_ - this._textField.width;
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
      
      public function get x() : Number
      {
         return this._x;
      }
      
      public function set x(param1:Number) : void
      {
         this._x = param1;
         this._textField.x = this._x + this._tfOffset.x;
      }
      
      public function get y() : Number
      {
         return this._y;
      }
      
      public function set y(param1:Number) : void
      {
         this._y = param1;
         this._textField.y = this._y + this._tfOffset.y;
      }
      
      public function get key() : String
      {
         return this._key;
      }
      
      public function get width() : Number
      {
         return this._textField.width;
      }
      
      public function get height() : Number
      {
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
      
      public function get numLines() : int
      {
         return !!this._used ? int(this._textField.numLines) : int(1);
      }
      
      public function deleteFromPool() : void
      {
      }
      
      private function onEnterFrameHandler() : void
      {
         if(!this._isEnterFrameEnable)
         {
            return;
         }
         var _loc1_:Number = (this._endFadeTime - getTimer()) * this._inverseFadeTime;
         this._textField.alpha = _loc1_;
         if(_loc1_ <= 0)
         {
            this.close();
         }
         else
         {
            App.utils.scheduler.scheduleOnNextFrame(this.onEnterFrameHandler);
         }
      }
      
      public function get showed() : Boolean
      {
         return this._showed;
      }
      
      public function markUnused() : void
      {
         this.clear();
      }
      
      public function markUsed() : void
      {
         this._used = true;
      }
      
      public function get used() : Boolean
      {
         return this._used;
      }
   }
}
