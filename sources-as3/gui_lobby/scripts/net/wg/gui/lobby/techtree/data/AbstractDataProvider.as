package net.wg.gui.lobby.techtree.data
{
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import net.wg.data.constants.Errors;
   import net.wg.data.constants.generated.NODE_STATE_FLAGS;
   import net.wg.gui.lobby.techtree.TechTreeEvent;
   import net.wg.gui.lobby.techtree.data.vo.NodeData;
   import net.wg.gui.lobby.techtree.data.vo.UnlockProps;
   import net.wg.gui.lobby.techtree.interfaces.INodesDataProvider;
   import net.wg.infrastructure.exceptions.AbstractException;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class AbstractDataProvider implements INodesDataProvider
   {
      
      protected static const ARRAY:String = "Array";
       
      
      protected var nodeData:Vector.<NodeData>;
      
      protected var nodeIdxCache:Object;
      
      protected var dispatcher:EventDispatcher;
      
      private var _nation:String = "";
      
      private var _disposed:Boolean = false;
      
      public function AbstractDataProvider()
      {
         super();
         this.dispatcher = new EventDispatcher(this);
         this.nodeData = new Vector.<NodeData>();
      }
      
      protected static function findAndSetState(param1:Vector.<NodeData>, param2:Number, param3:Number, param4:Number) : Boolean
      {
         var _loc5_:Boolean = false;
         var _loc6_:Object = param1[param2];
         if(_loc6_ != null)
         {
            _loc5_ = (_loc6_.state & param3) != (param4 & param3);
            if(!_loc5_ && param3 == NODE_STATE_FLAGS.IN_INVENTORY)
            {
               _loc5_ = (_loc6_.state & NODE_STATE_FLAGS.VEHICLE_IN_RENT) != (param4 & NODE_STATE_FLAGS.VEHICLE_IN_RENT);
            }
            _loc6_.state = param4;
         }
         return _loc5_;
      }
      
      public function addEventListener(param1:String, param2:Function, param3:Boolean = false, param4:int = 0, param5:Boolean = false) : void
      {
         this.dispatcher.addEventListener(param1,param2,param3,param4,param5);
      }
      
      public function cleanUp() : void
      {
         this.clearNodeData(this.nodeData);
         this.nodeIdxCache = {};
      }
      
      public final function dispose() : void
      {
         this._disposed = true;
         this.onDispose();
      }
      
      public function getIndexByID(param1:Number) : Number
      {
         return this.nodeIdxCache[param1] != undefined ? Number(this.nodeIdxCache[param1]) : Number(-1);
      }
      
      public function getItemAt(param1:Number) : NodeData
      {
         return this.nodeData[param1];
      }
      
      public function getItemByID(param1:Number) : NodeData
      {
         var _loc2_:Number = this.getIndexByID(param1);
         var _loc3_:NodeData = null;
         if(this.nodeData.length > _loc2_ > -1)
         {
            _loc3_ = this.nodeData[_loc2_];
         }
         return _loc3_;
      }
      
      public function getRootItem() : NodeData
      {
         return this.nodeData.length > 0 ? this.nodeData[0] : null;
      }
      
      public function hasEventListener(param1:String) : Boolean
      {
         return this.dispatcher.hasEventListener(param1);
      }
      
      public function invalidate(param1:String, param2:Object) : void
      {
         this._nation = param1;
         if(param2 != null)
         {
            this.parse(param2);
            this.dispatchEvent(new TechTreeEvent(TechTreeEvent.DATA_BUILD_COMPLETE));
         }
      }
      
      public function isDisposed() : Boolean
      {
         return this._disposed;
      }
      
      public function isPremiumItem(param1:Number) : Boolean
      {
         return false;
      }
      
      public function parse(param1:Object) : void
      {
         throw new AbstractException(Errors.ABSTRACT_INVOKE);
      }
      
      public function removeEventListener(param1:String, param2:Function, param3:Boolean = false) : void
      {
         this.dispatcher.removeEventListener(param1,param2,param3);
      }
      
      public function setEarnedXP(param1:Number, param2:Number) : Boolean
      {
         var _loc3_:Boolean = false;
         if(param1 < this.nodeData.length && this.nodeData[param1] != null)
         {
            this.nodeData[param1].earnedXP = param2;
            _loc3_ = true;
         }
         return _loc3_;
      }
      
      public function setItemField(param1:String, param2:Number, param3:Object) : Boolean
      {
         var _loc5_:Array = null;
         var _loc6_:UnlockProps = null;
         var _loc4_:Boolean = false;
         if(param1 == NodeData.UNLOCK_PROPS_FIELD)
         {
            _loc5_ = param3 as Array;
            App.utils.asserter.assertNotNull(_loc5_,Errors.INVALID_TYPE + ARRAY);
            _loc6_ = new UnlockProps();
            _loc6_.fromArray(_loc5_,App.utils.locale);
            _loc4_ = this.setUnlockProps(param2,_loc6_);
         }
         return _loc4_;
      }
      
      public function setState(param1:Number, param2:Number, param3:Number) : Boolean
      {
         return findAndSetState(this.nodeData,param1,param2,param3);
      }
      
      public function setUnlockProps(param1:Number, param2:UnlockProps) : Boolean
      {
         var _loc3_:Boolean = false;
         if(param1 < this.nodeData.length && this.nodeData[param1] != null)
         {
            this.nodeData[param1].unlockProps = param2;
            _loc3_ = true;
         }
         return _loc3_;
      }
      
      public function willTrigger(param1:String) : Boolean
      {
         return this.dispatcher.willTrigger(param1);
      }
      
      protected function onDispose() : void
      {
         this.clearNodeData(this.nodeData);
         this.nodeIdxCache = null;
         this.dispatcher = null;
      }
      
      protected function clearNodeData(param1:Vector.<NodeData>) : void
      {
         var _loc2_:IDisposable = null;
         if(param1 != null)
         {
            App.toolTipMgr.hide();
            for each(_loc2_ in param1)
            {
               _loc2_.dispose();
            }
            param1.splice(0,param1.length);
            param1 = null;
         }
      }
      
      public function get nation() : String
      {
         return this._nation;
      }
      
      public function get length() : Number
      {
         return this.nodeData.length;
      }
      
      public function dispatchEvent(param1:Event) : Boolean
      {
         return this.dispatcher.dispatchEvent(param1);
      }
   }
}
