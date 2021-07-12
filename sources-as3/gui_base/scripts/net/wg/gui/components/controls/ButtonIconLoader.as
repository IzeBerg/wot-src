package net.wg.gui.components.controls
{
   import flash.display.DisplayObject;
   import flash.display.Loader;
   import flash.display.LoaderInfo;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.IOErrorEvent;
   import flash.net.URLRequest;
   import net.wg.data.constants.SoundTypes;
   import net.wg.gui.interfaces.IButtonIconLoader;
   import net.wg.infrastructure.events.IconLoaderEvent;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.core.UIComponent;
   
   [Event(name="iconLoadingFailed",type="net.wg.infrastructure.events.IconLoaderEvent")]
   [Event(name="iconLoaded",type="net.wg.infrastructure.events.IconLoaderEvent")]
   public class ButtonIconLoader extends SoundButtonEx implements IButtonIconLoader
   {
       
      
      public var container:Sprite;
      
      public var states:MovieClip;
      
      protected var _iconOffsetTop:Number = 0;
      
      protected var _iconOffsetLeft:Number = 0;
      
      protected var loader:Loader;
      
      protected var _iconSource:String;
      
      private const ICON_SOURCE_INVALID:String = "iconSrcInv";
      
      private var LAYOUT_INVALID:String = "layoutInv";
      
      private var ICON_LOADED_INVALID:String = "iconLoadInv";
      
      private var iconWasLoaded:Boolean = false;
      
      private var newScaleX:Number = 1;
      
      private var newScaleY:Number = 1;
      
      public function ButtonIconLoader()
      {
         super();
         soundType = SoundTypes.ICON_BTN;
         this.container.visible = false;
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         if(this.states)
         {
            _labelHash = UIComponent.generateLabelHash(this.states);
         }
      }
      
      private function initItems() : void
      {
         var _loc3_:DisplayObject = null;
         this.newScaleX = this.scaleX;
         this.newScaleY = this.scaleY;
         var _loc1_:Number = this.numChildren;
         this.setActualScale(1,1);
         var _loc2_:Number = 0;
         while(_loc2_ < _loc1_)
         {
            _loc3_ = this.getChildAt(_loc2_);
            if(_loc3_ != this.container)
            {
               _loc3_.scaleX = this.newScaleX;
               _loc3_.scaleY = this.newScaleY;
            }
            _loc2_++;
         }
      }
      
      override protected function onDispose() : void
      {
         if(this.loader)
         {
            this.removeIconListeners(this.loader.contentLoaderInfo);
            this.loader.unloadAndStop();
            this.loader.unload();
            this.container.removeChild(this.loader);
            this.loader = null;
         }
         super.onDispose();
      }
      
      override public function set enabled(param1:Boolean) : void
      {
         super.enabled = param1;
      }
      
      public function get iconSource() : String
      {
         return this._iconSource;
      }
      
      public function set iconSource(param1:String) : void
      {
         if(this._iconSource != param1)
         {
            this._iconSource = param1;
            invalidate(this.ICON_SOURCE_INVALID);
         }
      }
      
      public function get iconOffsetTop() : Number
      {
         return this._iconOffsetTop;
      }
      
      public function set iconOffsetTop(param1:Number) : void
      {
         this._iconOffsetTop = param1;
         invalidate(this.LAYOUT_INVALID);
      }
      
      public function get iconOffsetLeft() : Number
      {
         return this._iconOffsetLeft;
      }
      
      public function set iconOffsetLeft(param1:Number) : void
      {
         this._iconOffsetLeft = param1;
         invalidate(this.LAYOUT_INVALID);
      }
      
      override public function gotoAndPlay(param1:Object, param2:String = null) : void
      {
         if(this.states)
         {
            this.states.gotoAndPlay(param1,param2);
         }
         else
         {
            super.gotoAndPlay(param1,param2);
         }
      }
      
      override public function gotoAndStop(param1:Object, param2:String = null) : void
      {
         if(this.states)
         {
            this.states.gotoAndStop(param1,param2);
         }
         else
         {
            super.gotoAndStop(param1,param2);
         }
      }
      
      override protected function configUI() : void
      {
         if(this.states)
         {
            constraintsDisabled = true;
            preventAutosizing = true;
            this.initItems();
         }
         super.configUI();
      }
      
      override protected function draw() : void
      {
         var _loc1_:URLRequest = null;
         super.draw();
         if(isInvalid(this.ICON_SOURCE_INVALID))
         {
            if(this.loader)
            {
               this.loader.unload();
               this.removeIconListeners(this.loader.contentLoaderInfo);
               this.container.removeChild(this.loader);
               this.loader = null;
            }
            if(this._iconSource != null && this._iconSource != "")
            {
               _loc1_ = new URLRequest(this._iconSource);
               this.loader = new Loader();
               this.addIconListeners(this.loader.contentLoaderInfo);
               this.iconWasLoaded = false;
               this.container.visible = false;
               this.loader.load(_loc1_);
               this.container.addChild(this.loader);
            }
         }
         if(isInvalid(InvalidationType.SIZE) || isInvalid(this.LAYOUT_INVALID))
         {
            this.configIcon();
         }
         if(isInvalid(this.ICON_LOADED_INVALID) && this.iconWasLoaded)
         {
            this.container.visible = true;
         }
      }
      
      protected function addIconListeners(param1:LoaderInfo) : void
      {
         param1.addEventListener(Event.COMPLETE,this.iconLoadingCompleteHandler);
         param1.addEventListener(IOErrorEvent.IO_ERROR,this.iconLoadingIOErrorHandler);
      }
      
      protected function configIcon() : void
      {
         var _loc1_:Number = NaN;
         var _loc2_:Number = NaN;
         var _loc3_:Number = NaN;
         var _loc4_:Number = NaN;
         if(this.container && this.loader)
         {
            _loc1_ = 0;
            _loc2_ = 0;
            _loc3_ = 1;
            _loc4_ = 1;
            if(!this.states)
            {
               _loc3_ = 1 / this.scaleX;
               _loc4_ = 1 / this.scaleY;
            }
            _loc1_ = Math.floor(((this.width - this.loader.width) / 2 + this._iconOffsetLeft) * _loc3_);
            _loc2_ = Math.floor(((this.height - this.loader.height) / 2 + this._iconOffsetTop) * _loc4_);
            this.container.x = _loc1_;
            this.container.y = _loc2_;
            this.container.scaleX = _loc3_;
            this.container.scaleY = _loc4_;
         }
      }
      
      override public function get width() : Number
      {
         return Boolean(this.states) ? Number(super.width * this.newScaleX) : Number(super.width);
      }
      
      override public function get height() : Number
      {
         return Boolean(this.states) ? Number(super.height * this.newScaleY) : Number(super.height);
      }
      
      private function removeIconListeners(param1:LoaderInfo) : void
      {
         param1.removeEventListener(Event.COMPLETE,this.iconLoadingCompleteHandler);
         param1.removeEventListener(IOErrorEvent.IO_ERROR,this.iconLoadingIOErrorHandler);
      }
      
      [Event(name="iconLoadingFailed",type="net.wg.infrastructure.events.IconLoaderEvent")]
      protected function iconLoadingIOErrorHandler(param1:IOErrorEvent) : void
      {
         dispatchEvent(this.getNewLoadingEvent(IconLoaderEvent.ICON_LOADING_FAILED,loaderInfo.loader,loaderInfo.url));
         this.removeIconListeners(LoaderInfo(param1.target));
      }
      
      [Event(name="iconLoaded",type="net.wg.infrastructure.events.IconLoaderEvent")]
      protected function iconLoadingCompleteHandler(param1:Event) : void
      {
         var _loc2_:LoaderInfo = LoaderInfo(param1.target);
         this.removeIconListeners(_loc2_);
         dispatchEvent(this.getNewLoadingEvent(IconLoaderEvent.ICON_LOADED,_loc2_.loader,_loc2_.url));
         this.iconWasLoaded = true;
         invalidate(this.LAYOUT_INVALID,this.ICON_LOADED_INVALID);
      }
      
      private function getNewLoadingEvent(param1:String, param2:Loader, param3:String) : IconLoaderEvent
      {
         return new IconLoaderEvent(param1,param2,param3,false,true);
      }
   }
}
