package net.wg.gui.battle.views.stats.fullStats
{
   import flash.text.TextField;
   import flash.utils.Dictionary;
   import net.wg.data.VO.daapi.DAAPIVehicleInfoVO;
   import net.wg.data.VO.daapi.DAAPIVehicleUserTagsVO;
   import net.wg.data.constants.Errors;
   import net.wg.gui.battle.battleloading.data.VehiclesDataProvider;
   import net.wg.gui.battle.interfaces.IStatsTableController;
   import net.wg.infrastructure.events.ListDataProviderEvent;
   import net.wg.infrastructure.exceptions.AbstractException;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   import scaleform.gfx.TextFieldEx;
   
   public class StatsTableControllerBase implements IStatsTableController, IDisposable
   {
       
      
      protected var numRows:int = 15;
      
      protected var activePlayerData:DAAPIVehicleInfoVO;
      
      protected var _teamDP:VehiclesDataProvider;
      
      protected var _enemyDP:VehiclesDataProvider;
      
      protected var _allyRenderers:Vector.<StatsTableItemHolderBase>;
      
      protected var _enemyRenderers:Vector.<StatsTableItemHolderBase>;
      
      protected var _dogTagsToShow:Dictionary;
      
      private var _isRenderingAvailable:Boolean;
      
      private var _disposed:Boolean = false;
      
      public function StatsTableControllerBase()
      {
         super();
         this._teamDP = new VehiclesDataProvider();
         this._teamDP.addEventListener(ListDataProviderEvent.VALIDATE_ITEMS,this.onAllyDataProviderUpdateItemHandler);
         this._enemyDP = new VehiclesDataProvider();
         this._enemyDP.addEventListener(ListDataProviderEvent.VALIDATE_ITEMS,this.onEnemyDataProviderUpdateItemHandler);
         this._allyRenderers = new Vector.<StatsTableItemHolderBase>(0);
         this._enemyRenderers = new Vector.<StatsTableItemHolderBase>(0);
         this._dogTagsToShow = new Dictionary();
      }
      
      protected function onAllyDataProviderUpdateItemHandler(param1:ListDataProviderEvent) : void
      {
         var _loc4_:int = 0;
         var _loc5_:StatsTableItemHolderBase = null;
         var _loc6_:DAAPIVehicleInfoVO = null;
         var _loc2_:uint = this._allyRenderers.length - 1;
         var _loc3_:Vector.<int> = Vector.<int>(param1.data);
         if(this.activePlayerData == null)
         {
            this.updateActivePlayerVO(_loc3_);
         }
         for each(_loc4_ in _loc3_)
         {
            if(_loc4_ <= _loc2_)
            {
               _loc5_ = this._allyRenderers[_loc4_];
               _loc6_ = this._teamDP.requestItemAt(_loc4_) as DAAPIVehicleInfoVO;
               _loc5_.setDAAPIVehicleData(_loc6_);
               if(this.activePlayerData)
               {
                  _loc5_.setActivePlayerData(this.activePlayerData);
               }
               if(_loc5_.isSelected)
               {
                  this.setSelectedItem(false,_loc4_);
               }
               this.onItemDataSet(_loc5_,false);
            }
         }
      }
      
      private function updateActivePlayerVO(param1:Vector.<int>) : void
      {
         var _loc2_:int = 0;
         for each(_loc2_ in param1)
         {
            this.activePlayerData = this._teamDP.requestItemAt(_loc2_) as DAAPIVehicleInfoVO;
            if(this.activePlayerData.isCurrentPlayer)
            {
               break;
            }
         }
      }
      
      protected function onEnemyDataProviderUpdateItemHandler(param1:ListDataProviderEvent) : void
      {
         var _loc4_:int = 0;
         var _loc5_:StatsTableItemHolderBase = null;
         var _loc6_:DAAPIVehicleInfoVO = null;
         var _loc7_:* = null;
         var _loc2_:uint = this._enemyRenderers.length - 1;
         var _loc3_:Vector.<int> = Vector.<int>(param1.data);
         for each(_loc4_ in _loc3_)
         {
            if(_loc4_ <= _loc2_)
            {
               _loc5_ = this._enemyRenderers[_loc4_];
               _loc6_ = this._enemyDP.requestItemAt(_loc4_) as DAAPIVehicleInfoVO;
               _loc5_.setDAAPIVehicleData(_loc6_);
               _loc5_.showDogTag(null);
               for(_loc7_ in this._dogTagsToShow)
               {
                  if(Number(_loc7_) == _loc6_.vehicleID)
                  {
                     _loc5_.showDogTag(this._dogTagsToShow[_loc7_]);
                     break;
                  }
               }
               if(_loc5_.isSelected)
               {
                  this.setSelectedItem(true,_loc4_);
               }
               this.onItemDataSet(_loc5_,true);
            }
         }
         this.updateDogTags();
      }
      
      protected function updateDogTags() : void
      {
         var _loc1_:StatsTableItemHolderBase = null;
         var _loc2_:Number = NaN;
         var _loc3_:* = null;
         for each(_loc1_ in this._enemyRenderers)
         {
            if(_loc1_.containsData)
            {
               _loc2_ = _loc1_.getVehicleID();
               for(_loc3_ in this._dogTagsToShow)
               {
                  if(Number(_loc3_) == _loc2_)
                  {
                     _loc1_.showDogTag(this._dogTagsToShow[_loc3_]);
                  }
               }
            }
         }
      }
      
      public function setVehiclesData(param1:Array, param2:Vector.<Number>, param3:Boolean) : void
      {
         var _loc4_:VehiclesDataProvider = !!param3 ? this._enemyDP : this._teamDP;
         _loc4_.setSource(param1);
         _loc4_.setSorting(param2);
         _loc4_.invalidate();
      }
      
      public function addVehiclesInfo(param1:Vector.<DAAPIVehicleInfoVO>, param2:Vector.<Number>, param3:Boolean) : void
      {
         var _loc4_:VehiclesDataProvider = !!param3 ? this._enemyDP : this._teamDP;
         if(_loc4_.addVehiclesInfo(param1,param2))
         {
            _loc4_.invalidate();
         }
      }
      
      public function setTeamsInfo(param1:String, param2:String) : void
      {
      }
      
      public function updateVehiclesData(param1:Vector.<DAAPIVehicleInfoVO>, param2:Vector.<Number>, param3:Boolean) : void
      {
         var _loc4_:VehiclesDataProvider = !!param3 ? this._enemyDP : this._teamDP;
         var _loc5_:Boolean = _loc4_.updateVehiclesInfo(param1);
         _loc5_ = _loc4_.setSorting(param2) || _loc5_;
         if(_loc5_)
         {
            _loc4_.invalidate();
         }
      }
      
      public function setVehicleStatus(param1:Boolean, param2:Number, param3:uint, param4:Vector.<Number>) : void
      {
         var _loc5_:VehiclesDataProvider = !!param1 ? this._enemyDP : this._teamDP;
         var _loc6_:Boolean = _loc5_.setVehicleStatus(param2,param3);
         _loc6_ = _loc5_.setSorting(param4) || _loc6_;
         if(_loc6_)
         {
            _loc5_.invalidate();
         }
      }
      
      public function setPlayerStatus(param1:Boolean, param2:Number, param3:uint) : void
      {
         var _loc4_:VehiclesDataProvider = !!param1 ? this._enemyDP : this._teamDP;
         if(_loc4_.setPlayerStatus(param2,param3))
         {
            _loc4_.invalidate();
         }
      }
      
      public function setUserTags(param1:Boolean, param2:Vector.<DAAPIVehicleUserTagsVO>) : void
      {
         var _loc3_:VehiclesDataProvider = !!param1 ? this._enemyDP : this._teamDP;
         if(_loc3_.setUserTags(param2))
         {
            _loc3_.invalidate();
         }
      }
      
      public function updateColorBlind() : void
      {
         var _loc1_:StatsTableItemHolderBase = null;
         for each(_loc1_ in this._allyRenderers)
         {
            _loc1_.updateColorBlind();
         }
         for each(_loc1_ in this._enemyRenderers)
         {
            _loc1_.updateColorBlind();
         }
      }
      
      public final function dispose() : void
      {
         this._disposed = true;
         this.onDispose();
      }
      
      protected function createItemHolder(param1:int, param2:int) : StatsTableItemHolderBase
      {
         throw new AbstractException(Errors.ABSTRACT_INVOKE);
      }
      
      protected function setSelectedItem(param1:Boolean, param2:int) : void
      {
      }
      
      protected function onDispose() : void
      {
         var _loc1_:StatsTableItemHolderBase = null;
         var _loc2_:* = null;
         this._teamDP.removeEventListener(ListDataProviderEvent.VALIDATE_ITEMS,this.onAllyDataProviderUpdateItemHandler);
         this._teamDP.cleanUp();
         this._teamDP = null;
         this._enemyDP.removeEventListener(ListDataProviderEvent.VALIDATE_ITEMS,this.onEnemyDataProviderUpdateItemHandler);
         this._enemyDP.cleanUp();
         this._enemyDP = null;
         for each(_loc1_ in this._allyRenderers)
         {
            _loc1_.dispose();
         }
         this._allyRenderers.splice(0,this._allyRenderers.length);
         this._allyRenderers = null;
         for each(_loc1_ in this._enemyRenderers)
         {
            _loc1_.dispose();
         }
         this._enemyRenderers.splice(0,this._enemyRenderers.length);
         this._enemyRenderers = null;
         for(_loc2_ in this._dogTagsToShow)
         {
            delete this._dogTagsToShow[_loc2_];
         }
         this._dogTagsToShow = null;
      }
      
      protected function onItemDataSet(param1:StatsTableItemHolderBase, param2:Boolean) : void
      {
      }
      
      protected final function setNoTranslateForCollection(param1:Vector.<TextField>) : void
      {
         var _loc2_:TextField = null;
         for each(_loc2_ in param1)
         {
            TextFieldEx.setNoTranslate(_loc2_,true);
         }
      }
      
      protected function init() : void
      {
         var _loc1_:int = 0;
         while(_loc1_ < this.numRows)
         {
            this._allyRenderers[_loc1_] = this.createItemHolder(0,_loc1_);
            this._enemyRenderers[_loc1_] = this.createItemHolder(1,_loc1_);
            _loc1_++;
         }
      }
      
      public function get isRenderingAvailable() : Boolean
      {
         return this._isRenderingAvailable;
      }
      
      public function set isRenderingAvailable(param1:Boolean) : void
      {
         if(this._isRenderingAvailable == param1)
         {
            return;
         }
         this._isRenderingAvailable = param1;
         var _loc2_:StatsTableItemHolderBase = null;
         for each(_loc2_ in this._allyRenderers)
         {
            _loc2_.isRenderingAvailable = param1;
         }
         for each(_loc2_ in this._enemyRenderers)
         {
            _loc2_.isRenderingAvailable = param1;
         }
      }
      
      public function isDisposed() : Boolean
      {
         return this._disposed;
      }
   }
}
