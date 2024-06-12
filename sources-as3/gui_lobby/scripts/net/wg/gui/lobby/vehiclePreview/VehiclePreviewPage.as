package net.wg.gui.lobby.vehiclePreview
{
   import flash.display.DisplayObject;
   import flash.display.InteractiveObject;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.display.Stage;
   import flash.events.Event;
   import flash.events.KeyboardEvent;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import flash.ui.Keyboard;
   import net.wg.data.constants.generated.VEHPREVIEW_CONSTANTS;
   import net.wg.gui.components.advanced.interfaces.IBackButton;
   import net.wg.gui.events.LobbyEvent;
   import net.wg.gui.events.ViewStackEvent;
   import net.wg.gui.interfaces.ISoundButtonEx;
   import net.wg.gui.lobby.hangar.VehicleParameters;
   import net.wg.gui.lobby.techtree.TechTreeEvent;
   import net.wg.gui.lobby.vehicleCompare.events.VehCompareEvent;
   import net.wg.gui.lobby.vehiclePreview.bottomPanel.IVPBottomPanel;
   import net.wg.gui.lobby.vehiclePreview.bottomPanel.VPBottomPanel;
   import net.wg.gui.lobby.vehiclePreview.bottomPanel.VPBottomPanelEarlyAccess;
   import net.wg.gui.lobby.vehiclePreview.bottomPanel.VPBottomPanelOfferGift;
   import net.wg.gui.lobby.vehiclePreview.bottomPanel.VPBottomPanelTradeIn;
   import net.wg.gui.lobby.vehiclePreview.bottomPanel.VPBottomPanelWell;
   import net.wg.gui.lobby.vehiclePreview.bottomPanel.VPBottomPanelWotPlus;
   import net.wg.gui.lobby.vehiclePreview.data.VPPageVO;
   import net.wg.gui.lobby.vehiclePreview.infoPanel.VPInfoPanel;
   import net.wg.gui.lobby.vehiclePreview.topPanel.IVPTopPanel;
   import net.wg.gui.lobby.vehiclePreview.topPanel.VPTopPanelTabs;
   import net.wg.infrastructure.base.meta.IVehiclePreviewMeta;
   import net.wg.infrastructure.base.meta.impl.VehiclePreviewMeta;
   import net.wg.infrastructure.interfaces.IDAAPIModule;
   import net.wg.infrastructure.managers.ITooltipMgr;
   import net.wg.utils.IStageSizeDependComponent;
   import net.wg.utils.StageSizeBoundaries;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.data.DataProvider;
   import scaleform.clik.events.ButtonEvent;
   import scaleform.clik.events.InputEvent;
   import scaleform.clik.motion.Tween;
   
   public class VehiclePreviewPage extends VehiclePreviewMeta implements IVehiclePreviewMeta, IStageSizeDependComponent
   {
      
      private static const INTRO_FLAG:String = "showIntro";
      
      private static const BIG_OFFSET:int = 50;
      
      private static const SMALL_OFFSET:int = BIG_OFFSET >> 1;
      
      private static const BIG_PANELS_VERTICAL_OFFSET:int = 90;
      
      private static const SMALL_PANELS_VERTICAL_OFFSET:int = 84;
      
      private static const FADE_ANIMATION_DURATION:int = 200;
      
      private static const FADE_ANIMATION_DELAY:int = 150;
      
      private static const INTRO_ANIMATION_DURATION:int = 500;
      
      private static const INTRO_ANIMATION_DELAY:int = 200;
      
      private static const SHOW_SLOTS_ALPHA:Number = 1;
      
      private static const HIDE_SLOTS_ALPHA:Number = 0;
      
      private static const NAVIGATION_BUTTONS_OFFSET:int = 10;
      
      private static const VEH_DESCRIPTION_H_OFFSET:int = 2;
      
      private static const VEH_PARAMS_H_OFFSET:int = 35;
      
      private static const VEH_PARAMS_V_OFFSET:int = 20;
      
      private static const INFO_PANEL_V_OFFSET:int = -70;
      
      private static const LEFT_OFFSET:int = 8;
       
      
      public var closeButton:ISoundButtonEx;
      
      public var backButton:IBackButton;
      
      public var leftBackground:MovieClip;
      
      public var rightBackground:MovieClip;
      
      public var topPanel:IVPTopPanel;
      
      public var bottomPanel:IVPBottomPanel;
      
      public var messengerBg:Sprite;
      
      public var fadingPanels:MovieClip = null;
      
      public var background:Sprite;
      
      public var compareBlock:CompareBlock;
      
      public var listDesc:TextField = null;
      
      private var _toolTipMgr:ITooltipMgr;
      
      private var _stage:Stage;
      
      private var _infoPanel:VPInfoPanel = null;
      
      private var _vehParams:VehicleParameters = null;
      
      private var _tweens:Vector.<Tween>;
      
      private var _offset:int = 50;
      
      private var _panelVerticalOffset:int = 90;
      
      private var _isIntroFinished:Boolean;
      
      public function VehiclePreviewPage()
      {
         this._toolTipMgr = App.toolTipMgr;
         this._stage = App.stage;
         super();
         this._vehParams = this.fadingPanels.vehParams;
         this._vehParams.addEventListener(Event.RESIZE,this.onVehParamsResizeHandler);
         this._infoPanel = this.fadingPanels.infoPanel;
         this.listDesc = this.fadingPanels.listDesc;
         this._tweens = new Vector.<Tween>(0);
      }
      
      override public function updateStage(param1:Number, param2:Number) : void
      {
         setSize(param1,param2);
      }
      
      override protected function onInitModalFocus(param1:InteractiveObject) : void
      {
         super.onInitModalFocus(param1);
         var _loc2_:Vector.<InteractiveObject> = new Vector.<InteractiveObject>(0);
         var _loc3_:int = 0;
         _loc2_.push(InteractiveObject(this.backButton));
         if(this.bottomPanel != null && this.bottomPanel.getBtn() != null)
         {
            _loc2_.push(InteractiveObject(this.bottomPanel.getBtn()));
            _loc3_ = 1;
         }
         _loc2_.push(InteractiveObject(this.compareBlock.addToCompareButton));
         _loc2_.push(InteractiveObject(this.closeButton));
         App.utils.commons.initTabIndex(_loc2_);
         setFocus(_loc2_[_loc3_]);
         _loc2_.splice(0,_loc2_.length);
      }
      
      override protected function setData(param1:VPPageVO) : void
      {
         this._infoPanel.setData(param1);
         this.closeButton.label = param1.closeBtnLabel;
         this.closeButton.visible = param1.showCloseBtn;
         this.backButton.label = param1.backBtnLabel;
         this.backButton.descrLabel = param1.backBtnDescrLabel;
         this.backButton.visible = param1.showBackButton;
         this.compareBlock.setData(param1);
         this.listDesc.htmlText = param1.listDesc;
         invalidateSize();
      }
      
      override protected function setTabsData(param1:DataProvider) : void
      {
         this._infoPanel.setTabsData(param1);
         invalidate(INTRO_FLAG);
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
         this.listDesc.autoSize = TextFieldAutoSize.RIGHT;
         this.listDesc.wordWrap = true;
         this.listDesc.multiline = true;
         this.listDesc.mouseWheelEnabled = this.listDesc.mouseEnabled = false;
         this.background.mouseEnabled = this.background.mouseChildren = false;
         this.backButton.addEventListener(ButtonEvent.CLICK,this.onBackBtnClickHandler);
         this.closeButton.addEventListener(ButtonEvent.CLICK,this.onCloseBtnClickHandler);
         this.compareBlock.alpha = 0;
         this.compareBlock.addEventListener(VehCompareEvent.ADD,this.onCompareBlockAddHandler);
         this._infoPanel.viewStack.addEventListener(ViewStackEvent.NEED_UPDATE,this.onStackViewNeedUpdateHandler);
         this._infoPanel.viewStack.addEventListener(ViewStackEvent.VIEW_CHANGED,this.onStackViewChangedHandler);
         this._infoPanel.addEventListener(TechTreeEvent.GO_TO_POST_PROGRESSION,this.onInfoPanelGoToPostProgressionhandler);
         this._infoPanel.alpha = 0;
         this._vehParams.bg.visible = false;
         this._vehParams.alpha = 0;
         registerFlashComponentS(this._vehParams,VEHPREVIEW_CONSTANTS.PARAMETERS_PY_ALIAS);
         App.stageSizeMgr.register(this);
      }
      
      override protected function onPopulate() : void
      {
         super.onPopulate();
         this._stage.dispatchEvent(new LobbyEvent(LobbyEvent.REGISTER_DRAGGING));
         App.gameInputMgr.setKeyHandler(Keyboard.ESCAPE,KeyboardEvent.KEY_DOWN,this.onEscapeKeyUpHandler,true);
         var _loc1_:String = this.getTopPanelAlias();
         if(_loc1_)
         {
            registerFlashComponentS(IDAAPIModule(this.topPanel),_loc1_);
            this.topPanel.addEventListener(Event.RESIZE,this.onTopPanelResizeHandler);
         }
         var _loc2_:String = this.getBottomPanelAlias();
         if(_loc2_)
         {
            registerFlashComponentS(IDAAPIModule(this.bottomPanel),_loc2_);
            this.bottomPanel.addEventListener(Event.RESIZE,this.onBottomPanelResizeHandler);
         }
         if(this.bottomPanel is VPBottomPanelWell)
         {
            setChildIndex(DisplayObject(this.bottomPanel),getChildIndex(this.fadingPanels));
         }
         if(this.bottomPanel != null)
         {
            this.bottomPanel.alpha = 0;
         }
      }
      
      override protected function onBeforeDispose() : void
      {
         this._infoPanel.viewStack.removeEventListener(ViewStackEvent.NEED_UPDATE,this.onStackViewNeedUpdateHandler);
         this._infoPanel.viewStack.removeEventListener(ViewStackEvent.VIEW_CHANGED,this.onStackViewChangedHandler);
         this._infoPanel.removeEventListener(TechTreeEvent.GO_TO_POST_PROGRESSION,this.onInfoPanelGoToPostProgressionhandler);
         this.compareBlock.removeEventListener(VehCompareEvent.ADD,this.onCompareBlockAddHandler);
         this.backButton.removeEventListener(ButtonEvent.CLICK,this.onBackBtnClickHandler);
         this.closeButton.removeEventListener(ButtonEvent.CLICK,this.onCloseBtnClickHandler);
         App.gameInputMgr.clearKeyHandler(Keyboard.ESCAPE,KeyboardEvent.KEY_DOWN,this.onEscapeKeyUpHandler);
         this._stage.dispatchEvent(new LobbyEvent(LobbyEvent.UNREGISTER_DRAGGING));
         this._stage.removeEventListener(LobbyEvent.DRAGGING_START,this.onDraggingStartHandler);
         this._stage.removeEventListener(LobbyEvent.DRAGGING_END,this.onDraggingEndHandler);
         super.onBeforeDispose();
      }
      
      override protected function onDispose() : void
      {
         App.stageSizeMgr.unregister(this);
         this.compareBlock.dispose();
         this.compareBlock = null;
         this.disposeTweens();
         this._tweens = null;
         this.backButton.dispose();
         this.backButton = null;
         this.closeButton.dispose();
         this.closeButton = null;
         this.leftBackground = null;
         this.rightBackground = null;
         this.messengerBg = null;
         if(this.topPanel != null)
         {
            this.topPanel.removeEventListener(Event.RESIZE,this.onTopPanelResizeHandler);
            this.topPanel = null;
         }
         if(this.bottomPanel != null)
         {
            this.bottomPanel.removeEventListener(Event.RESIZE,this.onBottomPanelResizeHandler);
            this.bottomPanel = null;
         }
         this._toolTipMgr = null;
         this._stage = null;
         this._vehParams.removeEventListener(Event.RESIZE,this.onVehParamsResizeHandler);
         this._vehParams = null;
         this._infoPanel = null;
         this.background = null;
         this.fadingPanels = null;
         this.listDesc = null;
         super.onDispose();
      }
      
      override protected function draw() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
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
            _loc1_ = 0;
            if(this.bottomPanel != null)
            {
               _loc1_ = this.bottomPanel.getTotalHeight();
            }
            _loc2_ = height - this._offset - _loc1_;
            this._vehParams.x = width - this._offset - this._vehParams.width + VEH_PARAMS_H_OFFSET ^ 0;
            this._vehParams.y = this._offset + this._panelVerticalOffset + VEH_PARAMS_V_OFFSET;
            this._infoPanel.x = this._offset;
            this._infoPanel.y = this._offset + this._panelVerticalOffset + INFO_PANEL_V_OFFSET;
            this._vehParams.height = _loc2_ - this._vehParams.y - this.listDesc.height;
            this._infoPanel.height = _loc2_ - this._infoPanel.y;
            if(this.topPanel != null)
            {
               this.topPanel.x = width - this.topPanel.width >> 1;
            }
            if(this.bottomPanel != null)
            {
               this.bottomPanel.x = (width - this.bottomPanel.width >> 1) + LEFT_OFFSET;
               this.bottomPanel.y = height - this._offset - this.bottomPanel.height | 0;
            }
            this.compareBlock.x = width - this._offset - this.compareBlock.width | 0;
            this.compareBlock.y = this._offset + this._panelVerticalOffset;
            this.listDesc.x = width - this._offset - this.listDesc.width + VEH_DESCRIPTION_H_OFFSET ^ 0;
            this.listDesc.y = this._vehParams.y + this._vehParams.bg.height | 0;
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
      
      public function as_setBulletVisibility(param1:int, param2:Boolean) : void
      {
         if(this._infoPanel != null)
         {
            this._infoPanel.setBulletVisibility(param1,param2);
         }
      }
      
      public function setStateSizeBoundaries(param1:int, param2:int) : void
      {
         if(param2 <= StageSizeBoundaries.HEIGHT_900)
         {
            this._offset = SMALL_OFFSET;
            this._panelVerticalOffset = SMALL_PANELS_VERTICAL_OFFSET;
         }
         else
         {
            this._offset = BIG_OFFSET;
            this._panelVerticalOffset = BIG_PANELS_VERTICAL_OFFSET;
         }
         invalidateSize();
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
         if(this.bottomPanel is VPBottomPanel)
         {
            return VEHPREVIEW_CONSTANTS.BOTTOM_PANEL_PY_ALIAS;
         }
         if(this.bottomPanel is VPBottomPanelTradeIn)
         {
            return VEHPREVIEW_CONSTANTS.BOTTOM_PANEL_TRADE_IN_PY_ALIAS;
         }
         if(this.bottomPanel is VPBottomPanelOfferGift)
         {
            return VEHPREVIEW_CONSTANTS.BOTTOM_PANEL_OFFER_GIFT_PY_ALIAS;
         }
         if(this.bottomPanel is VPBottomPanelWotPlus)
         {
            return VEHPREVIEW_CONSTANTS.BOTTOM_PANEL_WOT_PLUS_LINKAGE;
         }
         if(this.bottomPanel is VPBottomPanelWell)
         {
            return VEHPREVIEW_CONSTANTS.BOTTOM_PANEL_WELL_PY_ALIAS;
         }
         if(this.bottomPanel is VPBottomPanelEarlyAccess)
         {
            return VEHPREVIEW_CONSTANTS.BOTTOM_PANEL_EARLY_ACCESS_PY_ALIAS;
         }
         return null;
      }
      
      private function hideTooltip() : void
      {
         this._toolTipMgr.hide();
      }
      
      private function startIntroAnimation() : void
      {
         this.disposeTweens();
         this._tweens.push(new Tween(INTRO_ANIMATION_DURATION,this._vehParams,{"alpha":1},{
            "delay":INTRO_ANIMATION_DELAY,
            "fastTransform":false
         }),new Tween(INTRO_ANIMATION_DURATION,this.compareBlock,{"alpha":1},{
            "delay":INTRO_ANIMATION_DELAY,
            "fastTransform":false
         }),new Tween(INTRO_ANIMATION_DURATION,this._infoPanel,{"alpha":1},{
            "delay":INTRO_ANIMATION_DELAY,
            "fastTransform":false
         }));
         if(this.topPanel != null)
         {
            this._tweens.push(new Tween(INTRO_ANIMATION_DURATION,this.topPanel,{"alpha":1},{
               "delay":INTRO_ANIMATION_DELAY,
               "fastTransform":false
            }));
         }
         if(this.bottomPanel != null)
         {
            this._tweens.push(new Tween(INTRO_ANIMATION_DURATION,this.bottomPanel,{"alpha":1},{
               "delay":INTRO_ANIMATION_DELAY,
               "fastTransform":false,
               "onComplete":this.onIntroCompleteCallback
            }));
         }
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
         this._stage.addEventListener(LobbyEvent.DRAGGING_START,this.onDraggingStartHandler);
         this._stage.addEventListener(LobbyEvent.DRAGGING_END,this.onDraggingEndHandler);
      }
      
      private function onFadingPanelsHide() : void
      {
         this._infoPanel.visible = false;
      }
      
      private function onFadingPanelsShow() : void
      {
         this._infoPanel.visible = true;
      }
      
      private function onInfoPanelGoToPostProgressionhandler(param1:TechTreeEvent) : void
      {
         onGoToPostProgressionClickS();
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
            this._tweens.push(new Tween(FADE_ANIMATION_DURATION,this.fadingPanels,{"alpha":SHOW_SLOTS_ALPHA},{
               "fastTransform":false,
               "onComplete":this.onFadingPanelsShow
            }),new Tween(FADE_ANIMATION_DURATION,this.compareBlock,{
               "alpha":SHOW_SLOTS_ALPHA,
               "visible":true
            },{"fastTransform":false}),new Tween(FADE_ANIMATION_DURATION,this.leftBackground,{"alpha":SHOW_SLOTS_ALPHA},{"fastTransform":false}),new Tween(FADE_ANIMATION_DURATION,this.rightBackground,{"alpha":SHOW_SLOTS_ALPHA},{"fastTransform":false}));
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
            "fastTransform":false,
            "onComplete":this.onFadingPanelsHide
         }),new Tween(FADE_ANIMATION_DURATION,this.compareBlock,{
            "alpha":HIDE_SLOTS_ALPHA,
            "visible":false
         },{
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
      
      private function onCompareBlockAddHandler(param1:VehCompareEvent) : void
      {
         onCompareClickS();
      }
      
      private function onStackViewChangedHandler(param1:ViewStackEvent) : void
      {
         onOpenInfoTabS(this._infoPanel.tabButtonBar.selectedIndex);
      }
      
      private function onStackViewNeedUpdateHandler(param1:ViewStackEvent) : void
      {
         registerFlashComponentS(IDAAPIModule(param1.view),param1.viewId);
      }
      
      private function onVehParamsResizeHandler(param1:Event) : void
      {
         invalidateSize();
      }
      
      private function onTopPanelResizeHandler(param1:Event) : void
      {
         invalidateSize();
      }
      
      private function onBottomPanelResizeHandler(param1:Event) : void
      {
         invalidateSize();
      }
   }
}
