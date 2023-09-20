package net.wg.gui.battle.views.stats.fullStats
{
   import flash.text.TextField;
   import flash.utils.Dictionary;
   import net.wg.data.VO.daapi.DAAPIInvitationStatusVO;
   import net.wg.data.VO.daapi.DAAPIVehicleInfoVO;
   import net.wg.data.VO.daapi.DAAPIVehicleStatsVO;
   import net.wg.data.VO.daapi.DAAPIVehicleUserTagsVO;
   import net.wg.data.constants.Errors;
   import net.wg.data.constants.generated.BATTLEATLAS;
   import net.wg.gui.battle.battleloading.data.VehiclesDataProvider;
   import net.wg.gui.battle.interfaces.IStatsTableController;
   import net.wg.gui.battle.interfaces.ITabbedFullStatsTableController;
   import net.wg.gui.components.dogtag.VO.DogTagVO;
   import net.wg.infrastructure.events.ListDataProviderEvent;
   import net.wg.infrastructure.exceptions.AbstractException;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   import scaleform.gfx.TextFieldEx;
   
   public class StatsTableControllerBase implements IStatsTableController, ITabbedFullStatsTableController, IDisposable
   {
      
      private static const ITEM_HEIGHT:Number = 25;
      
      private static const TABLE_START_POINT:int = 33;
       
      
      protected var allyRenderers:Vector.<StatsTableItemHolderBase>;
      
      protected var enemyRenderers:Vector.<StatsTableItemHolderBase>;
      
      protected var table:FullStatsTableBase = null;
      
      private var _teamDP:VehiclesDataProvider;
      
      private var _enemyDP:VehiclesDataProvider;
      
      private var _dogTagsToShow:Dictionary;
      
      private var _activePlayerData:DAAPIVehicleInfoVO;
      
      private var _isRenderingAvailable:Boolean;
      
      private var _disposed:Boolean = false;
      
      public function StatsTableControllerBase(param1:FullStatsTableBase)
      {
         super();
         this._teamDP = new VehiclesDataProvider();
         this._teamDP.addEventListener(ListDataProviderEvent.VALIDATE_ITEMS,this.onAllyDataProviderValidateItemsHandler);
         this._enemyDP = new VehiclesDataProvider();
         this._enemyDP.addEventListener(ListDataProviderEvent.VALIDATE_ITEMS,this.onEnemyDataProviderValidateItemsHandler);
         this.allyRenderers = new Vector.<StatsTableItemHolderBase>(0);
         this.enemyRenderers = new Vector.<StatsTableItemHolderBase>(0);
         this._dogTagsToShow = new Dictionary();
         this.table = param1;
         this.init();
         this.initCommonItems();
         this.setNoTranslate();
      }
      
      public function addVehiclesInfo(param1:Vector.<DAAPIVehicleInfoVO>, param2:Vector.<Number>, param3:Boolean) : void
      {
         var _loc4_:VehiclesDataProvider = !!param3 ? this._enemyDP : this._teamDP;
         if(_loc4_.addVehiclesInfo(param1,param2))
         {
            _loc4_.invalidate();
         }
      }
      
      public final function dispose() : void
      {
         this._disposed = true;
         this.onDispose();
      }
      
      public function isDisposed() : Boolean
      {
         return this._disposed;
      }
      
      public function setDogTagToShow(param1:Number, param2:DogTagVO) : void
      {
         var _loc3_:StatsTableItemHolderBase = null;
         this._dogTagsToShow[param1] = param2;
         for each(_loc3_ in this.enemyRenderers)
         {
            if(_loc3_.containsData)
            {
               if(_loc3_.getVehicleID() == param1)
               {
                  _loc3_.showDogTag(param2);
               }
            }
         }
      }
      
      public function setInteractive(param1:Boolean, param2:Boolean) : void
      {
      }
      
      public function setIsInviteShown(param1:Boolean, param2:Boolean) : void
      {
      }
      
      public function setPlayerStatus(param1:Boolean, param2:Number, param3:uint) : void
      {
         var _loc4_:VehiclesDataProvider = !!param1 ? this._enemyDP : this._teamDP;
         if(_loc4_.setPlayerStatus(param2,param3))
         {
            _loc4_.invalidate();
         }
      }
      
      public function setSpeaking(param1:Number, param2:Boolean) : void
      {
         if(this._teamDP.setSpeaking(param1,param2))
         {
            this._teamDP.invalidate();
         }
         else if(this._enemyDP.setSpeaking(param1,param2))
         {
            this._enemyDP.invalidate();
         }
      }
      
      public function setTeamsInfo(param1:String, param2:String) : void
      {
         this.table.team1TF.text = param1;
         this.table.team2TF.text = param2;
      }
      
      public function setUserTags(param1:Boolean, param2:Vector.<DAAPIVehicleUserTagsVO>) : void
      {
         var _loc3_:VehiclesDataProvider = !!param1 ? this._enemyDP : this._teamDP;
         if(_loc3_.setUserTags(param2))
         {
            _loc3_.invalidate();
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
      
      public function setVehiclesData(param1:Array, param2:Vector.<Number>, param3:Boolean) : void
      {
         var _loc4_:VehiclesDataProvider = !!param3 ? this._enemyDP : this._teamDP;
         _loc4_.setSource(param1);
         _loc4_.setSorting(param2);
         _loc4_.invalidate();
      }
      
      public function setVehiclesStats(param1:Vector.<DAAPIVehicleStatsVO>, param2:Vector.<DAAPIVehicleStatsVO>) : void
      {
         var _loc3_:VehiclesDataProvider = this._teamDP;
         if(_loc3_.updateFrags(param1))
         {
            _loc3_.invalidate();
         }
         _loc3_ = this._enemyDP;
         if(_loc3_.updateFrags(param2))
         {
            _loc3_.invalidate();
         }
      }
      
      public function updateColorBlind() : void
      {
         var _loc1_:StatsTableItemHolderBase = null;
         for each(_loc1_ in this.allyRenderers)
         {
            _loc1_.updateColorBlind();
         }
         for each(_loc1_ in this.enemyRenderers)
         {
            _loc1_.updateColorBlind();
         }
      }
      
      public function updateInvitationsStatuses(param1:Boolean, param2:Vector.<DAAPIInvitationStatusVO>) : void
      {
         var _loc3_:VehiclesDataProvider = !!param1 ? this._enemyDP : this._teamDP;
         if(_loc3_.updateInvitationsStatuses(param2))
         {
            _loc3_.invalidate();
         }
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
      
      protected function updateDogTags() : void
      {
         var _loc1_:StatsTableItemHolderBase = null;
         var _loc2_:Number = NaN;
         var _loc3_:* = null;
         for each(_loc1_ in this.enemyRenderers)
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
      
      protected function createItemHolder(param1:int, param2:int) : StatsTableItemHolderBase
      {
         throw new AbstractException(Errors.ABSTRACT_INVOKE);
      }
      
      protected function setSelectedItem(param1:Boolean, param2:int) : void
      {
         if(param1)
         {
            this.table.selfBgRight.y = this.tableStartPoint + param2 * ITEM_HEIGHT;
            this.table.selfBgRight.visible = true;
            this.table.selfBgLeft.visible = false;
         }
         else
         {
            this.table.selfBgLeft.y = this.tableStartPoint + param2 * ITEM_HEIGHT;
            this.table.selfBgLeft.visible = true;
            this.table.selfBgRight.visible = false;
         }
      }
      
      protected function onDispose() : void
      {
         var _loc1_:StatsTableItemHolderBase = null;
         var _loc2_:* = null;
         this._activePlayerData = null;
         this.table = null;
         this._teamDP.removeEventListener(ListDataProviderEvent.VALIDATE_ITEMS,this.onAllyDataProviderValidateItemsHandler);
         this._teamDP.cleanUp();
         this._teamDP = null;
         this._enemyDP.removeEventListener(ListDataProviderEvent.VALIDATE_ITEMS,this.onEnemyDataProviderValidateItemsHandler);
         this._enemyDP.cleanUp();
         this._enemyDP = null;
         for each(_loc1_ in this.allyRenderers)
         {
            _loc1_.dispose();
         }
         this.allyRenderers.splice(0,this.allyRenderers.length);
         this.allyRenderers = null;
         for each(_loc1_ in this.enemyRenderers)
         {
            _loc1_.dispose();
         }
         this.enemyRenderers.splice(0,this.enemyRenderers.length);
         this.enemyRenderers = null;
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
            this.allyRenderers[_loc1_] = this.createItemHolder(0,_loc1_);
            this.enemyRenderers[_loc1_] = this.createItemHolder(1,_loc1_);
            _loc1_++;
         }
      }
      
      private function updateActivePlayerVO(param1:Vector.<int>) : void
      {
         var _loc2_:int = 0;
         for each(_loc2_ in param1)
         {
            this._activePlayerData = this._teamDP.requestItemAt(_loc2_) as DAAPIVehicleInfoVO;
            if(this._activePlayerData.isCurrentPlayer)
            {
               break;
            }
         }
      }
      
      private function initCommonItems() : void
      {
         this.table.selfBgLeft.visible = false;
         this.table.selfBgLeft.imageName = BATTLEATLAS.FULL_STATS_SELF_BG;
         this.table.selfBgRight.visible = false;
         this.table.selfBgRight.imageName = BATTLEATLAS.FULL_STATS_SELF_BG;
      }
      
      private function setNoTranslate() : void
      {
         this.setNoTranslateForCollection(this.table.playerNameCollection);
         this.setNoTranslateForCollection(this.table.vehicleNameCollection);
         this.setNoTranslateForCollection(this.table.fragsCollection);
      }
      
      public function get isRenderingAvailable() : Boolean
      {
         return this._isRenderingAvailable;
      }
      
      public function set isRenderingAvailable(param1:Boolean) : void
      {
         var _loc2_:StatsTableItemHolderBase = null;
         if(this._isRenderingAvailable == param1)
         {
            return;
         }
         this._isRenderingAvailable = param1;
         for each(_loc2_ in this.allyRenderers)
         {
            _loc2_.isRenderingAvailable = param1;
            if(_loc2_.isSelected)
            {
               this.setSelectedItem(false,this.allyRenderers.indexOf(_loc2_));
            }
         }
         for each(_loc2_ in this.enemyRenderers)
         {
            _loc2_.isRenderingAvailable = param1;
            if(_loc2_.isSelected)
            {
               this.setSelectedItem(true,this.enemyRenderers.indexOf(_loc2_));
            }
         }
      }
      
      protected function get tableStartPoint() : int
      {
         return TABLE_START_POINT;
      }
      
      protected function get numRows() : int
      {
         return this.table.numRows;
      }
      
      protected function onEnemyDataProviderValidateItemsHandler(param1:ListDataProviderEvent) : void
      {
         var _loc4_:int = 0;
         var _loc5_:StatsTableItemHolderBase = null;
         var _loc6_:DAAPIVehicleInfoVO = null;
         var _loc7_:* = null;
         var _loc2_:uint = this.enemyRenderers.length - 1;
         var _loc3_:Vector.<int> = Vector.<int>(param1.data);
         for each(_loc4_ in _loc3_)
         {
            if(_loc4_ <= _loc2_)
            {
               _loc5_ = this.enemyRenderers[_loc4_];
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
      
      protected function onAllyDataProviderValidateItemsHandler(param1:ListDataProviderEvent) : void
      {
         var _loc4_:int = 0;
         var _loc5_:StatsTableItemHolderBase = null;
         var _loc6_:DAAPIVehicleInfoVO = null;
         var _loc2_:Vector.<int> = Vector.<int>(param1.data);
         var _loc3_:uint = this.allyRenderers.length - 1;
         if(this._activePlayerData == null)
         {
            this.updateActivePlayerVO(_loc2_);
         }
         for each(_loc4_ in _loc2_)
         {
            if(_loc4_ <= _loc3_)
            {
               _loc5_ = this.allyRenderers[_loc4_];
               _loc6_ = this._teamDP.requestItemAt(_loc4_) as DAAPIVehicleInfoVO;
               _loc5_.setDAAPIVehicleData(_loc6_);
               if(this._activePlayerData)
               {
                  _loc5_.setActivePlayerData(this._activePlayerData);
               }
               if(_loc5_.isSelected)
               {
                  this.setSelectedItem(false,_loc4_);
               }
               this.onItemDataSet(_loc5_,false);
            }
         }
      }
   }
}
