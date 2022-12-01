package net.wg.gui.lobby.new_year
{
   import fl.motion.easing.Cubic;
   import flash.display.DisplayObjectContainer;
   import flash.display.Graphics;
   import flash.display.InteractiveObject;
   import flash.display.Sprite;
   import flash.events.KeyboardEvent;
   import flash.ui.Keyboard;
   import net.wg.data.constants.generated.NY_CONSTS;
   import net.wg.gui.lobby.techtree.helpers.TweenWrapper;
   import net.wg.infrastructure.base.meta.INYMainViewMeta;
   import net.wg.infrastructure.base.meta.impl.NYMainViewMeta;
   import scaleform.clik.motion.Tween;
   
   public class NYMainView extends NYMainViewMeta implements INYMainViewMeta
   {
      
      private static const BOTTOM_PANEL_HEIGHT:int = 35;
      
      private static const SIDEBAR_PANEL_WIDTH:int = 250;
      
      private static const FADE_IN_DURATION:int = 300;
      
      private static const FADE_OUT_DELAY:int = 100;
      
      private static const FADE_OUT_DURATION:int = 350;
      
      private static const BLACK_OVERLAY_NAME:String = "blackOverlay";
       
      
      public var mainMenu:NYMainMenuInject = null;
      
      public var gfContent:NYMainViewGFContentInject = null;
      
      public var ubContent:NYMainViewUBContentInject = null;
      
      public var sidebar:NYMainViewGFContentInject = null;
      
      private var _nextContent:DisplayObjectContainer = null;
      
      private var _currentContent:DisplayObjectContainer = null;
      
      private var _currentInjectId:int = 0;
      
      private var _tweens:Vector.<Tween> = null;
      
      private var _blackOverlay:Sprite = null;
      
      private var _blackOverlayWrapper:TweenWrapper = null;
      
      public function NYMainView()
      {
         super();
         this._blackOverlay = new Sprite();
         this._blackOverlay.name = BLACK_OVERLAY_NAME;
         var _loc1_:Graphics = this._blackOverlay.graphics;
         _loc1_.beginFill(0);
         _loc1_.drawRect(0,0,1,1);
         _loc1_.endFill();
         this._blackOverlay.visible = false;
         addChild(this._blackOverlay);
         swapChildren(this._blackOverlay,this.mainMenu);
         this._blackOverlayWrapper = new TweenWrapper(this._blackOverlay);
      }
      
      override public function updateStage(param1:Number, param2:Number) : void
      {
         super.updateStage(param1,param2);
         _originalWidth = param1;
         _originalHeight = param2;
         var _loc3_:int = param2 + BOTTOM_PANEL_HEIGHT;
         if(this.gfContent)
         {
            this.gfContent.setSize(param1,_loc3_);
         }
         if(this.sidebar)
         {
            this.sidebar.setSize(SIDEBAR_PANEL_WIDTH,param2);
         }
         if(this.ubContent)
         {
            this.ubContent.setSize(param1,_loc3_);
         }
         if(this._blackOverlay)
         {
            this._blackOverlay.width = param1;
            this._blackOverlay.height = _loc3_;
         }
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this._blackOverlay.mouseEnabled = this._blackOverlay.tabEnabled = false;
         this.gfContent.visible = this.ubContent.visible = false;
         this.gfContent.mouseChildren = this.gfContent.mouseEnabled = this.gfContent.tabEnabled = this.gfContent.tabChildren = false;
         this.ubContent.mouseChildren = this.ubContent.mouseEnabled = this.ubContent.tabEnabled = this.ubContent.tabChildren = false;
      }
      
      override protected function onPopulate() : void
      {
         super.onPopulate();
         if(App.gameInputMgr)
         {
            App.gameInputMgr.setKeyHandler(Keyboard.ESCAPE,KeyboardEvent.KEY_DOWN,this.onEscapeKeyDownHandler,true);
         }
      }
      
      override protected function onDispose() : void
      {
         if(App.gameInputMgr)
         {
            App.gameInputMgr.clearKeyHandler(Keyboard.ESCAPE,KeyboardEvent.KEY_DOWN,this.onEscapeKeyDownHandler);
         }
         this.cleanTweens();
         this._tweens = null;
         if(this._blackOverlayWrapper)
         {
            this._blackOverlayWrapper.dispose();
            this._blackOverlayWrapper = null;
         }
         this._currentContent = null;
         this._nextContent = null;
         this._blackOverlay = null;
         this.mainMenu = null;
         this.ubContent = null;
         this.gfContent = null;
         this.sidebar = null;
         super.onDispose();
      }
      
      override protected function onSetModalFocus(param1:InteractiveObject) : void
      {
         if(param1 == null)
         {
            param1 = this;
         }
         super.onSetModalFocus(param1);
      }
      
      public function as_switchView(param1:uint) : void
      {
         this.cleanTweens();
         if(this._currentInjectId != param1)
         {
            this._currentContent = this.getInjectById(this._currentInjectId);
            this._currentInjectId = param1;
         }
         this._nextContent = this.getInjectById(param1);
         if(!this._tweens)
         {
            this._tweens = new Vector.<Tween>();
         }
         this._blackOverlay.visible = true;
         this._blackOverlayWrapper.alpha = 0;
         this._tweens.push(new Tween(FADE_IN_DURATION,this._blackOverlayWrapper,{"alpha":1},{
            "ease":Cubic.easeIn,
            "onComplete":this.hideCurrentContent
         }));
      }
      
      private function onEscapeKeyDownHandler() : void
      {
         onEscPressS();
      }
      
      private function onFadeOut(param1:Tween) : void
      {
         this._blackOverlay.visible = false;
      }
      
      private function hideCurrentContent(param1:Tween) : void
      {
         if(this._currentContent)
         {
            this._currentContent.visible = false;
            this._currentContent.mouseChildren = this._currentContent.mouseEnabled = this._currentContent.tabChildren = this._currentContent.tabEnabled = false;
         }
         onSwitchViewS();
         this.sidebar.visible = true;
         this._nextContent.visible = true;
         this._nextContent.mouseChildren = this._nextContent.mouseEnabled = this._nextContent.tabChildren = this._nextContent.tabEnabled = true;
         this._tweens.push(new Tween(FADE_OUT_DURATION,this._blackOverlayWrapper,{"alpha":0},{
            "ease":Cubic.easeOut,
            "delay":FADE_OUT_DELAY,
            "onComplete":this.onFadeOut
         }));
      }
      
      private function getInjectById(param1:uint) : DisplayObjectContainer
      {
         if(param1 == NY_CONSTS.NY_MAIN_GF_INJECT)
         {
            return this.gfContent;
         }
         if(param1 == NY_CONSTS.NY_MAIN_UB_INJECT)
         {
            return this.ubContent;
         }
         return null;
      }
      
      private function cleanTweens() : void
      {
         var _loc1_:Tween = null;
         if(this._tweens)
         {
            for each(_loc1_ in this._tweens)
            {
               _loc1_.paused = true;
               _loc1_.dispose();
            }
            this._tweens.splice(0,this._tweens.length);
         }
      }
   }
}
