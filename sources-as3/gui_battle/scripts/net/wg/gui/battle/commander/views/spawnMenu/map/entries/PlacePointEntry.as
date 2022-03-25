package net.wg.gui.battle.commander.views.spawnMenu.map.entries
{
   import flash.display.MovieClip;
   import net.wg.data.constants.InvalidationType;
   import net.wg.data.constants.SoundTypes;
   import net.wg.data.constants.generated.RTS_SUPPLY_TYPE;
   import net.wg.gui.battle.commander.views.spawnMenu.map.VO.PlacePointEntryVO;
   import net.wg.gui.battle.commander.views.spawnMenu.map.entries.components.VehicleType;
   import net.wg.gui.battle.commander.views.spawnMenu.map.entries.components.VisionRadius;
   
   public class PlacePointEntry extends BaseEntry
   {
      
      private static const _FOCUSED_FRAME:String = "hover";
      
      private static const _UNFOCUSED_FRAME:String = "default";
       
      
      public var vehicleType:VehicleType = null;
      
      public var point:MovieClip = null;
      
      private var _visionRadius:VisionRadius;
      
      public function PlacePointEntry()
      {
         this._visionRadius = new VisionRadius();
         super();
         addChild(this._visionRadius);
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         soundType = SoundTypes.RTS_SPAWN_MENU_PLACE_POINT_ENTRY;
         this.vehicleType.isPlace = true;
      }
      
      override protected function onDispose() : void
      {
         this.vehicleType.dispose();
         this.vehicleType = null;
         this.point = null;
         this._visionRadius.dispose();
         removeChild(this._visionRadius);
         this._visionRadius = null;
         super.onDispose();
      }
      
      override protected function draw() : void
      {
         var _loc2_:String = null;
         super.draw();
         var _loc1_:PlacePointEntryVO = data as PlacePointEntryVO;
         if(_loc1_ && isInvalid(InvalidationType.DATA))
         {
            this.vehicleType.vehicleType = _loc1_.vehicleType;
            if(RTS_SUPPLY_TYPE.ALL.indexOf(_loc1_.vehicleType) != -1)
            {
               if(_loc1_.yawLeftLimit != 0 && _loc1_.yawRightLimit != 0)
               {
                  this._visionRadius.setUseConeRadius(true);
                  this._visionRadius.setConeAngles(_loc1_.yawLeftLimit,_loc1_.yawRightLimit);
               }
               else
               {
                  this._visionRadius.setUseConeRadius(false);
               }
               this._visionRadius.setRadius(_loc1_.visionRadius,_loc1_.engagementRadius);
            }
            else
            {
               this._visionRadius.visible = false;
            }
         }
         if(isInvalid(InvalidationType.STATE))
         {
            this.vehicleType.isHovered = isFocusedVisually;
            this.vehicleType.isSelected = isSelected;
            if(isFocusedVisually)
            {
               _loc2_ = _FOCUSED_FRAME;
            }
            else if(isSelected)
            {
               _loc2_ = _UNFOCUSED_FRAME;
            }
            else
            {
               _loc2_ = _UNFOCUSED_FRAME;
            }
            this._visionRadius.setState(isFocused,isSelected);
            this.point.gotoAndStop(_loc2_);
         }
      }
      
      override public function get isSoundEnabled() : Boolean
      {
         return true;
      }
      
      override public function get visionRadius() : VisionRadius
      {
         return this._visionRadius;
      }
   }
}
