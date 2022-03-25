package net.wg.gui.battle.commander.views.spawnMenu.map.entries
{
   import flash.display.MovieClip;
   import net.wg.data.constants.InvalidationType;
   import net.wg.data.constants.SoundTypes;
   import net.wg.gui.battle.commander.views.spawnMenu.map.VO.VehicleEntryVO;
   import net.wg.gui.battle.commander.views.spawnMenu.map.entries.components.VehicleType;
   
   public class VehicleEntry extends BaseEntry
   {
       
      
      public var selectionRect:MovieClip = null;
      
      public var vehicleType:VehicleType = null;
      
      public function VehicleEntry()
      {
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         soundType = SoundTypes.RTS_SPAWN_MENU_VEHICLE_ENTRY;
         this.selectionRect.visible = false;
         this.vehicleType.isInstalled = true;
      }
      
      override protected function onDispose() : void
      {
         this.selectionRect = null;
         this.vehicleType.dispose();
         this.vehicleType = null;
         super.onDispose();
      }
      
      override protected function draw() : void
      {
         super.draw();
         var _loc1_:VehicleEntryVO = this.vehicleData;
         if(_loc1_ && isInvalid(InvalidationType.DATA))
         {
            isSelected = _loc1_.isSelected;
            this.processSelection();
            this.vehicleType.vehicleType = _loc1_.vehicleType;
            this.vehicleType.vehicleName = _loc1_.vehicleName;
         }
         if(isInvalid(InvalidationType.DATA | InvalidationType.STATE))
         {
            this.processSelection();
            this.vehicleType.isHovered = isFocusedVisually || isSelected;
         }
      }
      
      private function processSelection() : void
      {
         if(this.selectionRect.visible != isSelected)
         {
            this.selectionRect.visible = isSelected;
            if(this.selectionRect.visible)
            {
               this.selectionRect.gotoAndPlay(0);
            }
         }
      }
      
      override public function get itemID() : String
      {
         return this.vehicleID.toString();
      }
      
      override public function get vehicleID() : Number
      {
         return this.vehicleData.vehicleID;
      }
      
      override public function get isSoundEnabled() : Boolean
      {
         return true;
      }
      
      public function get vehicleData() : VehicleEntryVO
      {
         return data as VehicleEntryVO;
      }
   }
}
