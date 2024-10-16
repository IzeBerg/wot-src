package net.wg.gui.lobby.vehicleCompare.nodes
{
   import flash.geom.Point;
   import net.wg.data.constants.Values;
   import net.wg.data.constants.generated.NODE_STATE_FLAGS;
   import net.wg.gui.components.controls.SoundListItemRenderer;
   import net.wg.gui.lobby.techtree.TechTreeEvent;
   import net.wg.gui.lobby.techtree.data.vo.NTDisplayInfo;
   import net.wg.gui.lobby.techtree.data.vo.NodeData;
   import net.wg.gui.lobby.techtree.interfaces.INodesContainer;
   import net.wg.gui.lobby.techtree.interfaces.IRenderer;
   import net.wg.gui.lobby.techtree.interfaces.IResearchContainer;
   import scaleform.clik.constants.InvalidationType;
   
   public class ModuleRenderer extends SoundListItemRenderer implements IRenderer
   {
      
      public static const LINES_AND_ARROWS_NAME:String = "linesAndArrows";
      
      private static const STATE_UP:String = "up";
       
      
      private var _dataInited:Boolean;
      
      private var _container:IResearchContainer = null;
      
      private var _entityType:uint = 0;
      
      private var _valueObject:NodeData;
      
      private var _matrixPosition:Object;
      
      public function ModuleRenderer()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         this._valueObject = null;
         this._dataInited = false;
         this._matrixPosition = null;
         this._container = null;
         super.onDispose();
      }
      
      override protected function preInitialize() : void
      {
         constraintsDisabled = true;
         super.preInitialize();
         _state = STATE_UP;
         this._dataInited = false;
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(!_baseDisposed)
         {
            if(isInvalid(InvalidationType.DATA))
            {
               if(this._valueObject != null)
               {
                  visible = true;
                  this.applyData();
               }
               else
               {
                  visible = false;
               }
            }
         }
      }
      
      public function applyData() : void
      {
      }
      
      public function canHaveBlueprint() : Boolean
      {
         return false;
      }
      
      public function getActualWidth() : Number
      {
         return hitArea != null ? Number(hitArea.width) : Number(_width);
      }
      
      public function getColorIndex(param1:IRenderer = null) : uint
      {
         return 0;
      }
      
      public function getDisplayInfo() : Object
      {
         return !!this._dataInited ? this._valueObject.displayInfo : null;
      }
      
      public function getEarnedXP() : Number
      {
         return 0;
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
         return Math.round(x + (hitArea != null ? hitArea.x : 0));
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
         return !!this._dataInited ? int(this._valueObject.level) : int(-1);
      }
      
      public function getOutX() : Number
      {
         return x + (hitArea != null ? hitArea.x + Math.round(hitArea.width) : Math.round(_width));
      }
      
      public function getRatioY() : Number
      {
         return hitArea != null ? Number(Math.round(hitArea.height) >> 1) : Number(Math.round(_height) >> 1);
      }
      
      public function getY() : Number
      {
         return y + (hitArea != null ? hitArea.y + (Math.round(hitArea.height) >> 1) : Math.round(_height) >> 1);
      }
      
      public function inInventory() : Boolean
      {
         return this._dataInited && (this._valueObject.state & NODE_STATE_FLAGS.IN_INVENTORY) > 0;
      }
      
      public function invalidateNodeState() : void
      {
         setState(state);
         App.contextMenuMgr.hide();
         dispatchEvent(new TechTreeEvent(TechTreeEvent.STATE_CHANGED,this.nodeState,_index,this._entityType));
      }
      
      public function isActionEnabled() : Boolean
      {
         return false;
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
         return !this.isUnlocked();
      }
      
      public function isNext2Unlock() : Boolean
      {
         return false;
      }
      
      public function isPremium() : Boolean
      {
         return false;
      }
      
      public function isCollectible() : Boolean
      {
         return false;
      }
      
      public function isSelected() : Boolean
      {
         return this._dataInited && (this._valueObject.state & NODE_STATE_FLAGS.SELECTED) > 0;
      }
      
      public function isTradeIn() : Boolean
      {
         return false;
      }
      
      public function isUnlocked() : Boolean
      {
         return this._dataInited && (this._valueObject.state & NODE_STATE_FLAGS.UNLOCKED) > 0;
      }
      
      public function setPosition(param1:Point) : void
      {
         if(hitArea != null)
         {
            this.x = Math.round(param1.x - hitArea.x);
            this.y = Math.round(param1.y - hitArea.y);
         }
         else
         {
            this.x = param1.x;
            this.y = param1.y;
         }
      }
      
      public function setup(param1:uint, param2:NodeData, param3:uint = 0, param4:Object = null) : void
      {
         var _loc6_:Point = null;
         if(param3 != 0)
         {
            this._entityType = param3;
         }
         this._index = param1;
         this._matrixPosition = param4;
         if(this._valueObject == param2 || param2 == null)
         {
            return;
         }
         this._valueObject = param2;
         this._dataInited = true;
         setState(state);
         var _loc5_:Object = this.getDisplayInfo();
         if(_loc5_ != null && _loc5_ is NTDisplayInfo)
         {
            _loc6_ = NTDisplayInfo(_loc5_).position;
            if(_loc6_ != null)
            {
               this.setPosition(_loc6_);
            }
         }
      }
      
      public function get nodeState() : String
      {
         return Values.EMPTY_STR;
      }
      
      public function get bottomArrowOffset() : Number
      {
         return 0;
      }
      
      public function get container() : INodesContainer
      {
         return this._container;
      }
      
      public function set container(param1:INodesContainer) : void
      {
         this._container = IResearchContainer(param1);
      }
      
      public function get matrixPosition() : Object
      {
         return this._matrixPosition;
      }
      
      public function get valueObject() : NodeData
      {
         return this._valueObject;
      }
      
      public function get entityType() : uint
      {
         return this._entityType;
      }
      
      public function set entityType(param1:uint) : void
      {
         this._entityType = param1;
      }
      
      public function isTopActionNode() : Boolean
      {
         return false;
      }
      
      public function cleanUp() : void
      {
      }
      
      public function getNodeData() : NodeData
      {
         return null;
      }
   }
}
