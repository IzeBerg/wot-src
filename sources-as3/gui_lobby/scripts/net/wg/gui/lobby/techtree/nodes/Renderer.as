package net.wg.gui.lobby.techtree.nodes
{
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import net.wg.data.constants.Errors;
   import net.wg.data.constants.SoundTypes;
   import net.wg.data.constants.Values;
   import net.wg.data.constants.generated.NODE_STATE_FLAGS;
   import net.wg.gui.components.controls.SoundListItemRenderer;
   import net.wg.gui.lobby.techtree.TechTreeEvent;
   import net.wg.gui.lobby.techtree.constants.ColorIndex;
   import net.wg.gui.lobby.techtree.constants.NodeEntityType;
   import net.wg.gui.lobby.techtree.data.state.NodeStateCollection;
   import net.wg.gui.lobby.techtree.data.state.StateProperties;
   import net.wg.gui.lobby.techtree.data.vo.NodeData;
   import net.wg.gui.lobby.techtree.interfaces.INodesContainer;
   import net.wg.gui.lobby.techtree.interfaces.IRenderer;
   import net.wg.infrastructure.exceptions.AbstractException;
   import net.wg.utils.ICommons;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.events.ComponentEvent;
   
   public class Renderer extends SoundListItemRenderer implements IRenderer
   {
      
      public static const LINES_AND_ARROWS_NAME:String = "linesAndArrows";
      
      private static const STATE_PREFIX_SELECTED:String = "selected_";
      
      private static const STATE_UP:String = "up";
      
      private static const STATE_UNION:String = "_";
       
      
      public var hit:MovieClip = null;
      
      private var _delegateToChildren:Boolean = false;
      
      private var _tooltipID:String = null;
      
      private var _stateProps:StateProperties = null;
      
      private var _nodeState:String = "locked";
      
      private var _dataInited:Boolean = false;
      
      private var _container:INodesContainer = null;
      
      private var _entityType:uint = 0;
      
      private var _valueObject:NodeData = null;
      
      private var _matrixPosition:Object = null;
      
      private var _enabledChildren:Vector.<DisplayObject> = null;
      
      private var _commons:ICommons;
      
      public function Renderer()
      {
         this._commons = App.utils.commons;
         super();
      }
      
      override protected function onDispose() : void
      {
         App.contextMenuMgr.hide();
         App.toolTipMgr.hide();
         this.removeNodeEventHandlers();
         this.hit = null;
         if(this._valueObject)
         {
            this._valueObject.dispose();
            this._valueObject = null;
         }
         this._dataInited = false;
         this._matrixPosition = null;
         this._container = null;
         this._enabledChildren.splice(0,this._enabledChildren.length);
         this._enabledChildren = null;
         this._commons = null;
         super.onDispose();
      }
      
      override protected function preInitialize() : void
      {
         preventAutosizing = true;
         constraintsDisabled = true;
         super.preInitialize();
         soundType = SoundTypes.NORMAL_BTN;
         _state = STATE_UP;
         statesSelected = Vector.<String>([STATE_PREFIX_SELECTED,this._nodeState]);
         statesDefault = Vector.<String>([this._nodeState]);
         this._enabledChildren = new Vector.<DisplayObject>();
      }
      
      override protected function draw() : void
      {
         if(_baseDisposed)
         {
            return;
         }
         if(isInvalid(InvalidationType.SETTINGS))
         {
            this.removeNodeEventHandlers();
            this.setMouseBehavior();
            this.addNodeEventHandlers();
         }
         if(isInvalid(InvalidationType.STATE))
         {
            if(_newFrame)
            {
               gotoAndPlay(_newFrame);
               if(_baseDisposed)
               {
                  return;
               }
               _newFrame = null;
            }
            updateAfterStateChange();
            dispatchEventAndSound(new ComponentEvent(ComponentEvent.STATE_CHANGE));
         }
         if(!this._dataInited)
         {
            this.visible = false;
            return;
         }
         if(isInvalid(InvalidationType.DATA,InvalidationType.SETTINGS))
         {
            if(this._delegateToChildren)
            {
               this._commons.updateChildrenMouseBehavior(this,false,false,this.mouseEnabledChildren);
            }
            this.visible = true;
            this.validateData();
         }
         if(isInvalid(InvalidationType.DATA))
         {
            dispatchEvent(new TechTreeEvent(TechTreeEvent.STATE_CHANGED,this._nodeState,_index,this._entityType));
         }
      }
      
      public function canHaveBlueprint() : Boolean
      {
         return this._dataInited && (this._valueObject.state & NODE_STATE_FLAGS.BLUEPRINT) > 0;
      }
      
      public function cleanUp() : void
      {
      }
      
      public function getActualWidth() : Number
      {
         return this.hit != null ? Number(this.hit.width) : Number(width);
      }
      
      public function getColorIndex(param1:IRenderer = null) : uint
      {
         var _loc2_:uint = ColorIndex.LOCKED;
         if(param1 && param1.isPremium() || this.isPremium())
         {
            _loc2_ = ColorIndex.PREMIUM;
         }
         else if(this.isUnlocked() && (param1 == null || param1.isUnlocked()) || this.isNext2Unlock() && param1 && param1.isUnlocked())
         {
            _loc2_ = ColorIndex.UNLOCKED;
         }
         return _loc2_;
      }
      
      public function getDisplayInfo() : Object
      {
         return !!this._dataInited ? this._valueObject.displayInfo : null;
      }
      
      public function getEarnedXP() : Number
      {
         return !!this._dataInited ? Number(this._valueObject.earnedXP) : Number(0);
      }
      
      public function getExtraState() : Object
      {
         return null;
      }
      
      public function getGraphicsName() : String
      {
         return LINES_AND_ARROWS_NAME;
      }
      
      public function getID() : uint
      {
         return !!this._dataInited ? uint(this._valueObject.id) : uint(0);
      }
      
      public function getIconPath() : String
      {
         return !!this._dataInited ? this._valueObject.iconPath : Values.EMPTY_STR;
      }
      
      public function getInX() : Number
      {
         return Math.round(x + (this.hit != null ? this.hit.x : 0));
      }
      
      public function getItemName() : String
      {
         return !!this._dataInited ? this._valueObject.nameString : Values.EMPTY_STR;
      }
      
      public function getItemType() : String
      {
         return !!this._dataInited ? this._valueObject.primaryClassName : Values.EMPTY_STR;
      }
      
      public function getLevel() : int
      {
         return !!this._dataInited ? int(this._valueObject.level) : int(0);
      }
      
      public function getNodeData() : NodeData
      {
         return this._valueObject;
      }
      
      public function getState() : uint
      {
         return !!this._dataInited ? uint(this._valueObject.state) : uint(0);
      }
      
      public function getOutX() : Number
      {
         return x + (this.hit != null ? this.hit.x + Math.round(this.hit.width) : Math.round(_width));
      }
      
      public function getRatioY() : Number
      {
         return this.hit != null ? Number(Math.round(this.hit.height) >> 1) : Number(Math.round(_height) >> 1);
      }
      
      public function getY() : Number
      {
         return y + (this.hit != null ? this.hit.y + (Math.round(this.hit.height) >> 1) : Math.round(_height) >> 1);
      }
      
      public function inInventory() : Boolean
      {
         return this._dataInited && (this._valueObject.state & NODE_STATE_FLAGS.IN_INVENTORY) > 0;
      }
      
      public function invalidateNodeState() : void
      {
         this.updateStateProps();
         App.contextMenuMgr.hide();
         invalidateData();
      }
      
      public function isActionEnabled() : Boolean
      {
         if(!this._dataInited)
         {
            return false;
         }
         return this._stateProps.enough == 0 || (this._valueObject.state & this._stateProps.enough) > 0;
      }
      
      public function isCollectible() : Boolean
      {
         return this._dataInited && (this._valueObject.state & NODE_STATE_FLAGS.COLLECTIBLE) > 0;
      }
      
      public function isElite() : Boolean
      {
         return this._dataInited && (this._valueObject.state & NODE_STATE_FLAGS.ELITE) > 0;
      }
      
      public function isFake() : Boolean
      {
         return false;
      }
      
      public function isLocked() : Boolean
      {
         return this._dataInited && (this._valueObject.state & NODE_STATE_FLAGS.LOCKED) > 0;
      }
      
      public function isNext2Unlock() : Boolean
      {
         return this._dataInited && (this._valueObject.state & NODE_STATE_FLAGS.NEXT_2_UNLOCK) > 0;
      }
      
      public function isNotClickable() : Boolean
      {
         return this._dataInited && (this._valueObject.state & NODE_STATE_FLAGS.NOT_CLICKABLE) > 0;
      }
      
      public function isPremium() : Boolean
      {
         return this._dataInited && (this._valueObject.state & NODE_STATE_FLAGS.PREMIUM) > 0;
      }
      
      public function isRentAvailable() : Boolean
      {
         if(!this._dataInited)
         {
            return false;
         }
         return (this._valueObject.state & NODE_STATE_FLAGS.RENT_AVAILABLE) > 0;
      }
      
      public function isRestoreAvailable() : Boolean
      {
         if(!this._dataInited)
         {
            return false;
         }
         return (this._valueObject.state & NODE_STATE_FLAGS.RESTORE_AVAILABLE) > 0;
      }
      
      public function isSelected() : Boolean
      {
         throw new AbstractException(Errors.ABSTRACT_INVOKE);
      }
      
      public function isTopActionNode() : Boolean
      {
         return !!this._dataInited ? Boolean(this._valueObject.isTopActionNode) : Boolean(false);
      }
      
      public function isTradeIn() : Boolean
      {
         return this._dataInited && (this._valueObject.state & NODE_STATE_FLAGS.CAN_TRADE_IN) > 0 && !this.isRentAvailable();
      }
      
      public function isUnlocked() : Boolean
      {
         return this._dataInited && (this._valueObject.state & NODE_STATE_FLAGS.UNLOCKED) > 0;
      }
      
      public function setPosition(param1:Point) : void
      {
         if(this.hit != null)
         {
            this.x = Math.round(param1.x - this.hit.x);
            this.y = Math.round(param1.y - this.hit.y);
         }
         else
         {
            this.x = param1.x;
            this.y = param1.y;
         }
      }
      
      public function setup(param1:uint, param2:NodeData, param3:uint = 0, param4:Object = null) : void
      {
         this._index = param1;
         this._matrixPosition = param4;
         if((this._valueObject == param2 || param2 == null) && (param3 == NodeEntityType.UNDEFINED || param3 == this._entityType))
         {
            return;
         }
         if(param3 != NodeEntityType.UNDEFINED)
         {
            this._entityType = param3;
         }
         this._valueObject = param2;
         this._dataInited = true;
         this.invalidateNodeState();
      }
      
      public function showContextMenu() : void
      {
      }
      
      public function showTooltip() : void
      {
         if(this._tooltipID && this._valueObject && this._valueObject.dataIsReady)
         {
            App.toolTipMgr.showSpecial(this._tooltipID,null,this._valueObject,this._container != null ? this._container.rootRenderer.getID() : null);
         }
      }
      
      protected function validateData() : void
      {
      }
      
      protected function addNodeEventHandlers() : void
      {
         if(this._delegateToChildren)
         {
            this.hit.addEventListener(MouseEvent.ROLL_OVER,this.onNodeRollOverHandler,false,0,true);
            this.hit.addEventListener(MouseEvent.ROLL_OUT,this.onNodeRollOutHandler,false,0,true);
            this.hit.addEventListener(MouseEvent.CLICK,this.onNodeClickHandler,false,0,true);
         }
         else
         {
            this.addEventListener(MouseEvent.ROLL_OVER,this.onNodeRollOverHandler,false,0,true);
            this.addEventListener(MouseEvent.ROLL_OUT,this.onNodeRollOutHandler,false,0,true);
            this.addEventListener(MouseEvent.CLICK,this.onNodeClickHandler,false,0,true);
         }
      }
      
      protected function removeNodeEventHandlers() : void
      {
         this.removeEventListener(MouseEvent.ROLL_OVER,this.onNodeRollOverHandler);
         this.removeEventListener(MouseEvent.ROLL_OUT,this.onNodeRollOutHandler);
         this.removeEventListener(MouseEvent.CLICK,this.onNodeClickHandler);
         if(this.hit != null)
         {
            this.hit.removeEventListener(MouseEvent.ROLL_OVER,this.onNodeRollOverHandler);
            this.hit.removeEventListener(MouseEvent.ROLL_OUT,this.onNodeRollOutHandler);
            this.hit.removeEventListener(MouseEvent.CLICK,this.onNodeClickHandler);
         }
      }
      
      protected function delegateToChildren(param1:Boolean = true) : void
      {
         if(param1 != this._delegateToChildren)
         {
            this._delegateToChildren = param1;
            invalidate(InvalidationType.SETTINGS);
         }
      }
      
      protected function updateStateProps() : void
      {
         this._stateProps = NodeStateCollection.instance.getStateProps(this._entityType,!!this._dataInited ? uint(this._valueObject.state) : uint(0),this.getExtraState());
         this._nodeState = this._stateProps.state;
         statesSelected = Vector.<String>([STATE_PREFIX_SELECTED,this._nodeState + STATE_UNION]);
         statesDefault = Vector.<String>([this._nodeState + STATE_UNION]);
         setState(state);
      }
      
      protected function rollOut() : void
      {
         App.toolTipMgr.hide();
      }
      
      protected function rollOver() : void
      {
         this.showTooltip();
      }
      
      private function setMouseBehavior() : void
      {
         if(this._delegateToChildren)
         {
            mouseEnabled = false;
            mouseChildren = true;
            this.hit.buttonMode = true;
         }
         else if(this.hit)
         {
            hitArea = this.hit;
         }
      }
      
      public function get bottomArrowOffset() : Number
      {
         return 0;
      }
      
      public final function get nodeState() : String
      {
         return this._nodeState;
      }
      
      public function get stateProps() : StateProperties
      {
         return this._stateProps;
      }
      
      public function get dataInited() : Boolean
      {
         return this._dataInited;
      }
      
      public function get container() : INodesContainer
      {
         return this._container;
      }
      
      public function set container(param1:INodesContainer) : void
      {
         this._container = param1;
      }
      
      public function get entityType() : uint
      {
         return this._entityType;
      }
      
      public function set entityType(param1:uint) : void
      {
         if(this._entityType == param1)
         {
            return;
         }
         this._entityType = param1;
         this.updateStateProps();
         invalidate(InvalidationType.SETTINGS);
      }
      
      public function get matrixPosition() : Object
      {
         return this._matrixPosition;
      }
      
      public function get hasTechTreeEvent() : Boolean
      {
         return this._dataInited && this._valueObject.hasTechTreeEvent;
      }
      
      protected function get mouseEnabledChildren() : Vector.<DisplayObject>
      {
         this._enabledChildren.splice(0,this._enabledChildren.length);
         if(this.hit != null)
         {
            this._enabledChildren.push(this.hit);
         }
         return this._enabledChildren;
      }
      
      protected function get hasAction() : Boolean
      {
         return this._dataInited && (this._valueObject.state & NODE_STATE_FLAGS.ACTION) > 0;
      }
      
      protected function get blueprintLabel() : String
      {
         return !!this._dataInited ? this._valueObject.blueprintLabel : Values.EMPTY_STR;
      }
      
      protected function get blueprintProgress() : Number
      {
         return !!this._dataInited ? Number(this._valueObject.blueprintProgress) : Number(0);
      }
      
      protected function get blueprintCanConvert() : Boolean
      {
         return !!this._dataInited ? Boolean(this._valueObject.blueprintCanConvert) : Boolean(false);
      }
      
      protected function set tooltipID(param1:String) : void
      {
         this._tooltipID = param1;
      }
      
      public function get isAnnouncement() : Boolean
      {
         return !!this._dataInited ? Boolean(this._valueObject.isAnnouncement) : Boolean(false);
      }
      
      protected function get isEarlyAccess() : Boolean
      {
         return !!this._dataInited ? Boolean(this._valueObject.isEarlyAccess) : Boolean(false);
      }
      
      protected function get isEarlyAccessLocked() : Boolean
      {
         return !!this._dataInited ? Boolean(this._valueObject.isEarlyAccessLocked) : Boolean(false);
      }
      
      protected function get isFirstTimeEarlyAccessShow() : Boolean
      {
         return !!this._dataInited ? Boolean(this._valueObject.isFirstTimeEarlyAccessShow) : Boolean(false);
      }
      
      private function onNodeClickHandler(param1:MouseEvent) : void
      {
         if(App.utils.commons.isRightButton(param1))
         {
            this.showContextMenu();
         }
         else
         {
            App.contextMenuMgr.hide();
         }
      }
      
      private function onNodeRollOutHandler(param1:MouseEvent) : void
      {
         this.rollOut();
      }
      
      private function onNodeRollOverHandler(param1:MouseEvent) : void
      {
         this.rollOver();
      }
   }
}
