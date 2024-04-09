package net.wg.gui.battle.pveBase.views.stats.components.playersPanel.list
{
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import net.wg.data.constants.generated.BATTLEATLAS;
   import net.wg.data.constants.generated.PLAYERS_PANEL_STATE;
   import net.wg.gui.battle.battleloading.BattleLoadingHelper;
   import net.wg.gui.battle.components.BattleAtlasSprite;
   import net.wg.gui.battle.components.stats.playersPanel.ChatCommandItemComponent;
   import net.wg.gui.battle.components.stats.playersPanel.SpottedIndicator;
   import net.wg.gui.battle.components.stats.playersPanel.events.PlayersPanelItemEvent;
   import net.wg.gui.battle.components.stats.playersPanel.list.HPBarPlayersPanelListItem;
   import net.wg.gui.battle.random.views.stats.components.playersPanel.constants.PlayersPanelInvalidationType;
   import net.wg.gui.battle.views.stats.constants.PlayerStatusSchemeName;
   import net.wg.infrastructure.interfaces.IColorScheme;
   import net.wg.infrastructure.interfaces.IUserProps;
   import net.wg.utils.ICommons;
   import scaleform.gfx.TextFieldEx;
   
   public class PvePlayersPanelListItemRight extends PveBasePlayersPanelListItemRight
   {
      
      private static const ALT_TEXT_COLOR:uint = 16777215;
      
      private static const HIGHLIGHT_TEXT_COLOR:uint = 16630156;
      
      private static const DEAD_ALT_TEXT_ALPHA:Number = 0.73;
      
      private static const CHAT_COMMAND_ICONS_OFFSET:int = -210;
      
      private static const HP_BAR_VEHICLE_ICON_X:int = 111;
      
      private static const HP_BAR_OFFSET_Y:int = -24;
       
      
      public var hit:Sprite = null;
      
      public var textField:TextField = null;
      
      public var spottedIndicator:SpottedIndicator = null;
      
      public var vehicleType:BattleAtlasSprite = null;
      
      public var vehicleIcon:BattleAtlasSprite = null;
      
      public var hpBarPlayersPanelListItem:HPBarPlayersPanelListItem = null;
      
      public var deadAltBg:BattleAtlasSprite = null;
      
      public var deadBg:BattleAtlasSprite = null;
      
      public var normAltBg:BattleAtlasSprite = null;
      
      public var bg:BattleAtlasSprite = null;
      
      public var chatCommandState:ChatCommandItemComponent = null;
      
      private var _holderItemID:int = -1;
      
      private var _vehicleImage:String = null;
      
      private var _isAlive:Boolean = true;
      
      private var _isHpBarsVisible:Boolean = false;
      
      private var _isShowWithHP:Boolean = false;
      
      private var _hpSettingValue:uint = 0;
      
      private var _originalTFAlpha:Number = 0;
      
      private var _name:String = null;
      
      private var _vehicleType:String = null;
      
      private var _teamColor:String = null;
      
      private var _highlighted:Boolean = false;
      
      private var _commons:ICommons;
      
      public function PvePlayersPanelListItemRight()
      {
         this._commons = App.utils.commons;
         super();
         this.spottedIndicator.validateNow();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         TextFieldEx.setNoTranslate(this.textField,true);
         hitArea = this.hit;
         this.spottedIndicator.mouseEnabled = false;
         this.vehicleIcon.mouseEnabled = false;
         this.vehicleType.mouseEnabled = false;
         this.vehicleType.isCentralize = true;
         this.hpBarPlayersPanelListItem.setRightAligned(true);
         this.hpBarPlayersPanelListItem.setVehicleIconX(HP_BAR_VEHICLE_ICON_X);
         this.hpBarPlayersPanelListItem.setOffsetY(HP_BAR_OFFSET_Y);
         this.bg.imageName = BATTLEATLAS.PLAYERS_PANEL_BG;
         this.normAltBg.visible = false;
         this.normAltBg.imageName = BATTLEATLAS.PLAYERS_PANEL_NORM_ALT_BG;
         this.deadAltBg.visible = false;
         this.deadAltBg.imageName = BATTLEATLAS.PLAYERS_PANEL_DEAD_ALT_BG;
         this.deadBg.visible = false;
         this.deadBg.imageName = BATTLEATLAS.PLAYERS_PANEL_DEAD_BG;
         this.deadBg.mouseEnabled = this.deadBg.mouseChildren = false;
         this.bg.mouseEnabled = this.bg.mouseChildren = false;
         this._originalTFAlpha = this.textField.alpha;
         this.chatCommandState.mouseEnabled = false;
         this.chatCommandState.iconOffset(CHAT_COMMAND_ICONS_OFFSET);
         addEventListener(MouseEvent.MOUSE_OVER,this.onMouseOverHandler);
         addEventListener(MouseEvent.MOUSE_OUT,this.onMouseOutHandler);
      }
      
      override protected function onDispose() : void
      {
         hitArea = null;
         this.hit = null;
         this.bg = null;
         this.textField = null;
         this.spottedIndicator.dispose();
         this.spottedIndicator = null;
         this.vehicleIcon = null;
         this.vehicleType = null;
         this.hpBarPlayersPanelListItem.dispose();
         this.hpBarPlayersPanelListItem = null;
         this.normAltBg = null;
         this.deadAltBg = null;
         this.deadBg = null;
         this.chatCommandState.dispose();
         this.chatCommandState = null;
         this._commons = null;
         removeEventListener(MouseEvent.MOUSE_OVER,this.onMouseOverHandler);
         removeEventListener(MouseEvent.MOUSE_OUT,this.onMouseOutHandler);
         super.onDispose();
      }
      
      override public function setSpottedStatus(param1:uint) : void
      {
         this.spottedIndicator.updateSpottedStatus(param1);
      }
      
      override public function setVehicleIcon(param1:String) : void
      {
         if(this._vehicleImage == param1)
         {
            return;
         }
         this._vehicleImage = param1;
         this.vehicleIcon.setImageNames(param1,BATTLEATLAS.UNKNOWN);
      }
      
      override public function setIsAlive(param1:Boolean) : void
      {
         if(this._isAlive == param1)
         {
            return;
         }
         this._isAlive = param1;
         invalidate(PlayersPanelInvalidationType.ALIVE | PlayersPanelInvalidationType.PLAYER_SCHEME | PlayersPanelInvalidationType.HP_BAR_VISIBILITY);
      }
      
      override public function setVehicleHealth(param1:int) : void
      {
         this.hpBarPlayersPanelListItem.updateHP(param1);
      }
      
      override public function setOverrideExInfo(param1:Boolean) : void
      {
         if(!this._isShowWithHP)
         {
            this._isHpBarsVisible = this._hpSettingValue == PLAYERS_PANEL_STATE.ALWAYS_SHOW_HP || param1 && this._hpSettingValue == PLAYERS_PANEL_STATE.SHOW_HP_ON_ALT;
         }
         else
         {
            this._isHpBarsVisible = this._isShowWithHP;
         }
         invalidate(PlayersPanelInvalidationType.HP_BAR_VISIBILITY | PlayersPanelInvalidationType.ALIVE | PlayersPanelInvalidationType.PLAYER_SCHEME);
      }
      
      override public function setPanelHPBarVisibilityState(param1:uint) : void
      {
         this._hpSettingValue = param1;
         if(!this._isShowWithHP)
         {
            this._isHpBarsVisible = param1 == PLAYERS_PANEL_STATE.ALWAYS_SHOW_HP;
         }
         else
         {
            this._isHpBarsVisible = this._isShowWithHP;
         }
         invalidate(PlayersPanelInvalidationType.HP_BAR_VISIBILITY | PlayersPanelInvalidationType.ALIVE | PlayersPanelInvalidationType.PLAYER_SCHEME);
      }
      
      override public function setShowWithHP() : void
      {
         this._isShowWithHP = true;
      }
      
      override public function setChatCommand(param1:String, param2:uint) : void
      {
         this.chatCommandState.setActiveChatCommand(param1,param2);
      }
      
      override public function setChatCommandVisibility(param1:Boolean) : void
      {
         this.chatCommandState.setChatCommandVisibility(param1);
      }
      
      override public function triggerChatCommand(param1:String) : void
      {
         this.chatCommandState.playCommandAnimation(param1);
      }
      
      override public function updateColorBlind() : void
      {
         invalidate(PlayersPanelInvalidationType.PLAYER_SCHEME);
      }
      
      override public function setVehicleType(param1:String) : void
      {
         if(this._vehicleType == param1)
         {
            return;
         }
         this._vehicleType = param1;
         invalidate(PlayersPanelInvalidationType.PLAYER_SCHEME);
      }
      
      override public function setTeamColor(param1:String) : void
      {
         if(this._teamColor == param1)
         {
            return;
         }
         this._teamColor = param1;
         invalidate(PlayersPanelInvalidationType.PLAYER_SCHEME);
      }
      
      override public function setHighlighted(param1:Boolean) : void
      {
         if(this._highlighted == param1)
         {
            return;
         }
         this._highlighted = param1;
         invalidate(PlayersPanelInvalidationType.PLAYER_SCHEME);
      }
      
      override public function setPlayerNameProps(param1:IUserProps) : void
      {
         this._name = param1.userName;
         invalidate(PlayersPanelInvalidationType.VEHILCE_NAME);
      }
      
      private function updateColors() : void
      {
         var _loc4_:uint = 0;
         var _loc5_:String = null;
         var _loc1_:String = PlayerStatusSchemeName.getSchemeNameForVehicle(false,false,false,!this._isAlive,true);
         var _loc2_:IColorScheme = App.colorSchemeMgr.getScheme(_loc1_);
         if(_loc2_)
         {
            this.vehicleIcon.transform.colorTransform = _loc2_.colorTransform;
         }
         if(this._isAlive && this._highlighted)
         {
            this.textField.textColor = HIGHLIGHT_TEXT_COLOR;
         }
         else
         {
            _loc1_ = PlayerStatusSchemeName.getSchemeNameForPlayer(false,false,false,!this._isAlive,false);
            _loc2_ = App.colorSchemeMgr.getScheme(_loc1_);
            if(_loc2_)
            {
               _loc4_ = !!this._isHpBarsVisible ? uint(ALT_TEXT_COLOR) : uint(_loc2_.rgb);
               this.textField.textColor = _loc4_;
            }
         }
         var _loc3_:Boolean = App.colorSchemeMgr.getIsColorBlindS();
         this.chatCommandState.updateColors(_loc3_);
         this.hpBarPlayersPanelListItem.updateBarColor(_loc3_);
         if(this._vehicleType != null)
         {
            _loc5_ = BattleLoadingHelper.instance.getVehicleTypeIconIdAlt(this._teamColor,this._vehicleType);
            this.vehicleType.imageName = BATTLEATLAS.getFullStatsVehicleType(_loc5_);
            this.vehicleType.visible = true;
         }
         else
         {
            this.vehicleType.visible = false;
         }
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(PlayersPanelInvalidationType.VEHILCE_NAME))
         {
            this._commons.truncateTextFieldText(this.textField,this._name);
         }
         if(isInvalid(PlayersPanelInvalidationType.ALIVE))
         {
            this.bg.visible = this._isAlive && !this._isHpBarsVisible;
            this.deadBg.visible = !this._isAlive && !this._isHpBarsVisible;
            this.normAltBg.visible = this._isAlive && this._isHpBarsVisible;
            this.deadAltBg.visible = !this._isAlive && this._isHpBarsVisible;
            this.textField.alpha = !!this.deadAltBg.visible ? Number(DEAD_ALT_TEXT_ALPHA) : Number(this._originalTFAlpha);
         }
         if(isInvalid(PlayersPanelInvalidationType.PLAYER_SCHEME))
         {
            this.updateColors();
         }
         if(isInvalid(PlayersPanelInvalidationType.HP_BAR_VISIBILITY))
         {
            this.hpBarPlayersPanelListItem.visible = this._isHpBarsVisible && this._isAlive;
         }
      }
      
      override public function get holderItemID() : uint
      {
         return this._holderItemID;
      }
      
      override public function set holderItemID(param1:uint) : void
      {
         this._holderItemID = param1;
      }
      
      protected function onMouseOverHandler(param1:MouseEvent) : void
      {
         var _loc2_:PlayersPanelItemEvent = new PlayersPanelItemEvent(PlayersPanelItemEvent.ON_ITEM_OVER,this,this.holderItemID,param1);
         dispatchEvent(_loc2_);
      }
      
      protected function onMouseOutHandler(param1:MouseEvent) : void
      {
         var _loc2_:PlayersPanelItemEvent = new PlayersPanelItemEvent(PlayersPanelItemEvent.ON_ITEM_OUT,this,this.holderItemID,param1);
         dispatchEvent(_loc2_);
      }
   }
}
