package net.wg.gui.battle.epicRandom.views.stats.components.fullStats
{
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.utils.Dictionary;
   import net.wg.data.VO.daapi.DAAPIInvitationStatusVO;
   import net.wg.data.VO.daapi.DAAPIVehicleInfoVO;
   import net.wg.data.VO.daapi.DAAPIVehicleStatsVO;
   import net.wg.gui.battle.battleloading.data.VehiclesDataProvider;
   import net.wg.gui.battle.epicRandom.battleloading.components.EpicRandomStatsTableCtrl;
   import net.wg.gui.battle.epicRandom.views.stats.events.EpicRandomFullStatsListItemRendererEvent;
   import net.wg.gui.battle.interfaces.ITabbedFullStatsTableController;
   import net.wg.gui.battle.random.views.stats.components.fullStats.interfaces.ISquadHandler;
   import net.wg.gui.battle.random.views.stats.components.fullStats.tableItem.DynamicSquadCtrl;
   import net.wg.gui.components.dogtag.VO.DogTagVO;
   import net.wg.infrastructure.base.meta.impl.StatsBaseMeta;
   import net.wg.infrastructure.events.ListDataProviderEvent;
   import scaleform.clik.controls.ScrollingList;
   import scaleform.gfx.TextFieldEx;
   
   public class EpicRandomFullStatsTableCtrl extends EpicRandomStatsTableCtrl implements ITabbedFullStatsTableController, ISquadHandler
   {
      
      private static const SQUAD_BT_LEFT_X:int = -501;
      
      private static const SQUAD_BT_RIGHT_X:int = 472;
      
      private static const ITEM_HEIGHT:int = 32;
      
      private static const SQUAD_BT_Y_START:int = 34;
       
      
      private var _table:EpicRandomFullStatsTable = null;
      
      private var _squadHandler:StatsBaseMeta = null;
      
      private var _isAllyInviteShown:Boolean = false;
      
      private var _isEnemyInviteShown:Boolean = false;
      
      private var _isAllyInteractive:Boolean = false;
      
      private var _isEnemyInteractive:Boolean = false;
      
      private var _isRenderingAvailable:Boolean;
      
      private var _activePlayerData:DAAPIVehicleInfoVO;
      
      private var _dogTagsToShow:Dictionary = null;
      
      public function EpicRandomFullStatsTableCtrl(param1:EpicRandomFullStatsTable, param2:StatsBaseMeta)
      {
         super(param1);
         this._table = param1;
         TextFieldEx.setNoTranslate(this._table.team1TF,true);
         TextFieldEx.setNoTranslate(this._table.team2TF,true);
         this._dogTagsToShow = new Dictionary();
         this._squadHandler = param2;
      }
      
      override public function addVehiclesInfo(param1:Boolean, param2:Vector.<DAAPIVehicleInfoVO>, param3:Vector.<Number>) : void
      {
         super.addVehiclesInfo(param1,param2,param3);
         var _loc4_:ScrollingList = !!param1 ? this._table.team2PlayerList : this._table.team1PlayerList;
         _loc4_.invalidateData();
      }
      
      override protected function onDispose() : void
      {
         var _loc1_:* = null;
         this._squadHandler = null;
         this._table = null;
         this._activePlayerData = null;
         for(_loc1_ in this._dogTagsToShow)
         {
            delete this._dogTagsToShow[_loc1_];
         }
         this._dogTagsToShow = null;
         super.onDispose();
      }
      
      public function onAcceptSquad(param1:DynamicSquadCtrl) : void
      {
         this._squadHandler.acceptSquadS(param1.sessionID);
      }
      
      public function onAddToSquad(param1:DynamicSquadCtrl) : void
      {
         this._squadHandler.addToSquadS(param1.sessionID);
      }
      
      public function onSquadBtVisibleChange(param1:DynamicSquadCtrl) : void
      {
         var _loc4_:EpicRandomFullStatsListItemRenderer = null;
         var _loc2_:int = -1;
         var _loc3_:Boolean = false;
         var _loc5_:int = this._table.team1PlayerList.rowCount;
         var _loc6_:int = 0;
         _loc6_ = 0;
         while(_loc6_ < _loc5_)
         {
            _loc4_ = this._table.team1PlayerList.getRendererAt(_loc6_) as EpicRandomFullStatsListItemRenderer;
            if(_loc4_ && _loc4_.squadItem == param1)
            {
               _loc2_ = _loc6_;
               break;
            }
            _loc6_++;
         }
         _loc5_ = this._table.team2PlayerList.rowCount;
         _loc6_ = 0;
         while(_loc6_ < _loc5_)
         {
            _loc4_ = this._table.team2PlayerList.getRendererAt(_loc6_) as EpicRandomFullStatsListItemRenderer;
            if(_loc4_ && _loc4_.squadItem == param1)
            {
               _loc2_ = _loc6_;
               _loc3_ = true;
               break;
            }
            _loc6_++;
         }
         if(_loc2_ != -1 && _loc4_ && !_loc4_.isCurrentPlayer())
         {
            if(param1.isAcceptBtAvailable)
            {
               this._table.squadAcceptBt.x = !!_loc3_ ? Number(SQUAD_BT_RIGHT_X) : Number(SQUAD_BT_LEFT_X);
               this._table.squadAcceptBt.y = SQUAD_BT_Y_START + _loc2_ * ITEM_HEIGHT;
               this._table.squadAcceptBt.visible = true;
            }
            else
            {
               this._table.squadAcceptBt.visible = false;
            }
            if(param1.isAddBtAvailable)
            {
               this._table.squadAddBt.x = !!_loc3_ ? Number(SQUAD_BT_RIGHT_X) : Number(SQUAD_BT_LEFT_X);
               this._table.squadAddBt.y = SQUAD_BT_Y_START + _loc2_ * ITEM_HEIGHT;
               this._table.squadAddBt.visible = true;
            }
            else
            {
               this._table.squadAddBt.visible = false;
            }
         }
      }
      
      public function setFrags(param1:Vector.<DAAPIVehicleStatsVO>, param2:Vector.<DAAPIVehicleStatsVO>) : void
      {
         if(teamDP.updateFrags(param1))
         {
            teamDP.invalidate();
         }
         if(enemyDP.updateFrags(param2))
         {
            enemyDP.invalidate();
         }
      }
      
      public function setInteractive(param1:Boolean, param2:Boolean) : void
      {
         var _loc3_:int = 0;
         var _loc4_:int = this._table.team1PlayerList.rowCount;
         if(this._isAllyInteractive != param1)
         {
            _loc3_ = 0;
            while(_loc3_ < _loc4_)
            {
               this.setItemInteractive(false,_loc3_,param1);
               _loc3_++;
            }
            this._isAllyInteractive = param1;
         }
         if(this._isEnemyInteractive != param2)
         {
            _loc4_ = this._table.team2PlayerList.rowCount;
            _loc3_ = 0;
            while(_loc3_ < _loc4_)
            {
               this.setItemInteractive(true,_loc3_,param2);
               _loc3_++;
            }
            this._isEnemyInteractive = param2;
         }
      }
      
      public function setIsInviteShown(param1:Boolean, param2:Boolean) : void
      {
         var _loc3_:int = 0;
         var _loc4_:int = this._table.team1PlayerList.rowCount;
         if(this._isAllyInviteShown != param1)
         {
            _loc3_ = 0;
            while(_loc3_ < _loc4_)
            {
               this.setItemInviteShown(false,_loc3_,param1);
               _loc3_++;
            }
            this._isAllyInviteShown = param1;
         }
         if(this._isEnemyInviteShown != param2)
         {
            _loc4_ = this._table.team2PlayerList.rowCount;
            _loc3_ = 0;
            while(_loc3_ < _loc4_)
            {
               this.setItemInviteShown(true,_loc3_,param2);
               _loc3_++;
            }
            this._isEnemyInviteShown = param2;
         }
      }
      
      public function setSpeaking(param1:Number, param2:Boolean) : void
      {
         var _loc3_:EpicRandomFullStatsListItemRenderer = null;
         if(teamDP.setSpeaking(param1,param2))
         {
            _loc3_ = this.getRendererByAccountId(false,param1);
            if(_loc3_)
            {
               _loc3_.setIsSpeaking(param2);
            }
            teamDP.invalidate();
         }
         else if(enemyDP.setSpeaking(param1,param2))
         {
            _loc3_ = this.getRendererByAccountId(true,param1);
            if(_loc3_)
            {
               _loc3_.setIsSpeaking(param2);
            }
            enemyDP.invalidate();
         }
      }
      
      public function updateColorBlind() : void
      {
         var _loc3_:EpicRandomFullStatsListItemRenderer = null;
         var _loc1_:int = 0;
         var _loc2_:int = this._table.team1PlayerList.rowCount;
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc3_ = this._table.team1PlayerList.getRendererAt(_loc1_) as EpicRandomFullStatsListItemRenderer;
            if(_loc3_)
            {
               _loc3_.updateColorBlind();
            }
            _loc1_++;
         }
         _loc2_ = this._table.team2PlayerList.rowCount;
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc3_ = this._table.team2PlayerList.getRendererAt(_loc1_) as EpicRandomFullStatsListItemRenderer;
            if(_loc3_)
            {
               _loc3_.updateColorBlind();
            }
            _loc1_++;
         }
      }
      
      public function updateInvitationsStatuses(param1:Boolean, param2:Vector.<DAAPIInvitationStatusVO>) : void
      {
         var _loc3_:VehiclesDataProvider = !!param1 ? enemyDP : teamDP;
         if(_loc3_.updateInvitationsStatuses(param2))
         {
            _loc3_.invalidate();
         }
      }
      
      private function onItemDataSet(param1:EpicRandomFullStatsListItemRenderer, param2:Boolean) : void
      {
         param1.setIsInviteShown(!!param2 ? Boolean(this._isEnemyInviteShown) : Boolean(this._isAllyInviteShown));
         param1.setIsInteractive(!!param2 ? Boolean(this._isEnemyInteractive) : Boolean(this._isAllyInteractive));
      }
      
      private function getRendererIfInRange(param1:ScrollingList, param2:int) : EpicRandomFullStatsListItemRenderer
      {
         var _loc5_:EpicRandomFullStatsListItemRenderer = null;
         var _loc3_:int = param2 - param1.scrollPosition;
         var _loc4_:EpicRandomFullStatsListItemRenderer = null;
         if(_loc3_ >= 0 && _loc3_ < param1.rowCount)
         {
            _loc5_ = param1.getRendererAt(_loc3_) as EpicRandomFullStatsListItemRenderer;
            if(_loc5_)
            {
               _loc4_ = _loc5_;
            }
         }
         return _loc4_;
      }
      
      private function setSquadSettingsForRenderer(param1:EpicRandomFullStatsListItemRenderer) : void
      {
         if(!param1.squadItem)
         {
            param1.setSquadControlButtons(this._table.squadAcceptBt,this._table.squadAddBt);
            param1.addSquadHandler(this);
         }
      }
      
      private function getRendererByAccountId(param1:Boolean, param2:int) : EpicRandomFullStatsListItemRenderer
      {
         var _loc6_:EpicRandomFullStatsListItemRenderer = null;
         var _loc3_:ScrollingList = !!param1 ? this._table.team2PlayerList : this._table.team1PlayerList;
         var _loc4_:int = _loc3_.rowCount;
         var _loc5_:int = _loc3_.scrollPosition;
         while(_loc5_ < _loc4_)
         {
            _loc6_ = _loc3_.getRendererAt(_loc5_) as EpicRandomFullStatsListItemRenderer;
            if(_loc6_ && _loc6_.getAccountId() == param2)
            {
               return _loc6_;
            }
            _loc5_++;
         }
         return null;
      }
      
      private function setItemInviteShown(param1:Boolean, param2:int, param3:Boolean) : void
      {
         var _loc4_:ScrollingList = !!param1 ? this._table.team2PlayerList : this._table.team1PlayerList;
         var _loc5_:EpicRandomFullStatsListItemRenderer = _loc4_.getRendererAt(param2) as EpicRandomFullStatsListItemRenderer;
         if(_loc5_)
         {
            _loc5_.setIsInviteShown(param3);
         }
      }
      
      private function setItemInteractive(param1:Boolean, param2:int, param3:Boolean) : void
      {
         var _loc4_:ScrollingList = !!param1 ? this._table.team2PlayerList : this._table.team1PlayerList;
         var _loc5_:EpicRandomFullStatsListItemRenderer = _loc4_.getRendererAt(param2) as EpicRandomFullStatsListItemRenderer;
         if(_loc5_)
         {
            _loc5_.setIsInteractive(param3);
         }
      }
      
      private function updateActivePlayerVO(param1:Vector.<int>) : void
      {
         var _loc2_:int = 0;
         for each(_loc2_ in param1)
         {
            this._activePlayerData = teamDP.requestItemAt(_loc2_) as DAAPIVehicleInfoVO;
            if(this._activePlayerData.isCurrentPlayer)
            {
               break;
            }
         }
      }
      
      public function get isRenderingAvailable() : Boolean
      {
         return this._isRenderingAvailable;
      }
      
      public function set isRenderingAvailable(param1:Boolean) : void
      {
         var _loc2_:EpicRandomFullStatsListItemRenderer = null;
         if(this._isRenderingAvailable == param1)
         {
            return;
         }
         this._isRenderingAvailable = param1;
         var _loc3_:int = 0;
         var _loc4_:int = this._table.team2PlayerList.rowCount;
         _loc3_ = 0;
         while(_loc3_ < _loc4_)
         {
            _loc2_ = this._table.team2PlayerList.getRendererAt(_loc3_) as EpicRandomFullStatsListItemRenderer;
            if(_loc2_)
            {
               _loc2_.isRenderingAvailable = param1;
            }
            _loc3_++;
         }
         _loc4_ = this._table.team1PlayerList.rowCount;
         _loc3_ = 0;
         while(_loc3_ < _loc4_)
         {
            _loc2_ = this._table.team1PlayerList.getRendererAt(_loc3_) as EpicRandomFullStatsListItemRenderer;
            if(_loc2_)
            {
               _loc2_.isRenderingAvailable = param1;
            }
            _loc3_++;
         }
      }
      
      override protected function updateTeamDPItems(param1:ListDataProviderEvent) : void
      {
         var _loc5_:int = 0;
         var _loc6_:DAAPIVehicleInfoVO = null;
         var _loc7_:EpicRandomFullStatsListItemRenderer = null;
         var _loc2_:uint = this._table.team1PlayerList.scrollPosition;
         var _loc3_:uint = _loc2_ + this._table.team1PlayerList.rowCount - 1;
         var _loc4_:Vector.<int> = Vector.<int>(param1.data);
         if(this._activePlayerData == null)
         {
            this.updateActivePlayerVO(_loc4_);
         }
         for each(_loc5_ in _loc4_)
         {
            if(!(_loc5_ < _loc2_ || _loc5_ > _loc3_))
            {
               _loc6_ = teamDP.requestItemAt(_loc5_) as DAAPIVehicleInfoVO;
               _loc7_ = this.getRendererIfInRange(this._table.team1PlayerList,_loc5_);
               if(_loc6_ && _loc7_)
               {
                  this.setSquadSettingsForRenderer(_loc7_);
                  _loc7_.setDAAPIVehicleInfoVO(_loc6_,false);
                  this.onItemDataSet(_loc7_,false);
                  if(this._activePlayerData)
                  {
                     _loc7_.setActivePlayerData(this._activePlayerData);
                  }
               }
            }
         }
      }
      
      public function setDogTagToShow(param1:Number, param2:DogTagVO) : void
      {
         this._dogTagsToShow[param1] = param2;
      }
      
      private function onItemRendererDataSync(param1:Event) : void
      {
         var _loc2_:EpicRandomFullStatsListItemRenderer = param1.currentTarget as EpicRandomFullStatsListItemRenderer;
         if(_loc2_)
         {
            _loc2_.showDogTag(this._dogTagsToShow[_loc2_.vehicleID]);
         }
         if(_loc2_.hitTestPoint(App.stage.mouseX,App.stage.mouseY))
         {
            _loc2_.dispatchEvent(new MouseEvent(MouseEvent.ROLL_OVER));
         }
      }
      
      override protected function updateEnemyDPItems(param1:ListDataProviderEvent) : void
      {
         var _loc5_:int = 0;
         var _loc6_:DAAPIVehicleInfoVO = null;
         var _loc7_:EpicRandomFullStatsListItemRenderer = null;
         var _loc2_:uint = this._table.team2PlayerList.scrollPosition;
         var _loc3_:uint = _loc2_ + this._table.team2PlayerList.rowCount - 1;
         var _loc4_:Vector.<int> = Vector.<int>(param1.data);
         for each(_loc5_ in _loc4_)
         {
            if(!(_loc5_ < _loc2_ || _loc5_ > _loc3_))
            {
               _loc6_ = enemyDP.requestItemAt(_loc5_) as DAAPIVehicleInfoVO;
               _loc7_ = this.getRendererIfInRange(this._table.team2PlayerList,_loc5_);
               if(_loc6_ && _loc7_)
               {
                  if(this._dogTagsToShow[_loc6_.vehicleID])
                  {
                     _loc7_.showDogTag(this._dogTagsToShow[_loc6_.vehicleID]);
                  }
                  this.setSquadSettingsForRenderer(_loc7_);
                  _loc7_.setDAAPIVehicleInfoVO(_loc6_,true);
                  this.onItemDataSet(_loc7_,true);
               }
               if(!_loc7_.hasEventListener(EpicRandomFullStatsListItemRendererEvent.ON_DATA_SYNC))
               {
                  _loc7_.addEventListener(EpicRandomFullStatsListItemRendererEvent.ON_DATA_SYNC,this.onItemRendererDataSync,false,0,true);
               }
            }
         }
      }
   }
}
