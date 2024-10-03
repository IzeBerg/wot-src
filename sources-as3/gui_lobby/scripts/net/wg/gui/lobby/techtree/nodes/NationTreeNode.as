package net.wg.gui.lobby.techtree.nodes
{
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.geom.ColorTransform;
   import flash.geom.Point;
   import flash.text.TextField;
   import net.wg.data.constants.Linkages;
   import net.wg.data.constants.Values;
   import net.wg.data.constants.generated.CONTEXT_MENU_HANDLER_TYPE;
   import net.wg.data.constants.generated.TOOLTIPS_CONSTANTS;
   import net.wg.gui.components.controls.TradeIco;
   import net.wg.gui.lobby.techtree.TechTreeEvent;
   import net.wg.gui.lobby.techtree.constants.ColorIndex;
   import net.wg.gui.lobby.techtree.constants.NodeEntityType;
   import net.wg.gui.lobby.techtree.constants.NodeRendererState;
   import net.wg.gui.lobby.techtree.constants.XpTypeStrings;
   import net.wg.gui.lobby.techtree.controls.ActionButton;
   import net.wg.gui.lobby.techtree.controls.EAField;
   import net.wg.gui.lobby.techtree.controls.FadeComponent;
   import net.wg.gui.lobby.techtree.controls.TypeAndLevelField;
   import net.wg.gui.lobby.techtree.controls.XPField;
   import net.wg.gui.lobby.techtree.data.vo.NTDisplayInfo;
   import net.wg.gui.lobby.techtree.interfaces.IBorderHighlighted;
   import net.wg.gui.lobby.techtree.interfaces.IRenderer;
   import net.wg.gui.lobby.techtree.postProgression.NodeHighlightAnimation;
   import net.wg.gui.lobby.techtree.sub.ResearchItems;
   import net.wg.infrastructure.interfaces.IImage;
   import net.wg.infrastructure.managers.ITooltipMgr;
   
   public class NationTreeNode extends Renderer implements IBorderHighlighted
   {
      
      private static const LABEL_ANIM_START:String = "animStart";
      
      private static const TRADE_POS_X:uint = 14;
      
      private static const TRADE_POS_Y:uint = 33;
      
      private static const XP_FIELD_DEFAULT_OFFSET_X:uint = 20;
      
      private static const XP_FIELD_ACTION_OFFSET_X:int = 0;
      
      private static const PROGRESS_BAR_RESEARCH_AVAILABLE_ALPHA:uint = 1;
      
      private static const PROGRESS_BAR_RESEARCH_UNAVAILABLE_ALPHA:Number = 0.7;
      
      private static const BOTTOM_ARROW_OFFSET:uint = 6;
      
      private static const BOTTOM_ARROW_OFFSET_ACTION:uint = 8;
      
      private static const IN_X_OFFSET:int = -3;
      
      private static const BLUEPRINT_PLUS_COLOR_OFFSET:int = 50;
      
      private static const NAME_TF_FULL_WIDTH:int = 124;
      
      private static const NAME_TF_SHORT_WIDTH_FOR_NATION_CHANGE_ICON:int = 108;
      
      private static const INV_FIRST_TIME_SHOW:String = "invFirstTimeShow";
      
      private static const DISCOUNT_LABEL_BLUE:String = "blue";
      
      private static const DISCOUNT_LABEL_RED:String = "red";
      
      private static const EARLY_ACCESS_BORDER_LABEL:String = "border";
      
      private static const EARLY_ACCESS_BORDER_HOVER_LABEL:String = "_hover";
      
      private static const EARLY_ACCESS_BORDER_LOCKED_LABEL:String = "_locked";
      
      private static const EARLY_ACCESS_BORDER_PAUSED_LABEL:String = "_paused";
      
      private static const EARLY_ACCESS_BORDER_HIGHLIGHT_SHOW_LABEL:String = "show";
      
      private static const EARLY_ACCESS_BORDER_HIGHLIGHT_HIDE_LABEL:String = "hide";
       
      
      public var lockedModuleHighlight:NodeHighlightAnimation = null;
      
      public var blueprintProgressBar:FadeComponent = null;
      
      public var blueprintBorder:FadeComponent = null;
      
      public var blueprintCount:TextField = null;
      
      public var blueprintPlus:FadeComponent = null;
      
      public var typeAndLevel:TypeAndLevelField = null;
      
      public var vehicleImage:IImage = null;
      
      public var button:ActionButton = null;
      
      public var discountIcon:MovieClip = null;
      
      public var nationChangeIcon:Sprite = null;
      
      public var xpField:XPField = null;
      
      public var eaField:EAField = null;
      
      public var nameTF:TextField = null;
      
      public var techTreeEventAnimMc:MovieClip = null;
      
      public var techTreeEventFrameMc:MovieClip = null;
      
      public var earlyAccessAnimMc:MovieClip = null;
      
      public var earlyAccessLock:MovieClip = null;
      
      public var earlyAccessBorder:MovieClip = null;
      
      public var earlyAccessBorderHighlight:MovieClip = null;
      
      private var _isFirstTimeActionShow:Boolean = false;
      
      private var _trade:TradeIco = null;
      
      private var _tooltipMgr:ITooltipMgr;
      
      public function NationTreeNode()
      {
         this._tooltipMgr = App.toolTipMgr;
         super();
      }
      
      override public function cleanUp() : void
      {
         super.cleanUp();
         if(!isEarlyAccess)
         {
            this.blueprintPlus.enabled = false;
         }
      }
      
      override public function getColorIndex(param1:IRenderer = null) : uint
      {
         var _loc3_:Boolean = false;
         var _loc2_:NationTreeNode = param1 as NationTreeNode;
         if(this._isFirstTimeActionShow && hasTechTreeEvent)
         {
            if(_loc2_ && _loc2_.hasTechTreeEvent && _loc2_.isFirstTimeActionShow)
            {
               return ColorIndex.EVENT_AVAILABLE;
            }
         }
         if(isEarlyAccess)
         {
            _loc3_ = _loc2_ && _loc2_.getNodeData().isEarlyAccess;
            return isFirstTimeEarlyAccessShow && _loc3_ ? uint(ColorIndex.EARLY_ACCESS) : uint(ColorIndex.LOCKED);
         }
         return super.getColorIndex(param1);
      }
      
      override public function getExtraState() : Object
      {
         return {"isResearchGraph":container is ResearchItems};
      }
      
      override public function getIconPath() : String
      {
         return !!dataInited ? getNodeData().smallIconPath : "";
      }
      
      override public function getInX() : Number
      {
         return x + IN_X_OFFSET;
      }
      
      override public function invalidateNodeState() : void
      {
         var _loc2_:Point = null;
         super.invalidateNodeState();
         var _loc1_:Object = getDisplayInfo();
         if(_loc1_ && _loc1_ is NTDisplayInfo)
         {
            _loc2_ = NTDisplayInfo(_loc1_).position;
            if(_loc2_ != null)
            {
               setPosition(_loc2_);
            }
         }
         if(isAnnouncement)
         {
            tooltipID = TOOLTIPS_CONSTANTS.TECHTREE_VEHICLE_ANNOUNCEMENT;
         }
         else
         {
            tooltipID = TOOLTIPS_CONSTANTS.TECHTREE_VEHICLE;
         }
      }
      
      override public function showContextMenu() : void
      {
         this.button.endAnimation(true);
         var _loc1_:Object = {
            "vehCD":getID(),
            "nodeState":getState()
         };
         if(this.isBlueprintMode)
         {
            App.contextMenuMgr.show(CONTEXT_MENU_HANDLER_TYPE.BLUEPRINT_VEHICLE,this,_loc1_);
         }
         else
         {
            App.contextMenuMgr.show(CONTEXT_MENU_HANDLER_TYPE.RESEARCH_VEHICLE,this,_loc1_);
         }
      }
      
      override public function showTooltip() : void
      {
         if(this.isBlueprintMode && dataInited && getNodeData().dataIsReady && this._tooltipMgr != null)
         {
            this._tooltipMgr.showSpecial(TOOLTIPS_CONSTANTS.BLUEPRINT_INFO,null,getID());
            return;
         }
         super.showTooltip();
      }
      
      override public function toString() : String
      {
         return "[NationTreeNode " + index + ", " + name + "]";
      }
      
      override protected function validateData() : void
      {
         var _loc1_:Boolean = false;
         var _loc5_:String = null;
         var _loc6_:Boolean = false;
         visible = !(this.isBlueprintMode && !canHaveBlueprint());
         if(!visible)
         {
            return;
         }
         super.validateData();
         this.vehicleImage.alpha = stateProps.cmpAlpha;
         this.vehicleImage.source = this.getIconPath();
         this.typeAndLevel.setOwner(this);
         this.nameTF.text = getItemName();
         _loc1_ = isLocked();
         var _loc2_:Boolean = isNext2Unlock();
         var _loc3_:String = (_loc1_ || _loc2_) && getNodeData().blueprintProgress.valueOf() > 0 ? DISCOUNT_LABEL_BLUE : DISCOUNT_LABEL_RED;
         var _loc4_:Boolean = hasAction || hasTechTreeEvent;
         if(this.discountIcon)
         {
            this.discountIcon.visible = _loc4_;
            if(_loc4_)
            {
               App.utils.asserter.assertFrameExists(_loc3_,this.discountIcon);
               this.discountIcon.gotoAndStop(_loc3_);
            }
         }
         if(this.xpField)
         {
            this.xpField.visible = true;
            this.xpField.alpha = stateProps.cmpAlpha;
            if(_loc1_)
            {
               this.xpField.setData(getNodeData().unlockProps.xpCost,XpTypeStrings.COST_XP_TYPE);
            }
            else if(getEarnedXP() > 0 && !stateProps.visible)
            {
               _loc5_ = !!isElite() ? XpTypeStrings.ELITE_XP_TYPE : XpTypeStrings.EARNED_XP_TYPE;
               this.xpField.setData(getEarnedXP(),_loc5_);
            }
            else
            {
               this.xpField.visible = false;
            }
            this.xpField.x = _loc4_ && this.discountIcon ? Number(XP_FIELD_ACTION_OFFSET_X) : Number(XP_FIELD_DEFAULT_OFFSET_X);
         }
         if(this.eaField)
         {
            this.eaField.visible = isEarlyAccess && (isLocked() || _loc2_) && !getNodeData().isEarlyAccessLocked;
            this.eaField.setData(getNodeData().earlyAccessCurrentTokens,getNodeData().earlyAccessTotalTokens,_loc2_);
            this.eaField.x = _loc4_ && this.discountIcon ? Number(XP_FIELD_ACTION_OFFSET_X) : Number(XP_FIELD_DEFAULT_OFFSET_X);
         }
         if(this.xpField && this.eaField)
         {
            if(this.eaField.visible || getNodeData().isEarlyAccessLocked)
            {
               this.xpField.visible = false;
            }
         }
         if(isRestoreAvailable())
         {
            this.button.label = App.utils.locale.makeString(MENU.RESEARCH_LABELS_BUTTON_RESTORE);
            this.button.imgSubstitution = ActionButton.DEFAULT_IMAGE_SUBSTITUTION;
         }
         else
         {
            this.button.label = getNodeData().costLabel;
         }
         this.button.action = stateProps.action;
         this.button.enabled = isActionEnabled();
         this.button.visible = stateProps.visible;
         this.button.setAnimation(stateProps.id,stateProps.animation);
         this.button.setOwner(this);
         if(this.isBlueprintMode && !isEarlyAccess)
         {
            this.blueprintBorder.enabled = _loc2_;
            this.blueprintProgressBar.scaleX = blueprintProgress;
            this.blueprintProgressBar.alpha = !!_loc2_ ? Number(PROGRESS_BAR_RESEARCH_AVAILABLE_ALPHA) : Number(PROGRESS_BAR_RESEARCH_UNAVAILABLE_ALPHA);
            _loc6_ = !isUnlocked();
            this.blueprintProgressBar.enabled = _loc6_;
            this.blueprintCount.htmlText = blueprintLabel;
            this.blueprintCount.visible = _loc6_;
            this.blueprintPlus.enabled = blueprintCanConvert && _loc6_;
            this.blueprintPlus.buttonMode = true;
         }
         else
         {
            this.blueprintProgressBar.enabled = false;
            this.blueprintBorder.enabled = false;
            this.blueprintPlus.enabled = false;
         }
         if(this.earlyAccessLock)
         {
            this.earlyAccessLock.visible = isEarlyAccess && isEarlyAccessLocked;
         }
         if(this.earlyAccessBorder)
         {
            this.earlyAccessBorder.mouseEnabled = this.earlyAccessBorder.mouseChildren = false;
            this.earlyAccessBorder.gotoAndStop(this.getEarlyAccessBorderState());
         }
         if(this.earlyAccessBorderHighlight)
         {
            this.earlyAccessBorderHighlight.mouseEnabled = this.earlyAccessBorderHighlight.mouseChildren = false;
         }
         if(this.nationChangeIcon)
         {
            this.nationChangeIcon.visible = getNodeData().isNationChangeAvailable;
         }
         this.nameTF.width = !!getNodeData().isNationChangeAvailable ? Number(NAME_TF_SHORT_WIDTH_FOR_NATION_CHANGE_ICON) : Number(NAME_TF_FULL_WIDTH);
         this.setTradeIcon();
         this.updateTechTreeEventBorder();
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(INV_FIRST_TIME_SHOW))
         {
            this.updateTechTreeEventBorder();
         }
      }
      
      override protected function onDispose() : void
      {
         if(this.techTreeEventAnimMc)
         {
            this.techTreeEventAnimMc = null;
         }
         if(this.techTreeEventFrameMc)
         {
            this.techTreeEventFrameMc = null;
         }
         this.earlyAccessAnimMc = null;
         this.earlyAccessLock = null;
         this.earlyAccessBorder = null;
         this.earlyAccessBorderHighlight = null;
         this.button.dispose();
         this.button = null;
         this.typeAndLevel.dispose();
         this.typeAndLevel = null;
         this.vehicleImage.dispose();
         this.vehicleImage = null;
         if(!isEarlyAccess)
         {
            this.blueprintProgressBar.dispose();
            this.blueprintProgressBar = null;
            this.blueprintBorder.dispose();
            this.blueprintBorder = null;
            this.blueprintPlus.removeEventListener(MouseEvent.ROLL_OVER,this.onBlueprintPlusRollOverHandler);
            this.blueprintPlus.removeEventListener(MouseEvent.ROLL_OUT,this.onBlueprintPlusRollOutHandler);
            this.blueprintPlus.removeEventListener(MouseEvent.CLICK,this.onBlueprintPlusClickHandler);
            this.blueprintPlus.dispose();
            this.blueprintPlus = null;
            this.blueprintCount = null;
         }
         if(this.xpField)
         {
            this.xpField.dispose();
            this.xpField = null;
         }
         if(this.eaField)
         {
            this.eaField.dispose();
            this.eaField = null;
         }
         if(this._trade)
         {
            this.removeChild(this._trade);
            this._trade.dispose();
            this._trade = null;
         }
         this.discountIcon = null;
         this.nameTF = null;
         this._tooltipMgr = null;
         this.nationChangeIcon = null;
         if(this.lockedModuleHighlight)
         {
            this.lockedModuleHighlight.dispose();
            this.lockedModuleHighlight = null;
         }
         super.onDispose();
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         entityType = NodeEntityType.NATION_TREE;
         delegateToChildren();
      }
      
      override protected function addNodeEventHandlers() : void
      {
         super.addNodeEventHandlers();
         addEventListener(MouseEvent.ROLL_OVER,this.onNationNodeRollOverHandler,false,0,true);
         addEventListener(MouseEvent.ROLL_OUT,this.onNationNodeRollOutHandler,false,0,true);
         hit.addEventListener(MouseEvent.CLICK,this.onHitClickHandler,false,0,true);
      }
      
      override protected function removeNodeEventHandlers() : void
      {
         removeEventListener(MouseEvent.ROLL_OVER,this.onNationNodeRollOverHandler);
         removeEventListener(MouseEvent.ROLL_OUT,this.onNationNodeRollOutHandler);
         hit.removeEventListener(MouseEvent.CLICK,this.onHitClickHandler);
         super.removeNodeEventHandlers();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         if(!isEarlyAccess)
         {
            this.blueprintPlus.addEventListener(MouseEvent.ROLL_OVER,this.onBlueprintPlusRollOverHandler,false,0,true);
            this.blueprintPlus.addEventListener(MouseEvent.ROLL_OUT,this.onBlueprintPlusRollOutHandler,false,0,true);
            this.blueprintPlus.addEventListener(MouseEvent.CLICK,this.onBlueprintPlusClickHandler,false,0,true);
         }
      }
      
      public function showEarlyAccessBorderHighlight(param1:Boolean) : void
      {
         if(this.earlyAccessBorderHighlight)
         {
            this.earlyAccessBorderHighlight.gotoAndPlay(!!param1 ? EARLY_ACCESS_BORDER_HIGHLIGHT_SHOW_LABEL : EARLY_ACCESS_BORDER_HIGHLIGHT_HIDE_LABEL);
         }
      }
      
      public function animateFrameHighlight() : void
      {
         if(this.techTreeEventFrameMc)
         {
            this.techTreeEventFrameMc.gotoAndPlay(LABEL_ANIM_START);
         }
      }
      
      public function createAnimationCallback(param1:MovieClip) : Function
      {
         var mc:MovieClip = param1;
         return function():void
         {
            mc.gotoAndPlay(LABEL_ANIM_START);
         };
      }
      
      public function resetAnimations() : void
      {
         this.techTreeEventAnimMc.gotoAndStop(1);
         this.earlyAccessAnimMc.gotoAndStop(1);
      }
      
      private function setTradeIcon() : void
      {
         if(isTradeIn())
         {
            if(this._trade == null)
            {
               this._trade = App.utils.classFactory.getComponent(Linkages.TRADE_ICO_UI,TradeIco);
               this._trade.x = TRADE_POS_X;
               this._trade.y = TRADE_POS_Y;
               this.addChildAt(this._trade,this.numChildren);
               this._trade.setData(getID(),label);
            }
         }
         else if(this._trade != null)
         {
            this.removeChild(this._trade);
            this._trade.dispose();
            this._trade = null;
         }
      }
      
      private function blueprintPlusHoverEffectEnable() : void
      {
         this.blueprintPlus.transform.colorTransform = new ColorTransform(1,1,1,1,BLUEPRINT_PLUS_COLOR_OFFSET,BLUEPRINT_PLUS_COLOR_OFFSET,BLUEPRINT_PLUS_COLOR_OFFSET,0);
         App.utils.commons.setGlowFilter(this.blueprintPlus,4283871231);
      }
      
      private function blueprintPlusHoverEffectDisable() : void
      {
         this.blueprintPlus.filters = [];
         this.blueprintPlus.transform.colorTransform = null;
      }
      
      private function updateTechTreeEventBorder() : void
      {
         if(this.techTreeEventFrameMc)
         {
            if(!this._isFirstTimeActionShow)
            {
               this.techTreeEventFrameMc.gotoAndStop(1);
            }
            this.techTreeEventFrameMc.visible = !this.isBlueprintMode && hasTechTreeEvent;
         }
      }
      
      private function getEarlyAccessBorderState(param1:Boolean = false) : String
      {
         var _loc2_:String = Values.EMPTY_STR;
         if(isLocked() || isNext2Unlock())
         {
            _loc2_ = EARLY_ACCESS_BORDER_LOCKED_LABEL;
         }
         if(getNodeData().isEarlyAccessPaused)
         {
            _loc2_ = EARLY_ACCESS_BORDER_PAUSED_LABEL;
         }
         if(param1)
         {
            _loc2_ += EARLY_ACCESS_BORDER_HOVER_LABEL;
         }
         return EARLY_ACCESS_BORDER_LABEL + _loc2_;
      }
      
      override protected function get mouseEnabledChildren() : Vector.<DisplayObject>
      {
         var _loc1_:Vector.<DisplayObject> = super.mouseEnabledChildren;
         _loc1_.push(this.button);
         if(!isEarlyAccess)
         {
            _loc1_.push(this.blueprintPlus);
         }
         if(this._trade != null)
         {
            _loc1_.push(this._trade);
         }
         return _loc1_;
      }
      
      override public function get bottomArrowOffset() : Number
      {
         if(nodeState == NodeRendererState.LOCKED || nodeState == NodeRendererState.BLUEPRINTS_LOCKED)
         {
            return super.bottomArrowOffset;
         }
         if(stateProps.visible)
         {
            return BOTTOM_ARROW_OFFSET_ACTION;
         }
         return BOTTOM_ARROW_OFFSET;
      }
      
      public function get isBlueprintMode() : Boolean
      {
         return entityType == NodeEntityType.BLUEPRINT_TREE;
      }
      
      public function get isFirstTimeActionShow() : Boolean
      {
         return this._isFirstTimeActionShow;
      }
      
      public function set isFirstTimeActionShow(param1:Boolean) : void
      {
         this._isFirstTimeActionShow = param1;
         invalidate(INV_FIRST_TIME_SHOW);
      }
      
      public function get isBorderHighlighted() : Boolean
      {
         return Boolean(this.lockedModuleHighlight) ? Boolean(this.lockedModuleHighlight.isHighlighted) : Boolean(false);
      }
      
      public function set isBorderHighlighted(param1:Boolean) : void
      {
         if(this.lockedModuleHighlight)
         {
            this.lockedModuleHighlight.isHighlighted = param1;
         }
      }
      
      private function onHitClickHandler(param1:MouseEvent) : void
      {
         if(!isNotClickable() && App.utils.commons.isLeftButton(param1))
         {
            dispatchEvent(new TechTreeEvent(TechTreeEvent.CLICK_2_OPEN,nodeState,_index,entityType));
         }
      }
      
      private function onNationNodeRollOverHandler(param1:MouseEvent) : void
      {
         this.button.startAnimation();
         if(this.earlyAccessBorder)
         {
            this.earlyAccessBorder.gotoAndStop(this.getEarlyAccessBorderState(true));
         }
      }
      
      private function onNationNodeRollOutHandler(param1:MouseEvent) : void
      {
         this.button.endAnimation(false);
         if(this.earlyAccessBorder)
         {
            this.earlyAccessBorder.gotoAndStop(this.getEarlyAccessBorderState());
         }
      }
      
      private function onBlueprintPlusRollOverHandler(param1:MouseEvent) : void
      {
         if(this._tooltipMgr)
         {
            this._tooltipMgr.showSpecial(TOOLTIPS_CONSTANTS.BLUEPRINT_CONVERT_INFO,null,getID());
         }
         this.blueprintPlusHoverEffectEnable();
      }
      
      private function onBlueprintPlusRollOutHandler(param1:MouseEvent) : void
      {
         if(this._tooltipMgr)
         {
            this._tooltipMgr.hide();
         }
         this.blueprintPlusHoverEffectDisable();
      }
      
      private function onBlueprintPlusClickHandler(param1:MouseEvent) : void
      {
         dispatchEvent(new TechTreeEvent(TechTreeEvent.GO_TO_BLUEPRINT_VIEW,nodeState,_index,entityType));
      }
   }
}
