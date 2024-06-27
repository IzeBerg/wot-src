package net.wg.gui.battle.battleRoyale.views
{
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.text.TextField;
   import flash.utils.Dictionary;
   import net.wg.data.VO.daapi.DAAPIVehicleInfoVO;
   import net.wg.data.VO.daapi.DAAPIVehicleUserTagsVO;
   import net.wg.data.VO.daapi.DAAPIVehiclesDataVO;
   import net.wg.data.VO.daapi.DAAPIVehiclesUserTagsVO;
   import net.wg.data.constants.Linkages;
   import net.wg.data.constants.UserTags;
   import net.wg.data.constants.Values;
   import net.wg.data.constants.generated.BATTLE_CONTEXT_MENU_HANDLER_TYPE;
   import net.wg.data.constants.generated.BATTLE_ROYAL_CONSTS;
   import net.wg.gui.battle.components.events.PlayersPanelListEvent;
   import net.wg.gui.battle.random.views.stats.components.playersPanel.VO.PlayersPanelContextMenuSentData;
   import net.wg.infrastructure.base.meta.IBattleRoyaleTeamPanelMeta;
   import net.wg.infrastructure.base.meta.impl.BattleRoyaleTeamPanelMeta;
   import net.wg.infrastructure.events.VoiceChatEvent;
   import net.wg.infrastructure.helpers.statisticsDataController.intarfaces.IBattleComponentDataController;
   import net.wg.infrastructure.interfaces.IDAAPIDataClass;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   import net.wg.infrastructure.managers.IContextMenuManager;
   
   public class BattleRoyaleTeamPanel extends BattleRoyaleTeamPanelMeta implements IBattleRoyaleTeamPanelMeta, IBattleComponentDataController
   {
      
      private static const PADDING_H:uint = 40;
      
      private static const LIST_PADDING_V:uint = 48;
      
      private static const PADDING_V:uint = 6;
      
      private static const TITLE_TF_ALPHA:Number = 0.8;
      
      private static const BLINK_DEAD_FRAME_LABEL:String = "die";
      
      private static const BLINK_REVIVE_FRAME_LABEL:String = "revive";
       
      
      public var titleTF:TextField = null;
      
      public var bg:MovieClip = null;
      
      public var bgBlinkMC:MovieClip = null;
      
      private var _renderersContainer:Sprite = null;
      
      private var _listItems:Vector.<BattleRoyaleTeamPanelListItem> = null;
      
      private var _dbIDToItemIndex:Dictionary = null;
      
      private var _vIDToItemIndex:Dictionary = null;
      
      private var _contextMenuMgr:IContextMenuManager;
      
      private var _userTags:Dictionary;
      
      private var _initUserTags:Vector.<DAAPIVehicleUserTagsVO>;
      
      private var _playerTeamIndex:int = -1;
      
      public function BattleRoyaleTeamPanel()
      {
         this._contextMenuMgr = App.contextMenuMgr;
         this._userTags = new Dictionary();
         this._initUserTags = new Vector.<DAAPIVehicleUserTagsVO>();
         super();
         this._renderersContainer = new Sprite();
         addChild(this._renderersContainer);
         this._listItems = new Vector.<BattleRoyaleTeamPanelListItem>(0);
         this.titleTF.visible = false;
         this.bg.visible = false;
      }
      
      override protected function onDispose() : void
      {
         var _loc1_:IDisposable = null;
         this.removeAllItems();
         App.voiceChatMgr.removeEventListener(VoiceChatEvent.START_SPEAKING,this.onVoiceChatStartSpeakingHandler);
         App.voiceChatMgr.removeEventListener(VoiceChatEvent.STOP_SPEAKING,this.onVoiceChatStopSpeakingHandler);
         removeEventListener(PlayersPanelListEvent.ITEM_CONTEXT_MENU_OPEN,this.onListItemContextMenuOpenHandler);
         for each(_loc1_ in this._initUserTags)
         {
            _loc1_.dispose();
         }
         this._initUserTags.length = 0;
         this._initUserTags = null;
         App.utils.data.cleanupDynamicObject(this._userTags);
         this._userTags = null;
         this._vIDToItemIndex = null;
         this._dbIDToItemIndex = null;
         this.titleTF = null;
         this.bg = null;
         this.bgBlinkMC = null;
         this._renderersContainer = null;
         this._listItems = null;
         this._contextMenuMgr = null;
         super.onDispose();
      }
      
      override protected function setInitData(param1:String, param2:Array, param3:Array, param4:int) : void
      {
         this.titleTF.text = param1;
         this._dbIDToItemIndex = new Dictionary();
         this._vIDToItemIndex = new Dictionary();
         this.removeAllItems();
         var _loc5_:uint = Values.ZERO;
         var _loc6_:uint = param2.length;
         var _loc7_:BattleRoyaleTeamPanelListItem = null;
         while(_loc5_ < _loc6_)
         {
            _loc7_ = this.addItem();
            _loc7_.setPlayerName(param2[_loc5_]);
            if(param3[_loc5_])
            {
               _loc7_.setClanName(param3[_loc5_]);
            }
            _loc5_++;
         }
         this._playerTeamIndex = param4;
         this.titleTF.visible = this.bg.visible = this.isInitialized();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         App.voiceChatMgr.addEventListener(VoiceChatEvent.START_SPEAKING,this.onVoiceChatStartSpeakingHandler);
         App.voiceChatMgr.addEventListener(VoiceChatEvent.STOP_SPEAKING,this.onVoiceChatStopSpeakingHandler);
         addEventListener(PlayersPanelListEvent.ITEM_CONTEXT_MENU_OPEN,this.onListItemContextMenuOpenHandler);
         this.titleTF.alpha = TITLE_TF_ALPHA;
         this.bgBlinkMC.stop();
         App.utils.commons.addEmptyHitArea(this.bg);
      }
      
      public function addVehiclesInfo(param1:IDAAPIDataClass) : void
      {
      }
      
      public function as_setPlayerFrags(param1:int, param2:String) : void
      {
         var _loc3_:BattleRoyaleTeamPanelListItem = this.getListItem(param1);
         if(_loc3_)
         {
            _loc3_.setFrags(param2);
         }
      }
      
      public function as_setPlayerHP(param1:int, param2:int) : void
      {
         var _loc3_:BattleRoyaleTeamPanelListItem = this.getListItem(param1);
         if(_loc3_)
         {
            _loc3_.setProgress(param2);
         }
      }
      
      public function as_setPlayerState(param1:int, param2:int, param3:int, param4:int, param5:Boolean, param6:Boolean, param7:int, param8:String, param9:String, param10:String) : void
      {
         var _loc12_:DAAPIVehicleUserTagsVO = null;
         var _loc11_:BattleRoyaleTeamPanelListItem = this.getListItem(param1);
         if(_loc11_)
         {
            _loc11_.setAlive(param5,_loc11_.getVehicleID() == param3);
            _loc11_.setReady(param6);
            _loc11_.setProgress(param7);
            _loc11_.setFrags(param8);
            _loc11_.setVehicleLevel(param9);
            _loc11_.setVehicleIcon(param10);
            _loc11_.setVehicleID(param3);
            _loc11_.setIsCurrentPlayerTeam(this._playerTeamIndex == param4);
            this._dbIDToItemIndex[param2] = param1;
            this._vIDToItemIndex[param3] = param1;
            _loc12_ = this._userTags[param3];
            if(_loc12_)
            {
               this.updateUserTags(_loc12_);
            }
         }
      }
      
      public function as_setPlayerStatus(param1:int, param2:Boolean, param3:Boolean, param4:Boolean) : void
      {
         var _loc5_:BattleRoyaleTeamPanelListItem = this.getListItem(param1);
         if(_loc5_)
         {
            _loc5_.setAlive(param2);
            _loc5_.setReady(param3);
            _loc5_.setIsRespawning(param4);
         }
      }
      
      public function as_setPlayerVehicle(param1:int, param2:String) : void
      {
         var _loc3_:BattleRoyaleTeamPanelListItem = this.getListItem(param1);
         if(_loc3_)
         {
            _loc3_.setVehicleIcon(param2);
         }
      }
      
      public function as_setVehicleLevel(param1:int, param2:String) : void
      {
         var _loc3_:BattleRoyaleTeamPanelListItem = this.getListItem(param1);
         if(_loc3_)
         {
            _loc3_.setVehicleLevel(param2);
         }
      }
      
      public function resetFrags() : void
      {
      }
      
      public function setArenaInfo(param1:IDAAPIDataClass) : void
      {
      }
      
      public function setFrags(param1:IDAAPIDataClass) : void
      {
      }
      
      public function setPersonalStatus(param1:uint) : void
      {
      }
      
      public function setQuestStatus(param1:IDAAPIDataClass) : void
      {
      }
      
      public function setUserTags(param1:IDAAPIDataClass) : void
      {
         var _loc4_:DAAPIVehicleUserTagsVO = null;
         var _loc2_:DAAPIVehiclesUserTagsVO = DAAPIVehiclesUserTagsVO(param1);
         var _loc3_:Vector.<DAAPIVehicleUserTagsVO> = _loc2_.leftUserTags;
         for each(_loc4_ in _loc3_)
         {
            this.updateUserTags(_loc4_);
         }
      }
      
      public function setVehiclesData(param1:IDAAPIDataClass) : void
      {
         var _loc4_:DAAPIVehicleInfoVO = null;
         var _loc5_:DAAPIVehicleUserTagsVO = null;
         var _loc2_:DAAPIVehiclesDataVO = DAAPIVehiclesDataVO(param1);
         var _loc3_:Vector.<DAAPIVehicleInfoVO> = _loc2_.leftVehicleInfos;
         for each(_loc4_ in _loc3_)
         {
            _loc5_ = new DAAPIVehicleUserTagsVO();
            _loc5_.userTags = _loc4_.userTags;
            _loc5_.vehicleID = _loc4_.vehicleID;
            this._initUserTags.push(_loc5_);
            this._userTags[_loc4_.vehicleID] = _loc5_;
         }
      }
      
      public function updateInvitationsStatuses(param1:IDAAPIDataClass) : void
      {
      }
      
      public function updatePersonalStatus(param1:uint, param2:uint) : void
      {
      }
      
      public function updatePlayerStatus(param1:IDAAPIDataClass) : void
      {
      }
      
      public function updateTriggeredChatCommands(param1:IDAAPIDataClass) : void
      {
      }
      
      public function updateUserTags(param1:IDAAPIDataClass) : void
      {
         var _loc2_:DAAPIVehicleUserTagsVO = null;
         if(!this.isInitialized())
         {
            return;
         }
         _loc2_ = DAAPIVehicleUserTagsVO(param1);
         this._userTags[_loc2_.vehicleID] = _loc2_;
         var _loc3_:int = this._vIDToItemIndex[_loc2_.vehicleID];
         var _loc4_:BattleRoyaleTeamPanelListItem = this.getListItem(_loc3_);
         if(_loc4_)
         {
            _loc4_.setIsCurrentPlayer(UserTags.isCurrentPlayer(_loc2_.userTags));
            if(UserTags.isIgnored(_loc2_.userTags) && UserTags.isMuted(_loc2_.userTags))
            {
               _loc4_.setVoiceState(BATTLE_ROYAL_CONSTS.VOICE_BLOCKED);
            }
            else if(UserTags.isMuted(_loc2_.userTags))
            {
               _loc4_.setVoiceState(BATTLE_ROYAL_CONSTS.VOICE_MUTED);
            }
            else if(UserTags.isIgnored(_loc2_.userTags))
            {
               _loc4_.setVoiceState(BATTLE_ROYAL_CONSTS.VOICE_CHAT_DISABLED);
            }
            else
            {
               _loc4_.setVoiceState(BATTLE_ROYAL_CONSTS.VOICE_DEFAULT);
            }
         }
      }
      
      public function updateVehicleStatus(param1:IDAAPIDataClass) : void
      {
      }
      
      public function updateVehiclesData(param1:IDAAPIDataClass) : void
      {
      }
      
      public function updateVehiclesStat(param1:IDAAPIDataClass) : void
      {
      }
      
      private function isInitialized() : Boolean
      {
         return this._listItems.length > 0;
      }
      
      private function getListItem(param1:int) : BattleRoyaleTeamPanelListItem
      {
         var _loc2_:BattleRoyaleTeamPanelListItem = null;
         if(param1 < this._listItems.length)
         {
            _loc2_ = this._listItems[param1];
         }
         else
         {
            App.utils.asserter.assert(false,"Wrong list item index, " + param1);
         }
         return _loc2_;
      }
      
      private function addItem() : BattleRoyaleTeamPanelListItem
      {
         var _loc1_:BattleRoyaleTeamPanelListItem = App.utils.classFactory.getComponent(Linkages.TEAM_PANEL_LIST_ITEM,BattleRoyaleTeamPanelListItem);
         _loc1_.x = PADDING_H;
         _loc1_.y = this._listItems.length * (_loc1_.height + PADDING_V) + LIST_PADDING_V;
         _loc1_.addEventListener(BattleRoyaleTeamPanelListItem.EVENT_TYPE_DEAD,this.onRendererDeadHandler);
         _loc1_.addEventListener(BattleRoyaleTeamPanelListItem.EVENT_TYPE_REVIVE,this.onRendererReviveHandler);
         this._listItems.push(_loc1_);
         this._renderersContainer.addChild(_loc1_);
         return _loc1_;
      }
      
      private function removeAllItems() : void
      {
         var _loc1_:BattleRoyaleTeamPanelListItem = null;
         for each(_loc1_ in this._listItems)
         {
            _loc1_.removeEventListener(BattleRoyaleTeamPanelListItem.EVENT_TYPE_REVIVE,this.onRendererReviveHandler);
            _loc1_.removeEventListener(BattleRoyaleTeamPanelListItem.EVENT_TYPE_DEAD,this.onRendererDeadHandler);
            this._renderersContainer.removeChild(_loc1_);
            _loc1_.dispose();
         }
         this._listItems.splice(Values.ZERO,this._listItems.length);
      }
      
      private function onListItemContextMenuOpenHandler(param1:PlayersPanelListEvent) : void
      {
         this._contextMenuMgr.show(BATTLE_CONTEXT_MENU_HANDLER_TYPE.PLAYERS_PANEL,this,new PlayersPanelContextMenuSentData(param1.vehicleID));
      }
      
      private function onRendererDeadHandler(param1:Event) : void
      {
         this.bgBlinkMC.gotoAndPlay(BLINK_DEAD_FRAME_LABEL);
      }
      
      private function onRendererReviveHandler(param1:Event) : void
      {
         this.bgBlinkMC.gotoAndPlay(BLINK_REVIVE_FRAME_LABEL);
      }
      
      private function onVoiceChatStartSpeakingHandler(param1:VoiceChatEvent) : void
      {
         var _loc2_:Number = NaN;
         _loc2_ = param1.getAccountDBID();
         var _loc3_:int = this._dbIDToItemIndex[_loc2_];
         var _loc4_:BattleRoyaleTeamPanelListItem = this.getListItem(_loc3_);
         if(_loc4_ && _loc4_.getVoiceState() == BATTLE_ROYAL_CONSTS.VOICE_DEFAULT)
         {
            _loc4_.setVoiceState(BATTLE_ROYAL_CONSTS.VOICE_ACTIVE);
         }
      }
      
      private function onVoiceChatStopSpeakingHandler(param1:VoiceChatEvent) : void
      {
         var _loc2_:Number = NaN;
         _loc2_ = param1.getAccountDBID();
         var _loc3_:int = this._dbIDToItemIndex[_loc2_];
         var _loc4_:BattleRoyaleTeamPanelListItem = this.getListItem(_loc3_);
         if(_loc4_ && _loc4_.getVoiceState() == BATTLE_ROYAL_CONSTS.VOICE_ACTIVE)
         {
            _loc4_.setVoiceState(BATTLE_ROYAL_CONSTS.VOICE_DEFAULT);
         }
      }
   }
}
