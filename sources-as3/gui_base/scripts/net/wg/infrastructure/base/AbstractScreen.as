package net.wg.infrastructure.base
{
   import flash.display.DisplayObject;
   import flash.display.Loader;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.IOErrorEvent;
   import flash.events.KeyboardEvent;
   import flash.filters.BitmapFilterQuality;
   import flash.filters.BlurFilter;
   import flash.net.URLRequest;
   import flash.system.ApplicationDomain;
   import flash.system.LoaderContext;
   import flash.ui.Keyboard;
   import net.wg.data.constants.LobbyMetrics;
   import net.wg.gui.interfaces.ISoundButtonEx;
   import net.wg.utils.IScheduler;
   import scaleform.clik.constants.InputValue;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.events.ButtonEvent;
   import scaleform.clik.events.InputEvent;
   import scaleform.clik.motion.Tween;
   import scaleform.clik.ui.InputDetails;
   import scaleform.clik.utils.Padding;
   
   public class AbstractScreen extends AbstractView
   {
      
      protected static const FADE_IN_TIME:int = 500;
      
      protected static const CLOSE_BTN_BORDER_OFFSET:int = 20;
      
      private static const BLUR_XY:int = 20;
      
      private static const ANIM_STEP_TIME:int = 20;
      
      private static const ANIM_NUM_CYCLES:int = 20;
      
      private static const BG_HOLDER_NAME:String = "bgHolder";
       
      
      public var closeBtn:ISoundButtonEx = null;
      
      protected var fadeEnable:Boolean = false;
      
      protected var bgHolder:Sprite = null;
      
      protected var bgIndex:int = 0;
      
      private var _bgLoader:Loader = null;
      
      private var _isBgReady:Boolean = false;
      
      private var _cachedBg:Object = null;
      
      private var _bgIsLoaded:Boolean = false;
      
      private var _backgroundURL:String;
      
      private var _showTween:Tween = null;
      
      private var _bgPaddingLayout:Padding;
      
      private var _blurAnimCount:int = 0;
      
      private var _blurStep:Number = 1.0;
      
      private var _scheduler:IScheduler;
      
      public function AbstractScreen()
      {
         this._bgPaddingLayout = new Padding(LobbyMetrics.LOBBY_MESSENGER_HEIGHT - App.utils.viewRestrictions.verticalOffset,0,0,0);
         this._scheduler = App.utils.scheduler;
         super();
      }
      
      override public function playShowTween(param1:DisplayObject, param2:Function = null) : Boolean
      {
         if(this.fadeEnable)
         {
            param1.alpha = 0;
            this._showTween = new Tween(FADE_IN_TIME,param1,{"alpha":1},{
               "paused":false,
               "onComplete":param2
            });
            return true;
         }
         return false;
      }
      
      override public function updateStage(param1:Number, param2:Number) : void
      {
         setViewSize(param1,param2);
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         this.bgHolder = new Sprite();
         this.bgHolder.name = BG_HOLDER_NAME;
         this._cachedBg = {};
         addChildAt(this.bgHolder,this.bgIndex);
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         if(this.closeBtn != null)
         {
            this.closeBtn.addEventListener(ButtonEvent.CLICK,this.onCloseBtnClickHandler);
         }
         if(App.gameInputMgr)
         {
            App.gameInputMgr.setKeyHandler(Keyboard.ESCAPE,KeyboardEvent.KEY_DOWN,this.onEscapeKeyDown,true);
         }
      }
      
      override protected function allowHandleInput() : Boolean
      {
         return App.gameInputMgr == null;
      }
      
      override protected function onDispose() : void
      {
         this.cancelScheduled();
         this._scheduler = null;
         App.utils.data.cleanupDynamicObject(this._cachedBg);
         this._cachedBg = null;
         this.clearLoader();
         if(this.bgHolder != null)
         {
            this.clearBackground();
            this.bgHolder = null;
         }
         if(this._showTween)
         {
            this._showTween.paused = true;
            this._showTween.dispose();
            this._showTween = null;
         }
         if(this.closeBtn != null)
         {
            this.closeBtn.removeEventListener(ButtonEvent.CLICK,this.onCloseBtnClickHandler);
            this.closeBtn.dispose();
            this.closeBtn = null;
         }
         if(App.gameInputMgr)
         {
            App.gameInputMgr.clearKeyHandler(Keyboard.ESCAPE,KeyboardEvent.KEY_DOWN,this.onEscapeKeyDown);
         }
         this._bgPaddingLayout = null;
         super.onDispose();
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(InvalidationType.SIZE))
         {
            this.layoutElements();
            if(this._bgIsLoaded)
            {
               this.layoutBackground();
            }
         }
      }
      
      public function setBackground(param1:String) : void
      {
         var _loc2_:DisplayObject = null;
         var _loc3_:URLRequest = null;
         var _loc4_:LoaderContext = null;
         if(this._backgroundURL == param1)
         {
            return;
         }
         this._backgroundURL = param1;
         if(this._cachedBg[param1] != null)
         {
            _loc2_ = this._cachedBg[param1];
            this.updateBgHolder(_loc2_);
         }
         else
         {
            this._bgIsLoaded = false;
            this.clearLoader();
            this._bgLoader = new Loader();
            _loc3_ = new URLRequest(param1);
            _loc4_ = new LoaderContext(false,ApplicationDomain.currentDomain);
            this._bgLoader.contentLoaderInfo.addEventListener(Event.COMPLETE,this.onBgLoaderCompleteHandler);
            this._bgLoader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR,this.onBgLoaderIoErrorHandler);
            this._bgLoader.load(_loc3_,_loc4_);
         }
      }
      
      protected function layoutElements() : void
      {
         if(this.closeBtn != null)
         {
            this.closeBtn.x = width - this.closeBtn.width - CLOSE_BTN_BORDER_OFFSET;
         }
      }
      
      protected function layoutBackground() : void
      {
         var _loc1_:Number = width + this._bgPaddingLayout.horizontal;
         var _loc2_:Number = height + this._bgPaddingLayout.vertical;
         var _loc3_:int = this.bgHolder.width / this.bgHolder.scaleX;
         var _loc4_:int = this.bgHolder.height / this.bgHolder.scaleY;
         if(_loc2_ < _loc4_ * _loc1_ / _loc3_)
         {
            this.bgHolder.width = _loc1_;
            this.bgHolder.scaleY = this.bgHolder.scaleX;
         }
         else
         {
            this.bgHolder.height = _loc2_;
            this.bgHolder.scaleX = this.bgHolder.scaleY;
         }
         this.bgHolder.x = _loc1_ - this.bgHolder.width >> 1;
         this.bgHolder.y = 0;
      }
      
      protected function onEscapeKeyDown() : void
      {
      }
      
      protected function onCloseBtn() : void
      {
      }
      
      protected function blurElements(param1:Vector.<DisplayObject>, param2:Boolean) : void
      {
         var _loc3_:DisplayObject = null;
         if(!param2)
         {
            for each(_loc3_ in param1)
            {
               App.utils.commons.setBlur(_loc3_,BLUR_XY,BLUR_XY,BitmapFilterQuality.MEDIUM);
            }
         }
         else
         {
            this._blurAnimCount = 0;
            this.cancelScheduled();
            this._scheduler.scheduleRepeatableTask(this.animateBlur,ANIM_STEP_TIME,ANIM_NUM_CYCLES,param1);
         }
      }
      
      protected function unblurElements(param1:Vector.<DisplayObject>, param2:Boolean) : void
      {
         var _loc3_:DisplayObject = null;
         if(!param2)
         {
            for each(_loc3_ in param1)
            {
               _loc3_.filters = [];
            }
         }
         else
         {
            this._blurAnimCount = BLUR_XY;
            this.cancelScheduled();
            this._scheduler.scheduleRepeatableTask(this.animateUnblur,ANIM_STEP_TIME,ANIM_NUM_CYCLES,param1);
         }
      }
      
      protected function onBgChanged(param1:Boolean) : void
      {
      }
      
      private function onBgReady() : void
      {
         if(!this._isBgReady && this.showViewAfterBgReady())
         {
            visible = true;
         }
         var _loc1_:Boolean = !this._isBgReady;
         this._isBgReady = true;
         this.onBgChanged(_loc1_);
      }
      
      private function showViewAfterBgReady() : Boolean
      {
         return autoShowViewProperty == SHOW_VIEW_PROP_AFTER_BG_READY;
      }
      
      private function clearLoader() : void
      {
         if(this._bgLoader)
         {
            this._bgLoader.contentLoaderInfo.removeEventListener(Event.COMPLETE,this.onBgLoaderCompleteHandler);
            this._bgLoader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR,this.onBgLoaderIoErrorHandler);
            this._bgLoader.close();
            this._bgLoader.unload();
            this._bgLoader = null;
         }
      }
      
      private function clearBackground() : void
      {
         if(this.bgHolder.numChildren > 0)
         {
            this.bgHolder.removeChildAt(0);
         }
      }
      
      private function animateBlur(param1:Vector.<DisplayObject>) : void
      {
         var _loc3_:DisplayObject = null;
         this._blurAnimCount += this._blurStep;
         var _loc2_:BlurFilter = new BlurFilter(this._blurAnimCount,this._blurAnimCount,BitmapFilterQuality.MEDIUM);
         for each(_loc3_ in param1)
         {
            _loc3_.filters = [_loc2_];
         }
      }
      
      private function animateUnblur(param1:Vector.<DisplayObject>) : void
      {
         var _loc3_:DisplayObject = null;
         this._blurAnimCount -= this._blurStep;
         var _loc2_:BlurFilter = new BlurFilter(this._blurAnimCount,this._blurAnimCount,BitmapFilterQuality.MEDIUM);
         for each(_loc3_ in param1)
         {
            _loc3_.filters = [_loc2_];
         }
      }
      
      private function cancelScheduled() : void
      {
         this._scheduler.cancelTask(this.animateBlur);
         this._scheduler.cancelTask(this.animateUnblur);
      }
      
      protected function updateBgHolder(param1:DisplayObject) : void
      {
         this.clearBackground();
         this.bgHolder.scaleX = this.bgHolder.scaleY = 1;
         this.bgHolder.addChild(param1);
         this.layoutBackground();
         this.onBgReady();
      }
      
      public function get bgPaddingLayout() : Padding
      {
         return this._bgPaddingLayout;
      }
      
      public function set bgPaddingLayout(param1:Padding) : void
      {
         this._bgPaddingLayout = param1;
      }
      
      protected function get isBgReady() : Boolean
      {
         return this._isBgReady;
      }
      
      override public function handleInput(param1:InputEvent) : void
      {
         super.handleInput(param1);
         if(param1.handled)
         {
            return;
         }
         var _loc2_:InputDetails = param1.details;
         if(_loc2_.code == Keyboard.ESCAPE && _loc2_.value == InputValue.KEY_DOWN)
         {
            param1.handled = true;
            this.onEscapeKeyDown();
         }
      }
      
      private function onBgLoaderIoErrorHandler(param1:IOErrorEvent) : void
      {
         this.clearLoader();
      }
      
      private function onBgLoaderCompleteHandler(param1:Event) : void
      {
         var _loc2_:DisplayObject = this._bgLoader.content;
         this._cachedBg[this._backgroundURL] = _loc2_;
         this.clearLoader();
         this.updateBgHolder(_loc2_);
         this._bgIsLoaded = true;
      }
      
      private function onCloseBtnClickHandler(param1:ButtonEvent) : void
      {
         this.onCloseBtn();
      }
   }
}
