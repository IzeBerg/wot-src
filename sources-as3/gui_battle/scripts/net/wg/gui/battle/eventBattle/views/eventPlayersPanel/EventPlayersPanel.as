package net.wg.gui.battle.eventBattle.views.eventPlayersPanel
{
   import flash.display.Sprite;
   import net.wg.data.VO.daapi.DAAPITriggeredCommandVO;
   import net.wg.data.VO.daapi.DAAPITriggeredCommandsVO;
   import net.wg.data.constants.InvalidationType;
   import net.wg.gui.battle.eventBattle.views.eventPlayersPanel.VO.DAAPIPlayerPanelInfoVO;
   import net.wg.infrastructure.base.meta.IEventPlayersPanelMeta;
   import net.wg.infrastructure.base.meta.impl.EventPlayersPanelMeta;
   
   public class EventPlayersPanel extends EventPlayersPanelMeta implements IEventPlayersPanelMeta
   {
      
      private static const LIST_PLAYERS_ITEM_LINKAGE:String = "EventPlayersPanelListItemUI";
      
      private static const LIST_ITEM_HEIGHT:int = 33;
      
      private static const INFO_OFFSET:int = 10;
       
      
      public var eventPlayersInfo:EventPlayersInfo = null;
      
      private var _playersPanelListItems:Vector.<EventPlayersPanelListItem> = null;
      
      private var _playerRendererContainer:Sprite = null;
      
      private var _playersCount:int = 0;
      
      private var _soulsCount:uint = 0;
      
      public function EventPlayersPanel()
      {
         super();
         mouseChildren = false;
         mouseEnabled = false;
         this._playersPanelListItems = new Vector.<EventPlayersPanelListItem>();
         this._playerRendererContainer = new Sprite();
         addChild(this._playerRendererContainer);
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(InvalidationType.POSITION))
         {
            this.eventPlayersInfo.y = this._playersCount * LIST_ITEM_HEIGHT + INFO_OFFSET;
         }
         if(isInvalid(InvalidationType.DATA))
         {
            this.eventPlayersInfo.setCountSouls(this._soulsCount);
         }
      }
      
      override protected function updateTriggeredChatCommands(param1:DAAPITriggeredCommandsVO) : void
      {
         var _loc4_:DAAPITriggeredCommandVO = null;
         var _loc5_:int = 0;
         var _loc2_:DAAPITriggeredCommandsVO = DAAPITriggeredCommandsVO(param1);
         var _loc3_:Vector.<DAAPITriggeredCommandVO> = _loc2_.triggeredCommands;
         for each(_loc4_ in _loc3_)
         {
            _loc5_ = this.getPlayerIndex(_loc4_.vehicleID);
            if(_loc5_ >= 0)
            {
               this._playersPanelListItems[_loc5_].triggerChatCommand(_loc4_.chatCommandName);
            }
         }
      }
      
      override protected function onDispose() : void
      {
         this.eventPlayersInfo.dispose();
         this.eventPlayersInfo = null;
         this.clearPlayerRendererContainer();
         this.clearPlayersPanelListItems();
         super.onDispose();
      }
      
      override protected function setPlayerPanelInfo(param1:DAAPIPlayerPanelInfoVO) : void
      {
         var _loc3_:EventPlayersPanelListItem = null;
         var _loc2_:int = this.getPlayerIndex(param1.vehID);
         if(_loc2_ >= 0)
         {
            this._playersPanelListItems[_loc2_].setData(param1);
         }
         else
         {
            _loc3_ = App.utils.classFactory.getComponent(LIST_PLAYERS_ITEM_LINKAGE,EventPlayersPanelListItem);
            _loc3_.y = this._playersCount * LIST_ITEM_HEIGHT;
            _loc3_.setData(param1);
            this._playerRendererContainer.addChild(_loc3_);
            this._playersPanelListItems.push(_loc3_);
            ++this._playersCount;
         }
         invalidatePosition();
         this.updateTotalSoulsCount();
      }
      
      public function as_setPlayerDead(param1:int) : void
      {
         var _loc2_:int = this.getPlayerIndex(param1);
         if(_loc2_ >= 0)
         {
            this._playersPanelListItems[_loc2_].setEnable(false);
         }
      }
      
      public function as_setPlayerPanelCountSouls(param1:int, param2:int) : void
      {
         var _loc3_:int = this.getPlayerIndex(param1);
         if(_loc3_ >= 0)
         {
            this._playersPanelListItems[_loc3_].setCountSouls(param2);
         }
         this.updateTotalSoulsCount();
      }
      
      public function as_setPlayerPanelHp(param1:int, param2:int, param3:int) : void
      {
         var _loc4_:int = this.getPlayerIndex(param1);
         if(_loc4_ >= 0)
         {
            this._playersPanelListItems[_loc4_].setHp(param2,param3);
         }
      }
      
      private function clearPlayerRendererContainer() : void
      {
         var _loc1_:int = 0;
         if(this._playerRendererContainer)
         {
            _loc1_ = this._playerRendererContainer.numChildren;
            while(--_loc1_ >= 0)
            {
               this._playerRendererContainer.removeChildAt(0);
            }
            removeChild(this._playerRendererContainer);
            this._playerRendererContainer = null;
         }
      }
      
      private function clearPlayersPanelListItems() : void
      {
         var _loc1_:EventPlayersPanelListItem = null;
         if(this._playersPanelListItems)
         {
            for each(_loc1_ in this._playersPanelListItems)
            {
               _loc1_.dispose();
            }
            this._playersPanelListItems.splice(0,this._playersPanelListItems.length);
            this._playersPanelListItems = null;
         }
      }
      
      private function getPlayerIndex(param1:int) : int
      {
         var _loc2_:int = this._playersPanelListItems.length;
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_)
         {
            if(this._playersPanelListItems[_loc3_].vehID == param1)
            {
               return _loc3_;
            }
            _loc3_++;
         }
         return -1;
      }
      
      private function updateTotalSoulsCount() : void
      {
         this._soulsCount = 0;
         var _loc1_:int = this._playersPanelListItems.length;
         var _loc2_:int = 0;
         while(_loc2_ < _loc1_)
         {
            this._soulsCount += this._playersPanelListItems[_loc2_].getCountSouls();
            _loc2_++;
         }
         invalidateData();
      }
      
      public function as_setChatCommand(param1:Number, param2:String, param3:uint) : void
      {
         var _loc4_:int = this.getPlayerIndex(param1);
         if(_loc4_ >= 0)
         {
            this._playersPanelListItems[_loc4_].setChatCommand(param2,param3);
         }
      }
      
      public function as_setCollectorGoal(param1:int) : void
      {
         this.eventPlayersInfo.setGoal(param1);
      }
      
      public function as_setCollectorNeedValue(param1:int) : void
      {
         this.eventPlayersInfo.setCollectorValue(param1);
      }
   }
}
