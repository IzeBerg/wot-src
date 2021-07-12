package net.wg.gui.battle.views.damagePanel.components.modules
{
   import net.wg.data.constants.Values;
   import net.wg.data.constants.VehicleModules;
   import net.wg.data.constants.generated.BATTLE_ITEM_STATES;
   import net.wg.gui.battle.views.damagePanel.components.tankIndicator.WheelRotator;
   import net.wg.gui.battle.views.damagePanel.interfaces.IAssetCreator;
   import net.wg.gui.battle.views.damagePanel.interfaces.IDamagePanelClickableItem;
   import net.wg.gui.battle.views.damagePanel.interfaces.IDamagePanelItemsCtrl;
   
   public class ModulesCtrl implements IDamagePanelItemsCtrl
   {
      
      private static const UNDERSCORE_SIGN:String = "_";
       
      
      private var _engine:ModuleAssets;
      
      private var _ammoBay:ModuleAssets;
      
      private var _gun:ModuleAssets;
      
      private var _turretRotator:ModuleAssets;
      
      private var _chassis:ModuleAssets;
      
      private var _surveyingDevice:ModuleAssets;
      
      private var _wheel:ModuleAssets;
      
      private var _radio:ModuleAssets;
      
      private var _fuelTank:ModuleAssets;
      
      private var _lastDestroyedChassisDevice:String = "";
      
      private var _lastBrokenChassisDevice:String = "";
      
      private var _destroyedChassisDevices:Object;
      
      private var _destroyedChassisDevicesCount:int = 0;
      
      private var _wheelsCount:int = 0;
      
      private var _isDestroyed:Boolean = false;
      
      private var _modules:Vector.<ModuleAssets>;
      
      public function ModulesCtrl()
      {
         super();
         this._engine = new ModuleAssets(VehicleModules.ENGINE,true,ModuleAssets.TOP_POSITION_IDX_0);
         this._ammoBay = new ModuleAssets(VehicleModules.AMMO_BAY,true,ModuleAssets.TOP_POSITION_IDX_1);
         this._gun = new ModuleAssets(VehicleModules.GUN,true,ModuleAssets.TOP_POSITION_IDX_2);
         this._turretRotator = new ModuleAssets(VehicleModules.TURRET_ROTATOR,true,ModuleAssets.TOP_POSITION_IDX_3);
         this._surveyingDevice = new ModuleAssets(VehicleModules.SURVEYING_DEVICE,false,ModuleAssets.TOP_POSITION_IDX_1);
         this._radio = new ModuleAssets(VehicleModules.RADIO,false,ModuleAssets.TOP_POSITION_IDX_2);
         this._fuelTank = new ModuleAssets(VehicleModules.FUEL_TANK,false,ModuleAssets.TOP_POSITION_IDX_3);
         this._modules = new <ModuleAssets>[this._engine,this._ammoBay,this._gun,this._turretRotator,this._surveyingDevice,this._radio,this._fuelTank];
         this._destroyedChassisDevices = {};
      }
      
      private static function isWheel(param1:String) : Boolean
      {
         return param1.slice(0,WheelRotator.WHEEL_LENGTH) == VehicleModules.WHEEL && param1 != VehicleModules.WHEEL;
      }
      
      private static function isTrack(param1:String) : Boolean
      {
         return param1 == VehicleModules.LEFT_TRACK || param1 == VehicleModules.RIGHT_TRACK;
      }
      
      public final function dispose() : void
      {
         this.onDispose();
      }
      
      public function getItemByName(param1:String) : IDamagePanelClickableItem
      {
         if(isWheel(param1))
         {
            param1 = VehicleModules.WHEEL;
         }
         App.utils.asserter.assert(VehicleModules.MODULES_LIST.indexOf(param1) >= 0,"Not valid itemName = " + param1);
         if(isTrack(param1))
         {
            param1 = VehicleModules.CHASSIS;
         }
         param1 = UNDERSCORE_SIGN + param1;
         var _loc2_:ModuleAssets = this[param1];
         App.utils.asserter.assertNotNull(_loc2_,"Not module with name = " + param1);
         return _loc2_;
      }
      
      public function getItems() : Vector.<IDamagePanelClickableItem>
      {
         return Vector.<IDamagePanelClickableItem>(this._modules);
      }
      
      public function reset() : void
      {
         var _loc1_:int = this._modules.length;
         var _loc2_:int = 0;
         while(_loc2_ < _loc1_)
         {
            this._modules[_loc2_].resetModule();
            _loc2_++;
         }
         this._destroyedChassisDevicesCount = 0;
         this._isDestroyed = false;
      }
      
      public function setChassis(param1:Boolean) : void
      {
         if(param1)
         {
            if(this._modules.indexOf(this._wheel) == -1)
            {
               this._wheel = new ModuleAssets(VehicleModules.WHEEL,false,ModuleAssets.TOP_POSITION_IDX_0);
               this._modules.push(this._wheel);
               this._wheel.destroyAvailability = true;
            }
            if(this._chassis && this._modules.indexOf(this._chassis) != -1)
            {
               this._modules.splice(this._modules.indexOf(this._chassis),1);
               this._chassis.dispose();
               this._chassis = null;
            }
         }
         else
         {
            if(this._modules.indexOf(this._chassis) == -1)
            {
               this._chassis = new ModuleAssets(VehicleModules.CHASSIS,false,ModuleAssets.TOP_POSITION_IDX_0);
               this._modules.push(this._chassis);
               this._chassis.destroyAvailability = true;
            }
            if(this._wheel && this._modules.indexOf(this._wheel) != -1)
            {
               this._modules.splice(this._modules.indexOf(this._wheel),1);
               this._wheel.dispose();
               this._wheel = null;
            }
         }
      }
      
      public function setModuleRepairing(param1:String, param2:int, param3:int) : void
      {
         var _loc4_:ModuleAssets = null;
         if(!this._isDestroyed)
         {
            _loc4_ = ModuleAssets(this.getItemByName(param1));
            if(isTrack(param1) || isWheel(param1))
            {
               if(this._lastDestroyedChassisDevice == param1)
               {
                  _loc4_.setModuleRepairing(param2,param3);
               }
               else if(this._destroyedChassisDevices[param1] < param3 && this._destroyedChassisDevices[this._lastDestroyedChassisDevice] < param3)
               {
                  this._lastDestroyedChassisDevice = param1;
                  _loc4_.setModuleRepairing(param2,param3);
               }
               this._destroyedChassisDevices[param1] = param3;
            }
            else
            {
               _loc4_.setModuleRepairing(param2,param3);
            }
         }
      }
      
      public function setPlaybackSpeed(param1:Number) : void
      {
         var _loc2_:Vector.<IDamagePanelClickableItem> = null;
         var _loc3_:IDamagePanelClickableItem = null;
         if(!this._isDestroyed)
         {
            _loc2_ = this.getItems();
            for each(_loc3_ in _loc2_)
            {
               ModuleAssets(_loc3_).setPlaybackSpeed(param1);
            }
         }
      }
      
      public function setState(param1:String, param2:String) : void
      {
         if(this._isDestroyed)
         {
            this._isDestroyed = param2 == BATTLE_ITEM_STATES.DESTROYED;
         }
         var _loc3_:IAssetCreator = this.getItemByName(param1);
         if(isTrack(param1))
         {
            this.setChessisState(_loc3_,param1,param2);
         }
         else if(isWheel(param1))
         {
            this.setWheelState(_loc3_,param1,param2);
         }
         else
         {
            _loc3_.state = param2;
         }
      }
      
      public function setWheelCount(param1:int) : void
      {
         this._wheelsCount = param1;
      }
      
      public function showDestroyed() : void
      {
         var _loc2_:IDamagePanelClickableItem = null;
         this._isDestroyed = true;
         var _loc1_:Vector.<IDamagePanelClickableItem> = this.getItems();
         for each(_loc2_ in _loc1_)
         {
            _loc2_.showDestroyed();
         }
      }
      
      public function updateAvailableAssets() : void
      {
         var _loc3_:ModuleAssets = null;
         var _loc1_:int = this._modules.length;
         var _loc2_:int = 0;
         while(_loc2_ < _loc1_)
         {
            _loc3_ = this._modules[_loc2_];
            if(_loc3_.destroyAvailability)
            {
               _loc3_.state = BATTLE_ITEM_STATES.NORMAL;
               _loc3_.resetModuleRepairing();
            }
            _loc2_++;
         }
      }
      
      protected function onDispose() : void
      {
         this._engine.dispose();
         this._engine = null;
         this._ammoBay.dispose();
         this._ammoBay = null;
         this._gun.dispose();
         this._gun = null;
         this._turretRotator.dispose();
         this._turretRotator = null;
         this._surveyingDevice.dispose();
         this._surveyingDevice = null;
         this._radio.dispose();
         this._radio = null;
         this._fuelTank.dispose();
         this._fuelTank = null;
         if(this._chassis)
         {
            this._chassis.dispose();
            this._chassis = null;
         }
         if(this._wheel)
         {
            this._wheel.dispose();
            this._wheel = null;
         }
         this._modules.splice(0,this._modules.length);
         this._modules = null;
         this._destroyedChassisDevices = null;
      }
      
      private function setChessisState(param1:IAssetCreator, param2:String, param3:String) : void
      {
         var _loc4_:String = Values.EMPTY_STR;
         if(param3 == BATTLE_ITEM_STATES.DESTROYED)
         {
            this._destroyedChassisDevices[param2] = 0;
            this._lastBrokenChassisDevice = param2;
            this._lastDestroyedChassisDevice = param2;
            ++this._destroyedChassisDevicesCount;
            _loc4_ = BATTLE_ITEM_STATES.DESTROYED;
         }
         else if(param3 == BATTLE_ITEM_STATES.CRITICAL)
         {
            this._lastBrokenChassisDevice = param2;
            _loc4_ = this._destroyedChassisDevicesCount <= 0 ? BATTLE_ITEM_STATES.CRITICAL : BATTLE_ITEM_STATES.DESTROYED;
         }
         else if(param3 == BATTLE_ITEM_STATES.REPAIRED || param3 == BATTLE_ITEM_STATES.REPAIRED_FULL)
         {
            this._destroyedChassisDevices[param2] = 0;
            this._lastBrokenChassisDevice = param2;
            --this._destroyedChassisDevicesCount;
            if(this._destroyedChassisDevicesCount <= 0)
            {
               this._lastDestroyedChassisDevice = Values.EMPTY_STR;
               _loc4_ = param3;
            }
            else
            {
               _loc4_ = BATTLE_ITEM_STATES.DESTROYED;
            }
         }
         else if(param3 == BATTLE_ITEM_STATES.NORMAL)
         {
            this._destroyedChassisDevices[param2] = 0;
            this._lastBrokenChassisDevice = Values.EMPTY_STR;
            this._destroyedChassisDevicesCount = 0;
            if(this._lastDestroyedChassisDevice == param2)
            {
               this._lastDestroyedChassisDevice = Values.EMPTY_STR;
            }
            _loc4_ = BATTLE_ITEM_STATES.NORMAL;
         }
         if(_loc4_ != Values.EMPTY_STR)
         {
            param1.state = _loc4_;
         }
      }
      
      private function setWheelState(param1:IAssetCreator, param2:String, param3:String) : void
      {
         if(param3 == BATTLE_ITEM_STATES.DESTROYED)
         {
            this._destroyedChassisDevices[param2] = 0;
            this._lastBrokenChassisDevice = param2;
            this._lastDestroyedChassisDevice = param2;
            ++this._destroyedChassisDevicesCount;
         }
         else if(param3 == BATTLE_ITEM_STATES.CRITICAL)
         {
            this._lastBrokenChassisDevice = param2;
         }
         else if(param3 == BATTLE_ITEM_STATES.REPAIRED || param3 == BATTLE_ITEM_STATES.REPAIRED_FULL)
         {
            this._destroyedChassisDevices[param2] = 0;
            --this._destroyedChassisDevicesCount;
            this._lastBrokenChassisDevice = param2;
            if(this._lastDestroyedChassisDevice == param2)
            {
               this._lastDestroyedChassisDevice = Values.EMPTY_STR;
            }
         }
         else if(param3 == BATTLE_ITEM_STATES.NORMAL)
         {
            this._destroyedChassisDevices[param2] = 0;
            --this._destroyedChassisDevicesCount;
            this._lastBrokenChassisDevice = Values.EMPTY_STR;
            if(this._lastDestroyedChassisDevice == param2)
            {
               this._lastDestroyedChassisDevice = Values.EMPTY_STR;
            }
         }
         var _loc4_:String = this.checkWheelChessisDestroyed();
         if(_loc4_ != Values.EMPTY_STR)
         {
            param1.state = _loc4_;
         }
      }
      
      private function checkWheelChessisDestroyed() : String
      {
         if(this._destroyedChassisDevicesCount > this._wheelsCount >> 1)
         {
            return BATTLE_ITEM_STATES.DESTROYED;
         }
         if(this._lastBrokenChassisDevice || this._lastDestroyedChassisDevice)
         {
            return BATTLE_ITEM_STATES.CRITICAL;
         }
         return BATTLE_ITEM_STATES.NORMAL;
      }
      
      public function get lastBrokenTrackName() : String
      {
         return this._lastBrokenChassisDevice;
      }
      
      public function set hasTurretRotator(param1:Boolean) : void
      {
         this._turretRotator.destroyAvailability = param1;
         if(!param1)
         {
            this._turretRotator.hideAsset();
         }
      }
      
      public function setRepairTimesVisible(param1:Boolean) : void
      {
         var _loc2_:ModuleAssets = null;
         for each(_loc2_ in this._modules)
         {
            _loc2_.setRepairTimeVisible(param1);
         }
      }
   }
}
