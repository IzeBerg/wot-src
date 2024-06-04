package net.wg.gui.battle.views.postmortemPanel
{
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.text.TextField;
   import flashx.textLayout.formats.VerticalAlign;
   import net.wg.data.VO.UserVO;
   import net.wg.data.constants.Linkages;
   import net.wg.data.constants.Values;
   import net.wg.gui.battle.components.BattleAtlasSprite;
   import net.wg.gui.components.controls.UserNameField;
   import net.wg.infrastructure.base.meta.IBasePostmortemPanelMeta;
   import net.wg.infrastructure.base.meta.impl.BasePostmortemPanelMeta;
   
   public class BasePostmortemPanel extends BasePostmortemPanelMeta implements IBasePostmortemPanelMeta
   {
      
      private static const WHITE_TEXT_COLOR:uint = 16777215;
      
      private static const EMPTY_STR:String = "";
      
      protected static const INVALID_PLAYER_INFO:uint = 1 << 7;
      
      protected static const INVALID_VEHICLE_PANEL:uint = 1 << 8;
      
      protected static const INVALID_PLAYER_INFO_POSITION:uint = 1 << 9;
      
      protected static const INVALID_DEAD_REASON_ITEMS_VISIBILITY:uint = 1 << 10;
      
      private static const INVALID_PLAYER_INFO_VISIBILITY:uint = 1 << 11;
      
      private static const INVALID_PLAYER_VEH_PANEL_VISIBILITY:uint = 1 << 12;
      
      private static const INVALID_DEAD_REASON_VISIBILITY:uint = 1 << 13;
      
      private static const INVALID_KILLER_VISIBILITY:uint = 1 << 14;
      
      public static const VEHICLE_PANEL_OFFSET_Y:int = 120;
      
      protected static const PLAYER_INFO_DELTA_Y:int = 250;
      
      protected static const GAP_VEHICLE_PANEL_DEAD_REASON:int = 40;
      
      protected static const GAP_USER_NAME_DEAD_REASON:int = 5;
      
      protected static const USER_NAME_FIELD_NAME:String = "userNameField";
       
      
      public var playerInfoTF:TextField = null;
      
      public var vehiclePanel:VehiclePanel = null;
      
      public var deadReasonTF:TextField = null;
      
      public var deadReasonBG:BattleAtlasSprite = null;
      
      public var deadReasonBack:Sprite = null;
      
      public var nicknameKillerBG:BattleAtlasSprite = null;
      
      protected var _userName:UserNameField = null;
      
      protected var _playerInfo:String = "";
      
      protected var _userVO:UserVO = null;
      
      private var _deadReason:String = "";
      
      private var _vehicleLevel:String = "";
      
      private var _vehicleImg:String = "";
      
      private var _vehicleType:String = "";
      
      private var _vehicleName:String = "";
      
      private var _isShowDeadReasonItems:Boolean = false;
      
      private var _showDeadReason:Boolean = false;
      
      private var _showPlayerInfo:Boolean = false;
      
      private var _showVehiclePanel:Boolean = false;
      
      private var _showNicknameKillerBg:Boolean = false;
      
      private const INVALID_ALL_DEAD_RESAON_DEPENDENCY:uint = INVALID_PLAYER_INFO_VISIBILITY | INVALID_PLAYER_VEH_PANEL_VISIBILITY | INVALID_DEAD_REASON_VISIBILITY;
      
      public function BasePostmortemPanel()
      {
         super();
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(INVALID_PLAYER_INFO))
         {
            this.invalidateKillerBgVisibility(false);
            if(this._playerInfo != this.playerInfoTF.htmlText)
            {
               this.playerInfoTF.htmlText = this._playerInfo;
            }
            this.invalidateDeadReasonItems(false,INVALID_DEAD_REASON_ITEMS_VISIBILITY);
         }
         if(isInvalid(INVALID_VEHICLE_PANEL))
         {
            if(this._showVehiclePanel)
            {
               this.vehiclePanel.setVehicleData(this._vehicleLevel,this._vehicleType,this._vehicleName,this._vehicleImg);
            }
            if(this._deadReason != this.deadReasonTF.text)
            {
               this.deadReasonTF.text = this._deadReason;
            }
            this.invalidateKillerBgVisibility(true);
            this.invalidateDeadReasonItems(true,INVALID_PLAYER_VEH_PANEL_VISIBILITY | INVALID_DEAD_REASON_VISIBILITY);
         }
         if(isInvalid(INVALID_PLAYER_INFO_POSITION))
         {
            this.updatePlayerInfoPosition();
         }
         if(isInvalid(INVALID_DEAD_REASON_ITEMS_VISIBILITY))
         {
            this.updateDeathReasonItems();
         }
         if(isInvalid(INVALID_PLAYER_INFO_VISIBILITY))
         {
            this.updatePlayerInfoVisibility();
         }
         if(isInvalid(INVALID_PLAYER_VEH_PANEL_VISIBILITY))
         {
            this.updatePlayerVehiclePanelVisibility();
         }
         if(isInvalid(INVALID_DEAD_REASON_VISIBILITY))
         {
            this.updateDeathReasonVisibility();
         }
         if(isInvalid(INVALID_KILLER_VISIBILITY))
         {
            this.updateNicknameKillerBG();
         }
      }
      
      override protected function setDeadReasonInfo(param1:String, param2:Boolean, param3:String, param4:String, param5:String, param6:String, param7:UserVO) : void
      {
         this._deadReason = param1;
         this._vehicleLevel = param3;
         this._vehicleImg = param4;
         this._vehicleName = param6;
         this._vehicleType = param5;
         this._userVO = param7;
         if(this._userVO)
         {
            if(this._userName == null)
            {
               this._userName = App.utils.classFactory.getComponent(Linkages.USER_NAME_FIELD,UserNameField);
               this._userName.addEventListener(Event.CHANGE,this.onDeadReasonChanged);
               this._userName.name = USER_NAME_FIELD_NAME;
               addChild(this._userName);
            }
            this._userName.userVO = this._userVO;
         }
         else
         {
            this.updatePlayerInfoPosition();
         }
         this._showVehiclePanel = param2;
         this._showDeadReason = this._deadReason != Values.EMPTY_STR;
         invalidate(INVALID_VEHICLE_PANEL);
      }
      
      override protected function onDispose() : void
      {
         this.playerInfoTF = null;
         this.deadReasonTF = null;
         this.vehiclePanel.dispose();
         this.vehiclePanel = null;
         this.deadReasonBG = null;
         this.deadReasonBack = null;
         this.nicknameKillerBG = null;
         this._userVO = null;
         if(this._userName != null)
         {
            this._userName.removeEventListener(Event.CHANGE,this.onDeadReasonChanged);
            this._userName.dispose();
            this._userName = null;
         }
         super.onDispose();
      }
      
      public function as_hideAnyVehDescription() : void
      {
         this._showPlayerInfo = false;
         this.invalidateDeadReasonItems(false,INVALID_PLAYER_INFO_VISIBILITY);
      }
      
      public function as_showDeadReason() : void
      {
         this.invalidateDeadReasonItems(true,this.INVALID_ALL_DEAD_RESAON_DEPENDENCY);
      }
      
      public function setPlayerInfo(param1:String) : void
      {
         this._playerInfo = param1;
         this._showPlayerInfo = true;
         invalidate(INVALID_PLAYER_INFO);
      }
      
      public function updateElementsPosition() : void
      {
         invalidate(INVALID_PLAYER_INFO_POSITION);
      }
      
      public function updateStage(param1:int, param2:int) : void
      {
      }
      
      protected function updateDeathReasonVisibility() : void
      {
         var _loc1_:Boolean = this._isShowDeadReasonItems && this._showDeadReason;
         if(this.deadReasonBG)
         {
            this.deadReasonBG.visible = _loc1_;
         }
         this.deadReasonTF.visible = _loc1_;
      }
      
      protected function invalidateKillerBgVisibility(param1:Boolean) : void
      {
         param1 = param1 && this.canShowKillerBg();
         if(this._showNicknameKillerBg != param1)
         {
            this._showNicknameKillerBg = param1;
            invalidate(INVALID_KILLER_VISIBILITY);
         }
      }
      
      protected function canShowKillerBg() : Boolean
      {
         return true;
      }
      
      protected function invalidateDeadReasonItems(param1:Boolean, param2:uint = 0) : void
      {
         if(this._isShowDeadReasonItems != param1)
         {
            this._isShowDeadReasonItems = param1;
            invalidate(INVALID_DEAD_REASON_ITEMS_VISIBILITY);
         }
         else if(param2)
         {
            invalidate(param2);
         }
      }
      
      protected function isShowVehiclePanel() : Boolean
      {
         return this._showVehiclePanel;
      }
      
      protected function updatePlayerInfoPosition() : void
      {
         this.playerInfoTF.y = -PLAYER_INFO_DELTA_Y - (App.appHeight >> 1);
         this.vehiclePanel.y = -(App.appHeight >> 1) + VEHICLE_PANEL_OFFSET_Y;
         this.deadReasonTF.y = this.vehiclePanel.y - this.deadReasonGap - this.deadReasonTF.height;
         if(this._userName != null)
         {
            this._userName.y = this.deadReasonTF.y + this.deadReasonTF.textHeight + GAP_USER_NAME_DEAD_REASON;
            this._userName.x = -this._userName.textWidth >> 1;
            this._userName.verticalAlign = VerticalAlign.MIDDLE;
            this._userName.textColor = WHITE_TEXT_COLOR;
         }
         if(this.deadReasonBG)
         {
            this.deadReasonBG.y = this.deadReasonTF.y - (this.deadReasonBG.height - this.deadReasonTF.height >> 1);
         }
      }
      
      protected function setComponentsVisibility(param1:Boolean) : void
      {
         this.playerInfoTF.visible = param1;
         this.invalidateKillerBgVisibility(param1);
         this.invalidateDeadReasonItems(param1,this.INVALID_ALL_DEAD_RESAON_DEPENDENCY);
      }
      
      private function updateKillerUserNameVisibility() : void
      {
         if(this._userName != null)
         {
            this._userName.visible = this._isShowDeadReasonItems;
         }
      }
      
      private function updatePlayerInfoVisibility() : void
      {
         this.playerInfoTF.visible = !this._isShowDeadReasonItems && this._showPlayerInfo;
      }
      
      private function updatePlayerVehiclePanelVisibility() : void
      {
         this.vehiclePanel.visible = this._isShowDeadReasonItems && this._showVehiclePanel;
      }
      
      private function updateNicknameKillerBG() : void
      {
         if(this.nicknameKillerBG)
         {
            this.nicknameKillerBG.visible = this._showNicknameKillerBg;
         }
      }
      
      private function updateDeathReasonItems() : void
      {
         this.updateKillerUserNameVisibility();
         this.updatePlayerInfoVisibility();
         this.updatePlayerVehiclePanelVisibility();
         this.updateDeathReasonVisibility();
      }
      
      protected function get isShowDeathReason() : Boolean
      {
         return this._showDeadReason;
      }
      
      protected function get deadReasonGap() : int
      {
         return GAP_VEHICLE_PANEL_DEAD_REASON;
      }
      
      private function onDeadReasonChanged(param1:Event) : void
      {
         this.updateElementsPosition();
      }
   }
}
