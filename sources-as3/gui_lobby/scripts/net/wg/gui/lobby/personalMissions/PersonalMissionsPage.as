package net.wg.gui.lobby.personalMissions
{
   import fl.motion.easing.Linear;
   import flash.display.DisplayObject;
   import flash.display.InteractiveObject;
   import flash.events.Event;
   import flash.geom.Point;
   import net.wg.data.constants.Linkages;
   import net.wg.data.constants.Values;
   import net.wg.data.constants.generated.PERSONAL_MISSIONS_ALIASES;
   import net.wg.gui.components.advanced.ViewHeader;
   import net.wg.gui.components.advanced.events.ViewHeaderEvent;
   import net.wg.gui.lobby.personalMissions.components.PersonalMissionsMapView;
   import net.wg.gui.lobby.personalMissions.components.interfaces.IAwardSheetPopup;
   import net.wg.gui.lobby.personalMissions.components.interfaces.IChainsPanel;
   import net.wg.gui.lobby.personalMissions.components.operationsHeader.OperationTitle;
   import net.wg.gui.lobby.personalMissions.components.operationsHeader.OperationsHeader;
   import net.wg.gui.lobby.personalMissions.components.popupComponents.FreeSheetObtainedPopup;
   import net.wg.gui.lobby.personalMissions.components.statusFooter.StatusFooter;
   import net.wg.gui.lobby.personalMissions.data.ChainsPanelVO;
   import net.wg.gui.lobby.personalMissions.data.OperationsHeaderVO;
   import net.wg.gui.lobby.personalMissions.data.StatusFooterVO;
   import net.wg.gui.lobby.personalMissions.events.ChainEvent;
   import net.wg.gui.lobby.personalMissions.events.OperationEvent;
   import net.wg.gui.lobby.personalMissions.events.StatusFooterEvent;
   import net.wg.infrastructure.base.meta.IPersonalMissionsPageMeta;
   import net.wg.infrastructure.base.meta.impl.PersonalMissionsPageMeta;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.motion.Tween;
   
   public class PersonalMissionsPage extends PersonalMissionsPageMeta implements IPersonalMissionsPageMeta
   {
      
      private static const CHAINS_PANEL_LEFT_MIN:int = 20;
      
      private static const CHAINS_PANEL_LEFT_MAX:int = 150;
      
      private static const SCREEN_WIDTH_MIN:int = 1024;
      
      private static const SCREEN_WIDTH_MAX:int = 1920;
      
      private static const BG_FADE_TIME:int = 500;
      
      private static const AWARD_SHEET_OFFSET:int = 20;
      
      private static const AWARD_SHEET_POS_DIV:Number = 2.1;
      
      private static const COMPACT_HEIGHT:uint = 712;
      
      private static const OPERATION_TITLE_COMPACT_OFFSET:uint = 10;
       
      
      public var header:ViewHeader;
      
      public var operationsHeader:OperationsHeader;
      
      public var operationTitle:OperationTitle;
      
      public var bgShadow:DisplayObject;
      
      public var chainsPanel:IChainsPanel;
      
      public var map:PersonalMissionsMapView;
      
      public var statusFooter:StatusFooter;
      
      private var _awardSheetPopup:IAwardSheetPopup = null;
      
      private var _bgFadeTween:Tween;
      
      private var _showFreeSheetPopover:Boolean = false;
      
      private var _isCompactLayout:Boolean = false;
      
      public function PersonalMissionsPage()
      {
         super();
      }
      
      override public function updateStage(param1:Number, param2:Number) : void
      {
         super.updateStage(param1,param2);
         this.operationTitle.updateStage(param1,param2);
         this._isCompactLayout = param2 < COMPACT_HEIGHT;
         invalidateSize();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.chainsPanel.addEventListener(ChainEvent.CHAIN_CHANGED,this.onChainsPanelChainChangedHandler);
         this.chainsPanel.addEventListener(ChainEvent.CHAIN_INIT_COMPLETED,this.onChainsPanelChainInitCompletedHandler);
         this.operationsHeader.operationsContainer.addEventListener(ChainEvent.CHAIN_CHANGED,this.onOperationsHeaderChainChangedHandler);
         this.header.addEventListener(ViewHeaderEvent.BACK_BTN_CLICK,this.onHeaderBackBtnClickHandler);
         this.operationsHeader.addEventListener(OperationEvent.SIZE_CHANGED,this.onOperationHeaderSizeChangedHandler);
         this.operationTitle.addEventListener(OperationEvent.AWARDS_BTN_CLICK,this.onOperationInfoAwardsBtnClickHandler);
         this.statusFooter.addEventListener(StatusFooterEvent.SKIP_TASK,this.onStatusPanelSkipTaskHandler);
         this.map.addEventListener(ChainEvent.CHAIN_CHANGED,this.onMapChainChangedHandler);
      }
      
      override protected function setHeaderData(param1:OperationsHeaderVO) : void
      {
         this.header.backBtnLabel = param1.backBtnLabel;
         this.header.backBtnDescription = param1.backBtnDescrLabel;
         this.operationsHeader.update(param1);
         this.operationTitle.update(param1.operationTitle);
      }
      
      override protected function setStatusData(param1:StatusFooterVO) : void
      {
         this.statusFooter.update(param1);
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(InvalidationType.SIZE))
         {
            this.map.width = width;
            this.map.height = height;
            this.statusFooter.y = _height - this.statusFooter.height | 0;
            this.statusFooter.x = _width - this.statusFooter.width >> 1;
            this.operationsHeader.width = width;
            this.header.width = width;
            this.operationTitle.x = width - this.operationTitle.width >> 1;
            this.operationTitle.y = this.operationsHeader.componentVisibleHeight;
            if(this._isCompactLayout)
            {
               this.operationTitle.y -= OPERATION_TITLE_COMPACT_OFFSET;
            }
            this.layoutChainsPanel();
            if(this._awardSheetPopup)
            {
               this._awardSheetPopup.x = width - this._awardSheetPopup.width >> 1;
               this._awardSheetPopup.y = (height + this.operationsHeader.componentVisibleHeight - this._awardSheetPopup.height) / AWARD_SHEET_POS_DIV + AWARD_SHEET_OFFSET >> 0;
               this.bgShadow.width = width;
               this.bgShadow.height = height;
            }
         }
      }
      
      override protected function updateSideBarData(param1:ChainsPanelVO) : void
      {
         this.chainsPanel.update(param1);
      }
      
      override protected function onDispose() : void
      {
         this.hideAwardSheetPopup();
         this.operationTitle.removeEventListener(OperationEvent.AWARDS_BTN_CLICK,this.onOperationInfoAwardsBtnClickHandler);
         if(this._bgFadeTween)
         {
            this._bgFadeTween.dispose();
            this._bgFadeTween = null;
         }
         this.header.removeEventListener(ViewHeaderEvent.BACK_BTN_CLICK,this.onHeaderBackBtnClickHandler);
         this.header.dispose();
         this.header = null;
         this.map.removeEventListener(ChainEvent.CHAIN_CHANGED,this.onMapChainChangedHandler);
         this.map = null;
         this.operationsHeader.removeEventListener(OperationEvent.SIZE_CHANGED,this.onOperationHeaderSizeChangedHandler);
         this.operationsHeader.operationsContainer.removeEventListener(ChainEvent.CHAIN_CHANGED,this.onOperationsHeaderChainChangedHandler);
         this.operationsHeader.dispose();
         this.operationsHeader = null;
         this.operationTitle.dispose();
         this.operationTitle = null;
         this.chainsPanel.removeEventListener(ChainEvent.CHAIN_CHANGED,this.onChainsPanelChainChangedHandler);
         this.chainsPanel.removeEventListener(ChainEvent.CHAIN_INIT_COMPLETED,this.onChainsPanelChainInitCompletedHandler);
         this.chainsPanel.dispose();
         this.chainsPanel = null;
         this.statusFooter.removeEventListener(StatusFooterEvent.SKIP_TASK,this.onStatusPanelSkipTaskHandler);
         this.statusFooter.dispose();
         this.statusFooter = null;
         this.bgShadow = null;
         super.onDispose();
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         this.bgShadow.visible = false;
      }
      
      override protected function onEscapeKeyDown() : void
      {
         onBackBtnClickS();
      }
      
      public function as_hideAwardSheetObtainedPopup() : void
      {
         this.hideAwardSheetPopup();
      }
      
      public function as_initView(param1:int, param2:int) : void
      {
         this.map.init(param1);
         registerFlashComponentS(this.map,PERSONAL_MISSIONS_ALIASES.PERSONAL_MISSIONS_MAP_VIEW_ALIAS);
         this.chainsPanel.init(param2);
      }
      
      public function as_reInitView(param1:int, param2:int) : void
      {
         this.map.reinit(param1);
         this.chainsPanel.init(param2);
      }
      
      public function as_setContentVisible(param1:Boolean) : void
      {
         this.header.visible = param1;
         this.operationsHeader.visible = param1;
         this.operationTitle.visible = param1;
         this.chainsPanel.visible = param1;
         this.statusFooter.visible = param1;
         this.map.showHideContent(param1);
      }
      
      public function as_setSelectedBranchIndex(param1:int) : void
      {
         this.chainsPanel.selectChain(param1);
      }
      
      public function as_showAwardsPopoverForTutor() : void
      {
         this._showFreeSheetPopover = true;
      }
      
      public function as_showFirstAwardSheetObtainedPopup(param1:Boolean, param2:Object) : void
      {
         this.showAwardSheetPopup(param1,Linkages.FREE_SHEET_OBTAINED_POPUP_UI,param2);
      }
      
      public function as_showFourAwardSheetsObtainedPopup(param1:Boolean, param2:Object) : void
      {
         this.showAwardSheetPopup(param1,Linkages.FOUR_FREE_SHEETS_OBTAINED_POPUP_UI,param2);
      }
      
      public function hideAwardSheetPopup() : void
      {
         if(this._awardSheetPopup)
         {
            this._awardSheetPopup.removeEventListener(Event.CLOSE,this.onAwardSheetPopupCloseHandler);
            this._awardSheetPopup.removeEventListener(Event.COMPLETE,this.onAwardSheetPopupCompleteHandler);
            removeChild(DisplayObject(this._awardSheetPopup));
            this._awardSheetPopup.dispose();
            this._awardSheetPopup = null;
            this.bgShadow.visible = false;
         }
      }
      
      private function showAwardSheetPopup(param1:Boolean, param2:String, param3:Object = null) : void
      {
         this.hideAwardSheetPopup();
         this._awardSheetPopup = App.utils.classFactory.getComponent(param2,IAwardSheetPopup);
         addChildAt(DisplayObject(this._awardSheetPopup),getChildIndex(this.bgShadow) + 1);
         this._awardSheetPopup.addEventListener(Event.COMPLETE,this.onAwardSheetPopupCompleteHandler);
         this._awardSheetPopup.addEventListener(Event.CLOSE,this.onAwardSheetPopupCloseHandler);
         this._awardSheetPopup.init(param1,param3);
         setFocus(InteractiveObject(this._awardSheetPopup));
         this.bgShadow.alpha = 1;
         this.bgShadow.visible = true;
         invalidateSize();
      }
      
      private function layoutChainsPanel() : void
      {
         var _loc1_:int = 0;
         if(width <= SCREEN_WIDTH_MIN)
         {
            _loc1_ = CHAINS_PANEL_LEFT_MIN;
         }
         else if(width >= SCREEN_WIDTH_MAX)
         {
            _loc1_ = CHAINS_PANEL_LEFT_MAX;
         }
         else
         {
            _loc1_ = CHAINS_PANEL_LEFT_MIN + (width - SCREEN_WIDTH_MIN) / (SCREEN_WIDTH_MAX - SCREEN_WIDTH_MIN) * (CHAINS_PANEL_LEFT_MAX - CHAINS_PANEL_LEFT_MIN);
         }
         this.chainsPanel.x = _loc1_;
         this.chainsPanel.y = (height - this.operationsHeader.componentVisibleHeight - this.statusFooter.height - this.chainsPanel.getPanelHeight() >> 1) + this.operationsHeader.componentVisibleHeight | 0;
      }
      
      private function bgFadeComplete() : void
      {
         this.bgShadow.visible = false;
      }
      
      private function doBarClick(param1:int, param2:Number) : void
      {
         if(param1 != Values.DEFAULT_INT && param2 != Values.DEFAULT_INT)
         {
            onBarClickS(param1,param2);
         }
      }
      
      override public function get isModal() : Boolean
      {
         return true;
      }
      
      private function onAwardSheetPopupCloseHandler(param1:Event) : void
      {
         onTutorialAcceptBtnClickedS();
      }
      
      private function onMapChainChangedHandler(param1:ChainEvent) : void
      {
         this.doBarClick(param1.btnIdx,this.operationsHeader.operationsContainer.selectedID);
      }
      
      private function onAwardSheetPopupCompleteHandler(param1:Event) : void
      {
         var _loc2_:Point = null;
         if(this._bgFadeTween)
         {
            this._bgFadeTween.dispose();
         }
         this._bgFadeTween = new Tween(BG_FADE_TIME,this.bgShadow,{"alpha":0},{
            "paused":false,
            "ease":Linear.easeOut,
            "onComplete":this.bgFadeComplete
         });
         if(this._awardSheetPopup is FreeSheetObtainedPopup)
         {
            _loc2_ = this.statusFooter.localToGlobal(new Point(this.statusFooter.sheetsBlock.x,this.statusFooter.sheetsBlock.y));
            FreeSheetObtainedPopup(this._awardSheetPopup).setAwardSheetDestPosition(_loc2_);
         }
         if(this._showFreeSheetPopover)
         {
            this._showFreeSheetPopover = false;
            this.statusFooter.showFreeSheetPopoverForTutor();
         }
      }
      
      private function onOperationHeaderSizeChangedHandler(param1:OperationEvent) : void
      {
         this.layoutChainsPanel();
      }
      
      private function onOperationsHeaderChainChangedHandler(param1:ChainEvent) : void
      {
         this.doBarClick(this.chainsPanel.getSelectedChainID(),param1.btnIdx);
      }
      
      private function onChainsPanelChainChangedHandler(param1:ChainEvent) : void
      {
         this.doBarClick(param1.btnIdx,this.operationsHeader.operationsContainer.selectedID);
      }
      
      private function onChainsPanelChainInitCompletedHandler(param1:ChainEvent) : void
      {
         this.layoutChainsPanel();
      }
      
      private function onHeaderBackBtnClickHandler(param1:ViewHeaderEvent) : void
      {
         onBackBtnClickS();
      }
      
      private function onStatusPanelSkipTaskHandler(param1:StatusFooterEvent) : void
      {
         onSkipTaskClickS();
      }
      
      private function onOperationInfoAwardsBtnClickHandler(param1:OperationEvent) : void
      {
         showAwardsS();
      }
   }
}
