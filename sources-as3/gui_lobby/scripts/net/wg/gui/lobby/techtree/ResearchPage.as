package net.wg.gui.lobby.techtree
{
   import flash.display.InteractiveObject;
   import flash.display.Sprite;
   import flash.events.KeyboardEvent;
   import flash.ui.Keyboard;
   import net.wg.data.constants.generated.NODE_STATE_FLAGS;
   import net.wg.data.constants.generated.VEHPREVIEW_CONSTANTS;
   import net.wg.gui.components.advanced.interfaces.IBackButton;
   import net.wg.gui.lobby.techtree.controls.BenefitsComponent;
   import net.wg.gui.lobby.techtree.controls.ResearchRootTitle;
   import net.wg.gui.lobby.techtree.data.ResearchPageVO;
   import net.wg.gui.lobby.techtree.data.ResearchRootVO;
   import net.wg.gui.lobby.techtree.data.state.NodeStateCollection;
   import net.wg.gui.lobby.techtree.data.vo.NodeData;
   import net.wg.gui.lobby.techtree.interfaces.IResearchPage;
   import net.wg.gui.lobby.techtree.sub.ResearchItems;
   import net.wg.gui.lobby.tradeIn.TradeOffWidget;
   import net.wg.infrastructure.base.meta.impl.ResearchMeta;
   import net.wg.infrastructure.events.FocusRequestEvent;
   import net.wg.infrastructure.interfaces.entity.IFocusContainer;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.events.ButtonEvent;
   import scaleform.clik.events.InputEvent;
   
   public class ResearchPage extends ResearchMeta implements IResearchPage
   {
      
      private static const RATIO_Y:int = 89;
      
      private static const RATIO_X:int = 40;
      
      private static const TOP_LEVEL_OFFSET:int = -168;
      
      private static const NEXT_LEVEL_OFFSET:int = 547;
      
      private static const MAX_NODES_ON_LEVEL:int = 6;
      
      private static const RESEARCH_ITEMS_CENTER_OFFSET_X:int = -252;
      
      private static const PREMIUM_LAYOUT_OFFSET_X:int = 150;
      
      private static const PREMIUM_LAYOUT_OFFSET_Y:int = 60;
      
      private static const PREMIUM_LAYOUT_OFFSET_SMALL_Y:int = 160;
      
      private static const PREMIUM_VIEW_COMPACT_WIDTH:int = 1600;
      
      private static const PREMIUM_VIEW_NOMINAL_WIDTH:int = 1920;
      
      private static const TITLE_CENTER_Y_OFFSET:int = -230;
      
      private static const TITLE_MIN_Y_VALUE:int = 80;
      
      private static const TITLE_SIZE_Y_FACTOR:int = 111;
      
      private static const BACK_BTN_X:int = 28;
      
      private static const SMALL_SIZE_BACK_BTN_X:int = 8;
       
      
      public var researchItems:ResearchItems = null;
      
      public var backButton:IBackButton = null;
      
      public var background:Sprite = null;
      
      public var title:ResearchRootTitle = null;
      
      public var footerBg:Sprite = null;
      
      private var _benefitsComponent:BenefitsComponent = null;
      
      public function ResearchPage()
      {
         super();
         _deferredDispose = true;
      }
      
      override public function updateStage(param1:Number, param2:Number) : void
      {
         super.updateStage(param1,param2);
         setViewSize(param1,param2);
         this.researchItems.setViewWidth(param1);
         invalidateSize();
      }
      
      override protected function setData(param1:ResearchPageVO) : void
      {
         this.backButton.label = param1.backBtnLabel;
         this.backButton.descrLabel = param1.backBtnDescrLabel;
         if(param1.isPremiumLayout && this._benefitsComponent == null)
         {
            this._benefitsComponent = new BenefitsComponent();
            this.addChild(this._benefitsComponent);
            this._benefitsComponent.setData(param1.benefitsData);
            invalidateSize();
         }
      }
      
      override protected function setRootData(param1:ResearchRootVO) : void
      {
         this.researchItems.setRootData(param1);
         this.title.setData(param1);
      }
      
      override protected function onBeforeDispose() : void
      {
         App.gameInputMgr.clearKeyHandler(Keyboard.ESCAPE,KeyboardEvent.KEY_DOWN,this.handleEscape);
         this.backButton.removeEventListener(ButtonEvent.CLICK,this.onBackBtnClickHandler);
         this.researchItems.removeEventListener(FocusRequestEvent.REQUEST_FOCUS,this.onResearchItemsRequestFocusHandler,false);
         NodeStateCollection.instance.dispose();
         super.onBeforeDispose();
      }
      
      override protected function onPopulate() : void
      {
         super.onPopulate();
         var _loc1_:TradeOffWidget = this.researchItems.tradeOffWidget;
         if(_loc1_ != null)
         {
            registerFlashComponentS(_loc1_,VEHPREVIEW_CONSTANTS.TRADE_OFF_WIDGET_ALIAS);
         }
      }
      
      override protected function onDispose() : void
      {
         if(this._benefitsComponent != null)
         {
            this.removeChild(this._benefitsComponent);
            this._benefitsComponent.dispose();
            this._benefitsComponent = null;
         }
         this.title.dispose();
         this.title = null;
         this.researchItems.dispose();
         this.researchItems = null;
         this.backButton.dispose();
         this.backButton = null;
         this.background = null;
         this.footerBg = null;
         super.onDispose();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.backButton.addEventListener(ButtonEvent.CLICK,this.onBackBtnClickHandler);
         this.researchItems.addEventListener(FocusRequestEvent.REQUEST_FOCUS,this.onResearchItemsRequestFocusHandler,false,0,true);
         this.researchItems.yRatio = RATIO_Y;
         this.researchItems.xRatio = RATIO_X;
         this.researchItems.topLevelOffset = TOP_LEVEL_OFFSET;
         this.researchItems.nextLevelOffset = NEXT_LEVEL_OFFSET;
         this.researchItems.maxNodesOnLevel = MAX_NODES_ON_LEVEL;
         this.researchItems.view = this;
         App.gameInputMgr.setKeyHandler(Keyboard.ESCAPE,KeyboardEvent.KEY_DOWN,this.handleEscape,true);
         requestResearchData();
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(InvalidationType.SIZE))
         {
            this.background.width = _width;
            this.background.height = _height;
            this.updateLayouts();
         }
      }
      
      override protected function onInitModalFocus(param1:InteractiveObject) : void
      {
         super.onInitModalFocus(param1);
         setFocus(this.researchItems);
      }
      
      override protected function setInstalledItems(param1:Array) : void
      {
         this.researchItems.setNodesStates(NODE_STATE_FLAGS.INSTALLED,param1);
      }
      
      override protected function setInventoryItems(param1:Array) : void
      {
         this.researchItems.setNodesStates(NODE_STATE_FLAGS.IN_INVENTORY,param1);
      }
      
      override protected function setNext2Unlock(param1:Array) : void
      {
         this.researchItems.setNodesStates(NODE_STATE_FLAGS.NEXT_2_UNLOCK,param1,NodeData.UNLOCK_PROPS_FIELD);
      }
      
      override protected function setNodeVehCompareData(param1:Array) : void
      {
         this.researchItems.setItemsField(param1,NodeData.VEH_COMPARE_TREE_NODE_DATA);
      }
      
      override protected function setNodesStates(param1:Number, param2:Array) : void
      {
         this.researchItems.setNodesStates(param1,param2);
      }
      
      override protected function setVehicleTypeXP(param1:Array) : void
      {
         this.researchItems.setVehicleTypeXP(param1);
      }
      
      public function as_setFreeXP(param1:Number) : void
      {
         this.researchItems.setFreeXP(param1);
      }
      
      public function as_setResearchItems(param1:String, param2:Object) : void
      {
         var _loc3_:NodeData = this.researchItems.invalidateNodesData(param1,param2);
         this.title.setNodeData(_loc3_);
      }
      
      public function as_setWalletStatus(param1:Object) : void
      {
         App.utils.voMgr.walletStatusVO.update(param1);
         this.researchItems.updateWalletStatus();
      }
      
      public function as_setXpInfoLinkage(param1:String) : void
      {
         this.researchItems.setXpInfoLinkage(param1);
      }
      
      protected function updateLayouts() : void
      {
         var _loc4_:int = 0;
         var _loc1_:int = width >> 1;
         var _loc2_:int = height >> 1;
         this.researchItems.y = _loc2_;
         this.researchItems.x = _loc1_ + RESEARCH_ITEMS_CENTER_OFFSET_X;
         this.title.x = _loc1_;
         var _loc3_:uint = _loc2_ + TITLE_CENTER_Y_OFFSET >> 1;
         this.title.y = _loc3_ > TITLE_MIN_Y_VALUE ? Number(_loc3_) : Number(TITLE_MIN_Y_VALUE);
         this.title.isSmallSized = _loc3_ < TITLE_SIZE_Y_FACTOR;
         if(this._benefitsComponent != null)
         {
            this._benefitsComponent.compact = width < PREMIUM_VIEW_COMPACT_WIDTH;
            _loc4_ = !!this._benefitsComponent.compact ? int(PREMIUM_LAYOUT_OFFSET_SMALL_Y) : int(PREMIUM_LAYOUT_OFFSET_Y);
            this._benefitsComponent.y = _loc2_ - _loc4_;
            this._benefitsComponent.x = _loc1_ + PREMIUM_LAYOUT_OFFSET_X * width / PREMIUM_VIEW_NOMINAL_WIDTH | 0;
         }
         this.footerBg.width = _width;
         this.footerBg.y = _height;
         this.backButton.x = App.appWidth >= 1366 ? Number(BACK_BTN_X) : Number(SMALL_SIZE_BACK_BTN_X);
      }
      
      private function onBackBtnClickHandler(param1:ButtonEvent) : void
      {
         exitFromResearchS();
      }
      
      private function handleEscape(param1:InputEvent) : void
      {
         exitFromResearchS();
      }
      
      private function onResearchItemsRequestFocusHandler(param1:FocusRequestEvent) : void
      {
         setFocus(IFocusContainer(param1.focusContainer).getComponentForFocus());
      }
   }
}
