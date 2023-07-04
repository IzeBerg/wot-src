package net.wg.gui.lobby.techtree.data.state
{
   import net.wg.data.constants.Errors;
   import net.wg.data.constants.generated.NODE_STATE_FLAGS;
   import net.wg.gui.lobby.techtree.constants.ActionName;
   import net.wg.gui.lobby.techtree.constants.NodeEntityType;
   import net.wg.gui.lobby.techtree.constants.NodeRendererState;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   import net.wg.utils.IScheduler;
   
   public class NodeStateCollection implements IDisposable
   {
      
      private static var _instance:NodeStateCollection = null;
      
      private static const NATION_TREE_STATE_MASK:uint = NODE_STATE_FLAGS.LOCKED | NODE_STATE_FLAGS.NEXT_2_UNLOCK | NODE_STATE_FLAGS.UNLOCKED | NODE_STATE_FLAGS.IN_INVENTORY | NODE_STATE_FLAGS.WAS_IN_BATTLE | NODE_STATE_FLAGS.PREMIUM | NODE_STATE_FLAGS.VEHICLE_IN_RENT | NODE_STATE_FLAGS.RESTORE_AVAILABLE | NODE_STATE_FLAGS.RENT_AVAILABLE | NODE_STATE_FLAGS.LAST_2_BUY;
      
      private static const RESEARCH_ROOT_STATE_MASK:uint = NODE_STATE_FLAGS.LOCKED | NODE_STATE_FLAGS.NEXT_2_UNLOCK | NODE_STATE_FLAGS.UNLOCKED | NODE_STATE_FLAGS.IN_INVENTORY | NODE_STATE_FLAGS.RESTORE_AVAILABLE | NODE_STATE_FLAGS.PURCHASE_DISABLED | NODE_STATE_FLAGS.VEHICLE_IN_RENT | NODE_STATE_FLAGS.COLLECTIBLE | NODE_STATE_FLAGS.COLLECTIBLE_ACTION;
      
      private static const RESEARCH_MODULE_STATE_MASK:uint = NODE_STATE_FLAGS.LOCKED | NODE_STATE_FLAGS.NEXT_2_UNLOCK | NODE_STATE_FLAGS.UNLOCKED | NODE_STATE_FLAGS.IN_INVENTORY | NODE_STATE_FLAGS.INSTALLED;
      
      private static const BLUEPRINT_TREE_STATE_MASK:uint = NODE_STATE_FLAGS.LOCKED | NODE_STATE_FLAGS.NEXT_2_UNLOCK | NODE_STATE_FLAGS.UNLOCKED;
      
      private static const DISPOSE_DELAY:int = 1000;
       
      
      private var _disposed:Boolean = false;
      
      private var _defaultStateProps:StateProperties;
      
      private var _showAnimation:AnimationProperties;
      
      private var _NTNodeStateCollection:Vector.<NodeStateItem>;
      
      private var _blueprintNodeStateCollection:Vector.<NodeStateItem>;
      
      private var _rootNodeStateCollection:Vector.<NodeStateItem>;
      
      private var _moduleNodeStateCollection:Vector.<NodeStateItem>;
      
      private var _disposeInitiated:Boolean = false;
      
      private var _scheduler:IScheduler;
      
      public function NodeStateCollection()
      {
         this._defaultStateProps = new StateProperties(0,NodeRendererState.LOCKED);
         this._showAnimation = new AnimationProperties(150,{"alpha":0},{"alpha":1});
         this._NTNodeStateCollection = Vector.<NodeStateItem>([new NodeStateItem(NODE_STATE_FLAGS.LOCKED,new StateProperties(1,NodeRendererState.LOCKED,ActionName.UNLOCK,0,false,null,0.7)),new NodeStateItem(NODE_STATE_FLAGS.NEXT_2_UNLOCK,new StateProperties(2,NodeRendererState.NEXT2UNLOCK,ActionName.UNLOCK,NODE_STATE_FLAGS.ENOUGH_XP,true)),new UnlockedStateItem(new StateProperties(3,NodeRendererState.NEXT4BUY,ActionName.BUY,NODE_STATE_FLAGS.ENOUGH_MONEY,false,this._showAnimation),new StateProperties(4,NodeRendererState.NEXT4BUY,ActionName.BUY,NODE_STATE_FLAGS.ENOUGH_MONEY,true)),new NodeStateItem(NODE_STATE_FLAGS.UNLOCKED | NODE_STATE_FLAGS.WAS_IN_BATTLE,new StateProperties(4,NodeRendererState.NEXT4BUY,ActionName.BUY,NODE_STATE_FLAGS.ENOUGH_MONEY,false,this._showAnimation)),new NodeStateItem(NODE_STATE_FLAGS.UNLOCKED | NODE_STATE_FLAGS.PREMIUM,new StateProperties(5,NodeRendererState.PREMIUM,ActionName.BUY,NODE_STATE_FLAGS.ENOUGH_MONEY,true)),new NodeStateItem(NODE_STATE_FLAGS.UNLOCKED | NODE_STATE_FLAGS.PREMIUM | NODE_STATE_FLAGS.WAS_IN_BATTLE,new StateProperties(6,NodeRendererState.PREMIUM,ActionName.BUY,NODE_STATE_FLAGS.ENOUGH_MONEY,true)),new NodeStateItem(NODE_STATE_FLAGS.UNLOCKED | NODE_STATE_FLAGS.IN_INVENTORY,new StateProperties(7,NodeRendererState.INVENTORY)),new NodeStateItem(NODE_STATE_FLAGS.UNLOCKED | NODE_STATE_FLAGS.IN_INVENTORY | NODE_STATE_FLAGS.WAS_IN_BATTLE,new StateProperties(8,NodeRendererState.INVENTORY)),new NodeStateItem(NODE_STATE_FLAGS.UNLOCKED | NODE_STATE_FLAGS.PREMIUM | NODE_STATE_FLAGS.IN_INVENTORY,new StateProperties(9,NodeRendererState.PREMIUM_INVENTORY)),new NodeStateItem(NODE_STATE_FLAGS.UNLOCKED | NODE_STATE_FLAGS.PREMIUM | NODE_STATE_FLAGS.IN_INVENTORY | NODE_STATE_FLAGS.WAS_IN_BATTLE,new StateProperties(10,NodeRendererState.PREMIUM_INVENTORY)),new NodeStateItem(NODE_STATE_FLAGS.UNLOCKED | NODE_STATE_FLAGS.PREMIUM | NODE_STATE_FLAGS.IN_INVENTORY | NODE_STATE_FLAGS.VEHICLE_IN_RENT,new StateProperties(11,NodeRendererState.IN_RENT)),new NodeStateItem(NODE_STATE_FLAGS.UNLOCKED | NODE_STATE_FLAGS.PREMIUM | NODE_STATE_FLAGS.IN_INVENTORY | NODE_STATE_FLAGS.VEHICLE_IN_RENT | NODE_STATE_FLAGS.WAS_IN_BATTLE,new StateProperties(12,NodeRendererState.IN_RENT)),new NodeStateItem(NODE_STATE_FLAGS.RENT_AVAILABLE | NODE_STATE_FLAGS.UNLOCKED | NODE_STATE_FLAGS.PREMIUM,new StateProperties(13,NodeRendererState.RENT_AVAILABLE,ActionName.RENT,0,true)),new NodeStateItem(NODE_STATE_FLAGS.RESTORE_AVAILABLE | NODE_STATE_FLAGS.UNLOCKED | NODE_STATE_FLAGS.PREMIUM,new StateProperties(14,NodeRendererState.PREMIUM,ActionName.RESTORE,NODE_STATE_FLAGS.ENOUGH_MONEY,true)),new NodeStateItem(NODE_STATE_FLAGS.RESTORE_AVAILABLE | NODE_STATE_FLAGS.RENT_AVAILABLE | NODE_STATE_FLAGS.UNLOCKED | NODE_STATE_FLAGS.PREMIUM,new StateProperties(15,NodeRendererState.RENT_AVAILABLE,ActionName.RESTORE,NODE_STATE_FLAGS.ENOUGH_MONEY,true)),new NodeStateItem(NODE_STATE_FLAGS.RESTORE_AVAILABLE | NODE_STATE_FLAGS.VEHICLE_IN_RENT | NODE_STATE_FLAGS.UNLOCKED | NODE_STATE_FLAGS.PREMIUM | NODE_STATE_FLAGS.IN_INVENTORY,new StateProperties(16,NodeRendererState.RENT_AVAILABLE,ActionName.RESTORE,NODE_STATE_FLAGS.ENOUGH_MONEY,true)),new NodeStateItem(NODE_STATE_FLAGS.RENT_AVAILABLE | NODE_STATE_FLAGS.UNLOCKED | NODE_STATE_FLAGS.PREMIUM | NODE_STATE_FLAGS.WAS_IN_BATTLE,new StateProperties(17,NodeRendererState.RENT_AVAILABLE,ActionName.RENT,0,true)),new NodeStateItem(NODE_STATE_FLAGS.RESTORE_AVAILABLE | NODE_STATE_FLAGS.UNLOCKED | NODE_STATE_FLAGS.PREMIUM | NODE_STATE_FLAGS.WAS_IN_BATTLE,new StateProperties(18,NodeRendererState.PREMIUM,ActionName.RESTORE,NODE_STATE_FLAGS.ENOUGH_MONEY,true)),new NodeStateItem(NODE_STATE_FLAGS.RESTORE_AVAILABLE | NODE_STATE_FLAGS.RENT_AVAILABLE | NODE_STATE_FLAGS.UNLOCKED | NODE_STATE_FLAGS.PREMIUM | NODE_STATE_FLAGS.WAS_IN_BATTLE,new StateProperties(19,NodeRendererState.RENT_AVAILABLE,ActionName.RESTORE,NODE_STATE_FLAGS.ENOUGH_MONEY,true)),new NodeStateItem(NODE_STATE_FLAGS.RESTORE_AVAILABLE | NODE_STATE_FLAGS.VEHICLE_IN_RENT | NODE_STATE_FLAGS.WAS_IN_BATTLE | NODE_STATE_FLAGS.UNLOCKED | NODE_STATE_FLAGS.PREMIUM | NODE_STATE_FLAGS.IN_INVENTORY,new StateProperties(20,NodeRendererState.RENT_AVAILABLE,ActionName.RESTORE,NODE_STATE_FLAGS.ENOUGH_MONEY,true)),new NodeStateItem(NODE_STATE_FLAGS.UNLOCKED | NODE_STATE_FLAGS.LAST_2_BUY,new StateProperties(21,NodeRendererState.NEXT4BUY,ActionName.BUY,NODE_STATE_FLAGS.ENOUGH_MONEY,true)),new NodeStateItem(NODE_STATE_FLAGS.UNLOCKED | NODE_STATE_FLAGS.LAST_2_BUY | NODE_STATE_FLAGS.WAS_IN_BATTLE,new StateProperties(22,NodeRendererState.NEXT4BUY,ActionName.BUY,NODE_STATE_FLAGS.ENOUGH_MONEY,false,this._showAnimation))]);
         this._blueprintNodeStateCollection = Vector.<NodeStateItem>([new NodeStateItem(NODE_STATE_FLAGS.LOCKED,new StateProperties(31,NodeRendererState.BLUEPRINTS_LOCKED,ActionName.UNLOCK,0,false,null,0.7)),new NodeStateItem(NODE_STATE_FLAGS.NEXT_2_UNLOCK,new StateProperties(32,NodeRendererState.BLUEPRINTS_NEXT2UNLOCK,ActionName.UNLOCK,NODE_STATE_FLAGS.ENOUGH_XP,true)),new NodeStateItem(NODE_STATE_FLAGS.UNLOCKED,new StateProperties(33,NodeRendererState.BLUEPRINTS_UNLOCKED))]);
         this._rootNodeStateCollection = Vector.<NodeStateItem>([new NodeStateItem(NODE_STATE_FLAGS.LOCKED,new StateProperties(1,NodeRendererState.ROOT_UNLOCK,ActionName.UNLOCK,NODE_STATE_FLAGS.NEXT_2_UNLOCK,true)),new NodeStateItem(NODE_STATE_FLAGS.NEXT_2_UNLOCK,new StateProperties(2,NodeRendererState.ROOT_UNLOCK,ActionName.UNLOCK,NODE_STATE_FLAGS.ENOUGH_XP,true)),new NodeStateItem(NODE_STATE_FLAGS.UNLOCKED,new StateProperties(3,NodeRendererState.ROOT_BUY,ActionName.BUY,NODE_STATE_FLAGS.ENOUGH_MONEY,true)),new NodeStateItem(NODE_STATE_FLAGS.UNLOCKED | NODE_STATE_FLAGS.IN_INVENTORY,new StateProperties(4,NodeRendererState.ROOT_HANGAR,ActionName.SELECT_VEHICLE,0,true)),new NodeStateItem(NODE_STATE_FLAGS.UNLOCKED | NODE_STATE_FLAGS.IN_INVENTORY | NODE_STATE_FLAGS.VEHICLE_IN_RENT,new StateProperties(5,NodeRendererState.ROOT_BUY,ActionName.BUY,NODE_STATE_FLAGS.ENOUGH_MONEY,true)),new NodeStateItem(NODE_STATE_FLAGS.UNLOCKED | NODE_STATE_FLAGS.RESTORE_AVAILABLE,new StateProperties(6,NodeRendererState.ROOT_BUY,ActionName.RESTORE,NODE_STATE_FLAGS.ENOUGH_MONEY,true)),new NodeStateItem(NODE_STATE_FLAGS.UNLOCKED | NODE_STATE_FLAGS.IN_INVENTORY | NODE_STATE_FLAGS.RESTORE_AVAILABLE | NODE_STATE_FLAGS.VEHICLE_IN_RENT,new StateProperties(7,NodeRendererState.ROOT_BUY,ActionName.RESTORE,0,true)),new NodeStateItem(NODE_STATE_FLAGS.UNLOCKED | NODE_STATE_FLAGS.PURCHASE_DISABLED,new StateProperties(8,NodeRendererState.ROOT_HANGAR,ActionName.SELECT_VEHICLE,0,true)),new NodeStateItem(NODE_STATE_FLAGS.UNLOCKED | NODE_STATE_FLAGS.IN_INVENTORY | NODE_STATE_FLAGS.VEHICLE_IN_RENT | NODE_STATE_FLAGS.PURCHASE_DISABLED,new StateProperties(9,NodeRendererState.ROOT_HANGAR,ActionName.SELECT_VEHICLE,0,true)),new NodeStateItem(NODE_STATE_FLAGS.UNLOCKED | NODE_STATE_FLAGS.IN_INVENTORY | NODE_STATE_FLAGS.PURCHASE_DISABLED,new StateProperties(10,NodeRendererState.ROOT_HANGAR,ActionName.SELECT_VEHICLE,0,true)),new NodeStateItem(NODE_STATE_FLAGS.COLLECTIBLE,new StateProperties(11,NodeRendererState.ROOT_COLLECTIBLE,ActionName.SHOP,0,true)),new NodeStateItem(NODE_STATE_FLAGS.COLLECTIBLE | NODE_STATE_FLAGS.COLLECTIBLE_ACTION,new StateProperties(12,NodeRendererState.ROOT_DISCOUNTED_COLLECTIBLE,ActionName.SHOP,0,true)),new NodeStateItem(NODE_STATE_FLAGS.COLLECTIBLE | NODE_STATE_FLAGS.LOCKED,new StateProperties(13,NodeRendererState.ROOT_COLLECTIBLE,ActionName.SHOP,0,true)),new NodeStateItem(NODE_STATE_FLAGS.COLLECTIBLE | NODE_STATE_FLAGS.LOCKED | NODE_STATE_FLAGS.COLLECTIBLE_ACTION,new StateProperties(14,NodeRendererState.ROOT_DISCOUNTED_COLLECTIBLE,ActionName.SHOP,0,true)),new NodeStateItem(NODE_STATE_FLAGS.COLLECTIBLE | NODE_STATE_FLAGS.UNLOCKED,new StateProperties(15,NodeRendererState.ROOT_COLLECTIBLE,ActionName.SHOP,0,true)),new NodeStateItem(NODE_STATE_FLAGS.COLLECTIBLE | NODE_STATE_FLAGS.UNLOCKED | NODE_STATE_FLAGS.COLLECTIBLE_ACTION,new StateProperties(16,NodeRendererState.ROOT_DISCOUNTED_COLLECTIBLE,ActionName.SHOP,0,true)),new NodeStateItem(NODE_STATE_FLAGS.COLLECTIBLE | NODE_STATE_FLAGS.LOCKED | NODE_STATE_FLAGS.PURCHASE_DISABLED,new StateProperties(17,NodeRendererState.ROOT_COLLECTIBLE,ActionName.SHOP,0,true,null,1,false)),new NodeStateItem(NODE_STATE_FLAGS.COLLECTIBLE | NODE_STATE_FLAGS.LOCKED | NODE_STATE_FLAGS.PURCHASE_DISABLED | NODE_STATE_FLAGS.ACTION,new StateProperties(18,NodeRendererState.ROOT_DISCOUNTED_COLLECTIBLE,ActionName.SHOP,0,true,null,1,false)),new NodeStateItem(NODE_STATE_FLAGS.COLLECTIBLE | NODE_STATE_FLAGS.IN_INVENTORY,new StateProperties(19,NodeRendererState.ROOT_COLLECTIBLE,ActionName.SHOP,0,true)),new NodeStateItem(NODE_STATE_FLAGS.COLLECTIBLE | NODE_STATE_FLAGS.IN_INVENTORY | NODE_STATE_FLAGS.UNLOCKED,new StateProperties(20,NodeRendererState.ROOT_COLLECTIBLE,ActionName.SHOP,0,true)),new NodeStateItem(NODE_STATE_FLAGS.COLLECTIBLE | NODE_STATE_FLAGS.IN_INVENTORY | NODE_STATE_FLAGS.UNLOCKED | NODE_STATE_FLAGS.PURCHASE_DISABLED,new StateProperties(21,NodeRendererState.ROOT_COLLECTIBLE,ActionName.SHOP,0,true,null,1,false))]);
         this._moduleNodeStateCollection = Vector.<NodeStateItem>([new NodeStateItem(NODE_STATE_FLAGS.LOCKED,new StateProperties(1,NodeRendererState.LOCKED,ActionName.UNLOCK)),new NodeStateItem(NODE_STATE_FLAGS.NEXT_2_UNLOCK,new StateProperties(2,NodeRendererState.NEXT2UNLOCK,ActionName.UNLOCK,NODE_STATE_FLAGS.ENOUGH_XP,true)),new UnlockedStateItem(new StateProperties(3,NodeRendererState.UNLOCKED),new StateProperties(4,NodeRendererState.NEXT4BUY,ActionName.BUY,NODE_STATE_FLAGS.ENOUGH_MONEY,true)),new NodeStateItem(NODE_STATE_FLAGS.UNLOCKED | NODE_STATE_FLAGS.IN_INVENTORY,new StateProperties(5,NodeRendererState.UNLOCKED)),new NodeStateItem(NODE_STATE_FLAGS.UNLOCKED | NODE_STATE_FLAGS.INSTALLED,new StateProperties(6,NodeRendererState.INSTALLED)),new NodeStateItem(NODE_STATE_FLAGS.UNLOCKED | NODE_STATE_FLAGS.IN_INVENTORY | NODE_STATE_FLAGS.INSTALLED,new StateProperties(7,NodeRendererState.INSTALLED))]);
         this._scheduler = App.utils.scheduler;
         App.utils.asserter.assertNull(_instance,"Class instance" + Errors.ALREADY_REGISTERED);
         super();
         _instance = this;
      }
      
      public static function get instance() : NodeStateCollection
      {
         if(_instance == null)
         {
            new NodeStateCollection();
         }
         else if(_instance._disposeInitiated)
         {
            _instance._scheduler.cancelTask(_instance.doDispose);
            _instance._disposeInitiated = false;
         }
         return _instance;
      }
      
      public final function dispose() : void
      {
         this._disposed = true;
         this._scheduler.scheduleTask(this.doDispose,DISPOSE_DELAY);
         this._disposeInitiated = true;
      }
      
      public function getStateProps(param1:uint, param2:uint, param3:Object = null) : StateProperties
      {
         var _loc4_:Vector.<NodeStateItem> = null;
         var _loc5_:uint = 0;
         switch(param1)
         {
            case NodeEntityType.NATION_TREE:
            case NodeEntityType.TOP_VEHICLE:
            case NodeEntityType.NEXT_VEHICLE:
               _loc4_ = this._NTNodeStateCollection;
               _loc5_ = NATION_TREE_STATE_MASK;
               break;
            case NodeEntityType.BLUEPRINT_TREE:
               _loc4_ = this._blueprintNodeStateCollection;
               _loc5_ = BLUEPRINT_TREE_STATE_MASK;
               break;
            case NodeEntityType.RESEARCH_ROOT:
               _loc4_ = this._rootNodeStateCollection;
               _loc5_ = RESEARCH_ROOT_STATE_MASK;
               break;
            case NodeEntityType.RESEARCH_ITEM:
               _loc4_ = this._moduleNodeStateCollection;
               _loc5_ = RESEARCH_MODULE_STATE_MASK;
               break;
            default:
               return this._defaultStateProps;
         }
         param2 &= _loc5_;
         return this.percolateStateProps(param2,_loc4_,param3);
      }
      
      public function isDisposed() : Boolean
      {
         return this._disposed;
      }
      
      public function isRedrawNTLines(param1:String) : Boolean
      {
         return param1 == NodeRendererState.NEXT2UNLOCK || param1 == NodeRendererState.BLUEPRINTS_NEXT2UNLOCK || NodeRendererState.NEXT4BUY || NodeRendererState.INVENTORY;
      }
      
      public function isRedrawResearchLines(param1:String) : Boolean
      {
         return Boolean(param1 == NodeRendererState.UNLOCKED || param1 == NodeRendererState.NEXT2UNLOCK || param1 == NodeRendererState.NEXT4BUY || NodeRendererState.ROOT_BUY);
      }
      
      protected function onDispose() : void
      {
         var _loc1_:NodeStateItem = null;
         this._defaultStateProps.dispose();
         this._defaultStateProps = null;
         this._showAnimation.dispose();
         this._showAnimation = null;
         for each(_loc1_ in this._NTNodeStateCollection)
         {
            _loc1_.dispose();
         }
         this._NTNodeStateCollection.splice(0,this._NTNodeStateCollection.length);
         this._NTNodeStateCollection = null;
         for each(_loc1_ in this._blueprintNodeStateCollection)
         {
            _loc1_.dispose();
         }
         this._blueprintNodeStateCollection.splice(0,this._blueprintNodeStateCollection.length);
         this._blueprintNodeStateCollection = null;
         for each(_loc1_ in this._rootNodeStateCollection)
         {
            _loc1_.dispose();
         }
         this._rootNodeStateCollection.splice(0,this._rootNodeStateCollection.length);
         this._rootNodeStateCollection = null;
         for each(_loc1_ in this._moduleNodeStateCollection)
         {
            _loc1_.dispose();
         }
         this._moduleNodeStateCollection.splice(0,this._moduleNodeStateCollection.length);
         this._moduleNodeStateCollection = null;
         this._scheduler = null;
      }
      
      private function doDispose() : void
      {
         _instance = null;
         this.onDispose();
      }
      
      private function percolateStateProps(param1:uint, param2:Vector.<NodeStateItem>, param3:Object = null) : StateProperties
      {
         var _loc4_:NodeStateItem = null;
         for each(_loc4_ in param2)
         {
            if(param1 == _loc4_.getState())
            {
               return _loc4_.resolveProps(param3);
            }
         }
         return this._defaultStateProps;
      }
   }
}
