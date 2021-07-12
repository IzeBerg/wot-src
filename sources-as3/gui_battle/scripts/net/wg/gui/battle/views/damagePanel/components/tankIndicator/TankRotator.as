package net.wg.gui.battle.views.damagePanel.components.tankIndicator
{
   import flash.display.Sprite;
   import flash.geom.ColorTransform;
   import net.wg.gui.battle.views.damagePanel.components.DamagePanelItemFrameStates;
   
   public class TankRotator extends ItemWithModules
   {
      
      private static const YAW_ORANGE_COLOR:int = 16082954;
      
      private static const LEFT_PARAM_IDX:int = 0;
      
      private static const RIGHT_PARAM_IDX:int = 1;
       
      
      public var leftGunConstraint:Sprite;
      
      public var rightGunConstraint:Sprite;
      
      public var fuelTank:DamagePanelItemFrameStates;
      
      public var rightTrack:DamagePanelItemFrameStates;
      
      public var leftTrack:DamagePanelItemFrameStates;
      
      public var engine:DamagePanelItemFrameStates;
      
      public var hullBase:DamagePanelItemFrameStates;
      
      public function TankRotator()
      {
         super();
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
      
      private function yawChangeColor(param1:Sprite, param2:int) : void
      {
         var _loc3_:ColorTransform = param1.transform.colorTransform;
         _loc3_.color = param2;
         param1.transform.colorTransform = _loc3_;
      }
   }
}
