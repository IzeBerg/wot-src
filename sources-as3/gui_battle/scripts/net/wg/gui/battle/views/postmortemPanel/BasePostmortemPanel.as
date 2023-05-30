package net.wg.gui.battle.views.postmortemPanel
{
   import flash.events.Event;
   import flash.text.TextField;
   import flashx.textLayout.formats.VerticalAlign;
   import net.wg.data.VO.UserVO;
   import net.wg.data.constants.Linkages;
   import net.wg.data.constants.Values;
   import net.wg.gui.battle.components.BattleAtlasSprite;
   import net.wg.gui.components.controls.UserNameField;
   import net.wg.infrastructure.base.meta.impl.BasePostmortemPanelMeta;
   
   public class BasePostmortemPanel extends BasePostmortemPanelMeta
   {
      
      private static const WHITE_TEXT_COLOR:uint = 16777215;
      
      protected static const INVALID_VEHICLE_PANEL:uint = 1 << 8;
      
      private static const EMPTY_STR:String = "";
      
      private static const INVALID_PLAYER_INFO:uint = 1 << 7;
      
      protected static const INVALID_PLAYER_INFO_POSITION:uint = 1 << 9;
      
      private static const INVALID_DEAD_REASON_VISIBILITY:uint = 1 << 10;
      
      public static const VEHICLE_PANEL_OFFSET_Y:int = 120;
      
      protected static const PLAYER_INFO_DELTA_Y:int = 250;
      
      protected static const GAP_VEHICLE_PANEL_DEAD_REASON:int = 40;
      
      protected static const GAP_USER_NAME_DEAD_REASON:int = 5;
       
      
      public var playerInfoTF:TextField = null;
      
      public var deadReasonTF:TextField = null;
      
      public var vehiclePanel:VehiclePanel = null;
      
      public var deadReasonBG:BattleAtlasSprite = null;
      
      public var nicknameKillerBG:BattleAtlasSprite = null;
      
      protected var _userName:UserNameField = null;
      
      protected var _deadReason:String = "";
      
      protected var _playerInfo:String = "";
      
      protected var _showVehiclePanel:Boolean = false;
      
      protected var _userVO:UserVO = null;
      
      private var _vehicleLevel:String = "";
      
      private var _vehicleImg:String = "";
      
      private var _vehicleType:String = "";
      
      private var _vehicleName:String = "";
      
      public function BasePostmortemPanel()
      {
         super();
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(INVALID_DEAD_REASON_VISIBILITY))
         {
            this.playerInfoTF.visible = false;
            this.deadReasonTF.visible = true;
            if(this._userName != null)
            {
               this._userName.visible = true;
            }
            this.vehiclePanel.visible = this._showVehiclePanel;
            if(this.deadReasonBG)
            {
               this.deadReasonBG.visible = true;
            }
         }
         if(isInvalid(INVALID_PLAYER_INFO))
         {
            this.playerInfoTF.visible = true;
            this.deadReasonTF.visible = false;
            if(this._userName != null)
            {
               this._userName.visible = false;
            }
            this.vehiclePanel.visible = false;
            if(this.deadReasonBG)
            {
               this.deadReasonBG.visible = false;
            }
            if(this.nicknameKillerBG)
            {
               this.nicknameKillerBG.visible = false;
            }
            if(this._playerInfo != this.playerInfoTF.htmlText)
            {
               this.playerInfoTF.htmlText = this._playerInfo;
            }
         }
         if(isInvalid(INVALID_VEHICLE_PANEL))
         {
            this.playerInfoTF.visible = false;
            this.deadReasonTF.visible = this._deadReason != Values.EMPTY_STR;
            if(this._userName != null)
            {
               this._userName.visible = true;
            }
            if(this._deadReason != this.deadReasonTF.text)
            {
               this.deadReasonTF.text = this._deadReason;
            }
            if(this.deadReasonBG)
            {
               this.deadReasonBG.visible = this._deadReason != Values.EMPTY_STR;
            }
            if(this.nicknameKillerBG)
            {
               this.nicknameKillerBG.visible = true;
            }
            this.vehiclePanel.visible = this._showVehiclePanel;
            if(this._showVehiclePanel)
            {
               this.vehiclePanel.setVehicleData(this._vehicleLevel,this._vehicleType,this._vehicleName,this._vehicleImg);
            }
         }
         if(isInvalid(INVALID_PLAYER_INFO_POSITION))
         {
            this.updatePlayerInfoPosition();
         }
      }
      
      override protected function setDeadReasonInfo(param1:String, param2:Boolean, param3:String, param4:String, param5:String, param6:String, param7:UserVO) : void
      {
         this._deadReason = param1;
         this._showVehiclePanel = param2;
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
               this._userName.addEventListener(Event.CHANGE,this.updateDeadReason);
               addChild(this._userName);
            }
            this._userName.userVO = this._userVO;
         }
         else
         {
            this.updatePlayerInfoPosition();
         }
         invalidate(INVALID_VEHICLE_PANEL);
      }
      
      override protected function onDispose() : void
      {
         this.playerInfoTF = null;
         this.deadReasonTF = null;
         this.vehiclePanel.dispose();
         this.vehiclePanel = null;
         this.deadReasonBG = null;
         this.nicknameKillerBG = null;
         this._userVO = null;
         if(this._userName != null)
         {
            this._userName.removeEventListener(Event.CHANGE,this.updateDeadReason);
            this._userName.dispose();
            this._userName = null;
         }
         super.onDispose();
      }
      
      public function setPlayerInfo(param1:String) : void
      {
         this._playerInfo = param1;
         invalidate(INVALID_PLAYER_INFO);
      }
      
      public function showDeadReason() : void
      {
         invalidate(INVALID_DEAD_REASON_VISIBILITY);
      }
      
      public function updateElementsPosition() : void
      {
         invalidate(INVALID_PLAYER_INFO_POSITION);
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
         this.vehiclePanel.visible = param1;
         this.deadReasonTF.visible = param1;
         if(this.deadReasonBG)
         {
            this.deadReasonBG.visible = param1;
         }
         if(this.nicknameKillerBG)
         {
            this.nicknameKillerBG.visible = param1;
         }
         if(this._userName != null)
         {
            this._userName.visible = param1;
         }
      }
      
      protected function get deadReasonGap() : int
      {
         return GAP_VEHICLE_PANEL_DEAD_REASON;
      }
      
      private function updateDeadReason(param1:Event) : void
      {
         this.updateElementsPosition();
      }
   }
}
