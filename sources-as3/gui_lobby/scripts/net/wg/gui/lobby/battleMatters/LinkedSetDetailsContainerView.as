package net.wg.gui.lobby.battleMatters
{
   import fl.motion.easing.Linear;
   import flash.display.InteractiveObject;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.ui.Keyboard;
   import flash.utils.Dictionary;
   import net.wg.data.constants.Errors;
   import net.wg.data.constants.Values;
   import net.wg.data.constants.generated.LINKEDSET_ALIASES;
   import net.wg.gui.interfaces.ISoundButtonEx;
   import net.wg.gui.lobby.battleMatters.data.LinkedSetDetailsContainerVO;
   import net.wg.infrastructure.base.BaseDAAPIComponent;
   import net.wg.infrastructure.base.interfaces.IWaiting;
   import net.wg.infrastructure.base.meta.ILinkedSetDetailsContainerViewMeta;
   import net.wg.infrastructure.base.meta.impl.LinkedSetDetailsContainerViewMeta;
   import net.wg.utils.IUtils;
   import org.idmedia.as3commons.util.StringUtils;
   import scaleform.clik.constants.InputValue;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.events.ButtonEvent;
   import scaleform.clik.events.InputEvent;
   import scaleform.clik.motion.Tween;
   import scaleform.clik.ui.InputDetails;
   
   public class LinkedSetDetailsContainerView extends LinkedSetDetailsContainerViewMeta implements ILinkedSetDetailsContainerViewMeta
   {
      
      private static const BTN_CLOSE_HEIGHT:int = 32;
      
      private static const BTN_CLOSE_WIDTH:int = 78;
      
      private static const MIN_CMP_PADDING:int = 12;
      
      private static const FADE_IN_DELAY:Number = 200;
      
      private static const FADE_IN_DURATION:Number = 400;
       
      
      public var btnClose:ISoundButtonEx = null;
      
      public var waiting:IWaiting = null;
      
      public var bg:Sprite = null;
      
      public var bgWindow:MovieClip = null;
      
      public var container:Sprite = null;
      
      private var _content:BaseDAAPIComponent = null;
      
      private var _contentLinkage:String = "";
      
      private var _data:LinkedSetDetailsContainerVO;
      
      private var _fadeTween:Tween;
      
      private var _bgFadeTween:Tween;
      
      private var _viewOpacity:Number = 1.0;
      
      private var _utils:IUtils = null;
      
      private var _linkagesDict:Dictionary;
      
      public function LinkedSetDetailsContainerView()
      {
         this._linkagesDict = new Dictionary();
         super();
      }
      
      override public function updateStage(param1:Number, param2:Number) : void
      {
         setSize(param1,param2);
      }
      
      override protected function onInitModalFocus(param1:InteractiveObject) : void
      {
         super.onInitModalFocus(param1);
         setFocus(this);
      }
      
      override protected function setInitData(param1:LinkedSetDetailsContainerVO) : void
      {
         this._data = param1;
         invalidateData();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this._utils = App.utils;
         this.waiting.setMessage(WAITING.LOADCONTENT);
         this.waiting.backgroundVisibility = false;
         this.viewOpacity = 0;
         this.bg.alpha = 0;
         this._bgFadeTween = new Tween(FADE_IN_DURATION,this.bg,{"alpha":1},{
            "paused":false,
            "ease":Linear.easeOut
         });
         this.btnClose.label = VEH_COMPARE.HEADER_CLOSEBTN_LABEL;
         this.btnClose.addEventListener(ButtonEvent.CLICK,this.onBtnCloseClickHandler);
         this.addLinkageWithAlias(LINKEDSET_ALIASES.LINKED_SET_DETAILS_VIEW_LINKAGE,LINKEDSET_ALIASES.LINKED_SET_DETAILS_VIEW_ALIAS);
      }
      
      override protected function onPopulate() : void
      {
         super.onPopulate();
         this.waiting.show();
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(this._data && isInvalid(InvalidationType.DATA))
         {
            this.waiting.hide();
            this.updateContent();
            this.playFadeInTween();
         }
         if(isInvalid(InvalidationType.SIZE))
         {
            this.updateLayout();
         }
      }
      
      private function clearFadeTween() : void
      {
         if(this._fadeTween)
         {
            this._fadeTween.dispose();
            this._fadeTween = null;
         }
      }
      
      override protected function onDispose() : void
      {
         this._utils.data.cleanupDynamicObject(this._linkagesDict);
         this._linkagesDict = null;
         this._utils = null;
         if(this._content)
         {
            this.container.removeChild(this._content);
            this._content = null;
         }
         this.container = null;
         this._contentLinkage = null;
         this._data = null;
         this.btnClose.removeEventListener(ButtonEvent.CLICK,this.onBtnCloseClickHandler);
         this.btnClose.dispose();
         this.btnClose = null;
         this.bg = null;
         this.bgWindow = null;
         this.waiting.dispose();
         this.waiting = null;
         this._bgFadeTween.dispose();
         this._bgFadeTween = null;
         this.clearFadeTween();
         super.onDispose();
      }
      
      private function updateLayout() : void
      {
         this.waiting.width = width;
         this.waiting.height = height;
         if(this._data.bgWidth != Values.DEFAULT_INT)
         {
            this.bgWindow.width = this._data.bgWidth;
         }
         if(this._data.bgHeight != Values.DEFAULT_INT)
         {
            this.bgWindow.height = this._data.bgHeight;
         }
         var _loc1_:int = this.bgWindow.height + BTN_CLOSE_HEIGHT + (MIN_CMP_PADDING << 1);
         this.btnClose.x = (width + this._data.bgWidth >> 1) - BTN_CLOSE_WIDTH;
         this.btnClose.y = height - _loc1_ >> 1;
         this.bgWindow.x = this.container.x = width - this.bgWindow.width >> 1;
         this.bgWindow.y = this.container.y = this.btnClose.y + BTN_CLOSE_HEIGHT + MIN_CMP_PADDING;
         this.bg.width = width;
         this.bg.height = height;
      }
      
      private function playFadeInTween() : void
      {
         this.clearFadeTween();
         this._fadeTween = new Tween(FADE_IN_DURATION,this,{"viewOpacity":1},{
            "paused":false,
            "ease":Linear.easeOut,
            "delay":FADE_IN_DELAY
         });
      }
      
      public function get viewOpacity() : Number
      {
         return this._viewOpacity;
      }
      
      public function set viewOpacity(param1:Number) : void
      {
         if(this._viewOpacity != param1)
         {
            this._viewOpacity = param1;
            this.bgWindow.alpha = this.btnClose.alpha = this.container.alpha = this._viewOpacity;
         }
      }
      
      override public function handleInput(param1:InputEvent) : void
      {
         var _loc2_:InputDetails = param1.details;
         if(_loc2_.code == Keyboard.ESCAPE && _loc2_.value == InputValue.KEY_DOWN)
         {
            param1.handled = true;
            closeViewS();
         }
      }
      
      protected function updateContent() : void
      {
         if(this._contentLinkage == this._data.linkage)
         {
            return;
         }
         if(this._content)
         {
            this.container.removeChild(this._content);
            unregisterFlashComponentS(this.getAliasByLinkage(this._contentLinkage));
            this._content = null;
         }
         this._contentLinkage = this._data.linkage;
         this._content = this._utils.classFactory.getComponent(this._contentLinkage,BaseDAAPIComponent);
         this.container.addChild(this._content);
         registerFlashComponentS(this._content,this.getAliasByLinkage(this._contentLinkage));
      }
      
      private function getAliasByLinkage(param1:String) : String
      {
         var _loc2_:String = this._linkagesDict[param1];
         this._utils.asserter.assert(StringUtils.isNotEmpty(_loc2_),Errors.BAD_LINKAGE + param1);
         return _loc2_;
      }
      
      private function addLinkageWithAlias(param1:String, param2:String) : void
      {
         this._linkagesDict[param1] = param2;
      }
      
      private function onBtnCloseClickHandler(param1:ButtonEvent) : void
      {
         closeViewS();
      }
   }
}
