package net.wg.gui.battle.views.damagePanel.components.tankIndicator
{
   import flash.display.Sprite;
   import flash.geom.ColorTransform;
   import net.wg.data.constants.Errors;
   import net.wg.data.constants.Values;
   import net.wg.data.constants.VehicleModules;
   import net.wg.data.constants.generated.BATTLE_ITEM_STATES;
   import net.wg.gui.battle.views.damagePanel.components.DamagePanelItemFrameStates;
   
   public class TankRotator extends ItemWithModules
   {
      
      private static const YAW_ORANGE_COLOR:int = 16082954;
      
      private static const LEFT_PARAM_IDX:int = 0;
      
      private static const RIGHT_PARAM_IDX:int = 1;
      
      private static const PREFIX:String = "_";
      
      private static const POSTFIX:String = "State";
      
      private static const MAIN_SUBFIX:String = "_main_";
      
      private static const SECOND_POSTFIX:String = "_second";
       
      
      public var leftGunConstraint:Sprite;
      
      public var rightGunConstraint:Sprite;
      
      public var fuelTank:DamagePanelItemFrameStates;
      
      public var rightTrack:DamagePanelItemFrameStates;
      
      public var leftTrack:DamagePanelItemFrameStates;
      
      public var engine:DamagePanelItemFrameStates;
      
      public var hullBase:DamagePanelItemFrameStates;
      
      public var ammoBay:DamagePanelItemFrameStates;
      
      private var _hasYoh:Boolean = false;
      
      private var _mainleftTrackState:String = "normal";
      
      private var _secondleftTrackState:String = "normal";
      
      private var _mainrightTrackState:String = "normal";
      
      private var _secondrightTrackState:String = "normal";
      
      public function TankRotator()
      {
         super();
      }
      
      override public function setModuleState(param1:String, param2:String) : void
      {
         if(this._hasYoh)
         {
            param2 = this.calculateYohModuleState(param1,param2);
         }
         if(VehicleModules.isLeftTrack(param1))
         {
            param1 = VehicleModules.getLeftTrackName(param1);
         }
         else if(VehicleModules.isRightTrack(param1))
         {
            param1 = VehicleModules.getRightTrackName(param1);
         }
         var _loc3_:DamagePanelItemFrameStates = this[param1];
         if(!_loc3_)
         {
            App.utils.asserter.assert(false,param1 + Errors.WASNT_FOUND);
         }
         _loc3_.state = param2;
      }
      
      override protected function onDispose() : void
      {
         this.leftGunConstraint = null;
         this.rightGunConstraint = null;
         this.fuelTank.dispose();
         this.fuelTank = null;
         if(this.rightTrack != null)
         {
            this.rightTrack.dispose();
            this.rightTrack = null;
         }
         if(this.leftTrack != null)
         {
            this.leftTrack.dispose();
            this.leftTrack = null;
         }
         if(this.ammoBay != null)
         {
            this.ammoBay.dispose();
            this.ammoBay = null;
         }
         this.engine.dispose();
         this.engine = null;
         this.hullBase.dispose();
         this.hullBase = null;
         super.onDispose();
      }
      
      override protected function getModules() : Vector.<DamagePanelItemFrameStates>
      {
         var _loc1_:Vector.<DamagePanelItemFrameStates> = new <DamagePanelItemFrameStates>[this.fuelTank,this.engine,this.hullBase];
         if(this.rightTrack != null)
         {
            _loc1_.push(this.rightTrack);
         }
         if(this.leftTrack != null)
         {
            _loc1_.push(this.leftTrack);
         }
         if(this.ammoBay != null)
         {
            _loc1_.push(this.ammoBay);
         }
         return _loc1_;
      }
      
      public function setYawLimits(param1:Array) : void
      {
         var _loc2_:Number = NaN;
         var _loc3_:Number = NaN;
         if(param1 != null && param1.length > 0)
         {
            _loc2_ = param1[LEFT_PARAM_IDX];
            _loc3_ = param1[RIGHT_PARAM_IDX];
            this.leftGunConstraint.rotation = -_loc2_;
            this.rightGunConstraint.rotation = _loc3_;
            this.leftGunConstraint.visible = true;
            this.rightGunConstraint.visible = true;
         }
         else
         {
            this.leftGunConstraint.visible = false;
            this.rightGunConstraint.visible = false;
         }
      }
      
      public function showTurretConstraintDisabled() : void
      {
         this.yawChangeColor(this.leftGunConstraint,0);
         this.yawChangeColor(this.rightGunConstraint,0);
      }
      
      public function showTurretConstraintEnabled() : void
      {
         this.yawChangeColor(this.leftGunConstraint,YAW_ORANGE_COLOR);
         this.yawChangeColor(this.rightGunConstraint,YAW_ORANGE_COLOR);
      }
      
      public function set hasYoh(param1:Boolean) : void
      {
         this._hasYoh = param1;
         if(this.leftTrack)
         {
            this.leftTrack.alwaysVisible = this._hasYoh;
         }
         if(this.rightTrack)
         {
            this.rightTrack.alwaysVisible = this._hasYoh;
         }
      }
      
      private function calculateYohModuleState(param1:String, param2:String) : String
      {
         var _loc3_:String = Values.EMPTY_STR;
         var _loc4_:String = VehicleModules.TRACK_MAIN;
         if(VehicleModules.isLeftTrack(param1))
         {
            _loc3_ = VehicleModules.getLeftTrackName(param1);
            _loc4_ = VehicleModules.getLeftTrackType(param1);
         }
         else
         {
            if(!VehicleModules.isRightTrack(param1))
            {
               return param2;
            }
            _loc3_ = VehicleModules.getRightTrackName(param1);
            _loc4_ = VehicleModules.getRightTrackType(param1);
         }
         var _loc5_:String = PREFIX + _loc4_ + _loc3_ + POSTFIX;
         this[_loc5_] = param2;
         var _loc6_:String = param2;
         if(_loc3_ == VehicleModules.LEFT_TRACK)
         {
            param2 = this._mainleftTrackState + MAIN_SUBFIX + this._secondleftTrackState + SECOND_POSTFIX;
         }
         else
         {
            param2 = this._mainrightTrackState + MAIN_SUBFIX + this._secondrightTrackState + SECOND_POSTFIX;
         }
         if(_loc6_ == BATTLE_ITEM_STATES.REPAIRED)
         {
            this[_loc5_] = BATTLE_ITEM_STATES.CRITICAL;
         }
         return param2;
      }
      
      private function yawChangeColor(param1:Sprite, param2:int) : void
      {
         var _loc3_:ColorTransform = param1.transform.colorTransform;
         _loc3_.color = param2;
         param1.transform.colorTransform = _loc3_;
      }
   }
}
