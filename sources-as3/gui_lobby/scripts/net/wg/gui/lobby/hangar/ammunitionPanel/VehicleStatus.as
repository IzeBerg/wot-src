package net.wg.gui.lobby.hangar.ammunitionPanel
{
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import net.wg.data.constants.Directions;
   import net.wg.data.constants.generated.TOOLTIPS_CONSTANTS;
   import net.wg.gui.components.tooltips.helpers.TankTypeIco;
   import net.wg.gui.lobby.hangar.ammunitionPanel.data.VehicleStatusVO;
   import net.wg.gui.lobby.hangar.ammunitionPanel.events.AmmunitionPanelEvents;
   import net.wg.infrastructure.base.UIComponentEx;
   import net.wg.infrastructure.managers.ITooltipMgr;
   import net.wg.utils.ICommons;
   import net.wg.utils.helpLayout.HelpLayoutVO;
   import org.idmedia.as3commons.util.StringUtils;
   import scaleform.clik.constants.InvalidationType;
   
   public class VehicleStatus extends UIComponentEx
   {
      
      private static const ELITE_TYPE_GAP:int = -2;
      
      private static const COMMON_TYPE_GAP:int = -12;
      
      private static const HELP_LAYOUT_ID_DELIMITER:String = "_";
      
      private static const HELP_LAYOUT_WIDTH:int = 280;
      
      private static const HELP_LAYOUT_HEIGHT:int = 65;
      
      private static const HELP_LAYOUT_HEIGHT_NO_BG:int = 47;
      
      private static const HELP_LAYOUT_NO_BG_OFFSET_Y:int = -63;
      
      private static const HELP_LAYOUT_OFFSET_Y:int = -5;
      
      private static const MESSAGE_Y:int = 38;
      
      private static const MESSAGE_Y_OFFSET:int = -6;
       
      
      public var tankTypeIcon:TankTypeIco;
      
      public var vehicleLevel:TextField = null;
      
      public var vehicleName:TextField = null;
      
      public var message:VehicleStatusMsg = null;
      
      public var roleMessage:VehicleStatusMsg = null;
      
      private var _data:VehicleStatusVO = null;
      
      private var _vehicleStateHelpLayoutId:String = "";
      
      private var _toolTipMgr:ITooltipMgr;
      
      private var _commons:ICommons;
      
      public function VehicleStatus()
      {
         this._toolTipMgr = App.toolTipMgr;
         this._commons = App.utils.commons;
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.tankTypeIcon.mouseEnabled = this.tankTypeIcon.mouseChildren = false;
         this.roleMessage.addEventListener(MouseEvent.ROLL_OVER,this.onRoleMessageRollOverHandler);
         this.roleMessage.addEventListener(MouseEvent.ROLL_OUT,this.onRoleMessageRollOutHandler);
      }
      
      override protected function onDispose() : void
      {
         this.roleMessage.removeEventListener(MouseEvent.ROLL_OVER,this.onRoleMessageRollOverHandler);
         this.roleMessage.removeEventListener(MouseEvent.ROLL_OUT,this.onRoleMessageRollOutHandler);
         this.roleMessage.dispose();
         this.roleMessage = null;
         this.message.dispose();
         this.message = null;
         this.tankTypeIcon.dispose();
         this.tankTypeIcon = null;
         this.vehicleName = null;
         this.vehicleLevel = null;
         this._data = null;
         this._toolTipMgr = null;
         this._commons = null;
         super.onDispose();
      }
      
      override protected function draw() : void
      {
         var _loc1_:String = null;
         var _loc2_:Boolean = false;
         var _loc3_:String = null;
         var _loc4_:Boolean = false;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         super.draw();
         if(this._data)
         {
            if(isInvalid(InvalidationType.DATA))
            {
               this.vehicleLevel.text = this._data.vehicleLevel;
               this.vehicleName.htmlText = this._data.vehicleName;
               this.tankTypeIcon.type = this._data.tankType;
               this.tankTypeIcon.validateNow();
               _loc1_ = this._data.message;
               _loc2_ = StringUtils.isNotEmpty(_loc1_);
               this.message.visible = _loc2_;
               if(_loc2_)
               {
                  this.message.setMessage(_loc1_);
                  this.message.validateNow();
               }
               _loc3_ = this._data.roleMessage;
               _loc4_ = StringUtils.isNotEmpty(_loc3_);
               this.roleMessage.visible = _loc4_;
               if(this.roleMessage.visible)
               {
                  this.roleMessage.setMessage(_loc3_);
                  this.roleMessage.validateNow();
               }
               invalidateSize();
            }
            if(isInvalid(InvalidationType.SIZE))
            {
               this._commons.updateTextFieldSize(this.vehicleName,true,false);
               this._commons.updateTextFieldSize(this.vehicleLevel,true,false);
               this.vehicleLevel.x = 0;
               _loc5_ = !!this._data.isElite ? int(ELITE_TYPE_GAP) : int(COMMON_TYPE_GAP);
               this.tankTypeIcon.x = this.vehicleLevel.x + this.vehicleLevel.width + this.tankTypeIcon.width + _loc5_ ^ 0;
               this.vehicleName.x = this.tankTypeIcon.x + this.tankTypeIcon.width + _loc5_ ^ 0;
               _loc6_ = this.vehicleName.x + this.vehicleName.width >> 1;
               this.vehicleLevel.x -= _loc6_;
               this.tankTypeIcon.x -= _loc6_;
               this.vehicleName.x -= _loc6_;
               _loc7_ = MESSAGE_Y;
               if(this.roleMessage.visible)
               {
                  this.roleMessage.x = -this.roleMessage.width >> 1;
                  this.roleMessage.y = _loc7_;
                  _loc7_ += MESSAGE_Y + MESSAGE_Y_OFFSET;
               }
               if(this.message.visible)
               {
                  this.message.x = -this.message.width >> 1;
                  this.message.y = _loc7_;
               }
               dispatchEvent(new AmmunitionPanelEvents(AmmunitionPanelEvents.VEHICLE_STATE_MSG_RESIZE));
            }
         }
      }
      
      public function createHelpLayoutData() : HelpLayoutVO
      {
         if(StringUtils.isEmpty(this._vehicleStateHelpLayoutId))
         {
            this._vehicleStateHelpLayoutId = name + HELP_LAYOUT_ID_DELIMITER + Math.random();
         }
         var _loc1_:Boolean = this.message.visible || this.roleMessage.visible;
         var _loc2_:HelpLayoutVO = new HelpLayoutVO();
         _loc2_.x = -HELP_LAYOUT_WIDTH >> 1;
         _loc2_.y = Boolean(y + _loc1_) ? int(HELP_LAYOUT_OFFSET_Y) : int(HELP_LAYOUT_NO_BG_OFFSET_Y);
         _loc2_.width = HELP_LAYOUT_WIDTH;
         _loc2_.height = !!_loc1_ ? int(HELP_LAYOUT_HEIGHT) : int(HELP_LAYOUT_HEIGHT_NO_BG);
         _loc2_.extensibilityDirection = Directions.RIGHT;
         _loc2_.message = LOBBY_HELP.HANGAR_HEADER_VEHICLE;
         _loc2_.id = this._vehicleStateHelpLayoutId;
         _loc2_.scope = this;
         return _loc2_;
      }
      
      public function setData(param1:VehicleStatusVO) : void
      {
         if(this._data != param1 && param1 != null)
         {
            this._data = param1;
            invalidateData();
         }
      }
      
      public function updateStage(param1:int, param2:int) : void
      {
         invalidateSize();
      }
      
      override public function get height() : Number
      {
         var _loc1_:int = this.vehicleName.height;
         if(this.message.visible)
         {
            _loc1_ = this.message.y + this.message.height;
         }
         else if(this.roleMessage.visible)
         {
            _loc1_ = this.roleMessage.y + this.roleMessage.height;
         }
         return _loc1_;
      }
      
      public function get statusEndX() : int
      {
         return this.x + this.message.x + this.message.width;
      }
      
      public function get statusStartY() : int
      {
         return this.y + this.message.y;
      }
      
      private function onRoleMessageRollOverHandler(param1:MouseEvent) : void
      {
         if(this._data.roleId > 0)
         {
            this._toolTipMgr.showWulfTooltip(TOOLTIPS_CONSTANTS.VEHICLE_ROLES,this._data.vehicleCD);
         }
      }
      
      private function onRoleMessageRollOutHandler(param1:MouseEvent) : void
      {
         this._toolTipMgr.hide();
      }
   }
}
