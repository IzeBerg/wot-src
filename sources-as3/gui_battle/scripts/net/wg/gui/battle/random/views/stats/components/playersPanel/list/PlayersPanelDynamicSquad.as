package net.wg.gui.battle.random.views.stats.components.playersPanel.list
{
   import net.wg.data.constants.InvalidationType;
   import net.wg.data.constants.generated.BATTLEATLAS;
   import net.wg.gui.battle.components.BattleAtlasSprite;
   import net.wg.gui.battle.components.BattleUIComponent;
   import net.wg.gui.battle.components.buttons.BattleButton;
   import net.wg.gui.battle.components.buttons.interfaces.IClickButtonHandler;
   import net.wg.gui.battle.random.views.stats.events.DynamicSquadEvent;
   import net.wg.gui.battle.views.stats.SquadTooltip;
   import net.wg.gui.battle.views.stats.constants.DynamicSquadState;
   import net.wg.gui.battle.views.stats.constants.SquadInvalidationType;
   
   public class PlayersPanelDynamicSquad extends BattleUIComponent implements IClickButtonHandler
   {
       
      
      public var squadIcon:BattleAtlasSprite = null;
      
      public var inviteDisabled:BattleAtlasSprite = null;
      
      public var inviteReceivedFromSquad:BattleAtlasSprite = null;
      
      public var inviteReceived:BattleAtlasSprite = null;
      
      public var inviteSent:BattleAtlasSprite = null;
      
      public var squadAcceptBt:BattleButton = null;
      
      public var squadAddBt:BattleButton = null;
      
      public var noSound:BattleAtlasSprite = null;
      
      private var _state:int = 0;
      
      private var _isPersonal:Boolean = false;
      
      private var _squadIndex:int = 0;
      
      private var _isInviteShown:Boolean = false;
      
      private var _isInteractive:Boolean = false;
      
      private var _isMouseOver:Boolean = false;
      
      private var _tooltip:SquadTooltip = null;
      
      private var _noSound:Boolean = false;
      
      private var _isEnemy:Boolean = false;
      
      private var _sessionID:String = "";
      
      private var _isCurrentPlayerAnonymized:Boolean = false;
      
      private var _isCurrentPlayerInClan:Boolean = false;
      
      public function PlayersPanelDynamicSquad()
      {
         super();
         this._state = DynamicSquadState.NONE;
         this._tooltip = new SquadTooltip();
      }
      
      public function setState(param1:int) : void
      {
         if(this._state == param1)
         {
            return;
         }
         this._state = param1;
         invalidateState();
      }
      
      public function setIsInviteShown(param1:Boolean) : void
      {
         if(this._isInviteShown == param1)
         {
            return;
         }
         this._isInviteShown = param1;
         invalidate(SquadInvalidationType.ACTIVE_MOUSE_OVER);
      }
      
      public function setIsInteractive(param1:Boolean) : void
      {
         if(this._isInteractive == param1)
         {
            return;
         }
         var _loc2_:Boolean = this._isInteractive && this._isMouseOver;
         this._isInteractive = param1;
         if(!param1)
         {
            this._isMouseOver = false;
         }
         if(_loc2_ != (this._isInteractive && this._isMouseOver))
         {
            this.updateTooltip();
            invalidate(SquadInvalidationType.ACTIVE_MOUSE_OVER);
         }
      }
      
      public function setCurrentSquad(param1:Boolean, param2:int) : void
      {
         if(this._isPersonal == param1 && this._squadIndex == param2)
         {
            return;
         }
         this._isPersonal = param1;
         this._squadIndex = param2;
         if(param2 > 0)
         {
            if(param1)
            {
               this.squadIcon.imageName = BATTLEATLAS.squad_gold(param2.toString());
            }
            else
            {
               this.squadIcon.imageName = BATTLEATLAS.squad_silver(param2.toString());
            }
         }
         invalidate(SquadInvalidationType.SQUAD_INDEX);
      }
      
      public function setNoSound(param1:Boolean) : void
      {
         if(this._noSound == param1)
         {
            return;
         }
         this._noSound = param1;
         invalidate(SquadInvalidationType.SQUAD_NO_SOUND);
      }
      
      public function setIsEnemy(param1:Boolean) : void
      {
         this._isEnemy = param1;
      }
      
      public function setSessionID(param1:String) : void
      {
         this._sessionID = param1;
      }
      
      public function setCurrentPlayerAnonymized() : void
      {
         this._isCurrentPlayerAnonymized = true;
      }
      
      public function setIsCurrentPlayerInClan(param1:Boolean) : void
      {
         this._isCurrentPlayerInClan = param1;
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.squadIcon.visible = false;
         this.inviteDisabled.visible = false;
         this.inviteDisabled.imageName = BATTLEATLAS.SQUAD_INVITE_DISABLED;
         this.inviteReceivedFromSquad.visible = false;
         this.inviteReceivedFromSquad.imageName = BATTLEATLAS.SQUAD_INVITE_RECEIVED_FROM_SQUAD;
         this.inviteReceived.visible = false;
         this.inviteReceived.imageName = BATTLEATLAS.SQUAD_INVITE_RECEIVED;
         this.inviteSent.visible = false;
         this.inviteSent.imageName = BATTLEATLAS.SQUAD_INVITE_SENT;
         this.noSound.visible = false;
         this.noSound.imageName = BATTLEATLAS.SQUAD_NO_SOUND;
         this.squadAcceptBt.visible = false;
         this.squadAddBt.visible = false;
         this.squadAcceptBt.addClickCallBack(this);
         this.squadAddBt.addClickCallBack(this);
         buttonMode = true;
         invalidate(InvalidationType.ALL);
      }
      
      override protected function onDispose() : void
      {
         this.squadAcceptBt.dispose();
         this.squadAddBt.dispose();
         this.squadIcon = null;
         this.inviteDisabled = null;
         this.inviteReceivedFromSquad = null;
         this.inviteReceived = null;
         this.inviteSent = null;
         this.squadAcceptBt = null;
         this.squadAddBt = null;
         this.noSound = null;
         this._tooltip = null;
         this._isCurrentPlayerAnonymized = false;
         this._isCurrentPlayerInClan = false;
         super.onDispose();
      }
      
      public function onItemOver() : void
      {
         if(this._isMouseOver)
         {
            return;
         }
         this._isMouseOver = true;
         if(this._isInteractive)
         {
            this.updateTooltip();
            invalidate(SquadInvalidationType.ACTIVE_MOUSE_OVER);
         }
      }
      
      public function onItemOut() : void
      {
         if(!this._isMouseOver)
         {
            return;
         }
         this._isMouseOver = false;
         if(this._isInteractive)
         {
            this.updateTooltip();
            invalidate(SquadInvalidationType.ACTIVE_MOUSE_OVER);
         }
      }
      
      public function onButtonClick(param1:Object) : void
      {
         if(param1.name == this.squadAcceptBt.name)
         {
            if(this._sessionID)
            {
               dispatchEvent(new DynamicSquadEvent(DynamicSquadEvent.ACCEPT,this._sessionID,true));
            }
         }
         else if(param1.name == this.squadAddBt.name)
         {
            if(this._sessionID)
            {
               dispatchEvent(new DynamicSquadEvent(DynamicSquadEvent.ADD,this._sessionID,true));
            }
         }
      }
      
      override protected function draw() : void
      {
         var _loc1_:Boolean = false;
         if(isInvalid(InvalidationType.STATE | SquadInvalidationType.SQUAD_INDEX))
         {
            this.squadIcon.visible = this._squadIndex && (this._state == DynamicSquadState.IN_SQUAD || this._state == DynamicSquadState.INVITE_RECEIVED_FROM_SQUAD);
         }
         if(isInvalid(InvalidationType.STATE | SquadInvalidationType.SQUAD_NO_SOUND))
         {
            this.noSound.visible = this._noSound && this._state == DynamicSquadState.IN_SQUAD;
         }
         if(isInvalid(InvalidationType.STATE | SquadInvalidationType.ACTIVE_MOUSE_OVER))
         {
            _loc1_ = this._isInteractive && this._isMouseOver;
            this.inviteDisabled.visible = _loc1_ && this._state == DynamicSquadState.INVITE_DISABLED;
            this.squadAddBt.visible = _loc1_ && this._state == DynamicSquadState.INVITE_AVAILABLE;
            this.squadAcceptBt.visible = _loc1_ && (this._state == DynamicSquadState.INVITE_RECEIVED || this._state == DynamicSquadState.INVITE_RECEIVED_FROM_SQUAD);
            this.inviteReceived.visible = this._isInviteShown && !_loc1_ && this._state == DynamicSquadState.INVITE_RECEIVED;
            this.inviteReceivedFromSquad.visible = this._isInviteShown && !_loc1_ && this._state == DynamicSquadState.INVITE_RECEIVED_FROM_SQUAD;
            this.inviteSent.visible = this._isInviteShown && this._state == DynamicSquadState.INVITE_SENT;
         }
      }
      
      private function updateTooltip() : void
      {
         if(this._isInteractive && this._isMouseOver && this._state != DynamicSquadState.NONE)
         {
            this._tooltip.show(this._state,this._isEnemy,this._isCurrentPlayerAnonymized,this._isCurrentPlayerInClan);
         }
         else
         {
            this._tooltip.hide();
         }
      }
   }
}
