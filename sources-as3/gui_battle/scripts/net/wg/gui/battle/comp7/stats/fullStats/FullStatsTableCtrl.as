package net.wg.gui.battle.comp7.stats.fullStats
{
   import flash.utils.Dictionary;
   import net.wg.gui.battle.comp7.VO.daapi.Comp7InterestPointVO;
   import net.wg.gui.battle.comp7.infrastructure.interfaces.IPoiContainer;
   import net.wg.gui.battle.comp7.stats.fullStats.tableItem.AnonymizerCtrl;
   import net.wg.gui.battle.comp7.stats.fullStats.tableItem.StatsTableItem;
   import net.wg.gui.battle.comp7.stats.fullStats.tableItem.StatsTableItemHolder;
   import net.wg.gui.battle.views.stats.fullStats.DogTagCtrl;
   import net.wg.gui.battle.views.stats.fullStats.StatsTableControllerBase;
   import net.wg.gui.battle.views.stats.fullStats.StatsTableItemHolderBase;
   
   public class FullStatsTableCtrl extends StatsTableControllerBase implements IPoiContainer
   {
      
      private static const RIGHT_COLUMN:int = 1;
      
      private static const NUM_ROWS:int = 7;
       
      
      private var _poiDataStorage:Dictionary;
      
      public function FullStatsTableCtrl(param1:FullStatsTable)
      {
         this._poiDataStorage = new Dictionary();
         super(param1);
      }
      
      override protected function onDispose() : void
      {
         var _loc1_:Vector.<Comp7InterestPointVO> = null;
         for each(_loc1_ in this._poiDataStorage)
         {
            _loc1_.length = 0;
         }
         App.utils.data.cleanupDynamicObject(this._poiDataStorage);
         this._poiDataStorage = null;
         super.onDispose();
      }
      
      override protected function createItemHolder(param1:int, param2:int) : StatsTableItemHolderBase
      {
         var _loc3_:FullStatsTable = this.getTable();
         var _loc4_:StatsTableItem = new StatsTableItem(_loc3_,param1,param2);
         var _loc5_:DogTagCtrl = new DogTagCtrl(_loc3_.hitCollection[this.calcIndex(param1,param2)]);
         var _loc6_:AnonymizerCtrl = new AnonymizerCtrl(_loc3_.hitCollection[this.calcIndex(param1,param2)]);
         return new StatsTableItemHolder(_loc4_,_loc5_,_loc6_,param1 == RIGHT_COLUMN);
      }
      
      override protected function onItemDataSet(param1:StatsTableItemHolderBase, param2:Boolean) : void
      {
         var _loc5_:Comp7InterestPointVO = null;
         super.onItemDataSet(param1,param2);
         if(param2)
         {
            return;
         }
         var _loc3_:StatsTableItemHolder = param1 as StatsTableItemHolder;
         if(!_loc3_ || !_loc3_.containsData)
         {
            if(_loc3_)
            {
               _loc3_.removeAllPOI();
            }
            return;
         }
         var _loc4_:Vector.<Comp7InterestPointVO> = this._poiDataStorage[_loc3_.getVehicleID()];
         _loc3_.removeAllPOI();
         if(_loc4_)
         {
            for each(_loc5_ in _loc4_)
            {
               _loc3_.updatePointOfInterest(_loc5_,false);
            }
         }
      }
      
      public function removePointOfInterest(param1:uint, param2:uint) : void
      {
         var _loc5_:int = 0;
         var _loc6_:Comp7InterestPointVO = null;
         var _loc3_:Vector.<Comp7InterestPointVO> = this._poiDataStorage[param1];
         if(_loc3_)
         {
            _loc5_ = _loc3_.length - 1;
            while(_loc5_ >= 0)
            {
               if(_loc3_[_loc5_].type == param2)
               {
                  _loc3_.splice(_loc5_,1);
                  break;
               }
               _loc5_--;
            }
            if(!_loc3_.length)
            {
               delete this._poiDataStorage[param1];
            }
         }
         var _loc4_:StatsTableItemHolder = this.getAllyRendererByVehicleID(param1);
         if(_loc4_)
         {
            _loc4_.removePointOfInterest(param1,param2);
         }
      }
      
      public function updatePointOfInterest(param1:Comp7InterestPointVO, param2:Boolean = true) : void
      {
         var _loc3_:Vector.<Comp7InterestPointVO> = this._poiDataStorage[param1.vehicleID];
         if(!_loc3_)
         {
            _loc3_ = new Vector.<Comp7InterestPointVO>();
            this._poiDataStorage[param1.vehicleID] = _loc3_;
         }
         var _loc4_:int = _loc3_.length;
         var _loc5_:Boolean = false;
         var _loc6_:int = 0;
         while(_loc6_ < _loc4_)
         {
            if(_loc3_[_loc6_].type == param1.type)
            {
               _loc3_[_loc6_] = param1;
               _loc5_ = true;
               break;
            }
            _loc6_++;
         }
         if(!_loc5_)
         {
            _loc3_.push(param1);
         }
         var _loc7_:StatsTableItemHolder = this.getAllyRendererByVehicleID(param1.vehicleID);
         if(_loc7_)
         {
            _loc7_.updatePointOfInterest(param1);
         }
      }
      
      private function getAllyRendererByVehicleID(param1:uint) : StatsTableItemHolder
      {
         var _loc2_:StatsTableItemHolder = null;
         for each(_loc2_ in allyRenderers)
         {
            if(_loc2_.containsData && _loc2_.getVehicleID() == param1)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      private function calcIndex(param1:int, param2:int) : int
      {
         return param1 * this.numRows + param2;
      }
      
      private function getTable() : FullStatsTable
      {
         return FullStatsTable(table);
      }
      
      override protected function get numRows() : int
      {
         return NUM_ROWS;
      }
   }
}
