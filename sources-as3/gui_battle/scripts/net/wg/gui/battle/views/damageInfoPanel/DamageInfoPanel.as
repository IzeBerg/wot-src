package net.wg.gui.battle.views.damageInfoPanel
{
   import net.wg.data.constants.InvalidationType;
   import net.wg.data.constants.Linkages;
   import net.wg.data.constants.generated.DAMAGE_INFO_PANEL_CONSTS;
   import net.wg.gui.battle.views.damageInfoPanel.components.DamageItem;
   import net.wg.gui.battle.views.damageInfoPanel.components.Fire;
   import net.wg.infrastructure.base.meta.IDamageInfoPanelMeta;
   import net.wg.infrastructure.base.meta.impl.DamageInfoPanelMeta;
   import net.wg.utils.IScheduler;
   
   public class DamageInfoPanel extends DamageInfoPanelMeta implements IDamageInfoPanelMeta
   {
      
      private static const ALPHA_DECREASE_STEP:Number = 0.01;
      
      private static const ACTIVE_STATE_ID:int = 0;
      
      private static const INACTIVE_STATE_ID:int = 1;
      
      private static const HIDDING_STATE_ID:int = 2;
      
      private static const ITEM_WIDTH:int = 32;
       
      
      public var fire:Fire = null;
      
      public var engine:DamageItem = null;
      
      public var ammoBay:DamageItem = null;
      
      public var fuelTank:DamageItem = null;
      
      public var radio:DamageItem = null;
      
      public var leftTrack:DamageItem = null;
      
      public var rightTrack:DamageItem = null;
      
      public var gun:DamageItem = null;
      
      public var turretRotator:DamageItem = null;
      
      public var surveyingDevice:DamageItem = null;
      
      public var wheel:DamageItem = null;
      
      public var commander:DamageItem = null;
      
      public var firstGunner:DamageItem = null;
      
      public var secondGunner:DamageItem = null;
      
      public var driver:DamageItem = null;
      
      public var firstRadioman:DamageItem = null;
      
      public var secondRadioman:DamageItem = null;
      
      public var firstLoader:DamageItem = null;
      
      public var secondLoader:DamageItem = null;
      
      private var _scheduler:IScheduler;
      
      private var _items:Vector.<DamageItem>;
      
      private var _stateID:int = -1;
      
      public function DamageInfoPanel()
      {
         this._scheduler = App.utils.scheduler;
         super();
         this._items = new <DamageItem>[this.gun,this.turretRotator,this.surveyingDevice,this.engine,this.fuelTank,this.radio,this.ammoBay,this.leftTrack,this.rightTrack,this.wheel,this.driver,this.firstLoader,this.secondLoader,this.firstGunner,this.secondGunner,this.firstRadioman,this.secondRadioman,this.commander];
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         mouseChildren = false;
         mouseEnabled = false;
         this.engine.setBitmapData(Linkages.DIP_ENGINE_DAMAGED,Linkages.DIP_ENGINE_DESTROYED);
         this.ammoBay.setBitmapData(Linkages.DIP_AMMO_BAY_DAMAGED,Linkages.DIP_AMMO_BAY_DESTROYED);
         this.fuelTank.setBitmapData(Linkages.DIP_FUEL_TANK_DAMAGED,Linkages.DIP_FUEL_TANK_DESTROYED);
         this.radio.setBitmapData(Linkages.DIP_RADIO_DAMAGED,Linkages.DIP_RADIO_DESTROYED);
         this.leftTrack.setBitmapData(Linkages.DIP_TRACKS_DAMAGED,Linkages.DIP_TRACKS_DESTROYED);
         this.rightTrack.setBitmapData(Linkages.DIP_TRACKS_DAMAGED,Linkages.DIP_TRACKS_DESTROYED);
         this.gun.setBitmapData(Linkages.DIP_GUN_DAMAGED,Linkages.DIP_GUN_DESTROYED);
         this.turretRotator.setBitmapData(Linkages.DIP_TURRET_ROTATOR_DAMAGED,Linkages.DIP_TURRET_ROTATOR_DESTROYED);
         this.surveyingDevice.setBitmapData(Linkages.DIP_SURVEYING_DEVICE_DAMAGED,Linkages.DIP_SURVEYING_DEVICE_DESTROYED);
         this.wheel.setBitmapData(Linkages.DIP_WHEEL_DEVICE_DAMAGED,Linkages.DIP_WHEEL_DEVICE_DESTROYED);
         this.commander.setBitmapData(Linkages.DIP_COMMANDER_DAMAGED,Linkages.DIP_COMMANDER_DAMAGED);
         this.firstGunner.setBitmapData(Linkages.DIP_GUNNER_DAMAGED,Linkages.DIP_GUNNER_DAMAGED);
         this.secondGunner.setBitmapData(Linkages.DIP_GUNNER_DAMAGED,Linkages.DIP_GUNNER_DAMAGED);
         this.driver.setBitmapData(Linkages.DIP_DRIVER_DAMAGED,Linkages.DIP_DRIVER_DAMAGED);
         this.firstRadioman.setBitmapData(Linkages.DIP_RADIOMAN_DAMAGED,Linkages.DIP_RADIOMAN_DAMAGED);
         this.secondRadioman.setBitmapData(Linkages.DIP_RADIOMAN_DAMAGED,Linkages.DIP_RADIOMAN_DAMAGED);
         this.firstLoader.setBitmapData(Linkages.DIP_LOADER_DAMAGED,Linkages.DIP_LOADER_DAMAGED);
         this.secondLoader.setBitmapData(Linkages.DIP_LOADER_DAMAGED,Linkages.DIP_LOADER_DAMAGED);
         this.setInActiveState();
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(InvalidationType.STATE))
         {
            alpha = 1;
            if(this._stateID == ACTIVE_STATE_ID)
            {
               visible = true;
            }
            else if(this._stateID == INACTIVE_STATE_ID)
            {
               visible = false;
            }
         }
      }
      
      override protected function onDispose() : void
      {
         this._scheduler.cancelTask(this.hidePanel);
         this._scheduler = null;
         this._items.splice(0,this._items.length);
         this._items = null;
         this.engine.dispose();
         this.engine = null;
         this.ammoBay.dispose();
         this.ammoBay = null;
         this.fuelTank.dispose();
         this.fuelTank = null;
         this.radio.dispose();
         this.radio = null;
         this.leftTrack.dispose();
         this.leftTrack = null;
         this.rightTrack.dispose();
         this.rightTrack = null;
         this.gun.dispose();
         this.gun = null;
         this.turretRotator.dispose();
         this.turretRotator = null;
         this.surveyingDevice.dispose();
         this.surveyingDevice = null;
         this.commander.dispose();
         this.commander = null;
         this.firstGunner.dispose();
         this.firstGunner = null;
         this.secondGunner.dispose();
         this.secondGunner = null;
         this.wheel.dispose();
         this.wheel = null;
         this.driver.dispose();
         this.driver = null;
         this.firstRadioman.dispose();
         this.firstRadioman = null;
         this.secondRadioman.dispose();
         this.secondRadioman = null;
         this.firstLoader.dispose();
         this.firstLoader = null;
         this.secondLoader.dispose();
         this.secondLoader = null;
         this.fire.dispose();
         this.fire = null;
         super.onDispose();
      }
      
      override protected function show(param1:Array, param2:int) : void
      {
         var _loc3_:Array = null;
         var _loc4_:DamageItem = null;
         var _loc5_:int = 0;
         this.setActiveState();
         this.hideItems();
         for each(_loc3_ in param1)
         {
            _loc4_ = this._items[_loc3_[DAMAGE_INFO_PANEL_CONSTS.ITEM_ID]];
            _loc5_ = _loc3_[DAMAGE_INFO_PANEL_CONSTS.STATE_ID];
            if(_loc4_ != this.wheel || _loc5_ != DAMAGE_INFO_PANEL_CONSTS.DAMAGED)
            {
               _loc4_.updateItem(_loc5_,false);
            }
         }
         if(param2 == DAMAGE_INFO_PANEL_CONSTS.HIDE_FIRE)
         {
            this.as_hideFire();
         }
         else if(param2 == DAMAGE_INFO_PANEL_CONSTS.SHOW_FIRE)
         {
            this.as_showFire(false);
         }
         else
         {
            this.as_showFire(true);
         }
         this.updateDevicesPosition();
         this.updateTankmenPosition();
      }
      
      public function as_hide() : void
      {
         this.setHiddingState();
         this._scheduler.scheduleRepeatableTask(this.hidePanel,DAMAGE_INFO_PANEL_CONSTS.HIDE_SPEED,DAMAGE_INFO_PANEL_CONSTS.HIDE_STEPS);
      }
      
      public function as_hideAmmoBay() : void
      {
         this.hideItem(this.ammoBay,true);
      }
      
      public function as_hideCommander() : void
      {
         this.hideItem(this.commander,false);
      }
      
      public function as_hideDriver() : void
      {
         this.hideItem(this.driver,false);
      }
      
      public function as_hideEngine() : void
      {
         this.hideItem(this.engine,true);
      }
      
      public function as_hideFire() : void
      {
         this.fire.hideFire();
      }
      
      public function as_hideFirstGunner() : void
      {
         this.hideItem(this.firstGunner,false);
      }
      
      public function as_hideFirstLoader() : void
      {
         this.hideItem(this.firstLoader,false);
      }
      
      public function as_hideFirstRadioman() : void
      {
         this.hideItem(this.firstRadioman,false);
      }
      
      public function as_hideFuelTank() : void
      {
         this.hideItem(this.fuelTank,true);
      }
      
      public function as_hideGun() : void
      {
         this.hideItem(this.gun,true);
      }
      
      public function as_hideLeftTrack() : void
      {
         this.hideItem(this.leftTrack,true);
      }
      
      public function as_hideRadio() : void
      {
         this.hideItem(this.radio,true);
      }
      
      public function as_hideRightTrack() : void
      {
         this.hideItem(this.rightTrack,true);
      }
      
      public function as_hideSecondGunner() : void
      {
         this.hideItem(this.secondGunner,false);
      }
      
      public function as_hideSecondLoader() : void
      {
         this.hideItem(this.secondLoader,false);
      }
      
      public function as_hideSecondRadioman() : void
      {
         this.hideItem(this.secondRadioman,false);
      }
      
      public function as_hideSurveyingDevice() : void
      {
         this.hideItem(this.surveyingDevice,true);
      }
      
      public function as_hideTurretRotator() : void
      {
         this.hideItem(this.turretRotator,true);
      }
      
      public function as_hideWheel() : void
      {
         this.hideItem(this.wheel,true);
      }
      
      public function as_showFire(param1:Boolean) : void
      {
         this.setActiveState();
         this.fire.showFire(param1);
      }
      
      public function as_updateAmmoBay(param1:int, param2:Boolean) : void
      {
         this.setActiveState();
         this.ammoBay.updateItem(param1,param2);
         this.updateDevicesPosition();
      }
      
      public function as_updateCommander(param1:int, param2:Boolean) : void
      {
         this.setActiveState();
         this.commander.updateItem(param1,param2);
         this.updateTankmenPosition();
      }
      
      public function as_updateDriver(param1:int, param2:Boolean) : void
      {
         this.setActiveState();
         this.driver.updateItem(param1,param2);
         this.updateTankmenPosition();
      }
      
      public function as_updateEngine(param1:int, param2:Boolean) : void
      {
         this.setActiveState();
         this.engine.updateItem(param1,param2);
         this.updateDevicesPosition();
      }
      
      public function as_updateFirstGunner(param1:int, param2:Boolean) : void
      {
         this.setActiveState();
         this.firstGunner.updateItem(param1,param2);
         this.updateTankmenPosition();
      }
      
      public function as_updateFirstLoader(param1:int, param2:Boolean) : void
      {
         this.setActiveState();
         this.firstLoader.updateItem(param1,param2);
         this.updateTankmenPosition();
      }
      
      public function as_updateFirstRadioman(param1:int, param2:Boolean) : void
      {
         this.setActiveState();
         this.firstRadioman.updateItem(param1,param2);
         this.updateTankmenPosition();
      }
      
      public function as_updateFuelTank(param1:int, param2:Boolean) : void
      {
         this.setActiveState();
         this.fuelTank.updateItem(param1,param2);
         this.updateDevicesPosition();
      }
      
      public function as_updateGun(param1:int, param2:Boolean) : void
      {
         this.setActiveState();
         this.gun.updateItem(param1,param2);
         this.updateDevicesPosition();
      }
      
      public function as_updateLeftTrack(param1:int, param2:Boolean) : void
      {
         this.setActiveState();
         this.leftTrack.updateItem(param1,param2);
         this.updateDevicesPosition();
      }
      
      public function as_updateRadio(param1:int, param2:Boolean) : void
      {
         this.setActiveState();
         this.radio.updateItem(param1,param2);
         this.updateDevicesPosition();
      }
      
      public function as_updateRightTrack(param1:int, param2:Boolean) : void
      {
         this.setActiveState();
         this.rightTrack.updateItem(param1,param2);
         this.updateDevicesPosition();
      }
      
      public function as_updateSecondGunner(param1:int, param2:Boolean) : void
      {
         this.setActiveState();
         this.secondGunner.updateItem(param1,param2);
         this.updateTankmenPosition();
      }
      
      public function as_updateSecondLoader(param1:int, param2:Boolean) : void
      {
         this.setActiveState();
         this.secondLoader.updateItem(param1,param2);
         this.updateTankmenPosition();
      }
      
      public function as_updateSecondRadioman(param1:int, param2:Boolean) : void
      {
         this.setActiveState();
         this.secondRadioman.updateItem(param1,param2);
         this.updateTankmenPosition();
      }
      
      public function as_updateSurveyingDevice(param1:int, param2:Boolean) : void
      {
         this.setActiveState();
         this.surveyingDevice.updateItem(param1,param2);
         this.updateDevicesPosition();
      }
      
      public function as_updateTurretRotator(param1:int, param2:Boolean) : void
      {
         this.setActiveState();
         this.turretRotator.updateItem(param1,param2);
         this.updateDevicesPosition();
      }
      
      public function as_updateWheel(param1:int, param2:Boolean) : void
      {
         this.setActiveState();
         var _loc3_:int = param1 == DAMAGE_INFO_PANEL_CONSTS.DAMAGED ? int(DAMAGE_INFO_PANEL_CONSTS.NORMAL) : int(param1);
         this.wheel.updateItem(_loc3_,param2);
         this.updateDevicesPosition();
      }
      
      private function hidePanel() : void
      {
         alpha -= ALPHA_DECREASE_STEP;
         if(alpha <= 0)
         {
            this.setInActiveState();
         }
      }
      
      private function hideItem(param1:DamageItem, param2:Boolean) : void
      {
         param1.updateItem(DAMAGE_INFO_PANEL_CONSTS.NORMAL,false);
         if(param2)
         {
            this.updateDevicesPosition();
         }
         else
         {
            this.updateTankmenPosition();
         }
      }
      
      private function updateDevicesPosition() : void
      {
         var _loc1_:int = DAMAGE_INFO_PANEL_CONSTS.ITEM_START_X;
         if(this.gun.stateId)
         {
            _loc1_ -= ITEM_WIDTH;
            this.gun.updateXPos(_loc1_);
         }
         if(this.turretRotator.stateId)
         {
            _loc1_ -= ITEM_WIDTH;
            this.turretRotator.updateXPos(_loc1_);
         }
         if(this.surveyingDevice.stateId)
         {
            _loc1_ -= ITEM_WIDTH;
            this.surveyingDevice.updateXPos(_loc1_);
         }
         if(this.wheel.stateId)
         {
            _loc1_ -= ITEM_WIDTH;
            this.wheel.updateXPos(_loc1_);
         }
         if(this.engine.stateId)
         {
            _loc1_ -= ITEM_WIDTH;
            this.engine.updateXPos(_loc1_);
         }
         if(this.fuelTank.stateId)
         {
            _loc1_ -= ITEM_WIDTH;
            this.fuelTank.updateXPos(_loc1_);
         }
         if(this.radio.stateId)
         {
            _loc1_ -= ITEM_WIDTH;
            this.radio.updateXPos(_loc1_);
         }
         if(this.ammoBay.stateId)
         {
            _loc1_ -= ITEM_WIDTH;
            this.ammoBay.updateXPos(_loc1_);
         }
         if(this.leftTrack.stateId)
         {
            _loc1_ -= ITEM_WIDTH;
            this.leftTrack.updateXPos(_loc1_);
         }
         if(this.rightTrack.stateId)
         {
            _loc1_ -= ITEM_WIDTH;
            this.rightTrack.updateXPos(_loc1_);
         }
      }
      
      private function updateTankmenPosition() : void
      {
         var _loc1_:int = DAMAGE_INFO_PANEL_CONSTS.ITEM_START_X;
         if(this.commander.stateId)
         {
            this.commander.updateXPos(_loc1_);
            _loc1_ += ITEM_WIDTH;
         }
         if(this.firstGunner.stateId)
         {
            this.firstGunner.updateXPos(_loc1_);
            _loc1_ += ITEM_WIDTH;
         }
         if(this.secondGunner.stateId)
         {
            this.secondGunner.updateXPos(_loc1_);
            _loc1_ += ITEM_WIDTH;
         }
         if(this.driver.stateId)
         {
            this.driver.updateXPos(_loc1_);
            _loc1_ += ITEM_WIDTH;
         }
         if(this.firstRadioman.stateId)
         {
            this.firstRadioman.updateXPos(_loc1_);
            _loc1_ += ITEM_WIDTH;
         }
         if(this.secondRadioman.stateId)
         {
            this.secondRadioman.updateXPos(_loc1_);
            _loc1_ += ITEM_WIDTH;
         }
         if(this.firstLoader.stateId)
         {
            this.firstLoader.updateXPos(_loc1_);
            _loc1_ += ITEM_WIDTH;
         }
         if(this.secondLoader.stateId)
         {
            this.secondLoader.updateXPos(_loc1_);
         }
      }
      
      private function hideItems() : void
      {
         this.engine.updateItem(DAMAGE_INFO_PANEL_CONSTS.NORMAL,false);
         this.ammoBay.updateItem(DAMAGE_INFO_PANEL_CONSTS.NORMAL,false);
         this.turretRotator.updateItem(DAMAGE_INFO_PANEL_CONSTS.NORMAL,false);
         this.surveyingDevice.updateItem(DAMAGE_INFO_PANEL_CONSTS.NORMAL,false);
         this.wheel.updateItem(DAMAGE_INFO_PANEL_CONSTS.NORMAL,false);
         this.leftTrack.updateItem(DAMAGE_INFO_PANEL_CONSTS.NORMAL,false);
         this.rightTrack.updateItem(DAMAGE_INFO_PANEL_CONSTS.NORMAL,false);
         this.gun.updateItem(DAMAGE_INFO_PANEL_CONSTS.NORMAL,false);
         this.fuelTank.updateItem(DAMAGE_INFO_PANEL_CONSTS.NORMAL,false);
         this.radio.updateItem(DAMAGE_INFO_PANEL_CONSTS.NORMAL,false);
         this.commander.updateItem(DAMAGE_INFO_PANEL_CONSTS.NORMAL,false);
         this.driver.updateItem(DAMAGE_INFO_PANEL_CONSTS.NORMAL,false);
         this.firstLoader.updateItem(DAMAGE_INFO_PANEL_CONSTS.NORMAL,false);
         this.secondLoader.updateItem(DAMAGE_INFO_PANEL_CONSTS.NORMAL,false);
         this.firstGunner.updateItem(DAMAGE_INFO_PANEL_CONSTS.NORMAL,false);
         this.secondGunner.updateItem(DAMAGE_INFO_PANEL_CONSTS.NORMAL,false);
         this.firstRadioman.updateItem(DAMAGE_INFO_PANEL_CONSTS.NORMAL,false);
         this.secondRadioman.updateItem(DAMAGE_INFO_PANEL_CONSTS.NORMAL,false);
      }
      
      private function setActiveState() : void
      {
         if(this._stateID != ACTIVE_STATE_ID)
         {
            this._stateID = ACTIVE_STATE_ID;
            this._scheduler.cancelTask(this.hidePanel);
            invalidate(InvalidationType.STATE);
         }
      }
      
      private function setInActiveState() : void
      {
         if(this._stateID != INACTIVE_STATE_ID)
         {
            this._stateID = INACTIVE_STATE_ID;
            this._scheduler.cancelTask(this.hidePanel);
            this.hideItems();
            this.fire.hideFireImmediately();
            invalidate(InvalidationType.STATE);
         }
      }
      
      private function setHiddingState() : void
      {
         if(this._stateID != HIDDING_STATE_ID)
         {
            this._stateID = HIDDING_STATE_ID;
            this._scheduler.cancelTask(this.hidePanel);
            this.fire.stopAnim();
            invalidate(InvalidationType.STATE);
         }
      }
   }
}
