package net.wg.gui.battle.views.damagePanel.components.tankIndicator
{
   import flash.display.Sprite;
   import net.wg.data.constants.Linkages;
   import net.wg.data.constants.VehicleModules;
   import net.wg.data.constants.VehicleTypes;
   import net.wg.data.constants.generated.BATTLE_ITEM_STATES;
   import net.wg.gui.battle.components.BattleUIComponent;
   import net.wg.gui.battle.views.damagePanel.VO.TankIndicatorItem;
   import net.wg.gui.battle.views.damagePanel.components.DamagePanelItemFrameStates;
   
   public class TankIndicator extends BattleUIComponent
   {
       
      
      public var turret:Sprite;
      
      public var hull:Sprite;
      
      public var isVehicleWithTurret:Boolean = false;
      
      public var isVehicleWithWheel:Boolean = false;
      
      private var _hull:TankRotator;
      
      private var _gunSPG:DamagePanelItemFrameStates;
      
      private var _turretTank:ItemWithModules;
      
      private var _indicators:Object;
      
      public function TankIndicator()
      {
         super();
         this._indicators = {};
         this._indicators[VehicleTypes.AT_SPG] = new TankIndicatorItem(Linkages.ATSPG_TURRET_UI,Linkages.ATSPG_HULL_UI);
         this._indicators[VehicleTypes.SPG] = new TankIndicatorItem(Linkages.SPG_TURRET_UI,Linkages.SPG_HULL_UI);
         this._indicators[VehicleTypes.TANK] = new TankIndicatorItem(Linkages.TANK_TURRET_UI,Linkages.TANK_HULL_UI);
         this._indicators[VehicleTypes.WHEEL] = new TankIndicatorItem(Linkages.WHEEL_TURRET_UI,Linkages.WHEEL_HULL_UI);
      }
      
      override protected function onDispose() : void
      {
         var _loc1_:* = null;
         var _loc2_:* = null;
         var _loc3_:SPGRotator = null;
         for(_loc1_ in this._indicators)
         {
            this._indicators[_loc1_].dispose();
            delete this._indicators[_loc1_];
         }
         this._indicators = null;
         this.turret = null;
         this.hull = null;
         this._gunSPG = null;
         this._hull = null;
         this._turretTank = null;
         for(_loc2_ in this._indicators)
         {
            _loc3_ = this._indicators[_loc2_];
            _loc3_.dispose();
            delete this._indicators[_loc2_];
         }
         super.onDispose();
      }
      
      public function onArrivedConstraint(param1:Boolean) : void
      {
         if(param1)
         {
            this._hull.showTurretConstraintEnabled();
         }
         else
         {
            this._hull.showTurretConstraintDisabled();
         }
      }
      
      public function reset() : void
      {
         if(this._hull != null)
         {
            this._hull.reset();
         }
         if(this._turretTank != null)
         {
            this._turretTank.reset();
         }
         if(this._gunSPG != null)
         {
            this._gunSPG.state = BATTLE_ITEM_STATES.NORMAL;
         }
      }
      
      public function setModuleState(param1:String, param2:String) : void
      {
         if(this.isVehicleWithWheel)
         {
            if(param1 == VehicleModules.GUN || param1 == VehicleModules.TURRET_ROTATOR)
            {
               this._turretTank.setModuleState(param1,param2);
            }
            else
            {
               this._hull.setModuleState(param1,param2);
            }
         }
         else if(this.isVehicleWithTurret)
         {
            if(VehicleModules.checkIsInTurret(param1))
            {
               this._turretTank.setModuleState(param1,param2);
            }
            else
            {
               this._hull.setModuleState(param1,param2);
            }
         }
         else if(param1 == VehicleModules.GUN)
         {
            this._gunSPG.state = param2;
         }
         else
         {
            this._hull.setModuleState(param1,param2);
         }
      }
      
      public function setRotatorType(param1:String, param2:Array) : void
      {
         App.utils.asserter.assert(this._indicators[param1] != null,"Not " + param1 + " type in rotatorLinkages");
         this.reset();
         if(this._hull != null)
         {
            this.hull.removeChild(this._hull);
            this._hull = null;
         }
         if(this._gunSPG != null)
         {
            this.turret.removeChild(this._gunSPG);
            this._gunSPG = null;
         }
         if(this._turretTank != null)
         {
            this.turret.removeChild(this._turretTank);
            this._turretTank = null;
         }
         var _loc3_:TankIndicatorItem = this._indicators[param1];
         if(this.isVehicleWithWheel)
         {
            _loc3_ = this._indicators[VehicleTypes.WHEEL];
            if(_loc3_.hull == null)
            {
               _loc3_.hull = App.utils.classFactory.getComponent(_loc3_.hullLinkage,WheelRotator);
            }
            if(_loc3_.turret == null)
            {
               _loc3_.turret = App.utils.classFactory.getComponent(_loc3_.turretLinkage,WheelTurret);
            }
            this._turretTank = _loc3_.turret;
            this.turret.addChild(this._turretTank);
         }
         else if(this.isVehicleWithTurret)
         {
            if(_loc3_.hull == null)
            {
               _loc3_.hull = App.utils.classFactory.getComponent(_loc3_.hullLinkage,TankRotator);
            }
            if(_loc3_.turret == null)
            {
               _loc3_.turret = App.utils.classFactory.getComponent(_loc3_.turretLinkage,VehicleTurret);
            }
            this._turretTank = _loc3_.turret;
            this.turret.addChild(this._turretTank);
         }
         else
         {
            if(_loc3_.hull == null)
            {
               _loc3_.hull = App.utils.classFactory.getComponent(_loc3_.hullLinkage,SPGRotator);
            }
            if(_loc3_.gun == null)
            {
               _loc3_.gun = App.utils.classFactory.getComponent(_loc3_.turretLinkage,DamagePanelItemFrameStates);
            }
            if(this._gunSPG == null)
            {
               this._gunSPG = _loc3_.gun;
               this._gunSPG.alwaysVisible = true;
            }
            this.turret.addChild(this._gunSPG);
         }
         this._hull = _loc3_.hull;
         this._hull.setYawLimits(param2);
         this.hull.addChild(this._hull);
      }
      
      public function setWheelCount(param1:int) : void
      {
         if(this._hull is WheelRotator)
         {
            WheelRotator(this._hull).setWheelCount(param1);
         }
      }
      
      public function showDestroyed() : void
      {
         this._hull.showDestroyed();
         if(this._turretTank != null)
         {
            this._turretTank.showDestroyed();
         }
         if(this._gunSPG != null)
         {
            this._gunSPG.state = BATTLE_ITEM_STATES.DESTROYED;
         }
      }
      
      public function setSpeedMode(param1:Boolean) : void
      {
         if(this._hull is WheelRotator)
         {
            WheelRotator(this._hull).setSpeedMode(param1);
         }
      }
   }
}
