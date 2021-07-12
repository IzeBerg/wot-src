package net.wg.gui.lobby.header.headerButtonBar
{
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.geom.Rectangle;
   import flash.text.TextField;
   import flash.text.TextFormat;
   import net.wg.gui.interfaces.IHeaderButtonContentItem;
   import net.wg.gui.lobby.header.LobbyHeader;
   import net.wg.gui.lobby.header.events.HeaderEvents;
   import net.wg.infrastructure.base.UIComponentEx;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.utils.Padding;
   
   public class HeaderButtonContentItem extends UIComponentEx implements IHeaderButtonContentItem
   {
      
      protected static const WIDE_SCREEN_PRC_BORDER:Number = 0.71;
      
      private static const NARROW_FONT_SIZE:int = 13;
      
      private static const WIDTH_FONT_SIZE:int = 13;
      
      public static const TEXT_FIELD_MARGIN:int = 4;
      
      public static const ARROW_MARGIN:int = 10;
      
      public static const ICON_MARGIN:int = 5;
      
      private static const MSG_MUST_BE_OVERRIDDEN:String = "Method must be overridden!";
       
      
      public var bounds:Sprite = null;
      
      private var _wideScreenPrc:Number = 0;
      
      private var _maxScreenPrc:Number = 0;
      
      private var _hideDisplayObjList:Vector.<DisplayObject> = null;
      
      private var _minScreenPadding:Padding;
      
      private var _additionalScreenPadding:Padding;
      
      private var _useFontSize:int = 13;
      
      private var _maxFontSize:int = 13;
      
      private var _narrowFontSize:int = 13;
      
      private var _needUpdateFontSize:Boolean = true;
      
      private var _data:Object = null;
      
      private var _readyToShow:Boolean = false;
      
      private var _boundsWidth:Number = 0;
      
      private var _screen:String = "narrowScreen";
      
      private var _forceInvalidSize:Boolean = false;
      
      private var _availableWidth:Number = 0;
      
      public function HeaderButtonContentItem()
      {
         this._minScreenPadding = new Padding(0,16,0,16);
         this._additionalScreenPadding = new Padding(0,10,0,10);
         super();
         this._readyToShow = false;
         this._hideDisplayObjList = new Vector.<DisplayObject>(0);
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(InvalidationType.DATA))
         {
            this.updateData();
            invalidateSize();
         }
         if(isInvalid(InvalidationType.SIZE))
         {
            this._forceInvalidSize = true;
            this.updateSize();
         }
      }
      
      override protected function onDispose() : void
      {
         this.bounds = null;
         this._data = null;
         this._hideDisplayObjList.splice(0,this._hideDisplayObjList.length);
         this._hideDisplayObjList = null;
         this._minScreenPadding = null;
         this._additionalScreenPadding = null;
         super.onDispose();
      }
      
      public function onPopoverClose() : void
      {
         DebugUtils.LOG_DEBUG(MSG_MUST_BE_OVERRIDDEN);
      }
      
      public function onPopoverOpen() : void
      {
         DebugUtils.LOG_DEBUG(MSG_MUST_BE_OVERRIDDEN);
      }
      
      public function setAvailableWidth(param1:Number) : void
      {
         this._availableWidth = param1 - this.leftPadding - this.rightPadding;
         if(this._availableWidth > 0)
         {
            this.updateData();
            this.updateSize();
         }
      }
      
      public function updateButtonBounds(param1:Rectangle) : void
      {
      }
      
      public function updateScreen(param1:String, param2:Number, param3:Number) : void
      {
         if(this._screen != param1)
         {
            this._screen = param1;
            this.updateVisibility();
            this.updateFonts();
            this._forceInvalidSize = true;
         }
         if(this._wideScreenPrc != param2 || this._maxScreenPrc != param3)
         {
            this._wideScreenPrc = param2;
            this._maxScreenPrc = param3;
            this._forceInvalidSize = true;
         }
         invalidateData();
      }
      
      protected function updateSize() : void
      {
         if(this.bounds.width != this._boundsWidth || this._forceInvalidSize)
         {
            this._forceInvalidSize = false;
            this._boundsWidth = this.bounds.width;
            dispatchEvent(new HeaderEvents(HeaderEvents.HBC_SIZE_UPDATED,this.bounds.width,this.leftPadding,this.rightPadding));
         }
      }
      
      protected function updateData() : void
      {
         if(this.data)
         {
            this.readyToShow = true;
            if(this.bounds != null)
            {
               dispatchEvent(new HeaderEvents(HeaderEvents.HBC_UPDATED,this.bounds.width));
            }
         }
      }
      
      protected function updateFontSize(param1:TextField, param2:Number) : void
      {
         var _loc3_:TextFormat = param1.getTextFormat();
         _loc3_.size = param2;
         param1.setTextFormat(_loc3_);
      }
      
      protected function isNeedUpdateFont() : Boolean
      {
         return this._needUpdateFontSize;
      }
      
      private function getFontSizeByScreen() : Number
      {
         var _loc1_:Number = this._useFontSize;
         switch(this.screen)
         {
            case LobbyHeader.NARROW_SCREEN:
               _loc1_ = this._narrowFontSize;
               break;
            case LobbyHeader.WIDE_SCREEN:
               _loc1_ = WIDTH_FONT_SIZE;
               break;
            case LobbyHeader.MAX_SCREEN:
               _loc1_ = this._maxFontSize;
         }
         return _loc1_;
      }
      
      private function updateVisibility() : Boolean
      {
         var _loc3_:DisplayObject = null;
         var _loc1_:Boolean = this._screen == LobbyHeader.MAX_SCREEN;
         var _loc2_:Boolean = this._hideDisplayObjList.length > 0 && this._hideDisplayObjList[0].visible != _loc1_;
         for each(_loc3_ in this._hideDisplayObjList)
         {
            _loc3_.visible = _loc1_;
         }
         return _loc2_;
      }
      
      private function updateFonts() : void
      {
         var _loc1_:Number = this._useFontSize;
         this._useFontSize = this.getFontSizeByScreen();
         this._needUpdateFontSize = _loc1_ != this._useFontSize;
      }
      
      public function get data() : Object
      {
         return this._data;
      }
      
      public function set data(param1:Object) : void
      {
         this._data = param1;
         this.updateVisibility();
         this.updateFonts();
         invalidateData();
      }
      
      public function get readyToShow() : Boolean
      {
         return this._readyToShow;
      }
      
      public function set readyToShow(param1:Boolean) : void
      {
         this._readyToShow = param1;
      }
      
      public function get screen() : String
      {
         return this._screen;
      }
      
      public function get availableWidth() : Number
      {
         return this._availableWidth;
      }
      
      public function set availableWidth(param1:Number) : void
      {
         this._availableWidth = param1;
      }
      
      public function get wideScreenPrc() : Number
      {
         return this._wideScreenPrc;
      }
      
      public function set wideScreenPrc(param1:Number) : void
      {
         this._wideScreenPrc = param1;
      }
      
      public function get maxScreenPrc() : Number
      {
         return this._maxScreenPrc;
      }
      
      public function set maxScreenPrc(param1:Number) : void
      {
         this._maxScreenPrc = param1;
      }
      
      public function get hideDisplayObjList() : Vector.<DisplayObject>
      {
         return this._hideDisplayObjList;
      }
      
      public function set hideDisplayObjList(param1:Vector.<DisplayObject>) : void
      {
         this._hideDisplayObjList = param1;
      }
      
      public function get minScreenPadding() : Padding
      {
         return this._minScreenPadding;
      }
      
      public function set minScreenPadding(param1:Padding) : void
      {
         this._minScreenPadding = param1;
      }
      
      public function get additionalScreenPadding() : Padding
      {
         return this._additionalScreenPadding;
      }
      
      public function set additionalScreenPadding(param1:Padding) : void
      {
         this._additionalScreenPadding = param1;
      }
      
      public function get useFontSize() : int
      {
         return this._useFontSize;
      }
      
      public function set useFontSize(param1:int) : void
      {
         this._useFontSize = param1;
      }
      
      public function get maxFontSize() : int
      {
         return this._maxFontSize;
      }
      
      public function set maxFontSize(param1:int) : void
      {
         this._maxFontSize = param1;
      }
      
      public function get needUpdateFontSize() : Boolean
      {
         return this._needUpdateFontSize;
      }
      
      public function set needUpdateFontSize(param1:Boolean) : void
      {
         this._needUpdateFontSize = param1;
      }
      
      protected function get leftPadding() : Number
      {
         return this._minScreenPadding.left + this._additionalScreenPadding.left * this._wideScreenPrc ^ 0;
      }
      
      protected function get rightPadding() : Number
      {
         return this._minScreenPadding.right + this._additionalScreenPadding.right * this._wideScreenPrc ^ 0;
      }
      
      public function get narrowFontSize() : int
      {
         return this._narrowFontSize;
      }
      
      public function set narrowFontSize(param1:int) : void
      {
         this._narrowFontSize = param1;
      }
   }
}
