package net.wg.gui.battle.epicBattle.views.data
{
   import flash.utils.Dictionary;
   import net.wg.data.VO.daapi.DAAPIVehicleInfoVO;
   import net.wg.gui.battle.battleloading.data.VehiclesDataProvider;
   import net.wg.gui.battle.battleloading.interfaces.IVehiclesDataProvider;
   import net.wg.gui.battle.epicBattle.VO.daapi.EpicVehicleStatsVO;
   
   public class EpicVehicleDataProvider extends VehiclesDataProvider implements IVehiclesDataProvider
   {
      
      private static const MAX_PLAYER_ENTRIES:int = 30;
       
      
      private var _activeLane:int = -1;
      
      private var _activeLaneVehicleIDs:Vector.<Number> = null;
      
      private var _epicStats:Dictionary = null;
      
      public function EpicVehicleDataProvider(param1:Array = null)
      {
         super(param1);
      }
      
      override public function cleanUp() : void
      {
         if(this._activeLaneVehicleIDs != null)
         {
            this._activeLaneVehicleIDs.fixed = false;
            this._activeLaneVehicleIDs.splice(0,this._activeLaneVehicleIDs.length);
            this._activeLaneVehicleIDs = null;
         }
         if(this._epicStats != null)
         {
            App.utils.data.cleanupDynamicObject(this._epicStats);
            this._epicStats = null;
         }
         super.cleanUp();
      }
      
      override public function setSorting(param1:Vector.<Number>) : Boolean
      {
         if(!super.setSorting(param1))
         {
            return false;
         }
         if(this._activeLaneVehicleIDs)
         {
            this._activeLaneVehicleIDs.sort(this.laneSortingCompare);
         }
         return true;
      }
      
      override public function setSource(param1:Array) : void
      {
         super.setSource(param1);
         this._activeLaneVehicleIDs = new Vector.<Number>(MAX_PLAYER_ENTRIES,true);
         this._epicStats = new Dictionary();
      }
      
      public function getActiveLaneVehicleData() : Array
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:DAAPIVehicleInfoVO = null;
         var _loc1_:Array = [];
         if(this._activeLaneVehicleIDs)
         {
            _loc2_ = this._activeLaneVehicleIDs.length;
            _loc3_ = 0;
            while(_loc3_ < _loc2_)
            {
               if(this._activeLaneVehicleIDs[_loc3_] != 0)
               {
                  _loc4_ = vehicleIDs.indexOf(this._activeLaneVehicleIDs[_loc3_]);
                  _loc5_ = this[_loc4_] as DAAPIVehicleInfoVO;
                  if(_loc5_)
                  {
                     _loc1_.push(_loc5_);
                  }
               }
               _loc3_++;
            }
         }
         return _loc1_;
      }
      
      public function getIndexOf(param1:Number, param2:Boolean) : int
      {
         if(param2 && this._activeLaneVehicleIDs)
         {
            return this._activeLaneVehicleIDs.indexOf(param1);
         }
         return vehicleIDs.indexOf(param1);
      }
      
      public function requestEpicData(param1:Number) : EpicVehicleStatsVO
      {
         return this._epicStats[param1];
      }
      
      public function requestVehicleData(param1:Number) : DAAPIVehicleInfoVO
      {
         var _loc2_:int = vehicleIDs.indexOf(param1);
         return this[_loc2_] as DAAPIVehicleInfoVO;
      }
      
      public function updateEpicStats(param1:Vector.<EpicVehicleStatsVO>) : Boolean
      {
         var _loc3_:EpicVehicleStatsVO = null;
         var _loc4_:int = 0;
         var _loc5_:DAAPIVehicleInfoVO = null;
         var _loc2_:Boolean = false;
         for each(_loc3_ in param1)
         {
            _loc4_ = vehicleIDs.indexOf(_loc3_.vehicleID);
            _loc5_ = this[_loc4_] as DAAPIVehicleInfoVO;
            if(_loc5_ != null)
            {
               if(this._epicStats[_loc3_.vehicleID])
               {
                  this._epicStats[_loc3_.vehicleID].rank = _loc3_.rank;
                  this._epicStats[_loc3_.vehicleID].frags = _loc3_.frags;
                  this._epicStats[_loc3_.vehicleID].hasRespawns = _loc3_.hasRespawns;
               }
               else
               {
                  this._epicStats[_loc3_.vehicleID] = _loc3_;
               }
               this.evaluatePlayerLane(this._epicStats[_loc3_.vehicleID],_loc3_,_loc3_.vehicleID);
               this._epicStats[_loc3_.vehicleID].lane = _loc3_.lane;
               _loc2_ = true;
               addUpdatedIndex(_loc4_);
            }
         }
         return _loc2_;
      }
      
      private function resetActiveLaneVehicleList(param1:int) : void
      {
         var _loc6_:DAAPIVehicleInfoVO = null;
         if(this._activeLaneVehicleIDs == null)
         {
            return;
         }
         var _loc2_:int = this._activeLaneVehicleIDs.length;
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_)
         {
            this._activeLaneVehicleIDs[_loc3_] = 0;
            _loc3_++;
         }
         var _loc4_:int = 0;
         _loc2_ = vehicleIDs.length;
         var _loc5_:int = 0;
         while(_loc5_ < _loc2_)
         {
            _loc6_ = this[_loc5_] as DAAPIVehicleInfoVO;
            if(_loc6_ != null && this._epicStats[_loc6_.vehicleID] && this._epicStats[_loc6_.vehicleID].lane == param1 && param1 > 0)
            {
               this._activeLaneVehicleIDs[_loc4_] = _loc6_.vehicleID;
               addUpdatedIndex(vehicleIDs.indexOf(_loc6_.vehicleID));
               _loc4_ += 1;
            }
            _loc5_++;
         }
      }
      
      private function evaluatePlayerLane(param1:EpicVehicleStatsVO, param2:EpicVehicleStatsVO, param3:Number) : void
      {
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         if(param1.lane >= 0 && param2.lane > 0 && this._activeLane > 0 && this._activeLaneVehicleIDs)
         {
            _loc4_ = this._activeLaneVehicleIDs.indexOf(param3);
            _loc5_ = 0;
            if(param1.lane == this._activeLane && param2.lane != this._activeLane && _loc4_ != -1)
            {
               this._activeLaneVehicleIDs[_loc4_] = 0;
            }
            else if(param1.lane != this._activeLane && param2.lane == this._activeLane && _loc4_ == -1)
            {
               _loc5_ = this.getNextFreeIndex();
               this._activeLaneVehicleIDs[_loc5_] = param2.vehicleID;
            }
            else if(param1.lane == param2.lane && param2.lane == this._activeLane && _loc4_ == -1)
            {
               _loc5_ = this.getNextFreeIndex();
               this._activeLaneVehicleIDs[_loc5_] = param2.vehicleID;
            }
         }
      }
      
      private function laneSortingCompare(param1:Number, param2:Number) : Number
      {
         var _loc3_:int = vehicleIDs.indexOf(param1);
         var _loc4_:int = vehicleIDs.indexOf(param2);
         if(_loc3_ == -1 && _loc4_ != -1)
         {
            return 1;
         }
         if(_loc3_ != -1 && _loc4_ == -1)
         {
            return -1;
         }
         if(_loc3_ > _loc4_)
         {
            return 1;
         }
         if(_loc3_ < _loc4_)
         {
            return -1;
         }
         return 0;
      }
      
      private function getNextFreeIndex() : int
      {
         var _loc1_:int = this._activeLaneVehicleIDs.length;
         var _loc2_:int = 0;
         while(_loc2_ < _loc1_)
         {
            if(this._activeLaneVehicleIDs[_loc2_] == 0)
            {
               return _loc2_;
            }
            _loc2_++;
         }
         return -1;
      }
      
      public function set activeLane(param1:int) : void
      {
         if(param1 != this._activeLane)
         {
            this.resetActiveLaneVehicleList(param1);
         }
         this._activeLane = param1;
      }
   }
}
