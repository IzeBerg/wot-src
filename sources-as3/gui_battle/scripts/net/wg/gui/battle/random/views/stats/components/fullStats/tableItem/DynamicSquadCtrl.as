package net.wg.gui.battle.random.views.stats.components.fullStats.tableItem
{
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import net.wg.data.VO.daapi.DAAPIVehicleInfoVO;
   import net.wg.data.constants.InvalidationType;
   import net.wg.data.constants.generated.BATTLEATLAS;
   import net.wg.gui.battle.components.BattleAtlasSprite;
   import net.wg.gui.battle.components.buttons.BattleButton;
   import net.wg.gui.battle.components.buttons.interfaces.IClickButtonHandler;
   import net.wg.gui.battle.components.buttons.interfaces.IRollOutButtonHandler;
   import net.wg.gui.battle.random.views.stats.components.fullStats.interfaces.ISquadHandler;
   import net.wg.gui.battle.views.stats.SquadTooltip;
   import net.wg.gui.battle.views.stats.constants.DynamicSquadState;
   import net.wg.gui.battle.views.stats.constants.SquadInvalidationType;
   import net.wg.gui.battle.views.stats.fullStats.DogTagCtrl;
   import net.wg.gui.battle.views.stats.fullStats.SquadInviteStatusView;
   import net.wg.infrastructure.managers.ITooltipMgr;
   import org.idmedia.as3commons.util.StringUtils;
   
   public class DynamicSquadCtrl extends DogTagCtrl implements IClickButtonHandler, IRollOutButtonHandler
   {
       
      
      private var _squadStatus:SquadInviteStatusView = null;
      
      private var _squadIcon:BattleAtlasSprite = null;
      
      private var _squadAcceptBt:BattleButton = null;
      
      private var _squadAddBt:BattleButton = null;
      
      private var _noSoundSpr:BattleAtlasSprite = null;
      
      private var _handler:ISquadHandler = null;
      
      private var _tooltip:SquadTooltip = null;
      
      private var _activeButton:BattleButton = null;
      
      private var _state:int = 0;
      
      private var _squadIndex:int = 0;
      
      private var _isSquadPersonal:Boolean = false;
      
      private var _isInviteShown:Boolean = false;
      
      private var _isInteractive:Boolean = false;
      
      private var _isMouseOver:Boolean = false;
      
      private var _isNoSound:Boolean = false;
      
      private var _isEnemy:Boolean = false;
      
      private var _sessionID:String = "";
      
      private var _isCurrentPlayerAnonymized:Boolean = false;
      
      private var _isCurrentPlayerInClan:Boolean = false;
      
      private var _currentPlayerFakeName:String = null;
      
      private var _toolTipString:String = null;
      
      private var _tooltipMgr:ITooltipMgr = null;
      
      private var _activePlayerData:DAAPIVehicleInfoVO = null;
      
      public function DynamicSquadCtrl(param1:SquadInviteStatusView, param2:BattleAtlasSprite, param3:BattleButton, param4:BattleButton, param5:Sprite, param6:BattleAtlasSprite = null)
      {
         super(param5);
         this._tooltipMgr = App.toolTipMgr;
         this._state = DynamicSquadState.NONE;
         this._squadStatus = param1;
         this._squadIcon = param2;
         this._squadAcceptBt = param3;
         this._squadAcceptBt.visible = false;
         this._squadAddBt = param4;
         this._squadAddBt.visible = false;
         param5.addEventListener(MouseEvent.ROLL_OVER,this.onMouseRollOverHandler);
         param5.addEventListener(MouseEvent.ROLL_OUT,this.onMouseRollOutHandler);
         if(param6)
         {
            this._noSoundSpr = param6;
            this._noSoundSpr.visible = false;
            this._noSoundSpr.imageName = BATTLEATLAS.SQUAD_NO_SOUND;
         }
         this._tooltip = new SquadTooltip();
      }
      
      override protected function onDispose() : void
      {
         hitArea.removeEventListener(MouseEvent.ROLL_OVER,this.onMouseRollOverHandler);
         hitArea.removeEventListener(MouseEvent.ROLL_OUT,this.onMouseRollOutHandler);
         this._squadStatus = null;
         this._squadIcon = null;
         this._squadAcceptBt = null;
         this._squadAddBt = null;
         this._handler = null;
         this._noSoundSpr = null;
         this._tooltip = null;
         this._activeButton = null;
         this._isCurrentPlayerAnonymized = false;
         this._isCurrentPlayerInClan = false;
         this._currentPlayerFakeName = null;
         this._activePlayerData = null;
         this._tooltipMgr = null;
         super.onDispose();
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(InvalidationType.STATE | SquadInvalidationType.ACTIVE_MOUSE_OVER))
         {
            this.updateStatusIcons();
         }
         if(isInvalid(InvalidationType.STATE | SquadInvalidationType.SQUAD_NO_SOUND) && this._noSoundSpr)
         {
            this._noSoundSpr.visible = this._isNoSound && this._state == DynamicSquadState.IN_SQUAD;
         }
         if(isInvalid(InvalidationType.STATE | SquadInvalidationType.SQUAD_INDEX))
         {
            if((this._state == DynamicSquadState.IN_SQUAD || this._state == DynamicSquadState.INVITE_RECEIVED_FROM_SQUAD) && this._squadIndex > 0)
            {
               if(this._isSquadPersonal)
               {
                  this._squadIcon.imageName = BATTLEATLAS.squad_gold(this._squadIndex.toString());
               }
               else
               {
                  this._squadIcon.imageName = BATTLEATLAS.squad_silver(this._squadIndex.toString());
               }
               this._squadIcon.visible = true;
            }
            else
            {
               this._squadIcon.visible = false;
            }
         }
      }
      
      public function addActionHandler(param1:ISquadHandler) : void
      {
         this._handler = param1;
      }
      
      public function onButtonClick(param1:Object) : void
      {
         if(param1.name == this._squadAcceptBt.name)
         {
            if(this._handler)
            {
               this._handler.onAcceptSquad(this);
            }
         }
         else if(param1.name == this._squadAddBt.name)
         {
            if(this._handler)
            {
               this._handler.onAddToSquad(this);
            }
         }
      }
      
      public function onButtonRollOut(param1:Object) : void
      {
         if(this._isMouseOver && !this.getIsMouseOver())
         {
            this._isMouseOver = false;
            this.updateTooltip();
            this.updateSquadButtons();
            invalidate(SquadInvalidationType.ACTIVE_MOUSE_OVER);
         }
      }
      
      public function reset() : void
      {
         this._state = DynamicSquadState.NONE;
         this._isInviteShown = false;
         this._isInteractive = false;
         invalidate(InvalidationType.ALL);
      }
      
      public function setActivePlayerData(param1:DAAPIVehicleInfoVO) : void
      {
         this._activePlayerData = param1;
      }
      
      public function setCurrentPlayerAnonymized() : void
      {
         this._isCurrentPlayerAnonymized = true;
      }
      
      public function setCurrentPlayerFakeName(param1:String) : void
      {
         this._currentPlayerFakeName = param1;
         if(!this._toolTipString)
         {
            this.makeTooltipString();
         }
      }
      
      public function setIsCurrentPlayerInClan(param1:Boolean) : void
      {
         this._isCurrentPlayerInClan = param1;
         if(!this._toolTipString)
         {
            this.makeTooltipString();
         }
      }
      
      public function setIsEnemy(param1:Boolean) : void
      {
         this._isEnemy = param1;
      }
      
      public function setIsInteractive(param1:Boolean) : void
      {
         if(this._isInteractive == param1)
         {
            return;
         }
         if(!param1)
         {
            this._isMouseOver = param1;
         }
         this._isInteractive = param1;
         this.updateTooltip();
         this.updateSquadButtons();
         invalidate(SquadInvalidationType.ACTIVE_MOUSE_OVER);
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
      
      public function setNoSound(param1:Boolean) : void
      {
         if(this._isNoSound == param1)
         {
            return;
         }
         this._isNoSound = param1;
         invalidate(SquadInvalidationType.SQUAD_NO_SOUND);
      }
      
      public function setSquadIndex(param1:int, param2:Boolean) : void
      {
         if(this._squadIndex == param1 && this._isSquadPersonal == param2)
         {
            return;
         }
         this._squadIndex = param1;
         this._isSquadPersonal = param2;
         invalidate(SquadInvalidationType.SQUAD_INDEX);
      }
      
      public function setState(param1:int) : void
      {
         if(this._state == param1)
         {
            return;
         }
         this._state = param1;
         this.updateSquadButtons();
         invalidate(InvalidationType.STATE);
      }
      
      private function makeTooltipString() : void
      {
         if(StringUtils.isNotEmpty(this._currentPlayerFakeName))
         {
            this._toolTipString = !!this._isCurrentPlayerInClan ? App.utils.locale.makeString(TOOLTIPS.ANONYMIZER_BATTLE_TEAMLIST_CLAN,{"fakeName":this._currentPlayerFakeName}) : App.utils.locale.makeString(TOOLTIPS.ANONYMIZER_BATTLE_TEAMLIST_NOCLAN,{"fakeName":this._currentPlayerFakeName});
         }
      }
      
      private function updateStatusIcons() : void
      {
         var _loc1_:Boolean = this._isMouseOver && this._isInteractive;
         if(_loc1_ && this._state == DynamicSquadState.INVITE_DISABLED)
         {
            this._squadStatus.showInviteDisabled();
            return;
         }
         if(this._isInviteShown)
         {
            if(this._state == DynamicSquadState.INVITE_SENT)
            {
               this._squadStatus.showInviteSent();
               return;
            }
            if(!_loc1_ && this._state == DynamicSquadState.INVITE_RECEIVED)
            {
               this._squadStatus.showInviteReceived();
               return;
            }
            if(!_loc1_ && this._state == DynamicSquadState.INVITE_RECEIVED_FROM_SQUAD)
            {
               this._squadStatus.showInviteReceivedFromSquad();
               return;
            }
         }
         this._squadStatus.hide();
      }
      
      private function getIsMouseOver() : Boolean
      {
         return hitArea.mouseX > 0 && hitArea.mouseX <= hitArea.width && hitArea.mouseY > 0 && hitArea.mouseY <= hitArea.height;
      }
      
      private function updateTooltip() : void
      {
         var _loc1_:Boolean = this._state != DynamicSquadState.NONE && this._state != DynamicSquadState.IN_SQUAD;
         var _loc2_:Boolean = !_loc1_ && this._isCurrentPlayerAnonymized && this._toolTipString;
         if(this._isMouseOver && this._activePlayerData)
         {
            if(this._isInteractive && _loc1_)
            {
               this._tooltip.show(this._state,this._isEnemy,this._activePlayerData.isAnonymized,StringUtils.isNotEmpty(this._activePlayerData.clanAbbrev));
            }
            if(_loc2_)
            {
               this._tooltipMgr.show(this._toolTipString);
            }
         }
         else if(_loc2_)
         {
            this._tooltipMgr.hide();
         }
         else
         {
            this._tooltip.hide();
         }
      }
      
      private function updateSquadButtons() : void
      {
         var _loc1_:Boolean = this._isInteractive && this._isMouseOver;
         var _loc2_:Boolean = _loc1_ && this._state == DynamicSquadState.INVITE_AVAILABLE;
         var _loc3_:Boolean = _loc1_ && (this._state == DynamicSquadState.INVITE_RECEIVED || this._state == DynamicSquadState.INVITE_RECEIVED_FROM_SQUAD);
         this.updateButton(this._squadAddBt,_loc2_);
         this.updateButton(this._squadAcceptBt,_loc3_);
      }
      
      private function updateButton(param1:BattleButton, param2:Boolean) : void
      {
         if(param2)
         {
            if(this._activeButton != param1)
            {
               this._activeButton = param1;
               this._activeButton.addRollOutCallBack(this);
               this._activeButton.addClickCallBack(this);
               this._handler.onSquadBtVisibleChange(this);
            }
         }
         else if(this._activeButton == param1)
         {
            this._activeButton = null;
            this._handler.onSquadBtVisibleChange(this);
         }
      }
      
      public function get sessionID() : String
      {
         return this._sessionID;
      }
      
      public function set sessionID(param1:String) : void
      {
         this._sessionID = param1;
      }
      
      public function get isAddBtAvailable() : Boolean
      {
         return this._activeButton == this._squadAddBt;
      }
      
      public function get isAcceptBtAvailable() : Boolean
      {
         return this._activeButton == this._squadAcceptBt;
      }
      
      private function onMouseRollOverHandler(param1:MouseEvent) : void
      {
         if(this._isMouseOver)
         {
            return;
         }
         this._isMouseOver = true;
         this.updateTooltip();
         this.updateSquadButtons();
         invalidate(SquadInvalidationType.ACTIVE_MOUSE_OVER);
      }
      
      private function onMouseRollOutHandler(param1:MouseEvent) : void
      {
         if(this.getIsMouseOver())
         {
            return;
         }
         this._isMouseOver = false;
         this.updateTooltip();
         this.updateSquadButtons();
         invalidate(SquadInvalidationType.ACTIVE_MOUSE_OVER);
      }
   }
}
