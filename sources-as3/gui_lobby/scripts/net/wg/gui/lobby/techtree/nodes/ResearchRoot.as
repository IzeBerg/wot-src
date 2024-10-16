package net.wg.gui.lobby.techtree.nodes
{
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import net.wg.data.constants.Linkages;
   import net.wg.data.constants.UniversalBtnStylesConst;
   import net.wg.data.constants.Values;
   import net.wg.data.constants.generated.NODE_STATE_FLAGS;
   import net.wg.data.constants.generated.TOOLTIPS_CONSTANTS;
   import net.wg.data.managers.ITooltipProps;
   import net.wg.data.managers.impl.ToolTipParams;
   import net.wg.gui.components.controls.VO.ItemPriceVO;
   import net.wg.gui.components.controls.price.CompoundPrice;
   import net.wg.gui.components.controls.universalBtn.UniversalBtn;
   import net.wg.gui.lobby.components.CollectibleStatus;
   import net.wg.gui.lobby.components.VehicleButton;
   import net.wg.gui.lobby.techtree.TechTreeEvent;
   import net.wg.gui.lobby.techtree.constants.ActionName;
   import net.wg.gui.lobby.techtree.constants.ColorIndex;
   import net.wg.gui.lobby.techtree.constants.NodeEntityType;
   import net.wg.gui.lobby.techtree.constants.NodeRendererState;
   import net.wg.gui.lobby.techtree.controls.BlueprintBar;
   import net.wg.gui.lobby.techtree.controls.DiscountBanner;
   import net.wg.gui.lobby.techtree.controls.EarlyAccessButton;
   import net.wg.gui.lobby.techtree.controls.EarlyAccessStatus;
   import net.wg.gui.lobby.techtree.controls.ExperienceBlock;
   import net.wg.gui.lobby.techtree.data.ResearchRootVO;
   import net.wg.gui.lobby.techtree.data.state.NodeStateCollection;
   import net.wg.gui.lobby.techtree.data.state.StateProperties;
   import net.wg.gui.lobby.techtree.data.vo.NodeData;
   import net.wg.gui.lobby.techtree.interfaces.INodesContainer;
   import net.wg.gui.lobby.techtree.interfaces.IRenderer;
   import net.wg.gui.lobby.techtree.interfaces.IResearchContainer;
   import net.wg.gui.lobby.tradeIn.TradeOffWidget;
   import net.wg.infrastructure.base.UIComponentEx;
   import net.wg.infrastructure.interfaces.ITutorialCustomComponent;
   import net.wg.infrastructure.managers.ITooltipMgr;
   import net.wg.infrastructure.managers.counter.CounterManager;
   import net.wg.infrastructure.managers.counter.CounterProps;
   import net.wg.utils.IClassFactory;
   import net.wg.utils.ICounterManager;
   import net.wg.utils.IUniversalBtnStyles;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.events.ButtonEvent;
   import scaleform.gfx.MouseEventEx;
   
   public class ResearchRoot extends UIComponentEx implements IRenderer, ITutorialCustomComponent
   {
      
      public static const NORMAL_SIZE:String = VehicleButton.MEDIUM_SIZE;
      
      public static const SMALL_SIZE:String = VehicleButton.SMALL_SIZE;
      
      public static const LARGE_SIZE:String = VehicleButton.LARGE_SIZE;
      
      private static const LINES_AND_ARROWS_NAME:String = "linesAndArrows";
      
      private static const MATRIX_POSITION:Object = {
         "row":0,
         "column":0
      };
      
      private static const BANNER_Y_GAP:int = 40;
      
      private static const ACTION_BUTTON_Y_GAP:int = 8;
      
      private static const BLUEPRINT_BAR_Y_GAP:int = 12;
      
      private static const EXPERIENCE_Y_GAP:int = 10;
      
      private static const SMALL_VEHICLE_BOTTOM_Y_GAP:int = 10;
      
      private static const COLLECTIBLE_STATUS_Y_GAP:int = 6;
      
      private static const TRADE_OFF_WIDGET_OFFSET:int = 8;
      
      private static const TRADE_OFF_WIDGET_DO_INTERNAL_X_SHIFT:int = -30;
      
      private static const CHANGE_NATION_DISABLE_ICON_ALPHA:Number = 0.5;
      
      private static const COUNTER_PROPS:CounterProps = new CounterProps(3,-1);
      
      private static const EARLY_ACCESS_COINS_TF_OFFSET:int = -4;
      
      private static const EARLY_ACCESS_COIN_ID:String = "eaCoin";
      
      private static const EARLY_ACCESS_SIMPLE_TOOLTIP_MAX_WIDTH:int = 300;
      
      private static const DELIMETER:String = " / ";
       
      
      public var price:CompoundPrice = null;
      
      public var actionButton:UniversalBtn = null;
      
      public var vehicleButton:VehicleButton = null;
      
      public var discountBanner:DiscountBanner = null;
      
      public var blueprintBar:BlueprintBar = null;
      
      public var tradeOffWidget:TradeOffWidget;
      
      public var collectibleStatus:CollectibleStatus = null;
      
      public var earlyAccessQuestsButton:EarlyAccessButton = null;
      
      public var earlyAccessStatus:EarlyAccessStatus = null;
      
      public var earlyAccessCoinsTF:TextField = null;
      
      public var earlyAccessLock:MovieClip = null;
      
      private var _nodeData:NodeData = null;
      
      private var _nodeState:String = "locked";
      
      private var _owner:IResearchContainer = null;
      
      private var _action:String = "unlock";
      
      private var _actionEnabled:Boolean = false;
      
      private var _actionAvailable:Boolean = false;
      
      private var _data:ResearchRootVO = null;
      
      private var _size:String = "large_";
      
      private var _experienceBlock:ExperienceBlock = null;
      
      private var _xpBlockLinkage:String = "";
      
      private var _rentBtn:UniversalBtn = null;
      
      private var _hangarBtn:UniversalBtn = null;
      
      private var _changeNationBtn:UniversalBtn = null;
      
      private var _classFactory:IClassFactory;
      
      private var _universalBtnStyles:IUniversalBtnStyles;
      
      private var _internalXShift:int = 0;
      
      private var _counterManager:ICounterManager;
      
      private var _tooltipMgr:ITooltipMgr;
      
      public function ResearchRoot()
      {
         this._classFactory = App.utils.classFactory;
         this._universalBtnStyles = App.utils.universalBtnStyles;
         this._counterManager = App.utils.counterManager;
         this._tooltipMgr = App.toolTipMgr;
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         if(isReadyForTutorialByDefault())
         {
            tutorialFunctionPointer(this);
         }
         mouseEnabled = false;
         mouseChildren = true;
         this.discountBanner.mouseEnabled = this.discountBanner.mouseChildren = false;
         this.blueprintBar.addEventListener(ButtonEvent.CLICK,this.onBlueprintBarClickHandler,false,0,true);
         this.price.bigFonts = true;
         this.price.actionMode = CompoundPrice.ACTION_MODE_DISABLED;
         this.price.itemsDirection = CompoundPrice.DIRECTION_RIGHT;
         this.price.oldPriceVisible = true;
         this.price.oldPriceAlign = CompoundPrice.OLD_PRICE_ALIGN_LEFT;
         this.actionButton.useHtmlText = true;
         this.actionButton.mouseEnabledOnDisabled = true;
         this.actionButton.addEventListener(ButtonEvent.CLICK,this.onActionButtonClickHandler,false,0,true);
         this.actionButton.addEventListener(MouseEvent.ROLL_OVER,this.onButtonRollOverHandler,false,0,true);
         this.actionButton.addEventListener(MouseEvent.ROLL_OUT,this.onButtonRollOutHandler,false,0,true);
         this.earlyAccessQuestsButton.mouseEnabledOnDisabled = true;
         this.earlyAccessQuestsButton.addEventListener(ButtonEvent.CLICK,this.onActionButtonClickHandler,false,0,true);
         this.earlyAccessQuestsButton.addEventListener(MouseEvent.ROLL_OVER,this.onButtonRollOverHandler,false,0,true);
         this.earlyAccessQuestsButton.addEventListener(MouseEvent.ROLL_OUT,this.onButtonRollOutHandler,false,0,true);
         this.earlyAccessStatus.addEventListener(MouseEvent.ROLL_OVER,this.onButtonRollOverHandler,false,0,true);
         this.earlyAccessStatus.addEventListener(MouseEvent.ROLL_OUT,this.onButtonRollOutHandler,false,0,true);
         this.earlyAccessLock.addEventListener(MouseEvent.ROLL_OVER,this.onButtonRollOverHandler,false,0,true);
         this.earlyAccessLock.addEventListener(MouseEvent.ROLL_OUT,this.onButtonRollOutHandler,false,0,true);
         this.earlyAccessCoinsTF.autoSize = TextFieldAutoSize.LEFT;
      }
      
      override protected function onDispose() : void
      {
         this._nodeData = null;
         this._data = null;
         this.tradeOffWidget = null;
         this.collectibleStatus.dispose();
         this.collectibleStatus = null;
         this.vehicleButton.dispose();
         this.vehicleButton = null;
         this.blueprintBar.removeEventListener(ButtonEvent.CLICK,this.onBlueprintBarClickHandler);
         this.blueprintBar.dispose();
         this.blueprintBar = null;
         this.actionButton.removeEventListener(ButtonEvent.CLICK,this.onActionButtonClickHandler);
         this.actionButton.removeEventListener(MouseEvent.ROLL_OVER,this.onButtonRollOverHandler);
         this.actionButton.removeEventListener(MouseEvent.ROLL_OUT,this.onButtonRollOutHandler);
         this.actionButton.dispose();
         this.actionButton = null;
         this.earlyAccessQuestsButton.removeEventListener(ButtonEvent.CLICK,this.onActionButtonClickHandler);
         this.earlyAccessQuestsButton.removeEventListener(MouseEvent.ROLL_OVER,this.onButtonRollOverHandler);
         this.earlyAccessQuestsButton.removeEventListener(MouseEvent.ROLL_OUT,this.onButtonRollOutHandler);
         this.earlyAccessQuestsButton.dispose();
         this.earlyAccessQuestsButton = null;
         this.earlyAccessStatus.removeEventListener(MouseEvent.ROLL_OVER,this.onButtonRollOverHandler);
         this.earlyAccessStatus.removeEventListener(MouseEvent.ROLL_OUT,this.onButtonRollOutHandler);
         this.earlyAccessStatus.dispose();
         this.earlyAccessStatus = null;
         this.earlyAccessCoinsTF = null;
         this.earlyAccessLock.removeEventListener(MouseEvent.ROLL_OVER,this.onButtonRollOverHandler);
         this.earlyAccessLock.removeEventListener(MouseEvent.ROLL_OUT,this.onButtonRollOutHandler);
         this.earlyAccessLock = null;
         this.price.dispose();
         this.price = null;
         if(this._experienceBlock)
         {
            this.removeChild(this._experienceBlock);
            this._experienceBlock.dispose();
            this._experienceBlock = null;
         }
         this._rentBtn = this.setupOrRemoveExtraBtn(this._rentBtn,false);
         this._hangarBtn = this.setupOrRemoveExtraBtn(this._hangarBtn,false);
         if(this._changeNationBtn)
         {
            this._counterManager.removeCounter(this._changeNationBtn);
         }
         this._changeNationBtn = this.setupOrRemoveExtraBtn(this._changeNationBtn,false);
         this.discountBanner.dispose();
         this.discountBanner = null;
         this._owner = null;
         this._classFactory = null;
         this._universalBtnStyles = null;
         this._counterManager = null;
         this._tooltipMgr = null;
         super.onDispose();
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(this._nodeData && this._data && isInvalid(InvalidationType.DATA))
         {
            this.populateUI();
            invalidateLayout();
         }
         if(isInvalid(InvalidationType.LAYOUT))
         {
            this.updateLayout();
         }
      }
      
      public function canHaveBlueprint() : Boolean
      {
         return this._nodeData != null && (this._nodeData.state & NODE_STATE_FLAGS.BLUEPRINT) > 0;
      }
      
      public function canPlaySound(param1:String) : Boolean
      {
         return this.enabled;
      }
      
      public function cleanUp() : void
      {
      }
      
      public function generatedUnstoppableEvents() : Boolean
      {
         return true;
      }
      
      public function getActualWidth() : Number
      {
         return actualWidth;
      }
      
      public function getColorIndex(param1:IRenderer = null) : uint
      {
         var _loc2_:uint = ColorIndex.LOCKED;
         if(param1 && param1.isElite() || this.isPremium() || this.isElite() && this.isUnlocked())
         {
            _loc2_ = ColorIndex.PREMIUM;
         }
         else if(this.isUnlocked() && (param1 == null || param1.isUnlocked()))
         {
            _loc2_ = ColorIndex.UNLOCKED;
         }
         else if(param1 && param1.isUnlocked() && this.isNext2Unlock())
         {
            _loc2_ = ColorIndex.UNLOCKED;
         }
         return _loc2_;
      }
      
      public function getDisplayInfo() : Object
      {
         return Boolean(this._nodeData) ? this._nodeData.displayInfo : null;
      }
      
      public function getEarnedXP() : Number
      {
         return Boolean(this._nodeData) ? Number(this._nodeData.earnedXP) : Number(0);
      }
      
      public function getGraphicsName() : String
      {
         return LINES_AND_ARROWS_NAME;
      }
      
      public function getID() : uint
      {
         return Boolean(this._nodeData) ? uint(this._nodeData.id) : uint(0);
      }
      
      public function getIconPath() : String
      {
         return Boolean(this._nodeData) ? this._nodeData.shopIconPath : Values.EMPTY_STR;
      }
      
      public function getInX() : Number
      {
         return x - (this.vehicleButton.contentWidth >> 1);
      }
      
      public function getItemName() : String
      {
         return Boolean(this._nodeData) ? this._nodeData.nameString : Values.EMPTY_STR;
      }
      
      public function getItemType() : String
      {
         return Boolean(this._nodeData) ? this._nodeData.primaryClassName : Values.EMPTY_STR;
      }
      
      public function getLevel() : int
      {
         return Boolean(this._nodeData) ? int(this._nodeData.level) : int(0);
      }
      
      public function getNodeData() : NodeData
      {
         return this._nodeData;
      }
      
      public function getOutX() : Number
      {
         return x - this._internalXShift + (this.vehicleButton.contentWidth >> 1);
      }
      
      public function getRatioY() : Number
      {
         return this.vehicleButton.contentHeight >> 1;
      }
      
      public function getSoundId() : String
      {
         return Values.EMPTY_STR;
      }
      
      public function getSoundType() : String
      {
         return Values.EMPTY_STR;
      }
      
      public function getTutorialDescriptionName() : String
      {
         return null;
      }
      
      public function getY() : Number
      {
         return y;
      }
      
      public function inInventory() : Boolean
      {
         return this._nodeData != null && (this._nodeData.state & NODE_STATE_FLAGS.IN_INVENTORY) > 0;
      }
      
      public function invalidateNodeState() : void
      {
         var _loc1_:StateProperties = NodeStateCollection.instance.getStateProps(this.entityType,this._nodeData.state);
         this.nodeState = _loc1_.state;
         this._action = _loc1_.action;
         this._actionEnabled = _loc1_.isEnabled && (!_loc1_.enough || (this._nodeData.state & _loc1_.enough) > 0);
         this._actionAvailable = _loc1_.visible;
         invalidateData();
      }
      
      public function isActionEnabled() : Boolean
      {
         return this._actionEnabled;
      }
      
      public function isCollectible() : Boolean
      {
         return this._nodeData != null && (this._nodeData.state & NODE_STATE_FLAGS.COLLECTIBLE) > 0;
      }
      
      public function isElite() : Boolean
      {
         return this._nodeData != null && (this._nodeData.state & NODE_STATE_FLAGS.ELITE) > 0;
      }
      
      public function isFake() : Boolean
      {
         return false;
      }
      
      public function isLocked() : Boolean
      {
         return this._nodeData != null && (this._nodeData.state & NODE_STATE_FLAGS.LOCKED) > 0;
      }
      
      public function isNext2Unlock() : Boolean
      {
         return this._nodeData != null && (this._nodeData.state & NODE_STATE_FLAGS.NEXT_2_UNLOCK) > 0;
      }
      
      public function isPremium() : Boolean
      {
         return this._nodeData != null && (this._nodeData.state & NODE_STATE_FLAGS.PREMIUM) > 0;
      }
      
      public function isSelected() : Boolean
      {
         return this._nodeData != null && (this._nodeData.state & NODE_STATE_FLAGS.SELECTED) > 0;
      }
      
      public function isTopActionNode() : Boolean
      {
         return false;
      }
      
      public function isTradeIn() : Boolean
      {
         return this._nodeData != null && (this._nodeData.state & NODE_STATE_FLAGS.CAN_TRADE_IN) > 0;
      }
      
      public function isUnlocked() : Boolean
      {
         return this._nodeData != null && (this._nodeData.state & NODE_STATE_FLAGS.UNLOCKED) > 0;
      }
      
      public function needPreventInnerEvents() : Boolean
      {
         return false;
      }
      
      public function setPosition(param1:Point) : void
      {
      }
      
      public function setXpBlockLinkage(param1:String, param2:String) : void
      {
         if(this._experienceBlock != null && param1 == this._xpBlockLinkage)
         {
            return;
         }
         this._xpBlockLinkage = param1;
         if(this._experienceBlock != null)
         {
            removeChild(this._experienceBlock);
            this._experienceBlock.dispose();
         }
         this._experienceBlock = this._classFactory.getComponent(this._xpBlockLinkage,ExperienceBlock);
         this._experienceBlock.name = param2;
         addChild(this._experienceBlock);
         invalidateData();
      }
      
      public function setup(param1:uint, param2:NodeData, param3:uint = 2, param4:Object = null) : void
      {
         if(!param2 || param2 == this._nodeData)
         {
            return;
         }
         this._nodeData = param2;
         this.invalidateNodeState();
      }
      
      private function isRentAvailable() : Boolean
      {
         return this._nodeData != null && (this._nodeData.state & NODE_STATE_FLAGS.RENT_AVAILABLE) > 0;
      }
      
      private function isEarlyAccess() : Boolean
      {
         return this._nodeData != null && (this._nodeData.state & NODE_STATE_FLAGS.EARLY_ACCESS) > 0;
      }
      
      private function populateUI() : void
      {
         var _loc2_:String = null;
         this.vehicleButton.setData(this._data.vehicleButton);
         this.blueprintBar.enabled = !this.isEarlyAccess();
         this.blueprintBar.mouseEnabledOnDisabled = true;
         if(this.isEarlyAccess())
         {
            this.blueprintBar.visible = this.canHaveBlueprint() && (this.isLocked() || this.isNext2Unlock()) && !this._nodeData.isEarlyAccessLocked;
         }
         else
         {
            this.blueprintBar.visible = this.canHaveBlueprint();
         }
         if(this.blueprintBar.visible)
         {
            this.blueprintBar.setData(this._data,this._nodeData.id,!this.isUnlocked());
         }
         if(this._experienceBlock)
         {
            this._experienceBlock.visible = this._nodeData.earnedXP != 0;
            if(this._experienceBlock.visible)
            {
               this._experienceBlock.setData(this._nodeData.earnedXP,this.isElite());
            }
         }
         this.collectibleStatus.visible = this.isCollectible();
         this.price.visible = this._nodeState != NodeRendererState.ROOT_HANGAR && this._nodeState != NodeRendererState.ROOT_COLLECTIBLE;
         if(this.price.visible && this._data.itemPrices)
         {
            if(this.isEarlyAccess() && (this.isLocked() || this.isNext2Unlock()) && !this._nodeData.isEarlyAccessLocked)
            {
               this.price.setData(new ItemPriceVO({"price":[[EARLY_ACCESS_COIN_ID,this._nodeData.earlyAccessTotalTokens]]}));
            }
            else
            {
               this.price.setData(new ItemPriceVO(this._data.itemPrices[0]));
            }
         }
         this.earlyAccessCoinsTF.visible = this.price.visible && this.isEarlyAccess() && this.isNext2Unlock() && !this._nodeData.isEarlyAccessLocked;
         if(this.earlyAccessCoinsTF.visible)
         {
            this.earlyAccessCoinsTF.text = this._nodeData.earlyAccessCurrentTokens + DELIMETER;
         }
         this.actionButton.visible = this._actionAvailable;
         this.actionButton.enabled = this._actionEnabled && this._data.isInteractive;
         this.actionButton.label = this._data.buttonLabel;
         var _loc1_:Boolean = this._nodeData.isEarlyAccessCanBuy;
         this.earlyAccessQuestsButton.visible = this.isEarlyAccess() && !this.isUnlocked() && (!this._nodeData.isEarlyAccessLocked || _loc1_);
         this.earlyAccessQuestsButton.enabled = !this._nodeData.isEarlyAccessPaused;
         if(_loc1_)
         {
            this.earlyAccessQuestsButton.label = MENU.RESEARCH_LABELS_BUTTON_TOEARLYACCESSBUYBUTTON;
         }
         else
         {
            this.earlyAccessQuestsButton.label = MENU.RESEARCH_LABELS_BUTTON_TOEARLYACCESSQUESTSBUTTON;
         }
         this.earlyAccessStatus.visible = this.isEarlyAccess() && !this._nodeData.isEarlyAccessLocked;
         this.earlyAccessLock.visible = this.isEarlyAccess() && this._nodeData.isEarlyAccessLocked;
         this.discountBanner.visible = Boolean(this._data.discountStr);
         if(this.discountBanner.visible)
         {
            this.discountBanner.setData(this._data.discountStr,(this.isLocked() || this.isNext2Unlock()) && this.getNodeData().blueprintProgress.valueOf() > 0);
         }
         switch(this._nodeState)
         {
            case NodeRendererState.ROOT_BUY:
               _loc2_ = UniversalBtnStylesConst.STYLE_HEAVY_ORANGE;
               break;
            case NodeRendererState.ROOT_UNLOCK:
               _loc2_ = UniversalBtnStylesConst.STYLE_HEAVY_LIME;
               break;
            case NodeRendererState.ROOT_HANGAR:
            case NodeRendererState.ROOT_COLLECTIBLE:
            case NodeRendererState.ROOT_DISCOUNTED_COLLECTIBLE:
               _loc2_ = UniversalBtnStylesConst.STYLE_HEAVY_BLACK;
               break;
            default:
               _loc2_ = UniversalBtnStylesConst.STYLE_HEAVY_GREEN;
         }
         this._universalBtnStyles.setStyle(this.actionButton,_loc2_);
         this._rentBtn = this.setupOrRemoveExtraBtn(this._rentBtn,this.isRentAvailable());
         if(this._rentBtn != null)
         {
            this._rentBtn.useHtmlText = true;
            this._rentBtn.label = this._data.rentBtnLabel;
         }
         this._hangarBtn = this.setupOrRemoveExtraBtn(this._hangarBtn,this.inInventory() && this._action != ActionName.SELECT_VEHICLE && this._action != ActionName.SHOP);
         if(this._hangarBtn != null)
         {
            this._hangarBtn.label = MENU.RESEARCH_LABELS_BUTTON_SHOWINHANGAR;
         }
         this._changeNationBtn = this.setupOrRemoveExtraBtn(this._changeNationBtn,this._data.changeNationBtnVisibility);
         if(this._changeNationBtn != null)
         {
            this._changeNationBtn.label = MENU.RESEARCH_LABELS_BUTTON_NATIONCHANGE;
            this._changeNationBtn.iconSource = RES_ICONS.MAPS_ICONS_BUTTONS_NC_ICON_MEDIUM;
            this._changeNationBtn.disabledImageAlpha = CHANGE_NATION_DISABLE_ICON_ALPHA;
            this._changeNationBtn.enabled = this._data.isTankNationChangeAvailable;
            this._changeNationBtn.mouseEnabledOnDisabled = true;
            this._changeNationBtn.tooltip = this._data.nationChangeTooltip;
            if(this._data.nationChangeIsNew)
            {
               this._counterManager.setCounter(this._changeNationBtn,CounterManager.EXCLAMATION_COUNTER_VALUE,null,COUNTER_PROPS);
            }
            else
            {
               this._counterManager.removeCounter(this._changeNationBtn);
            }
         }
      }
      
      private function updateLayout() : void
      {
         var _loc3_:int = 0;
         var _loc1_:Number = -this.getRatioY();
         if(this.discountBanner.visible)
         {
            _loc1_ -= BANNER_Y_GAP;
            this.discountBanner.y = _loc1_ | 0;
         }
         _loc1_ = this._size == SMALL_SIZE ? Number(this.getRatioY() + SMALL_VEHICLE_BOTTOM_Y_GAP) : Number(this.getRatioY());
         if(this.collectibleStatus.visible)
         {
            this.collectibleStatus.y = _loc1_ | 0;
            this.collectibleStatus.x = this.actionButton.x + (this.actionButton.width - this.collectibleStatus.width >> 1) | 0;
            _loc1_ += this.collectibleStatus.actualHeight + COLLECTIBLE_STATUS_Y_GAP;
         }
         if(this.price.visible)
         {
            this.price.validateNow();
            this.price.y = _loc1_ | 0;
            if(this.earlyAccessCoinsTF.visible)
            {
               this.earlyAccessCoinsTF.y = this.price.y;
               _loc3_ = this.earlyAccessCoinsTF.width + EARLY_ACCESS_COINS_TF_OFFSET;
               this.price.x = -(this.price.contentWidth - _loc3_) >> 1;
               this.earlyAccessCoinsTF.x = this.price.x - _loc3_ | 0;
            }
            else
            {
               this.price.x = -this.price.contentWidth >> 1;
            }
            _loc1_ += this.price.contentHeight + ACTION_BUTTON_Y_GAP;
         }
         if(this.earlyAccessLock.visible)
         {
            this.earlyAccessLock.y = _loc1_ | 0;
            this.earlyAccessLock.x = -(this.earlyAccessLock.width >> 1);
            _loc1_ += this.earlyAccessLock.height;
         }
         if(this._changeNationBtn)
         {
            this._universalBtnStyles.setStyle(this._changeNationBtn,UniversalBtnStylesConst.STYLE_HEAVY_GREEN);
            this._changeNationBtn.y = _loc1_ | 0;
            this._changeNationBtn.x = this.actionButton.x;
            this._changeNationBtn.iconSource = RES_ICONS.MAPS_ICONS_BUTTONS_NC_ICON_MEDIUM;
            _loc1_ += this._changeNationBtn.actualHeight;
         }
         if(this.actionButton.visible)
         {
            if(this._changeNationBtn)
            {
               _loc1_ += ACTION_BUTTON_Y_GAP;
            }
            this.actionButton.y = _loc1_ | 0;
            _loc1_ += this.actionButton.actualHeight;
         }
         if(this.earlyAccessQuestsButton.visible)
         {
            if(this.actionButton.visible)
            {
               _loc1_ += ACTION_BUTTON_Y_GAP;
            }
            this.earlyAccessQuestsButton.y = _loc1_ | 0;
            _loc1_ += this.earlyAccessQuestsButton.hitMc.height;
         }
         if(this._rentBtn)
         {
            _loc1_ += ACTION_BUTTON_Y_GAP;
            this._rentBtn.y = _loc1_ | 0;
            this._rentBtn.x = this.actionButton.x;
            _loc1_ += this._rentBtn.actualHeight;
         }
         if(this._hangarBtn)
         {
            _loc1_ += ACTION_BUTTON_Y_GAP;
            this._hangarBtn.y = _loc1_ | 0;
            this._hangarBtn.x = this.actionButton.x;
            _loc1_ += this._hangarBtn.actualHeight;
         }
         if(this.blueprintBar.visible)
         {
            _loc1_ += BLUEPRINT_BAR_Y_GAP;
            this.blueprintBar.y = _loc1_ | 0;
            _loc1_ += this.blueprintBar.actualHeight;
         }
         this.tradeOffWidget.visible = this.isTradeIn();
         if(this.tradeOffWidget.visible)
         {
            _loc1_ += TRADE_OFF_WIDGET_OFFSET;
            this.tradeOffWidget.y = _loc1_ | 0;
            _loc1_ += this.tradeOffWidget.actualHeight;
         }
         this.internalXShift = this._size == SMALL_SIZE && this.tradeOffWidget.visible ? int(TRADE_OFF_WIDGET_DO_INTERNAL_X_SHIFT) : int(Values.ZERO);
         var _loc2_:Boolean = this._experienceBlock && this._experienceBlock.visible;
         if(_loc2_)
         {
            _loc1_ += EXPERIENCE_Y_GAP;
            this._experienceBlock.validateNow();
            this._experienceBlock.y = _loc1_ | 0;
            this._experienceBlock.x = -this._experienceBlock.actualWidth >> 1;
            _loc1_ += this._experienceBlock.actualHeight | 0;
         }
         if(this.earlyAccessStatus.visible)
         {
            if(!_loc2_)
            {
               _loc1_ += BLUEPRINT_BAR_Y_GAP;
            }
            this.earlyAccessStatus.y = _loc1_ | 0;
            this.earlyAccessStatus.x = -(this.earlyAccessStatus.width >> 1);
         }
      }
      
      private function setupOrRemoveExtraBtn(param1:UniversalBtn, param2:Boolean) : UniversalBtn
      {
         if(param2 && param1 == null)
         {
            param1 = this._classFactory.getComponent(Linkages.BUTTON_UNIVERSAL_HEAVY,UniversalBtn);
            this._universalBtnStyles.setStyle(param1,UniversalBtnStylesConst.STYLE_HEAVY_BLACK);
            param1.width = this.actionButton.width;
            param1.addEventListener(ButtonEvent.CLICK,this.onExtraButtonClickHandler,false,0,true);
            this.addChild(param1);
         }
         else if(!param2 && param1 != null)
         {
            param1.removeEventListener(ButtonEvent.CLICK,this.onExtraButtonClickHandler);
            this.removeChild(param1);
            param1.dispose();
            param1 = null;
         }
         return param1;
      }
      
      public function get experienceBlock() : ExperienceBlock
      {
         return this._experienceBlock;
      }
      
      public function get hit() : MovieClip
      {
         return this.vehicleButton;
      }
      
      public function set data(param1:ResearchRootVO) : void
      {
         if(param1 == this._data)
         {
            return;
         }
         this._data = param1;
         invalidateData();
      }
      
      public function set size(param1:String) : void
      {
         if(this._size == param1)
         {
            return;
         }
         this._size = param1;
         this.vehicleButton.size = this._size;
         invalidate(InvalidationType.LAYOUT);
      }
      
      public function get index() : uint
      {
         return 0;
      }
      
      public function get entityType() : uint
      {
         return NodeEntityType.RESEARCH_ROOT;
      }
      
      public function set entityType(param1:uint) : void
      {
      }
      
      public function get nodeState() : String
      {
         return this._nodeState;
      }
      
      public function set nodeState(param1:String) : void
      {
         if(param1 == this._nodeState)
         {
            return;
         }
         this._nodeState = param1;
         invalidateData();
      }
      
      public function get bottomArrowOffset() : Number
      {
         return 0;
      }
      
      public function get matrixPosition() : Object
      {
         return MATRIX_POSITION;
      }
      
      public function get container() : INodesContainer
      {
         return this._owner;
      }
      
      public function set container(param1:INodesContainer) : void
      {
         this._owner = param1 as IResearchContainer;
      }
      
      private function set internalXShift(param1:int) : void
      {
         if(this._internalXShift == param1)
         {
            return;
         }
         this._internalXShift = param1;
         this.x = this._internalXShift;
      }
      
      override public function validateNow(param1:Event = null) : void
      {
         this.vehicleButton.validateNow(param1);
         super.validateNow(param1);
      }
      
      private function onButtonRollOverHandler(param1:MouseEvent) : void
      {
         var _loc2_:String = null;
         var _loc3_:ITooltipProps = null;
         var _loc4_:String = null;
         var _loc5_:String = null;
         var _loc6_:String = null;
         var _loc7_:String = null;
         if(param1.target != this.actionButton)
         {
            _loc2_ = Values.EMPTY_STR;
            if(param1.target == this.earlyAccessQuestsButton)
            {
               if(this.earlyAccessQuestsButton.enabled)
               {
                  _loc3_ = ITooltipProps(this._tooltipMgr.getDefaultTooltipProps().clone());
                  _loc3_.maxWidth = EARLY_ACCESS_SIMPLE_TOOLTIP_MAX_WIDTH;
                  if(this._nodeData.isEarlyAccessCanBuy)
                  {
                     _loc4_ = TOOLTIPS.TECHTREEPAGE_EARLYACCESSBUYENTRYPOINTTOOLTIP_HEADER;
                     _loc5_ = TOOLTIPS.TECHTREEPAGE_EARLYACCESSBUYENTRYPOINTTOOLTIP_BODY;
                  }
                  else
                  {
                     _loc4_ = TOOLTIPS.TECHTREEPAGE_EARLYACCESSQUESTSENTRYPOINTTOOLTIP_HEADER;
                     _loc5_ = TOOLTIPS.TECHTREEPAGE_EARLYACCESSQUESTSENTRYPOINTTOOLTIP_BODY;
                  }
                  _loc6_ = this._tooltipMgr.getNewFormatter().addHeader(_loc4_,true).addBody(_loc5_,true).make();
                  this._tooltipMgr.showComplex(_loc6_,_loc3_);
               }
               else
               {
                  _loc2_ = TOOLTIPS_CONSTANTS.EARLY_ACCESS_PAUSED;
               }
            }
            if(param1.target == this.earlyAccessStatus)
            {
               _loc2_ = TOOLTIPS_CONSTANTS.EARLY_ACCESS_COMMON_INFO;
            }
            if(param1.target == this.earlyAccessLock)
            {
               _loc2_ = TOOLTIPS_CONSTANTS.EARLY_ACCESS_VEHICLE_LOCKED;
            }
            if(_loc2_ != Values.EMPTY_STR)
            {
               this._tooltipMgr.showWulfTooltip(_loc2_);
            }
         }
         if(this.isCollectible())
         {
            if(this.actionButton.enabled)
            {
               _loc7_ = App.utils.locale.makeString(NATIONS.genetiveCase(this._owner.getNation()));
               this._tooltipMgr.showComplexWithParams(TOOLTIPS.RESEARCHPAGE_COLLECTIBLEVEHICLE_VEHICLEENABLED,new ToolTipParams({},{"nation":_loc7_}));
            }
            else
            {
               this._tooltipMgr.showSpecial(TOOLTIPS_CONSTANTS.VEHICLE_COLLECTOR_DISABLED,null);
            }
         }
         else if(!this.actionButton.enabled)
         {
            if(this.isTradeIn())
            {
               this._tooltipMgr.showComplex(TOOLTIPS.TRADEINUNAVAILABLE);
            }
            else
            {
               this._tooltipMgr.showSpecial(TOOLTIPS_CONSTANTS.TECHTREE_VEHICLE_STATUS,null,this._nodeData,this._nodeData.id);
            }
         }
      }
      
      private function onButtonRollOutHandler(param1:MouseEvent) : void
      {
         this._tooltipMgr.hide();
      }
      
      private function onBlueprintBarClickHandler(param1:ButtonEvent) : void
      {
         if(param1.buttonIdx == MouseEventEx.LEFT_BUTTON)
         {
            dispatchEvent(new TechTreeEvent(TechTreeEvent.GO_TO_BLUEPRINT_VIEW,this.nodeState,this.index,this.entityType));
         }
      }
      
      private function onActionButtonClickHandler(param1:ButtonEvent) : void
      {
         var _loc2_:String = null;
         switch(this._action)
         {
            case ActionName.UNLOCK:
               _loc2_ = TechTreeEvent.CLICK_2_UNLOCK;
               break;
            case ActionName.BUY:
               _loc2_ = TechTreeEvent.CLICK_2_BUY;
               break;
            case ActionName.RESTORE:
               _loc2_ = TechTreeEvent.RESTORE_VEHICLE;
               break;
            case ActionName.SELECT_VEHICLE:
               _loc2_ = TechTreeEvent.GO_TO_VEHICLE_VIEW;
               break;
            case ActionName.SHOP:
               _loc2_ = TechTreeEvent.GO_TO_SHOP;
               break;
            case ActionName.EARLY_ACCESS:
               if(this._nodeData.isEarlyAccessCanBuy)
               {
                  _loc2_ = TechTreeEvent.GO_TO_EARLY_ACCESS_BUY_VIEW;
               }
               else
               {
                  _loc2_ = TechTreeEvent.GO_TO_EARLY_ACCESS_QUESTS_VIEW;
               }
         }
         if(_loc2_)
         {
            dispatchEvent(new TechTreeEvent(_loc2_,this.nodeState,this.index,this.entityType));
         }
      }
      
      private function onExtraButtonClickHandler(param1:ButtonEvent) : void
      {
         if(param1.target == this._rentBtn)
         {
            dispatchEvent(new TechTreeEvent(TechTreeEvent.CLICK_2_RENT,this.nodeState,this.index,this.entityType));
         }
         else if(param1.target == this._hangarBtn)
         {
            dispatchEvent(new TechTreeEvent(TechTreeEvent.GO_TO_VEHICLE_VIEW,this.nodeState,this.index,this.entityType));
         }
         else if(param1.target == this._changeNationBtn)
         {
            dispatchEvent(new TechTreeEvent(TechTreeEvent.GO_TO_CHANGE_NATION_VIEW));
         }
      }
   }
}
