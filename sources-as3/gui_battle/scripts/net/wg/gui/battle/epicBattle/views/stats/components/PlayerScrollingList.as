package net.wg.gui.battle.epicBattle.views.stats.components
{
   import net.wg.data.VO.daapi.DAAPIVehicleInfoVO;
   import net.wg.data.constants.PlayerStatus;
   import net.wg.data.constants.UserTags;
   import net.wg.data.constants.generated.BATTLE_CONTEXT_MENU_HANDLER_TYPE;
   import net.wg.gui.battle.components.buttons.BattleButton;
   import net.wg.gui.battle.epicBattle.VO.daapi.EpicVehicleStatsVO;
   import net.wg.gui.battle.epicBattle.views.data.EpicVehicleDataProvider;
   import net.wg.gui.battle.epicBattle.views.stats.events.EpicFullStatsRendererEvent;
   import net.wg.gui.battle.epicBattle.views.stats.renderers.EpicStatsPlayerRenderer;
   import net.wg.gui.battle.random.views.stats.components.fullStats.interfaces.ISquadHandler;
   import net.wg.gui.battle.random.views.stats.components.fullStats.tableItem.DynamicSquadCtrl;
   import net.wg.gui.battle.random.views.stats.components.playersPanel.VO.PlayersPanelContextMenuSentData;
   import net.wg.infrastructure.managers.IContextMenuManager;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.constants.WrappingMode;
   import scaleform.clik.controls.ScrollingList;
   import scaleform.clik.data.ListData;
   
   public class PlayerScrollingList extends ScrollingList
   {
       
      
      [Inspectable(defaultValue="false",verbose="1")]
      public var rightSide:Boolean = false;
      
      private var _contextMenuMgr:IContextMenuManager;
      
      private var _laneFilterIsActive:Boolean = false;
      
      private var _squadAcceptBt:BattleButton = null;
      
      private var _squadAddBt:BattleButton = null;
      
      private var _squadHandler:ISquadHandler = null;
      
      private var _isInteractive:Boolean = false;
      
      private var _isInviteShown:Boolean = false;
      
      public function PlayerScrollingList()
      {
         this._contextMenuMgr = App.contextMenuMgr;
         super();
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(InvalidationType.DATA) && _scrollBar)
         {
            _scrollBar.visible = !this._laneFilterIsActive;
         }
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         wrapping = WrappingMode.NORMAL;
      }
      
      override protected function populateData(param1:Array) : void
      {
         var _loc5_:EpicStatsPlayerRenderer = null;
         var _loc6_:uint = 0;
         var _loc7_:ListData = null;
         var _loc8_:DAAPIVehicleInfoVO = null;
         var _loc9_:EpicVehicleStatsVO = null;
         var _loc2_:uint = param1.length;
         var _loc3_:uint = _renderers.length;
         var _loc4_:uint = 0;
         while(_loc4_ < _loc3_)
         {
            _loc5_ = getRendererAt(_loc4_) as EpicStatsPlayerRenderer;
            _loc6_ = _scrollPosition + _loc4_;
            _loc7_ = new ListData(_loc6_,itemToLabel(param1[_loc4_]),_selectedIndex == _loc6_);
            _loc5_.enabled = _loc4_ < _loc2_;
            this.setupDynamicSquad(_loc5_);
            _loc5_.isRightSide = this.rightSide;
            _loc5_.setListData(_loc7_);
            _loc5_.addEventListener(EpicFullStatsRendererEvent.RENDERER_CLICKED,this.onPlayerItemRendererClickedHandler);
            if(param1[_loc4_])
            {
               _loc8_ = param1[_loc4_] as DAAPIVehicleInfoVO;
               if(_loc8_)
               {
                  _loc5_.setData(_loc8_);
                  _loc9_ = (_dataProvider as EpicVehicleDataProvider).requestEpicData(_loc8_.vehicleID);
                  if(_loc9_)
                  {
                     _loc5_.setEpicData(_loc9_);
                  }
               }
            }
            _loc5_.setIsInviteShown(this._isInviteShown);
            _loc5_.setIsInteractive(this._isInteractive);
            _loc5_.validateNow();
            _loc4_++;
         }
         App.tutorialMgr.dispatchEventForCustomComponent(this);
      }
      
      override protected function refreshData() : void
      {
         var _loc1_:EpicVehicleDataProvider = null;
         _scrollPosition = Math.min(Math.max(0,_dataProvider.length - _totalRenderers),_scrollPosition);
         selectedIndex = Math.min(_dataProvider.length - 1,_selectedIndex);
         updateSelectedIndex();
         if(this._laneFilterIsActive)
         {
            _loc1_ = dataProvider as EpicVehicleDataProvider;
            if(_loc1_)
            {
               this.populateData(_loc1_.getActiveLaneVehicleData());
            }
         }
         else
         {
            _dataProvider.requestItemRange(_scrollPosition,Math.min(_dataProvider.length - 1,_scrollPosition + _totalRenderers - 1),this.populateData);
         }
      }
      
      override protected function onDispose() : void
      {
         var _loc3_:EpicStatsPlayerRenderer = null;
         var _loc1_:uint = _renderers.length;
         var _loc2_:uint = 0;
         while(_loc2_ < _loc1_)
         {
            _loc3_ = getRendererAt(_loc2_) as EpicStatsPlayerRenderer;
            if(_loc3_)
            {
               _loc3_.removeEventListener(EpicFullStatsRendererEvent.RENDERER_CLICKED,this.onPlayerItemRendererClickedHandler);
            }
            _loc2_++;
         }
         this._contextMenuMgr = null;
         this._squadAcceptBt = null;
         this._squadAddBt = null;
         this._squadHandler = null;
         super.onDispose();
      }
      
      public function getRendererIndexByVehicleID(param1:Number) : int
      {
         var _loc2_:EpicVehicleDataProvider = _dataProvider as EpicVehicleDataProvider;
         var _loc3_:int = -1;
         if(_loc2_)
         {
            _loc3_ = _loc2_.getIndexOf(param1,this._laneFilterIsActive);
         }
         return _loc3_;
      }
      
      public function setInteractive(param1:Boolean) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:EpicStatsPlayerRenderer = null;
         if(this._isInteractive == param1)
         {
            return;
         }
         if(_renderers)
         {
            _loc2_ = 0;
            _loc3_ = _renderers.length;
            _loc2_ = 0;
            while(_loc2_ < _loc3_)
            {
               _loc4_ = this.getRendererAt(_loc2_) as EpicStatsPlayerRenderer;
               if(_loc4_)
               {
                  _loc4_.setIsInteractive(param1);
               }
               _loc2_++;
            }
         }
         this._isInteractive = param1;
      }
      
      public function setIsInviteShown(param1:Boolean) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:EpicStatsPlayerRenderer = null;
         if(this._isInviteShown == param1)
         {
            return;
         }
         if(_renderers)
         {
            _loc2_ = 0;
            _loc3_ = _renderers.length;
            _loc2_ = 0;
            while(_loc2_ < _loc3_)
            {
               _loc4_ = this.getRendererAt(_loc2_) as EpicStatsPlayerRenderer;
               if(_loc4_)
               {
                  _loc4_.setIsInviteShown(param1);
               }
               _loc2_++;
            }
         }
         this._isInviteShown = param1;
      }
      
      public function setLaneFilter(param1:int) : void
      {
         this._laneFilterIsActive = param1 >= 0;
         invalidateData();
      }
      
      public function setupSquadElements(param1:BattleButton, param2:BattleButton) : void
      {
         this._squadAcceptBt = param1;
         this._squadAddBt = param2;
      }
      
      public function setupSquadHandler(param1:EpicFullStatsTableCtrl) : void
      {
         this._squadHandler = param1;
      }
      
      private function setupDynamicSquad(param1:EpicStatsPlayerRenderer) : void
      {
         var _loc2_:DynamicSquadCtrl = new DynamicSquadCtrl(param1.squadStatus,param1.squad,this._squadAcceptBt,this._squadAddBt,param1.hit,param1.noSound);
         _loc2_.addActionHandler(this._squadHandler);
         param1.setupDynamicSquadCtrl(_loc2_);
      }
      
      override public function set scrollPosition(param1:Number) : void
      {
         if(!this._laneFilterIsActive)
         {
            super.scrollPosition = param1;
         }
      }
      
      private function onPlayerItemRendererClickedHandler(param1:EpicFullStatsRendererEvent) : void
      {
         var _loc3_:DAAPIVehicleInfoVO = null;
         var _loc2_:EpicVehicleDataProvider = _dataProvider as EpicVehicleDataProvider;
         if(_loc2_)
         {
            _loc3_ = _loc2_.requestVehicleData(param1.vehicleID);
            if(_loc3_ && App.utils.commons.isRightButton(param1.mEvent) && !PlayerStatus.isActionDisabled(_loc3_.playerStatus) && !UserTags.isCurrentPlayer(_loc3_.userTags))
            {
               this._contextMenuMgr.show(BATTLE_CONTEXT_MENU_HANDLER_TYPE.EPIC_FULL_STATS,this,new PlayersPanelContextMenuSentData(param1.vehicleID));
               App.toolTipMgr.hide();
            }
         }
      }
   }
}
