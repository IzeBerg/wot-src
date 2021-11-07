package net.wg.gui.battle.eventBattle.views.eventPlayersPanel
{
   import flash.display.MovieClip;
   import net.wg.data.constants.generated.BATTLEATLAS;
   import net.wg.gui.battle.components.BattleAtlasSprite;
   import net.wg.gui.battle.components.BattleUIComponent;
   import net.wg.gui.battle.components.stats.playersPanel.ChatCommandItemComponent;
   import net.wg.gui.battle.eventBattle.views.eventPlayersPanel.VO.DAAPIPlayerPanelInfoVO;
   import net.wg.gui.components.controls.BadgeComponent;
   import net.wg.gui.eventcomponents.NumberProgress;
   import org.idmedia.as3commons.util.StringUtils;
   
   public class EventPlayersPanelListItem extends BattleUIComponent
   {
      
      private static const SUFFIX_SQUAD:String = "_Squad";
      
      private static const NAME_COLOR_GREY:int = 1;
      
      private static const NAME_COLOR_SQUAD:int = 2;
      
      private static const NAME_COLOR_BLACK:int = 3;
      
      private static const COMMUNICATION_X_OFFSET:uint = 10;
      
      private static const NAME_SPACE:uint = 165;
      
      private static const BADGE_ICON_MARGIN:uint = 25;
      
      private static const ICON_MARGIN:uint = 23;
      
      private static const PLAYER_XPOS:uint = 55;
      
      private static const BADGE_GAP:int = 2;
       
      
      public var namePlayer:NumberProgress = null;
      
      public var typeVehicle:MovieClip = null;
      
      public var healthBar:EventHealthBar = null;
      
      public var matterIndicator:EventMatterIndicator = null;
      
      public var chatCommandState:ChatCommandItemComponent = null;
      
      public var squadIcon:BattleAtlasSprite = null;
      
      public var badgeIcon:BadgeComponent = null;
      
      public var testerIcon:BattleAtlasSprite = null;
      
      public var testerBG:BattleAtlasSprite = null;
      
      private var _namePlayer:String = "";
      
      private var _isSquad:Boolean = false;
      
      private var _countSouls:uint = 0;
      
      private var _vehID:uint = 0;
      
      private var _isEnabled:Boolean = true;
      
      private var _playerNameSpace:int = 0;
      
      public function EventPlayersPanelListItem()
      {
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.chatCommandState.iconOffset(COMMUNICATION_X_OFFSET);
         this.chatCommandState.setAnimationVisibility(false);
         this.squadIcon.visible = false;
      }
      
      override protected function onDispose() : void
      {
         this.namePlayer.dispose();
         this.namePlayer = null;
         this.typeVehicle = null;
         this.healthBar.dispose();
         this.healthBar = null;
         this.matterIndicator.dispose();
         this.matterIndicator = null;
         this.squadIcon = null;
         this.badgeIcon.dispose();
         this.badgeIcon = null;
         this.testerIcon = null;
         this.testerBG = null;
         this.chatCommandState.dispose();
         this.chatCommandState = null;
         super.onDispose();
      }
      
      public function getCountSouls() : uint
      {
         return this._countSouls;
      }
      
      public function setChatCommand(param1:String, param2:uint) : void
      {
         this.chatCommandState.setActiveChatCommand(param1,param2);
      }
      
      public function setCountSouls(param1:uint) : void
      {
         this.matterIndicator.setCount(param1);
         this._countSouls = param1;
      }
      
      public function setData(param1:DAAPIPlayerPanelInfoVO) : void
      {
         this._namePlayer = param1.name;
         this._isSquad = param1.isSquad;
         this._vehID = param1.vehID;
         this.namePlayer.setColor(!!this._isSquad ? int(NAME_COLOR_SQUAD) : int(NAME_COLOR_GREY));
         if(_baseDisposed)
         {
            return;
         }
         this.namePlayer.setValue(param1.name);
         var _loc2_:String = param1.typeVehicle;
         if(this._isSquad)
         {
            _loc2_ += SUFFIX_SQUAD;
         }
         this.typeVehicle.gotoAndStop(_loc2_);
         if(_baseDisposed)
         {
            return;
         }
         this.setHp(param1.hpMax,param1.hpCurrent);
         if(_baseDisposed)
         {
            return;
         }
         this.setCountSouls(param1.countSouls);
         if(_baseDisposed)
         {
            return;
         }
         this.healthBar.setSelfState(param1.isSelf);
         if(_baseDisposed)
         {
            return;
         }
         if(param1.hpCurrent == 0)
         {
            this.setEnable(false);
         }
         var _loc3_:int = param1.squadIndex;
         if(_loc3_ > 0)
         {
            this.squadIcon.visible = true;
            if(this._isSquad)
            {
               this.squadIcon.imageName = BATTLEATLAS.squad_gold(_loc3_.toString());
            }
            else
            {
               this.squadIcon.imageName = BATTLEATLAS.squad_silver(_loc3_.toString());
            }
         }
         this._playerNameSpace = NAME_SPACE;
         if(param1.badgeVO)
         {
            this.badgeIcon.visible = true;
            this.badgeIcon.setData(param1.badgeVO);
            this.namePlayer.x = this.badgeIcon.x + BADGE_ICON_MARGIN;
            this._playerNameSpace -= BADGE_ICON_MARGIN;
         }
         else
         {
            this.namePlayer.x = PLAYER_XPOS;
            this.badgeIcon.visible = false;
         }
         var _loc4_:Boolean = StringUtils.isNotEmpty(param1.suffixBadgeIcon);
         this.testerIcon.visible = this.testerBG.visible = _loc4_;
         if(_loc4_)
         {
            this.testerIcon.imageName = param1.suffixBadgeIcon;
            this.testerBG.imageName = param1.suffixBadgeStripIcon;
            this._playerNameSpace -= ICON_MARGIN;
         }
         this.namePlayer.setTextFieldWidth(this._playerNameSpace);
         this.namePlayer.setValue(this._namePlayer);
         if(_loc4_)
         {
            this.testerIcon.x = this.namePlayer.x + this.namePlayer.getTextWidth() + BADGE_GAP >> 0;
            this.testerBG.x = (this.testerIcon.width >> 1) + this.testerIcon.x - this.testerBG.width >> 0;
         }
      }
      
      public function setEnable(param1:Boolean) : void
      {
         if(param1 || this._isSquad)
         {
            this.namePlayer.setColor(!!this._isSquad ? int(NAME_COLOR_SQUAD) : int(NAME_COLOR_GREY));
         }
         else
         {
            this.namePlayer.setColor(NAME_COLOR_BLACK);
         }
         if(_baseDisposed)
         {
            return;
         }
         this.namePlayer.setTextFieldWidth(this._playerNameSpace);
         this.namePlayer.setValue(this._namePlayer);
         this.matterIndicator.visible = param1;
         this._isEnabled = param1;
      }
      
      public function setHp(param1:int, param2:int) : void
      {
         var _loc3_:Number = this.healthBar.getHpMaskWidth();
         this.healthBar.gotoAndStop(this.healthBar.totalFrames * (1 - param2 / param1));
         if(_baseDisposed)
         {
            return;
         }
         var _loc4_:Number = this.healthBar.getHpMaskWidth();
         this.healthBar.playFx(_loc3_,_loc4_);
         if(_baseDisposed)
         {
            return;
         }
         if(!this._isEnabled && param2 > 0)
         {
            this.setEnable(true);
         }
      }
      
      public function triggerChatCommand(param1:String) : void
      {
         this.chatCommandState.playCommandAnimation(param1);
      }
      
      public function get vehID() : uint
      {
         return this._vehID;
      }
   }
}
