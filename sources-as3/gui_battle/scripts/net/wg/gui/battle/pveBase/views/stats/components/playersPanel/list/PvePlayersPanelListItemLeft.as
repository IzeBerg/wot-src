package net.wg.gui.battle.pveBase.views.stats.components.playersPanel.list
{
   import flash.text.TextFieldAutoSize;
   import net.wg.data.constants.generated.BATTLEATLAS;
   import net.wg.data.constants.generated.PLAYERS_PANEL_STATE;
   import net.wg.gui.battle.battleloading.BattleLoadingHelper;
   import net.wg.gui.battle.components.BattleAtlasSprite;
   import net.wg.gui.battle.pveBase.views.stats.components.playersPanel.interfaces.IPvePlayersPanelListItem;
   import net.wg.gui.battle.random.views.stats.components.playersPanel.constants.PlayersPanelInvalidationType;
   import net.wg.gui.battle.random.views.stats.components.playersPanel.list.PlayersPanelListItem;
   
   public class PvePlayersPanelListItemLeft extends PlayersPanelListItem implements IPvePlayersPanelListItem
   {
      
      private static const HIGHLIGHT_TEXT_COLOR:uint = 16630156;
      
      private static const VEHICLE_TYPE_WIDTH:int = 24;
      
      private static const FRAGS_WIDTH:int = 24;
      
      private static const LIVECOUNTER_OFFSET:int = 45;
      
      private static const LIVECOUNTER_OFFSET_FULL:int = 40;
      
      private static const VEHICLE_ICON_OFFSET:int = -28;
      
      private static const SHOW_FRAGS:uint = 1;
      
      private static const SHOW_VEHICLE_TYPE:uint = 2;
       
      
      public var vehicleType:BattleAtlasSprite = null;
      
      public var liveCounter:PveLiveCounter = null;
      
      private var _vehicleType:String = null;
      
      private var _teamColor:String = null;
      
      private var _highlighted:Boolean = false;
      
      private var _state:int = 1;
      
      private var _icoIGRDefaultX:int = 0;
      
      private var _muteDefaultX:int = 0;
      
      private var _disableCommunicationDefaultX:int = 0;
      
      public function PvePlayersPanelListItemLeft()
      {
         super();
         this._icoIGRDefaultX = icoIGR.x;
         this._muteDefaultX = mute.x;
         this._disableCommunicationDefaultX = disableCommunication.x;
      }
      
      private static function calculateState(param1:Boolean, param2:Boolean) : int
      {
         var _loc3_:int = 0;
         if(param1)
         {
            _loc3_ = SHOW_FRAGS;
         }
         if(param2)
         {
            _loc3_ |= SHOW_VEHICLE_TYPE;
         }
         return _loc3_;
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.vehicleType.mouseEnabled = false;
         this.vehicleType.isCentralize = true;
         fragsTF.autoSize = TextFieldAutoSize.NONE;
      }
      
      public function setVehicleType(param1:String) : void
      {
         if(this._vehicleType == param1)
         {
            return;
         }
         this._vehicleType = param1;
         invalidate(PlayersPanelInvalidationType.PLAYER_SCHEME);
      }
      
      public function setTeamColor(param1:String) : void
      {
         if(this._teamColor == param1)
         {
            return;
         }
         this._teamColor = param1;
         invalidate(PlayersPanelInvalidationType.PLAYER_SCHEME);
      }
      
      public function setHighlighted(param1:Boolean) : void
      {
         if(this._highlighted == param1)
         {
            return;
         }
         this._highlighted = param1;
         invalidate(PlayersPanelInvalidationType.PLAYER_SCHEME);
      }
      
      public function setShowFrags(param1:Boolean) : void
      {
         var _loc2_:int = calculateState(param1,(this._state & SHOW_VEHICLE_TYPE) > 0);
         if(this._state == _loc2_)
         {
            return;
         }
         this._state = _loc2_;
         invalidate();
      }
      
      public function setShowVehicleTypeIcon(param1:Boolean) : void
      {
         var _loc2_:int = calculateState((this._state & SHOW_FRAGS) > 0,param1);
         if(this._state == _loc2_)
         {
            return;
         }
         this._state = _loc2_;
         invalidate();
      }
      
      public function setCountLivesVisibility(param1:Boolean) : void
      {
         this.liveCounter.visible = param1;
         this.updatePositions();
      }
      
      public function setCountLives(param1:int) : void
      {
         this.liveCounter.lives = param1;
      }
      
      override protected function onDispose() : void
      {
         this.vehicleType = null;
         this.liveCounter.dispose();
         this.liveCounter = null;
         super.onDispose();
      }
      
      override protected function updateColors() : void
      {
         var _loc1_:String = null;
         super.updateColors();
         if(this._vehicleType != null && (this._state & SHOW_VEHICLE_TYPE) > 0)
         {
            _loc1_ = BattleLoadingHelper.instance.getVehicleTypeIconIdAlt(this._teamColor,this._vehicleType);
            this.vehicleType.imageName = BATTLEATLAS.getFullStatsVehicleType(_loc1_);
            this.vehicleType.visible = true;
         }
         else
         {
            this.vehicleType.visible = false;
         }
         if(isAlive && this._highlighted)
         {
            playerNameFullTF.textColor = playerNameCutTF.textColor = vehicleTF.textColor = HIGHLIGHT_TEXT_COLOR;
         }
      }
      
      override protected function getOffset() : int
      {
         return !!this.liveCounter.visible ? int(LIVECOUNTER_OFFSET) : int(0);
      }
      
      override protected function getOffsetVehicleIcon() : int
      {
         return !!this.liveCounter.visible ? int(VEHICLE_ICON_OFFSET + LIVECOUNTER_OFFSET) : int(VEHICLE_ICON_OFFSET);
      }
      
      override protected function updatePositions() : void
      {
         var _loc1_:uint = 0;
         switch(this._state)
         {
            case 0:
               fragsTF.width = 0;
               fragsTF.visible = this.vehicleType.visible = false;
               break;
            case SHOW_FRAGS:
               fragsTF.width = FRAGS_WIDTH;
               fragsTF.visible = true;
               this.vehicleType.visible = false;
               break;
            case SHOW_VEHICLE_TYPE:
               fragsTF.width = VEHICLE_TYPE_WIDTH;
               fragsTF.visible = false;
               this.vehicleType.visible = true;
               break;
            case SHOW_FRAGS | SHOW_VEHICLE_TYPE:
               fragsTF.width = FRAGS_WIDTH + VEHICLE_TYPE_WIDTH;
               fragsTF.visible = this.vehicleType.visible = true;
         }
         super.updatePositions();
         switch(this._state)
         {
            case SHOW_VEHICLE_TYPE:
               this.vehicleType.x = fragsTF.x + (VEHICLE_TYPE_WIDTH >> 1);
               break;
            case SHOW_FRAGS | SHOW_VEHICLE_TYPE:
               fragsTF.width = FRAGS_WIDTH;
               this.vehicleType.x = fragsTF.x + FRAGS_WIDTH + (VEHICLE_TYPE_WIDTH >> 1);
         }
         if(this.liveCounter.visible)
         {
            _loc1_ = getState();
            if(_loc1_ != PLAYERS_PANEL_STATE.FULL && _loc1_ != PLAYERS_PANEL_STATE.FULL_NO_BADGES)
            {
               this.liveCounter.x = vehicleIcon.x - LIVECOUNTER_OFFSET;
            }
            else
            {
               this.liveCounter.x = vehicleTF.x - LIVECOUNTER_OFFSET_FULL;
            }
         }
         icoIGR.x = this._icoIGRDefaultX + this.getOffset();
         mute.x = this._muteDefaultX + this.getOffset();
         disableCommunication.x = this._disableCommunicationDefaultX + this.getOffset();
      }
      
      override protected function updatePositionsLeft() : void
      {
         super.updatePositionsLeft();
         var _loc1_:int = x > 0 ? int(-x) : int(0);
         selfBg.x = _loc1_;
         deadAltBg.x = _loc1_;
         deadBg.x = _loc1_;
         normAltBg.x = _loc1_;
         bg.x = _loc1_;
      }
      
      override protected function draw() : void
      {
         super.draw();
         this.vehicleType.alpha = fragsTF.alpha;
      }
   }
}
