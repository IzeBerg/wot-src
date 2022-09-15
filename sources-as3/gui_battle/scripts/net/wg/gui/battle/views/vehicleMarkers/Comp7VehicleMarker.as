package net.wg.gui.battle.views.vehicleMarkers
{
   import flash.display.MovieClip;
   import net.wg.data.constants.generated.BATTLE_MARKERS_CONSTS;
   import net.wg.gui.battle.views.vehicleMarkers.VO.CrossOffset;
   import org.idmedia.as3commons.util.StringUtils;
   
   public class Comp7VehicleMarker extends VehicleMarker
   {
      
      private static const ROLE_NAME:String = "RoleName";
      
      private static const ROLE_SKILL_LEVEL:String = "RoleSkillLevel";
      
      private static const ERROR_MODEL_NULL:String = "ERROR: Model is NULL";
      
      private static const ROLE_SKILL_TO_MARKER_OFFSET_Y:int = 11;
      
      private static const ROLE_SKILL_TO_HP_OFFSET_Y:int = -9;
      
      private static const ACTION_MARKER_OFFSET_Y:int = -35;
      
      private static const HP_LABEL_IDX:int = 1;
      
      private static const ACTION_MARKER_IDX:int = 9;
      
      private static const INV_ROLE_NAME:uint = 1 << 18;
      
      private static const INV_ROLE_SKILL:uint = 1 << 19;
      
      private static const INV_PLAYER_LOADED:uint = 1 << 20;
      
      private static const PLAYER_NOT_LOADED_ALPHA:Number = 0.5;
      
      private static const ROLE_X_BY_TYPE:Object = {};
      
      private static const ROLE_Y_BY_TYPE:Object = {};
      
      private static const ROLE_ICON_OFFSET_Y:int = 18;
      
      {
         ROLE_X_BY_TYPE[BATTLE_MARKERS_CONSTS.VEHICLE_TYPE_AT_SPG] = -3;
         ROLE_X_BY_TYPE[BATTLE_MARKERS_CONSTS.VEHICLE_TYPE_MEDIUM_AT_SPG] = -3;
         ROLE_X_BY_TYPE[BATTLE_MARKERS_CONSTS.VEHICLE_TYPE_HEAVY_AT_SPG] = -2;
         ROLE_X_BY_TYPE[BATTLE_MARKERS_CONSTS.VEHICLE_TYPE_SPG] = -6;
         ROLE_X_BY_TYPE[BATTLE_MARKERS_CONSTS.VEHICLE_TYPE_MEDIUM_SPG] = -2;
         ROLE_X_BY_TYPE[BATTLE_MARKERS_CONSTS.VEHICLE_TYPE_HEAVY_SPG] = -3;
         ROLE_X_BY_TYPE[BATTLE_MARKERS_CONSTS.VEHICLE_TYPE_LIGHT_TANK] = -3;
         ROLE_X_BY_TYPE[BATTLE_MARKERS_CONSTS.VEHICLE_TYPE_MEDIUM_TANK] = -3;
         ROLE_X_BY_TYPE[BATTLE_MARKERS_CONSTS.VEHICLE_TYPE_HEAVY_TANK] = -1;
         ROLE_Y_BY_TYPE[BATTLE_MARKERS_CONSTS.VEHICLE_TYPE_AT_SPG] = -5;
         ROLE_Y_BY_TYPE[BATTLE_MARKERS_CONSTS.VEHICLE_TYPE_MEDIUM_AT_SPG] = 3;
         ROLE_Y_BY_TYPE[BATTLE_MARKERS_CONSTS.VEHICLE_TYPE_HEAVY_AT_SPG] = 5;
         ROLE_Y_BY_TYPE[BATTLE_MARKERS_CONSTS.VEHICLE_TYPE_SPG] = -9;
         ROLE_Y_BY_TYPE[BATTLE_MARKERS_CONSTS.VEHICLE_TYPE_MEDIUM_SPG] = 4;
         ROLE_Y_BY_TYPE[BATTLE_MARKERS_CONSTS.VEHICLE_TYPE_HEAVY_SPG] = 5;
         ROLE_Y_BY_TYPE[BATTLE_MARKERS_CONSTS.VEHICLE_TYPE_LIGHT_TANK] = -4;
         ROLE_Y_BY_TYPE[BATTLE_MARKERS_CONSTS.VEHICLE_TYPE_MEDIUM_TANK] = -2;
         ROLE_Y_BY_TYPE[BATTLE_MARKERS_CONSTS.VEHICLE_TYPE_HEAVY_TANK] = 4;
      }
      
      public var roleIcon:MovieClip;
      
      public var roleSkillLevel:MovieClip;
      
      private var _hasRole:Boolean = false;
      
      public function Comp7VehicleMarker()
      {
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         marker.vehicleTypeIcon.addChild(this.roleIcon);
         this.roleIcon.visible = false;
         this.roleSkillLevel.visible = false;
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(INV_ROLE_NAME))
         {
            this.updateRoleIconPosition();
         }
         if(isInvalid(INV_ROLE_SKILL))
         {
            this.redrawRoleSkill();
         }
         if(isInvalid(INV_PLAYER_LOADED))
         {
            this.updatePlayerLoadedStatus();
         }
      }
      
      override protected function onDispose() : void
      {
         this.roleIcon = null;
         this.roleSkillLevel = null;
         super.onDispose();
      }
      
      override protected function prepareOffsets() : void
      {
         super.prepareOffsets();
         offsets.unshift(0);
      }
      
      override protected function initialDrawParts() : void
      {
         super.initialDrawParts();
         if(this._hasRole)
         {
            vmManager.drawGraphics(model.roleName,this.roleIcon.graphics);
         }
      }
      
      override protected function onSpeakingUpdate() : void
      {
         super.onSpeakingUpdate();
         this.roleIcon.visible = this.getRoleIconVisibility();
      }
      
      override protected function redrawParts() : void
      {
         super.redrawParts();
         this.redrawRoleSkill();
      }
      
      override protected function prepareParts() : Array
      {
         var _loc1_:Array = super.prepareParts();
         _loc1_.unshift(this.roleSkillLevel);
         return _loc1_;
      }
      
      override protected function prepareCrossOffsets() : Array
      {
         var _loc1_:Array = null;
         _loc1_ = super.prepareCrossOffsets();
         _loc1_.unshift(null);
         var _loc2_:CrossOffset = _loc1_[HP_LABEL_IDX] as CrossOffset;
         if(_loc2_)
         {
            _loc2_.appendOffset(this.roleSkillLevel,ROLE_SKILL_TO_HP_OFFSET_Y);
         }
         else
         {
            _loc1_[HP_LABEL_IDX] = new CrossOffset(this.roleSkillLevel,ROLE_SKILL_TO_HP_OFFSET_Y);
         }
         var _loc3_:CrossOffset = _loc1_[ACTION_MARKER_IDX] as CrossOffset;
         if(_loc3_)
         {
            _loc3_.appendOffset(statusContainer,ACTION_MARKER_OFFSET_Y);
         }
         return _loc1_;
      }
      
      override protected function updatePartsVisibility() : Vector.<Boolean>
      {
         var _loc1_:Vector.<Boolean> = null;
         _loc1_ = super.updatePartsVisibility();
         var _loc2_:Boolean = this.getRoleSkillVisible();
         _loc1_.unshift(_loc2_);
         this.roleSkillLevel.visible = _loc2_;
         var _loc3_:Boolean = this.getRoleIconVisibility();
         if(_loc3_)
         {
            this.updateRoleIconPosition();
         }
         this.roleIcon.visible = _loc3_;
         return _loc1_;
      }
      
      override protected function getStartY() : int
      {
         return super.getStartY() + (!!this.getRoleSkillVisible() ? ROLE_SKILL_TO_MARKER_OFFSET_Y : 0);
      }
      
      public function setIsPlayerLoaded(param1:Boolean) : void
      {
         if(this.checkModelExists())
         {
            model.isPlayerLoaded = param1;
            invalidate(INV_PLAYER_LOADED);
         }
      }
      
      public function setRoleName(param1:String) : void
      {
         if(this.checkModelExists())
         {
            model.roleName = param1;
            this._hasRole = StringUtils.isNotEmpty(param1);
            invalidate(INV_ROLE_NAME);
         }
      }
      
      public function setRoleSkillLevel(param1:int) : void
      {
         if(this.checkModelExists())
         {
            model.roleSkillLevel = param1;
            invalidate(INV_ROLE_SKILL);
         }
      }
      
      private function getRoleIconVisibility() : Boolean
      {
         if(isStickyAndOutOfScreen || !vehicleDestroyed && model && model.speaking)
         {
            return false;
         }
         return this._hasRole && getIsPartVisible(ROLE_NAME);
      }
      
      private function getRoleSkillVisible() : Boolean
      {
         return this._hasRole && !isEnemy() && getIsPartVisible(ROLE_SKILL_LEVEL) && getHpBarOrLabelVisible();
      }
      
      private function getRoleOffsetY() : int
      {
         if(this.checkModelExists() && StringUtils.isNotEmpty(model.vClass))
         {
            return ROLE_Y_BY_TYPE[model.vClass];
         }
         return 0;
      }
      
      private function getRoleOffsetX() : int
      {
         if(this.checkModelExists() && StringUtils.isNotEmpty(model.vClass))
         {
            return ROLE_X_BY_TYPE[model.vClass];
         }
         return 0;
      }
      
      private function updateRoleIconPosition() : void
      {
         this.roleIcon.x = this.getRoleOffsetX();
         this.roleIcon.y = this.getRoleOffsetY() + ROLE_ICON_OFFSET_Y;
      }
      
      private function redrawRoleSkill() : void
      {
         if(this.checkModelExists())
         {
            vmManager.drawWithCenterAlign(VMAtlasItemName.getRoleSkillLevelName(model.roleSkillLevel),this.roleSkillLevel.graphics,true,false);
         }
      }
      
      private function updatePlayerLoadedStatus() : void
      {
         var _loc1_:Number = NaN;
         if(this.checkModelExists())
         {
            _loc1_ = !!model.isPlayerLoaded ? Number(1) : Number(PLAYER_NOT_LOADED_ALPHA);
            vehicleNameField.alpha = _loc1_;
            playerNameField.alpha = _loc1_;
            marker.alpha = _loc1_;
            this.roleIcon.alpha = _loc1_;
         }
      }
      
      private function checkModelExists() : Boolean
      {
         if(!model)
         {
            return false;
         }
         return true;
      }
   }
}
