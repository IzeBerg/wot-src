package net.wg.gui.battle.commander.views.spawnMenu.map.entries
{
   import net.wg.data.constants.generated.BATTLEATLAS;
   import net.wg.gui.battle.commander.views.spawnMenu.map.VO.BasePointEntryVO;
   import net.wg.gui.battle.views.minimap.components.entries.constants.TeamBaseMinimapEntryConst;
   import net.wg.gui.battle.views.minimap.constants.MinimapColorConst;
   import net.wg.infrastructure.interfaces.IColorScheme;
   
   public class BasePointEntry extends ControlPointEntry
   {
       
      
      public function BasePointEntry()
      {
         super();
      }
      
      override protected function drawEntry() : void
      {
         point.icon.setImageNames(this.pointTeam + _ICON_SEPARATOR + this.schemePointColor + _ICON_SEPARATOR + this.basePointData.baseID,BATTLEATLAS.UNKNOWN);
      }
      
      override protected function get pointTeam() : String
      {
         return !!this.basePointData.isPlayerTeam ? TeamBaseMinimapEntryConst.ALLY_TEAM_BASE_ATLAS_ITEM_NAME : TeamBaseMinimapEntryConst.ENEMY_TEAM_BASE_ATLAS_ITEM_NAME;
      }
      
      public function get basePointData() : BasePointEntryVO
      {
         return data as BasePointEntryVO;
      }
      
      protected function get schemePointColor() : String
      {
         var _loc1_:String = this.pointColor;
         var _loc2_:IColorScheme = App.colorSchemeMgr.getScheme(this.pointColor);
         if(_loc2_.aliasColor)
         {
            _loc1_ = _loc2_.aliasColor;
         }
         return _loc1_;
      }
      
      protected function get pointColor() : String
      {
         return !!this.basePointData.isPlayerTeam ? MinimapColorConst.GREEN : MinimapColorConst.RED;
      }
   }
}
