package net.wg.gui.battle.commander.views.spawnMenu.renderers
{
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.text.TextField;
   import net.wg.data.constants.InvalidationType;
   import net.wg.data.constants.generated.RTS_SPAWN_MENU_ENTRY_TYPES;
   import net.wg.gui.battle.commander.views.spawnMenu.VO.RosterVehicleVO;
   import net.wg.gui.battle.commander.views.spawnMenu.items.components.AllyVehicleNationIcon;
   import net.wg.gui.battle.commander.views.spawnMenu.items.components.VehicleTypeProxy;
   
   public class RosterVehicleRenderer extends BaseRosterRenderer
   {
       
      
      public var vehicleType:VehicleTypeProxy = null;
      
      public var nationIcon:AllyVehicleNationIcon = null;
      
      public var nationIconMask:Sprite = null;
      
      public var groupTF:TextField = null;
      
      public var groupBg:MovieClip = null;
      
      public function RosterVehicleRenderer()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         this.vehicleType.dispose();
         this.vehicleType = null;
         this.nationIcon.dispose();
         this.nationIcon = null;
         this.groupTF = null;
         this.groupBg = null;
         this.nationIconMask = null;
         super.onDispose();
      }
      
      override protected function draw() : void
      {
         var _loc1_:RosterVehicleVO = null;
         super.draw();
         if(isInvalid(_INVALID_STAGE))
         {
            this.vehicleType.icon.isAlive = true;
            this.vehicleType.icon.isAlly = isAllyRenderer;
            this.nationIcon.mask = this.nationIconMask;
         }
         _loc1_ = this.vehicleData;
         if(_loc1_ && isInvalid(_INVALID_STAGE | InvalidationType.DATA))
         {
            this.vehicleType.icon.vehicleType = roosterData.vehicleType;
            this.groupTF.text = _loc1_.groupID.toString();
            this.groupTF.visible = this.groupBg.visible = isAllyRenderer;
            this.nationIcon.flagsMC.gotoAndStop(_loc1_.nation);
            background.visible = isAllyRenderer;
         }
      }
      
      public function get vehicleData() : RosterVehicleVO
      {
         return roosterData as RosterVehicleVO;
      }
      
      override public function get itemID() : String
      {
         return this.vehicleData.vehicleID.toString();
      }
      
      override public function get vehicleID() : Number
      {
         return this.vehicleData.vehicleID;
      }
      
      override public function get entryType() : int
      {
         return RTS_SPAWN_MENU_ENTRY_TYPES.ALLY_VEHICLE;
      }
      
      override protected function get canSelect() : Boolean
      {
         return super.canSelect && isAllyRenderer;
      }
      
      override public function get isFocused() : Boolean
      {
         return super.isFocused && isAllyRenderer;
      }
      
      override public function get isSelectable() : Boolean
      {
         return super.isSelectable && isAllyRenderer;
      }
   }
}
