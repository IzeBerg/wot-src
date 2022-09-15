package net.wg.gui.battle.comp7.stats.components
{
   import flash.display.MovieClip;
   import net.wg.data.constants.InvalidationType;
   import net.wg.gui.battle.components.BattleUIComponent;
   import net.wg.gui.battle.views.vehicleMarkers.VehicleMarkersManager;
   import org.idmedia.as3commons.util.StringUtils;
   
   public class RoleSkillLevel extends BattleUIComponent
   {
      
      private static const INV_ROLE:uint = InvalidationType.SYSTEM_FLAGS_BORDER << 1;
      
      private static const INV_SKILL_LEVEL:uint = InvalidationType.SYSTEM_FLAGS_BORDER << 2;
       
      
      public var roleIcon:MovieClip = null;
      
      public var skillLevel:MovieClip = null;
      
      private var _role:String = null;
      
      private var _skillLevel:uint = 0;
      
      private var _isDisabled:Boolean = false;
      
      private var _vmManager:VehicleMarkersManager = null;
      
      public function RoleSkillLevel()
      {
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this._vmManager = VehicleMarkersManager.getInstance();
         this.skillLevel.mouseEnabled = false;
         this.skillLevel.mouseChildren = false;
         App.utils.commons.addEmptyHitArea(this.skillLevel);
      }
      
      override protected function onDispose() : void
      {
         this.roleIcon = null;
         this.skillLevel = null;
         this._vmManager = null;
         super.onDispose();
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(this._role != null && isInvalid(INV_ROLE))
         {
            this._vmManager.drawGraphics(this._role,this.roleIcon.graphics);
         }
         if(isInvalid(INV_SKILL_LEVEL))
         {
            if(!this._isDisabled)
            {
               this.skillLevel.gotoAndStop(Math.min(this._skillLevel + 1,this.skillLevel.totalFrames));
            }
            else
            {
               this.skillLevel.gotoAndStop(this.skillLevel.totalFrames);
            }
         }
      }
      
      public function getRole() : String
      {
         return this._role;
      }
      
      public function setIsDisabled(param1:Boolean) : void
      {
         if(param1 != this._isDisabled)
         {
            this._isDisabled = param1;
            invalidate(INV_SKILL_LEVEL);
         }
      }
      
      public function setRole(param1:String) : void
      {
         if(StringUtils.isNotEmpty(param1) && param1 != this._role)
         {
            this._role = param1;
            invalidate(INV_ROLE);
         }
      }
      
      public function setSkillLevel(param1:uint) : void
      {
         if(param1 != this._skillLevel)
         {
            this._skillLevel = param1;
            invalidate(INV_SKILL_LEVEL);
         }
      }
   }
}
