package net.wg.gui.battle.commander.views.spawnMenu.map.entries
{
   import net.wg.data.constants.InvalidationType;
   import net.wg.data.constants.generated.BATTLEATLAS;
   import net.wg.gui.battle.commander.views.spawnMenu.map.VO.ControlPointEntryVO;
   import net.wg.gui.battle.commander.views.spawnMenu.map.entries.components.ControlPoint;
   import net.wg.gui.battle.views.minimap.components.entries.constants.TeamBaseMinimapEntryConst;
   
   public class ControlPointEntry extends BaseEntry
   {
      
      protected static const _ICON_SEPARATOR:String = "_";
       
      
      public var point:ControlPoint = null;
      
      public function ControlPointEntry()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         this.point = null;
         super.onDispose();
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(_INVALID_STAGE))
         {
            this.point.icon.isSmoothingEnabled = true;
            this.point.icon.isCentralize = true;
         }
         if(isInvalid(_INVALID_STAGE | InvalidationType.DATA))
         {
            this.drawEntry();
         }
      }
      
      protected function drawEntry() : void
      {
         this.point.icon.setImageNames(this.pointTeam + _ICON_SEPARATOR + this.controlPointData.baseID,BATTLEATLAS.UNKNOWN);
      }
      
      override public function get isSelectable() : Boolean
      {
         return false;
      }
      
      public function get controlPointData() : ControlPointEntryVO
      {
         return data as ControlPointEntryVO;
      }
      
      protected function get pointTeam() : String
      {
         if(this.controlPointData.baseID == 0)
         {
            return TeamBaseMinimapEntryConst.CONTROL_POINT_ATLAS_ITEM_NAME;
         }
         return TeamBaseMinimapEntryConst.COMMANDER_CONTROL_POINT_ATLAS_ITEM_NAME;
      }
   }
}
