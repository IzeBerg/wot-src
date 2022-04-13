package net.wg.gui.battle.commander.views.spawnMenu.map.entries
{
   import net.wg.data.constants.InvalidationType;
   import net.wg.data.constants.generated.RTS_SUPPLY_TYPE;
   import net.wg.gui.battle.commander.views.spawnMenu.map.VO.VehicleEntryVO;
   import net.wg.gui.battle.commander.views.spawnMenu.map.entries.components.VisionRadius;
   
   public class SupplyEntry extends VehicleEntry
   {
       
      
      private var _visionRadius:VisionRadius;
      
      public function SupplyEntry()
      {
         this._visionRadius = new VisionRadius();
         super();
         addChild(this._visionRadius);
      }
      
      override protected function onDispose() : void
      {
         this._visionRadius.dispose();
         removeChild(this._visionRadius);
         this._visionRadius = null;
         super.onDispose();
      }
      
      override protected function draw() : void
      {
         super.draw();
         var _loc1_:VehicleEntryVO = vehicleData;
         if(_loc1_ && isInvalid(InvalidationType.DATA))
         {
            vehicleType.vehicleType = _loc1_.vehicleType;
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
            this._visionRadius.setState(isFocused,isSelected);
         }
      }
      
      override public function get itemID() : String
      {
         return vehicleData.vehicleType;
      }
      
      override public function get visionRadius() : VisionRadius
      {
         return this._visionRadius;
      }
   }
}
