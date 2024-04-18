package net.wg.gui.lobby.vehiclePreview
{
   import flash.display.DisplayObject;
   import flash.display.InteractiveObject;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.KeyboardEvent;
   import flash.ui.Keyboard;
   import net.wg.data.constants.generated.VEHPREVIEW_CONSTANTS;
   import net.wg.gui.components.advanced.interfaces.IBackButton;
   import net.wg.gui.events.LobbyEvent;
   import net.wg.gui.interfaces.ISoundButtonEx;
   import net.wg.gui.lobby.vehiclePreview.additionalInfo.VPAdditionalInfoPanel;
   import net.wg.gui.lobby.vehiclePreview.bottomPanel.IVPBottomPanel;
   import net.wg.gui.lobby.vehiclePreview.bottomPanel.VPBottomPanelShowcaseStyleBuying;
   import net.wg.gui.lobby.vehiclePreview.bottomPanel.VPBottomPanelStyleBuying;
   import net.wg.gui.lobby.vehiclePreview.bottomPanel.VPBottomPanelStyleProgression;
   import net.wg.gui.lobby.vehiclePreview.data.VPAdditionalInfoVO;
   import net.wg.gui.lobby.vehiclePreview.data.VPPageBaseVO;
   import net.wg.gui.lobby.vehiclePreview.topPanel.IVPTopPanel;
   import net.wg.gui.lobby.vehiclePreview.topPanel.VPTopPanelTabs;
   import net.wg.infrastructure.base.meta.IVehicleBasePreviewMeta;
   import net.wg.infrastructure.base.meta.impl.VehicleBasePreviewMeta;
   import net.wg.infrastructure.interfaces.IDAAPIModule;
   import net.wg.infrastructure.managers.ITooltipMgr;
   import net.wg.utils.IStageSizeDependComponent;
   import net.wg.utils.StageSizeBoundaries;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.events.ButtonEvent;
   import scaleform.clik.events.InputEvent;
   import scaleform.clik.motion.Tween;
   
   public class VehicleBasePreviewPage extends VehicleBasePreviewMeta implements IVehicleBasePreviewMeta, IStageSizeDependComponent
   {
      
      private static const INTRO_FLAG:String = "showIntro";
      
      private static const BIG_OFFSET:int = 50;
      
      private static const SMALL_OFFSET:int = BIG_OFFSET >> 1;
      
      private static const BIG_PANELS_VERTICAL_OFFSET:int = 90;
      
      private static const SMALL_PANELS_VERTICAL_OFFSET:int = 84;
      
      private static const BUYING_PANEL_OFFSET:int = 90;
      
      private static const FADE_ANIMATION_DURATION:int = 200;
      
      private static const FADE_ANIMATION_DELAY:int = 150;
      
      private static const INTRO_ANIMATION_DURATION:int = 500;
      
      private static const INTRO_ANIMATION_DELAY:int = 200;
      
      private static const SHOW_SLOTS_ALPHA:Number = 1;
      
      private static const HIDE_SLOTS_ALPHA:Number = 0;
      
      private static const NAVIGATION_BUTTONS_OFFSET:int = 10;
       
      
      public var closeButton:ISoundButtonEx = null;
      
      public var backButton:IBackButton = null;
      
      public var leftBackground:MovieClip = null;
      
      public var rightBackground:MovieClip = null;
      
      public var topPanel:IVPTopPanel;
      
      public var bottomPanel:IVPBottomPanel;
      
      public var messengerBg:Sprite = null;
      
      public var fadingPanels:MovieClip = null;
      
      public var background:Sprite = null;
      
      private var _toolTipMgr:ITooltipMgr;
      
      private var _additionalInfoPanel:VPAdditionalInfoPanel = null;
      
      private var _tweens:Vector.<Tween>;
      
      private var _offset:int = 50;
      
      private var _panelVerticalOffset:int = 90;
      
      private var _isIntroFinished:Boolean;
      
      private var _isSmallHeight:Boolean = false;
      
      public function VehicleBasePreviewPage()
      {
         this._toolTipMgr = App.toolTipMgr;
         super();
         this._additionalInfoPanel = this.fadingPanels.additionalInfoPanel;
         this._tweens = new Vector.<Tween>(0);
      }
      
      override public function updateStage(param1:Number, param2:Number) : void
      {
         setSize(param1,param2);
      }
      
      override protected function onInitModalFocus(param1:InteractiveObject) : void
      {
         super.onInitModalFocus(param1);
         var _loc2_:Vector.<InteractiveObject> = new <InteractiveObject>[InteractiveObject(this.backButton),InteractiveObject(this.closeButton)];
         var _loc3_:int = 0;
         if(this.bottomPanel != null && this.bottomPanel.getBtn() != null)
         {
            _loc2_.push(InteractiveObject(this.bottomPanel.getBtn()));
            _loc3_ = 2;
         }
         App.utils.commons.initTabIndex(_loc2_);
         setFocus(_loc2_[_loc3_]);
         _loc2_.splice(0,_loc2_.length);
      }
      
      override protected function setData(param1:VPPageBaseVO) : void
      {
         this.closeButton.label = param1.closeBtnLabel;
         this.closeButton.visible = param1.showCloseBtn;
         this.backButton.label = param1.backBtnLabel;
         this.backButton.descrLabel = param1.backBtnDescrLabel;
         this.backButton.visible = param1.showBackButton;
         invalidateSize();
      }
      
      override protected function setAdditionalInfo(param1:VPAdditionalInfoVO) : void
      {
         this._additionalInfoPanel.setData(param1);
      }
      
      override protected function show3DSceneTooltip(param1:String, param2:Array) : void
      {
         this._toolTipMgr.showSpecial.apply(this._toolTipMgr,[param1,null].concat(param2));
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         mouseEnabled = false;
         this.fadingPanels.mouseEnabled = false;
         this.leftBackground.mouseEnabled = this.leftBackground.mouseChildren = false;
         this.rightBackground.mouseEnabled = this.rightBackground.mouseChildren = false;
         this.background.mouseEnabled = this.background.mouseChildren = false;
         this.backButton.addEventListener(ButtonEvent.CLICK,this.onBackBtnClickHandler);
         this.closeButton.addEventListener(ButtonEvent.CLICK,this.onCloseBtnClickHandler);
         App.stageSizeMgr.register(this);
      }
      
      override protected function onPopulate() : void
      {
         super.onPopulate();
         App.stage.dispatchEvent(new LobbyEvent(LobbyEvent.REGISTER_DRAGGING));
         App.gameInputMgr.setKeyHandler(Keyboard.ESCAPE,KeyboardEvent.KEY_DOWN,this.onEscapeKeyUpHandler,true);
         var _loc1_:String = this.getTopPanelAlias();
         if(_loc1_)
         {
            registerFlashComponentS(IDAAPIModule(this.topPanel),_loc1_);
         }
         var _loc2_:String = this.getBottomPanelAlias();
         if(_loc2_)
         {
            registerFlashComponentS(IDAAPIModule(this.bottomPanel),_loc2_);
         }
      }
      
      override protected function onBeforeDispose() : void
      {
         this.backButton.removeEventListener(ButtonEvent.CLICK,this.onBackBtnClickHandler);
         this.closeButton.removeEventListener(ButtonEvent.CLICK,this.onCloseBtnClickHandler);
         App.gameInputMgr.clearKeyHandler(Keyboard.ESCAPE,KeyboardEvent.KEY_DOWN,this.onEscapeKeyUpHandler);
         App.stage.dispatchEvent(new LobbyEvent(LobbyEvent.UNREGISTER_DRAGGING));
         App.stage.removeEventListener(LobbyEvent.DRAGGING_START,this.onDraggingStartHandler);
         App.stage.removeEventListener(LobbyEvent.DRAGGING_END,this.onDraggingEndHandler);
         super.onBeforeDispose();
      }
      
      override protected function onDispose() : void
      {
         App.stageSizeMgr.unregister(this);
         this.disposeTweens();
         this._tweens = null;
         this.backButton.dispose();
         this.backButton = null;
         this.closeButton.dispose();
         this.closeButton = null;
         this.leftBackground = null;
         this.rightBackground = null;
         this.messengerBg = null;
         this._toolTipMgr = null;
         this._additionalInfoPanel = null;
         this.background = null;
         this.fadingPanels = null;
         this.topPanel = null;
         this.bottomPanel = null;
         super.onDispose();
      }
      
      override protected function draw() : void
      {
         var _loc1_:int = 0;
         super.draw();
         if(isInvalid(InvalidationType.SIZE))
         {
            this.leftBackground.height = height;
            this.rightBackground.x = width - this.rightBackground.width | 0;
            this.rightBackground.height = height;
            this.background.width = width;
            this.background.height = height;
            this.messengerBg.width = width;
            this.messengerBg.y = height | 0;
            this.backButton.x = this._offset - NAVIGATION_BUTTONS_OFFSET;
            this.closeButton.x = width - this._offset - this.closeButton.width + NAVIGATION_BUTTONS_OFFSET | 0;
            _loc1_ = height - this._offset * 2 - this._panelVerticalOffset - BUYING_PANEL_OFFSET;
            this._additionalInfoPanel.x = this._offset;
            this._additionalInfoPanel.y = this._offset + this._panelVerticalOffset;
            this._additionalInfoPanel.height = _loc1_;
            if(this.topPanel != null)
            {
               this.topPanel.x = width - this.topPanel.width >> 1;
            }
            if(this.bottomPanel != null)
            {
               this.bottomPanel.x = width - this.bottomPanel.width >> 1;
               this.bottomPanel.y = height - this._offset - this.bottomPanel.height | 0;
               if(this._isSmallHeight)
               {
                  this.bottomPanel.y += this.bottomPanel.getSmallScreenOffsetY();
               }
            }
         }
         if(!this._isIntroFinished && isInvalid(INTRO_FLAG))
         {
            this.startIntroAnimation();
         }
      }
      
      public function as_hide3DSceneTooltip() : void
      {
         this.hideTooltip();
      }
      
      public function as_setTopPanel(param1:String) : void
      {
         if(this.topPanel == null && param1 != "")
         {
            this.topPanel = App.utils.classFactory.getComponent(param1,MovieClip);
            addChild(DisplayObject(this.topPanel));
         }
      }
      
      public function as_setBottomPanel(param1:String) : void
      {
         if(this.bottomPanel == null && param1 != "")
         {
            this.bottomPanel = App.utils.classFactory.getComponent(param1,MovieClip);
            addChild(DisplayObject(this.bottomPanel));
         }
      }
      
      public function setStateSizeBoundaries(param1:int, param2:int) : void
      {
         if(param2 == StageSizeBoundaries.HEIGHT_768)
         {
            this._offset = SMALL_OFFSET;
            this._panelVerticalOffset = SMALL_PANELS_VERTICAL_OFFSET;
            this._isSmallHeight = true;
         }
         else
         {
            this._offset = BIG_OFFSET;
            this._panelVerticalOffset = BIG_PANELS_VERTICAL_OFFSET;
            this._isSmallHeight = false;
         }
         invalidateSize();
      }
      
      private function hideTooltip() : void
      {
         this._toolTipMgr.hide();
      }
      
      private function startIntroAnimation() : void
      {
         this.disposeTweens();
         this._tweens.push(new Tween(INTRO_ANIMATION_DURATION,this._additionalInfoPanel,{"alpha":1},{
            "delay":INTRO_ANIMATION_DELAY,
            "fastTransform":false,
            "onComplete":this.onIntroCompleteCallback
         }));
      }
      
      private function disposeTweens() : void
      {
         var _loc1_:Tween = null;
         for each(_loc1_ in this._tweens)
         {
            _loc1_.paused = true;
            _loc1_.dispose();
         }
         this._tweens.length = 0;
      }
      
      private function onIntroCompleteCallback(param1:Tween) : void
      {
         this._isIntroFinished = true;
         App.stage.addEventListener(LobbyEvent.DRAGGING_START,this.onDraggingStartHandler);
         App.stage.addEventListener(LobbyEvent.DRAGGING_END,this.onDraggingEndHandler);
      }
      
      private function onDraggingEndHandler(param1:LobbyEvent) : void
      {
         if(this._isIntroFinished)
         {
            this.disposeTweens();
         }
         this.fadingPanels.mouseChildren = true;
         if(this.fadingPanels.alpha != SHOW_SLOTS_ALPHA)
         {
            this._tweens.push(new Tween(FADE_ANIMATION_DURATION,this.fadingPanels,{"alpha":SHOW_SLOTS_ALPHA},{"fastTransform":false}),new Tween(FADE_ANIMATION_DURATION,this.leftBackground,{"alpha":SHOW_SLOTS_ALPHA},{"fastTransform":false}),new Tween(FADE_ANIMATION_DURATION,this.rightBackground,{"alpha":SHOW_SLOTS_ALPHA},{"fastTransform":false}));
         }
      }
      
      private function onDraggingStartHandler(param1:LobbyEvent) : void
      {
         if(this._isIntroFinished)
         {
            this.disposeTweens();
         }
         this.fadingPanels.mouseChildren = false;
         this._tweens.push(new Tween(FADE_ANIMATION_DURATION,this.fadingPanels,{"alpha":HIDE_SLOTS_ALPHA},{
            "delay":FADE_ANIMATION_DELAY,
            "fastTransform":false
         }),new Tween(FADE_ANIMATION_DURATION,this.leftBackground,{"alpha":HIDE_SLOTS_ALPHA},{
            "delay":FADE_ANIMATION_DELAY,
            "fastTransform":false
         }),new Tween(FADE_ANIMATION_DURATION,this.rightBackground,{"alpha":HIDE_SLOTS_ALPHA},{
            "delay":FADE_ANIMATION_DELAY,
            "fastTransform":false
         }));
      }
      
      private function getTopPanelAlias() : String
      {
         if(this.topPanel is VPTopPanelTabs)
         {
            return VEHPREVIEW_CONSTANTS.TOP_PANEL_TABS_PY_ALIAS;
         }
         return null;
      }
      
      private function getBottomPanelAlias() : String
      {
         if(this.bottomPanel is VPBottomPanelStyleProgression)
         {
            return VEHPREVIEW_CONSTANTS.BOTTOM_PANEL_STYLE_PROGRESSION_PY_ALIAS;
         }
         if(this.bottomPanel is VPBottomPanelStyleBuying)
         {
            return VEHPREVIEW_CONSTANTS.BOTTOM_PANEL_STYLE_BUYING_PY_ALIAS;
         }
         if(this.bottomPanel is VPBottomPanelShowcaseStyleBuying)
         {
            return VEHPREVIEW_CONSTANTS.BOTTOM_PANEL_SHOWCASE_STYLE_BUYING_PY_ALIAS;
         }
         return null;
      }
      
      private function onEscapeKeyUpHandler(param1:InputEvent) : void
      {
         onBackClickS();
      }
      
      private function onCloseBtnClickHandler(param1:ButtonEvent) : void
      {
         closeViewS();
      }
      
      private function onBackBtnClickHandler(param1:ButtonEvent) : void
      {
         onBackClickS();
      }
   }
}
