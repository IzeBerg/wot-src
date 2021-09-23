package net.wg.gui.prebattle.controls
{
   import flash.display.MovieClip;
   import flash.text.TextField;
   import net.wg.data.constants.UserTags;
   import net.wg.data.constants.Values;
   import net.wg.gui.prebattle.constants.PrebattleStateString;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.core.UIComponent;
   import scaleform.clik.utils.Constraints;
   import scaleform.gfx.TextFieldEx;
   
   public class TeamMemberRenderer extends TeamMemberRendererBase
   {
      
      private static const NICK_NAME_X:int = 36;
      
      private static const NICK_NAME_EXTENDED_X:int = 47;
      
      private static const NUMBER_FIELD_X:int = 10;
      
      private static const NUMBER_FIELD_EXTENDED_X:int = 23;
      
      private static const BOOSTER_ICON_OFFSET_X:uint = 2;
      
      private static const VEHICLE_TYPE_ICON_OFFSET_X:uint = 2;
      
      private static const VEHICLE_NAME_FIELD_OFFSET_X:uint = 2;
       
      
      public var numberField:TextField;
      
      public var hasPermissionsIcon:MovieClip;
      
      public var commander_icon:UIComponent;
      
      public var status_icon:UIComponent;
      
      public var wrong_limits:UIComponent;
      
      public var vehicle_type_icon:UIComponent;
      
      public var boosterIcon:UIComponent;
      
      public var toolTipStr:String = "";
      
      private var _isVehicleValid:Boolean = true;
      
      public function TeamMemberRenderer()
      {
         useRightButton = true;
         super();
      }
      
      override public function setData(param1:Object) : void
      {
         super.setData(param1);
         if(model)
         {
            setSpeakers(model.isPlayerSpeaking,true);
         }
      }
      
      override protected function onDispose() : void
      {
         this.numberField = null;
         this.commander_icon.dispose();
         this.commander_icon = null;
         this.status_icon.dispose();
         this.status_icon = null;
         this.wrong_limits.dispose();
         this.wrong_limits = null;
         this.vehicle_type_icon.dispose();
         this.vehicle_type_icon = null;
         this.boosterIcon.dispose();
         this.boosterIcon = null;
         this.hasPermissionsIcon = null;
         super.onDispose();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         constraints.addElement(this.vehicle_type_icon.name,this.vehicle_type_icon,Constraints.ALL);
         constraints.addElement(this.boosterIcon.name,this.boosterIcon,Constraints.ALL);
      }
      
      override protected function showToolTips() : void
      {
         var _loc1_:String = Values.EMPTY_STR;
         if(model.accID == -1)
         {
            _loc1_ = MESSENGER.DIALOGS_TEAMCHANNEL_BUTTONS_INVITE;
         }
         else if(this.isVehicleValid)
         {
            _loc1_ = getToolTipData();
         }
         else if(UserTags.isCurrentPlayer(model.tags))
         {
            _loc1_ = this.toolTipStr;
         }
         else
         {
            _loc1_ = getToolTipData();
         }
         if(_loc1_ && _loc1_.length > 0)
         {
            App.toolTipMgr.show(_loc1_);
         }
         if(model && model.vType)
         {
            this.boosterIcon.visible = model.isExperimentalModule;
         }
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(model && isInvalid(InvalidationType.SIZE))
         {
            this.updateNicknamePosX();
         }
      }
      
      override protected function afterSetData() : void
      {
         var _loc3_:String = null;
         this.commander_icon.visible = this.status_icon.visible = this.vehicle_type_icon.visible = this.boosterIcon.visible = false;
         updatePlayerName();
         if(!model)
         {
            return;
         }
         var _loc1_:String = model.getStateString();
         if(_loc1_ != PrebattleStateString.UNKNOWN)
         {
            statusString = _loc1_;
            this.status_icon.visible = true;
            status.visible = true;
            status.gotoAndPlay(_loc1_);
            if(this.status_icon.currentLabels.indexOf(_loc1_,0))
            {
               this.status_icon.gotoAndPlay(_loc1_);
            }
            if(_loc1_ == PrebattleStateString.OFFLINE)
            {
               this.status_icon.gotoAndPlay(PrebattleStateString.NOT_READY);
            }
            if(this.hitTestPoint(mouseX,mouseY,true))
            {
               _loc3_ = getToolTipData();
               if(_loc3_.length > 0)
               {
                  App.toolTipMgr.showSpecial(_loc3_,null);
               }
            }
            if(model.vType)
            {
               this.vehicle_type_icon.visible = true;
               this.vehicle_type_icon.gotoAndPlay(model.vType);
               this.boosterIcon.visible = model.isExperimentalModule;
            }
            else
            {
               this.vehicle_type_icon.visible = false;
               this.boosterIcon.visible = false;
            }
            if(model.isCreator)
            {
               this.commander_icon.visible = true;
               this.status_icon.visible = false;
            }
         }
         else
         {
            setSpeakers(false,true);
            status.gotoAndPlay("invite");
            _loc1_ = null;
         }
         updateVoiceWave();
         var _loc2_:Number = model.getCurrentColor();
         if(!isNaN(_loc2_))
         {
            textField.textColor = _loc2_;
            vehicleNameField.textColor = _loc2_;
            this.numberField.textColor = _loc2_;
            vehicleLevelField.textColor = _loc2_;
         }
         vehicleNameField.htmlText = model.vShortName;
         this.updateValidVehicleState(this.isVehicleValid);
         if(isNaN(model.orderNumber))
         {
            this.numberField.visible = false;
         }
         else
         {
            this.numberField.text = String(model.orderNumber);
         }
         if(this.hasPermissionsIcon)
         {
            this.hasPermissionsIcon.visible = model.hasPermissions;
         }
         this.updateAfterStateChange();
      }
      
      override protected function updateAfterStateChange() : void
      {
         super.updateAfterStateChange();
         if(!initialized)
         {
            return;
         }
         if(model && model.isCreator)
         {
            this.commander_icon.visible = true;
            this.status_icon.visible = false;
         }
         if(model && model.vType)
         {
            this.vehicle_type_icon.visible = true;
            this.vehicle_type_icon.gotoAndPlay(model.vType);
            this.boosterIcon.visible = model.isExperimentalModule;
         }
         else
         {
            this.vehicle_type_icon.visible = false;
            this.boosterIcon.visible = false;
         }
         TextFieldEx.setVerticalAlign(textField,TextFieldEx.VALIGN_TOP);
         TextFieldEx.setVerticalAlign(vehicleNameField,TextFieldEx.VALIGN_TOP);
         TextFieldEx.setVerticalAlign(this.numberField,TextFieldEx.VALIGN_TOP);
         vehicleNameField.htmlText = Boolean(model) ? model.vShortName : Values.EMPTY_STR;
         this.numberField.text = Boolean(model) ? String(model.orderNumber) : Values.EMPTY_STR;
         var _loc1_:Number = Boolean(model) ? Number(model.getCurrentColor()) : Number(Number.NaN);
         if(!isNaN(_loc1_))
         {
            textField.textColor = _loc1_;
            vehicleNameField.textColor = _loc1_;
            this.numberField.textColor = _loc1_;
            vehicleLevelField.textColor = _loc1_;
         }
         this.updateValidVehicleState(this._isVehicleValid && vehicleLevelField.text != null && this.visible);
         constraints.updateElement("status",status);
         constraints.updateElement("vehicleNameField",vehicleNameField);
         constraints.updateElement(this.vehicle_type_icon.name,this.vehicle_type_icon);
         constraints.updateElement(this.boosterIcon.name,this.boosterIcon);
      }
      
      private function updateNicknamePosX() : void
      {
         var _loc1_:Boolean = model.hasPermissionsInfo;
         textField.x = !!_loc1_ ? Number(NICK_NAME_EXTENDED_X) : Number(NICK_NAME_X);
         this.numberField.x = !!_loc1_ ? Number(NUMBER_FIELD_EXTENDED_X) : Number(NUMBER_FIELD_X);
         if(this.boosterIcon.visible)
         {
            this.boosterIcon.x = textField.x + textField.textWidth + BOOSTER_ICON_OFFSET_X;
            this.vehicle_type_icon.x = this.boosterIcon.x + this.vehicle_type_icon.width + VEHICLE_TYPE_ICON_OFFSET_X;
            vehicleNameField.x = this.vehicle_type_icon.x + this.vehicle_type_icon.width + VEHICLE_NAME_FIELD_OFFSET_X;
         }
      }
      
      private function updateValidVehicleState(param1:Boolean) : void
      {
         if(model && isNaN(model.accID))
         {
            return;
         }
         this.wrong_limits.visible = !param1;
         if(param1)
         {
            vehicleLevelField.htmlText = Values.EMPTY_STR;
            vehicleLevelField.text = Boolean(model) ? model.vLevel : Values.EMPTY_STR;
         }
         else
         {
            vehicleLevelField.text = Values.EMPTY_STR;
            vehicleLevelField.htmlText = Boolean(model) ? "<font color=\"#ff0000\">" + model.vLevel + "</font>" : Values.EMPTY_STR;
         }
      }
      
      public function get isVehicleValid() : Boolean
      {
         return this._isVehicleValid;
      }
      
      public function set isVehicleValid(param1:Boolean) : void
      {
         this._isVehicleValid = param1;
         this.updateValidVehicleState(param1);
      }
   }
}
