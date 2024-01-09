package net.wg.gui.battle.views.damagePanel.components.modules
{
   import net.wg.data.constants.Errors;
   import net.wg.data.constants.Values;
   import net.wg.data.constants.VehicleModules;
   import net.wg.data.constants.generated.BATTLE_ITEM_STATES;
   import net.wg.gui.battle.views.damagePanel.interfaces.IAssetCreator;
   import net.wg.gui.battle.views.damagePanel.interfaces.IDamagePanelClickableItem;
   import net.wg.gui.battle.views.damagePanel.interfaces.IDamagePanelItemsCtrl;
   import net.wg.utils.IAssertable;
   
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
      
      private var _destroyedChassis:Array;
      
      private var _wheelsCount:int = 0;
      
      private var _isDestroyed:Boolean = false;
      
      private var _modules:Vector.<ModuleAssets>;
      
      private var _asserter:IAssertable;
      
      private var _hasYoh:Boolean = false;
      
      private var _yohChassisState:YohChassisState = null;
      
      private var _disposed:Boolean = false;
      
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
         this._destroyedChassis = [];
         this._asserter = App.utils.asserter;
      }
      
      public final function dispose() : void
      {
         this.onDispose();
      }
      
      public function getItemByName(param1:String) : IDamagePanelClickableItem
      {
         if(VehicleModules.isWheel(param1))
         {
            param1 = VehicleModules.WHEEL;
         }
         if(!VehicleModules.checkModuleName(param1))
         {
            this._asserter.assert(false,param1 + Errors.WASNT_FOUND);
         }
         if(VehicleModules.isTrack(param1))
         {
            param1 = VehicleModules.CHASSIS;
         }
         param1 = UNDERSCORE_SIGN + param1;
         var _loc2_:ModuleAssets = ModuleAssets(this[param1]);
         if(!_loc2_)
         {
            this._asserter.assert(false,param1 + Errors.WASNT_FOUND);
         }
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
         this._destroyedChassis.length = 0;
         if(this._yohChassisState)
         {
            this._yohChassisState.reset();
         }
         this._isDestroyed = false;
      }
      
      public function setChassis(param1:Boolean, param2:Boolean) : void
      {
         this._hasYoh = param2;
         if(this._hasYoh)
         {
            if(!this._yohChassisState)
            {
               this._yohChassisState = new YohChassisState();
            }
         }
         else
         {
            this._yohChassisState = null;
         }
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
      
      public function setModuleRepairing(param1:String, param2:int, param3:int, param4:int = 0) : void
      {
         var _loc5_:ModuleAssets = null;
         var _loc6_:PartState = null;
         if(!this._isDestroyed)
         {
            _loc5_ = ModuleAssets(this.getItemByName(param1));
            if(VehicleModules.isTrack(param1) || VehicleModules.isWheel(param1))
            {
               if(this._hasYoh)
               {
                  this._yohChassisState.updateRepairTime(param1,param3,param2);
                  _loc6_ = this._yohChassisState.getHigherRepairTimePart();
                  param2 = _loc6_ != null ? int(_loc6_.repairPercent) : int(0);
                  param3 = _loc6_ != null ? int(_loc6_.repairTime) : int(0);
                  _loc5_.setModuleRepairing(param2,param3,param4);
               }
               else
               {
                  if(this._lastDestroyedChassisDevice == param1)
                  {
                     _loc5_.setModuleRepairing(param2,param3,param4);
                  }
                  else if(this._destroyedChassisDevices[param1] < param3 && this._destroyedChassisDevices[this._lastDestroyedChassisDevice] < param3)
                  {
                     this._lastDestroyedChassisDevice = param1;
                     _loc5_.setModuleRepairing(param2,param3,param4);
                  }
                  this._destroyedChassisDevices[param1] = param3;
               }
            }
            else
            {
               _loc5_.setModuleRepairing(param2,param3,param4);
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
      
      public function setRepairTimesVisible(param1:Boolean) : void
      {
         var _loc2_:ModuleAssets = null;
         for each(_loc2_ in this._modules)
         {
            _loc2_.setRepairTimeVisible(param1);
         }
      }
      
      public function setState(param1:String, param2:String) : void
      {
         if(this._isDestroyed)
         {
            this._isDestroyed = param2 == BATTLE_ITEM_STATES.DESTROYED;
         }
         var _loc3_:IAssetCreator = this.getItemByName(param1);
         if(VehicleModules.isTrack(param1))
         {
            this.setChassisState(_loc3_,param1,param2);
         }
         else if(VehicleModules.isWheel(param1))
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
               _loc3_.resetModuleRepairing();
            }
            _loc2_++;
         }
      }
      
      protected function onDispose() : void
      {
         this._disposed = true;
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
         this._yohChassisState = null;
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
         this._destroyedChassis = null;
         this._asserter = null;
      }
      
      private function setChassisState(param1:IAssetCreator, param2:String, param3:String) : void
      {
         var _loc4_:String = null;
         var _loc5_:String = null;
         if(this._hasYoh)
         {
            this._yohChassisState.updateTrackState(param2,param3);
            _loc4_ = this._yohChassisState.getChassisState();
            if(param3 == BATTLE_ITEM_STATES.DESTROYED || param3 == BATTLE_ITEM_STATES.CRITICAL || param3 == BATTLE_ITEM_STATES.REPAIRED)
            {
               this._lastBrokenChassisDevice = param2;
            }
            if(_loc4_ == BATTLE_ITEM_STATES.NORMAL || _loc4_ == BATTLE_ITEM_STATES.REPAIRED_FULL)
            {
               this._lastBrokenChassisDevice = Values.EMPTY_STR;
            }
            if(!this._yohChassisState.hasSameState())
            {
               param1.state = _loc4_;
            }
         }
         else
         {
            _loc5_ = Values.EMPTY_STR;
            if(param3 == BATTLE_ITEM_STATES.DESTROYED)
            {
               this._destroyedChassisDevices[param2] = 0;
               this._lastBrokenChassisDevice = param2;
               this._lastDestroyedChassisDevice = param2;
               if(this._destroyedChassis.indexOf(param2) == -1)
               {
                  this._destroyedChassis.push(param2);
               }
               _loc5_ = BATTLE_ITEM_STATES.DESTROYED;
            }
            else if(param3 == BATTLE_ITEM_STATES.CRITICAL)
            {
               this._lastBrokenChassisDevice = param2;
               _loc5_ = this._destroyedChassis.length == 0 ? BATTLE_ITEM_STATES.CRITICAL : BATTLE_ITEM_STATES.DESTROYED;
            }
            else if(param3 == BATTLE_ITEM_STATES.REPAIRED || param3 == BATTLE_ITEM_STATES.REPAIRED_FULL)
            {
               this._destroyedChassisDevices[param2] = 0;
               this._lastBrokenChassisDevice = param2;
               this._destroyedChassis.splice(this._destroyedChassis.indexOf(param2),1);
               if(this._destroyedChassis.length == 0)
               {
                  this._lastDestroyedChassisDevice = Values.EMPTY_STR;
                  _loc5_ = param3;
               }
               else
               {
                  _loc5_ = BATTLE_ITEM_STATES.DESTROYED;
               }
            }
            else if(param3 == BATTLE_ITEM_STATES.NORMAL)
            {
               this._destroyedChassisDevices[param2] = 0;
               this._lastBrokenChassisDevice = Values.EMPTY_STR;
               this._destroyedChassis.length = 0;
               if(this._lastDestroyedChassisDevice == param2)
               {
                  this._lastDestroyedChassisDevice = Values.EMPTY_STR;
               }
               _loc5_ = BATTLE_ITEM_STATES.NORMAL;
            }
            if(_loc5_ != Values.EMPTY_STR)
            {
               param1.state = _loc5_;
            }
         }
      }
      
      private function setWheelState(param1:IAssetCreator, param2:String, param3:String) : void
      {
         if(param3 == BATTLE_ITEM_STATES.DESTROYED)
         {
            this._destroyedChassisDevices[param2] = 0;
            this._lastBrokenChassisDevice = param2;
            this._lastDestroyedChassisDevice = param2;
            if(this._destroyedChassis.indexOf(param2) == -1)
            {
               this._destroyedChassis.push(param2);
            }
         }
         else if(param3 == BATTLE_ITEM_STATES.CRITICAL)
         {
            this._lastBrokenChassisDevice = param2;
         }
         else if(param3 == BATTLE_ITEM_STATES.REPAIRED || param3 == BATTLE_ITEM_STATES.REPAIRED_FULL)
         {
            this._destroyedChassisDevices[param2] = 0;
            this._destroyedChassis.splice(this._destroyedChassis.indexOf(param2),1);
            this._lastBrokenChassisDevice = param2;
            if(this._lastDestroyedChassisDevice == param2)
            {
               this._lastDestroyedChassisDevice = Values.EMPTY_STR;
            }
         }
         else if(param3 == BATTLE_ITEM_STATES.NORMAL)
         {
            this._destroyedChassisDevices[param2] = 0;
            this._destroyedChassis.splice(this._destroyedChassis.indexOf(param2),1);
            this._lastBrokenChassisDevice = Values.EMPTY_STR;
            if(this._lastDestroyedChassisDevice == param2)
            {
               if(this._destroyedChassis.length > 0)
               {
                  this._lastDestroyedChassisDevice = this._destroyedChassis[this._destroyedChassis.length - 1];
               }
               else
               {
                  this._lastDestroyedChassisDevice = Values.EMPTY_STR;
               }
            }
         }
         var _loc4_:String = this.checkWheelChassisDestroyed();
         if(_loc4_ != Values.EMPTY_STR)
         {
            param1.state = _loc4_;
         }
      }
      
      private function checkWheelChassisDestroyed() : String
      {
         if(this._destroyedChassis.length > this._wheelsCount >> 1)
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
      
      public function isDisposed() : Boolean
      {
         return this._disposed;
      }
   }
}

import net.wg.data.constants.generated.BATTLE_ITEM_STATES;
import net.wg.infrastructure.interfaces.entity.IDisposable;

class YohChassisState implements IDisposable
{
    
   
   public var leftTrack0:PartState;
   
   public var rightTrack0:PartState;
   
   public var leftTrack1:PartState;
   
   public var rightTrack1:PartState;
   
   private var _prevState:String = "normal";
   
   private var _currentState:String = "normal";
   
   private var _disposed:Boolean = false;
   
   function YohChassisState()
   {
      this.leftTrack0 = new PartState();
      this.rightTrack0 = new PartState();
      this.leftTrack1 = new PartState();
      this.rightTrack1 = new PartState();
      super();
   }
   
   public function updateTrackState(param1:String, param2:String) : void
   {
      this[param1].updateState(param2);
   }
   
   public function updateRepairTime(param1:String, param2:int, param3:int) : void
   {
      this[param1].updateRepairTime(param2,param3);
   }
   
   public function reset() : void
   {
      this.leftTrack0.reset();
      this.leftTrack1.reset();
      this.rightTrack1.reset();
      this.rightTrack0.reset();
      this._prevState = BATTLE_ITEM_STATES.NORMAL;
      this._currentState = BATTLE_ITEM_STATES.NORMAL;
   }
   
   public function getChassisState() : String
   {
      if(this.leftTrack0.state == BATTLE_ITEM_STATES.DESTROYED || this.rightTrack0.state == BATTLE_ITEM_STATES.DESTROYED)
      {
         return this.saveState(BATTLE_ITEM_STATES.DESTROYED);
      }
      if(this.leftTrack1.state == BATTLE_ITEM_STATES.DESTROYED || this.rightTrack1.state == BATTLE_ITEM_STATES.DESTROYED)
      {
         return this.saveState(BATTLE_ITEM_STATES.CRITICAL);
      }
      if(this.leftTrack0.state == BATTLE_ITEM_STATES.REPAIRED && this.leftTrack1.state == BATTLE_ITEM_STATES.DESTROYED || this.rightTrack0.state == BATTLE_ITEM_STATES.REPAIRED && this.rightTrack1.state == BATTLE_ITEM_STATES.DESTROYED)
      {
         return this.saveState(BATTLE_ITEM_STATES.REPAIRED);
      }
      if(this.leftTrack1.state == BATTLE_ITEM_STATES.REPAIRED && this.leftTrack1.prevState == BATTLE_ITEM_STATES.DESTROYED || this.rightTrack1.state == BATTLE_ITEM_STATES.REPAIRED && this.rightTrack1.prevState == BATTLE_ITEM_STATES.DESTROYED)
      {
         return this.saveState(BATTLE_ITEM_STATES.REPAIRED_FULL);
      }
      if(this.leftTrack0.state == BATTLE_ITEM_STATES.REPAIRED_FULL || this.rightTrack0.state == BATTLE_ITEM_STATES.REPAIRED_FULL)
      {
         return this.saveState(BATTLE_ITEM_STATES.REPAIRED_FULL);
      }
      return this.saveState(BATTLE_ITEM_STATES.NORMAL);
   }
   
   public function getHigherRepairTimePart() : PartState
   {
      if(this.leftTrack0.repairTime > this.rightTrack0.repairTime)
      {
         if(this.leftTrack0.repairTime > 0)
         {
            return this.leftTrack0;
         }
      }
      else if(this.rightTrack0.repairTime > 0)
      {
         return this.rightTrack0;
      }
      if(this.leftTrack1.repairTime > this.rightTrack1.repairTime)
      {
         if(this.leftTrack1.repairTime > 0)
         {
            return this.leftTrack1;
         }
      }
      else if(this.rightTrack1.repairTime > 0)
      {
         return this.rightTrack1;
      }
      return null;
   }
   
   public function dispose() : void
   {
      this._disposed = true;
      this.leftTrack0 = null;
      this.leftTrack1 = null;
      this.rightTrack0 = null;
      this.rightTrack1 = null;
   }
   
   public function hasSameState() : Boolean
   {
      return this._currentState == this._prevState;
   }
   
   private function saveState(param1:String) : String
   {
      this._prevState = this._currentState;
      this._currentState = param1;
      return param1;
   }
   
   public function isDisposed() : Boolean
   {
      return this._disposed;
   }
}

import net.wg.data.constants.Values;
import net.wg.data.constants.generated.BATTLE_ITEM_STATES;

class PartState
{
    
   
   public var state:String = "normal";
   
   public var repairTime:int = 0;
   
   public var repairPercent:int = 0;
   
   public var prevState:String = "normal";
   
   function PartState()
   {
      super();
   }
   
   public function updateState(param1:String) : void
   {
      this.prevState = this.state;
      this.state = param1;
      if(this.state == BATTLE_ITEM_STATES.NORMAL || this.state == BATTLE_ITEM_STATES.REPAIRED || this.state == BATTLE_ITEM_STATES.REPAIRED_FULL)
      {
         this.repairTime = Values.ZERO;
         this.repairPercent = Values.ZERO;
      }
   }
   
   public function updateRepairTime(param1:int, param2:int) : void
   {
      this.repairTime = param1;
      this.repairPercent = param2;
   }
   
   public function reset() : void
   {
      this.state = BATTLE_ITEM_STATES.NORMAL;
      this.prevState = BATTLE_ITEM_STATES.NORMAL;
      this.repairTime = Values.ZERO;
      this.repairPercent = Values.ZERO;
   }
}
