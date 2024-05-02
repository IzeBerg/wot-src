package net.wg.gui.lobby.battleMatters
{
   import flash.display.DisplayObject;
   import flash.display.DisplayObjectContainer;
   import flash.display.Loader;
   import flash.display.Sprite;
   import flash.display.Stage;
   import flash.events.Event;
   import flash.events.IOErrorEvent;
   import flash.events.KeyboardEvent;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.net.URLRequest;
   import flash.system.ApplicationDomain;
   import flash.system.LoaderContext;
   import flash.ui.Keyboard;
   import net.wg.gui.interfaces.ISoundButtonEx;
   import net.wg.gui.lobby.battleMatters.data.BattleMattersAnimVO;
   import net.wg.infrastructure.base.UIComponentEx;
   import net.wg.utils.IGameInputManager;
   import net.wg.utils.StageSizeBoundaries;
   import scaleform.clik.events.ButtonEvent;
   import scaleform.clik.events.InputEvent;
   
   public class BattleMattersAnimLoaderView extends UIComponentEx
   {
      
      private static const ANIMATIONS_PATH:String = "./";
      
      private static const CLOSE_BTN_OFFSET:Point = new Point(21,-5);
      
      private static const OFFSET_TOP_Y_768:int = 104;
      
      private static const OFFSET_TOP_Y_900:int = 140;
      
      private static const ANIMATION_WIDTH:int = 940;
      
      private static const ANIMATION_HEIGHT:int = 520;
      
      public static const LOADING_COMPLETE:String = "loadingComplete";
      
      public static const ON_CLOSE:String = "onClose";
       
      
      public var bg:Sprite;
      
      public var closeBtn:ISoundButtonEx;
      
      public var shadow:Sprite;
      
      public var loaderMask:Sprite;
      
      private var _loader:Loader;
      
      private var _data:BattleMattersAnimVO;
      
      private var _stage:Stage;
      
      private var _gameInputMgr:IGameInputManager;
      
      public function BattleMattersAnimLoaderView()
      {
         this._loader = new Loader();
         this._stage = App.stage;
         this._gameInputMgr = App.gameInputMgr;
         super();
      }
      
      private static function onLoaderIOErrorHandler(param1:IOErrorEvent) : void
      {
         DebugUtils.LOG_ERROR(param1.toString());
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.closeBtn.label = MENU.VIEWHEADER_CLOSEBTN_LABEL;
         this._loader.contentLoaderInfo.addEventListener(Event.COMPLETE,this.onLoaderCompleteHandler);
         this._loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR,onLoaderIOErrorHandler);
         this._loader.mouseChildren = false;
         this.closeBtn.addEventListener(ButtonEvent.CLICK,this.onCloseBtnClickHandler);
         addChild(this._loader);
         this._loader.mask = this.loaderMask;
      }
      
      override protected function onDispose() : void
      {
         this._stage.removeEventListener(MouseEvent.CLICK,this.onStageClickHandler);
         this._gameInputMgr.clearKeyHandler(Keyboard.ESCAPE,KeyboardEvent.KEY_DOWN,this.onEscapeKeyDownHandler);
         this._loader.contentLoaderInfo.removeEventListener(Event.COMPLETE,this.onLoaderCompleteHandler);
         this._loader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR,onLoaderIOErrorHandler);
         this._loader.unloadAndStop();
         this._loader = null;
         this.closeBtn.removeEventListener(ButtonEvent.CLICK,this.onCloseBtnClickHandler);
         this.closeBtn.dispose();
         this.closeBtn = null;
         this.bg = null;
         this.shadow = null;
         this.loaderMask = null;
         this._data = null;
         this._stage = null;
         this._gameInputMgr = null;
         super.onDispose();
      }
      
      public function showAnimation(param1:String, param2:BattleMattersAnimVO) : void
      {
         this._data = param2;
         var _loc3_:LoaderContext = new LoaderContext(false,ApplicationDomain.currentDomain);
         this._loader.load(new URLRequest(ANIMATIONS_PATH + param1),_loc3_);
      }
      
      public function updateStage(param1:int, param2:int) : void
      {
         setSize(param1,param2);
         this.updatePosition();
      }
      
      private function updatePosition() : void
      {
         if(App.appHeight > StageSizeBoundaries.HEIGHT_900)
         {
            this.centerViewOnScreen();
         }
         else
         {
            this.setViewPositionWithOffset();
         }
         this.closeBtn.x = this._loader.x + ANIMATION_WIDTH - this.closeBtn.actualWidth + CLOSE_BTN_OFFSET.x;
         this.closeBtn.y = this._loader.y - this.closeBtn.actualHeight + CLOSE_BTN_OFFSET.y;
         this.shadow.x = this._loader.x + (ANIMATION_WIDTH >> 1);
         this.shadow.y = this._loader.y + (ANIMATION_HEIGHT >> 1);
         this.bg.width = _width;
         this.bg.height = _height;
      }
      
      private function centerViewOnScreen() : void
      {
         this.loaderMask.x = this._loader.x = _width - ANIMATION_WIDTH >> 1;
         this.loaderMask.y = this._loader.y = App.appHeight - ANIMATION_HEIGHT >> 1;
      }
      
      private function setViewPositionWithOffset() : void
      {
         var _loc1_:int = App.appHeight >= StageSizeBoundaries.HEIGHT_900 ? int(OFFSET_TOP_Y_900) : int(OFFSET_TOP_Y_768);
         this.loaderMask.x = this._loader.x = _width - ANIMATION_WIDTH >> 1;
         this.loaderMask.y = this._loader.y = _loc1_ + (_height - _loc1_ - ANIMATION_HEIGHT >> 1);
      }
      
      private function onStageClickHandler(param1:MouseEvent) : void
      {
         if(param1.target != this._loader)
         {
            this.onCloseBtnClickHandler();
         }
      }
      
      private function onCloseBtnClickHandler(param1:ButtonEvent = null) : void
      {
         if(!visible)
         {
            return;
         }
         this._gameInputMgr.clearKeyHandler(Keyboard.ESCAPE,KeyboardEvent.KEY_DOWN,this.onEscapeKeyDownHandler);
         this._stage.removeEventListener(MouseEvent.CLICK,this.onStageClickHandler);
         this._loader.unloadAndStop();
         dispatchEvent(new Event(ON_CLOSE));
      }
      
      private function onLoaderCompleteHandler(param1:Event) : void
      {
         var _loc2_:DisplayObject = null;
         App.utils.focusHandler.setFocus(this);
         this._stage.addEventListener(MouseEvent.CLICK,this.onStageClickHandler);
         this._gameInputMgr.setKeyHandler(Keyboard.ESCAPE,KeyboardEvent.KEY_DOWN,this.onEscapeKeyDownHandler,true);
         this.updatePosition();
         dispatchEvent(new Event(LOADING_COMPLETE));
         _loc2_ = DisplayObjectContainer(this._loader.content).getChildAt(0);
         var _loc3_:BattleMattersAnimation = BattleMattersAnimation(_loc2_);
         _loc3_.setData(this._data);
      }
      
      private function onEscapeKeyDownHandler(param1:InputEvent) : void
      {
         this.onCloseBtnClickHandler();
      }
   }
}
