package net.wg.gui.battle.commander.views.playersPanel.list
{
   import flash.text.TextField;
   import net.wg.data.constants.InvalidationType;
   import net.wg.data.constants.generated.PLAYERS_PANEL_STATE;
   import net.wg.gui.battle.commander.VO.daapi.DAAPIVehicleCommanderDataVO;
   import net.wg.gui.battle.commander.views.common.HealthBar;
   import net.wg.gui.battle.commander.views.common.MannerIcon;
   import net.wg.gui.battle.commander.views.common.OrderIcon;
   import net.wg.gui.battle.commander.views.common.VehicleTypeIcon;
   import net.wg.gui.battle.random.views.stats.components.playersPanel.constants.PlayersPanelInvalidationType;
   
   public class RTSPlayersPanelListItemLeft extends RTSPlayersPanelListItem
   {
      
      private static const STATE_IN_ROSTER:int = PLAYERS_PANEL_STATE.FULL_NO_BADGES;
      
      private static const FRAME_NORMAL:String = "normal";
      
      private static const FRAME_COMMANDER:String = "commander";
      
      private static const FRAGS_X_OFFSET:int = 30;
      
      private static const VEHICLE_TYPE_X_OFFSET:int = 45;
      
      private static const VEHICLE_TF_X_OFFSET:int = 70;
      
      private static const HP_BAR_X_OFFSET:int = 145;
      
      private static const MANNER_X_OFFSET:int = 205;
      
      private static const ORDER_X_OFFSET:int = 230;
      
      private static const VEHICLE_ICON_X_OFFSET:int = 250;
      
      private static const VEHICLE_LEVEL_X_OFFSET:int = 268;
       
      
      public var vehicleType:VehicleTypeIcon = null;
      
      public var healthBar:HealthBar = null;
      
      public var manner:MannerIcon = null;
      
      public var order:OrderIcon = null;
      
      public var vehicleTF_selected:TextField = null;
      
      public var fragsTF_selected:TextField = null;
      
      private var _isAlive:Boolean = false;
      
      private var _isSelected:Boolean = false;
      
      private var _hasCommanderData:Boolean = false;
      
      private var _baseState:int = -1;
      
      public function RTSPlayersPanelListItemLeft()
      {
         super();
      }
      
      override public function setIsSpotted(param1:Boolean) : void
      {
         this.vehicleType.isSpotted = param1;
      }
      
      override public function setRTSIsMove(param1:Boolean) : void
      {
         this.order.isShown = param1;
      }
      
      override public function setVehicleCommanderData(param1:DAAPIVehicleCommanderDataVO) : void
      {
         if(param1.hasCommanderData != this._hasCommanderData)
         {
            this._hasCommanderData = param1.hasCommanderData;
            super.setState(!!this._hasCommanderData ? uint(STATE_IN_ROSTER) : uint(this._baseState));
            invalidateData();
         }
         if(this._hasCommanderData)
         {
            this.manner.mannerID = param1.manner;
            this.order.orderID = param1.order;
            this.healthBar.maxHP = param1.maxHealth;
            this.healthBar.currentHP = param1.health;
            this.setIsSelected(param1.isAttached);
            hpBarPlayersPanelListItem.alpha = 0;
         }
      }
      
      override public function setVehicleType(param1:String) : void
      {
         if(this._hasCommanderData)
         {
            this.vehicleType.vehicleType = param1;
         }
         this.vehicleType.isAlly = true;
      }
      
      override public function setIsAlive(param1:Boolean) : void
      {
         this._isAlive = param1;
         super.setIsAlive(param1);
      }
      
      override public function setIsSelected(param1:Boolean) : void
      {
         this._isSelected = param1;
         super.setIsSelected(param1);
      }
      
      override public function setState(param1:uint) : void
      {
         this._baseState = param1;
         if(!this._hasCommanderData)
         {
            super.setState(param1);
         }
      }
      
      override protected function onDispose() : void
      {
         this.vehicleType.dispose();
         this.vehicleType = null;
         this.healthBar.dispose();
         this.healthBar = null;
         this.manner.dispose();
         this.manner = null;
         this.order.dispose();
         this.order = null;
         this.vehicleTF_selected = null;
         this.fragsTF_selected = null;
         super.onDispose();
      }
      
      override protected function updatePositionsLeft() : void
      {
         super.updatePositionsLeft();
         this.fragsTF_selected.x = fragsTF.x;
         if(this._hasCommanderData)
         {
            x = 0;
         }
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(InvalidationType.DATA))
         {
            gotoAndStop(!!this._hasCommanderData ? FRAME_COMMANDER : FRAME_NORMAL);
            this.vehicleType.visible = this._hasCommanderData;
            this.healthBar.visible = this._hasCommanderData;
            this.manner.visible = this._hasCommanderData;
            this.order.visible = this._hasCommanderData;
            if(this._hasCommanderData)
            {
               playerNameCutTF.visible = playerNameFullTF.visible = false;
               this.fragsTF_selected.x = fragsTF.x = FRAGS_X_OFFSET;
               this.vehicleType.x = VEHICLE_TYPE_X_OFFSET;
               this.vehicleTF_selected.x = vehicleTF.x = VEHICLE_TF_X_OFFSET;
               this.healthBar.x = HP_BAR_X_OFFSET;
               this.manner.x = MANNER_X_OFFSET;
               this.order.x = ORDER_X_OFFSET;
               vehicleIcon.x = VEHICLE_ICON_X_OFFSET;
               vehicleLevel.x = VEHICLE_LEVEL_X_OFFSET;
            }
         }
         if(isInvalid(InvalidationType.DATA) || isInvalid(PlayersPanelInvalidationType.SELECTED))
         {
            this.vehicleTF_selected.visible = this.fragsTF_selected.visible = this._isSelected;
            if(this._hasCommanderData)
            {
               vehicleTF.visible = fragsTF.visible = !this._isSelected;
            }
         }
         if(isInvalid(PlayersPanelInvalidationType.FRAGS))
         {
            this.fragsTF_selected.text = fragsTF.text;
         }
         if(isInvalid(PlayersPanelInvalidationType.VEHILCE_NAME))
         {
            this.vehicleTF_selected.text = vehicleTF.text;
         }
         if(isInvalid(PlayersPanelInvalidationType.ALIVE))
         {
            this.manner.isAlive = this._isAlive;
            this.order.isAlive = this._isAlive;
            this.healthBar.isAlive = this._isAlive;
            this.vehicleType.isAlive = this._isAlive;
         }
      }
   }
}
