package net.wg.gui.battle.views.minimap.components.entries.teambase
{
   import flash.display.Sprite;
   import net.wg.data.constants.generated.ATLAS_CONSTANTS;
   import net.wg.gui.battle.components.BattleUIComponent;
   import net.wg.gui.battle.views.minimap.MinimapEntryController;
   import net.wg.gui.battle.views.minimap.components.entries.constants.TeamBaseMinimapEntryConst;
   import net.wg.gui.battle.views.minimap.constants.MinimapColorConst;
   import net.wg.infrastructure.events.ColorSchemeEvent;
   import net.wg.infrastructure.managers.IAtlasManager;
   
   public class EnemyTeamSpawnMinimapEntry extends BattleUIComponent
   {
       
      
      private var _pointNumber:int = -1;
      
      public var atlasPlaceholder:Sprite = null;
      
      private var _atlasManager:IAtlasManager;
      
      public function EnemyTeamSpawnMinimapEntry()
      {
         this._atlasManager = App.atlasMgr;
         super();
         MinimapEntryController.instance.registerScalableEntry(this);
         mouseEnabled = mouseChildren = false;
      }
      
      override protected function configUI() : void
      {
         App.colorSchemeMgr.addEventListener(ColorSchemeEvent.SCHEMAS_UPDATED,this.onColorSchemeChangeHandler);
      }
      
      public function setPointNumber(param1:int) : void
      {
         this._pointNumber = param1;
         this.drawEntry();
      }
      
      private function drawEntry() : void
      {
         this._atlasManager.drawGraphics(ATLAS_CONSTANTS.BATTLE_ATLAS,TeamBaseMinimapEntryConst.ENEMY_TEAM_SPAWN_ATLAS_ITEM_NAME + "_" + App.colorSchemeMgr.getScheme(MinimapColorConst.TEAM_SPAWN_BASE_RED).aliasColor + "_" + this._pointNumber,this.atlasPlaceholder.graphics,"",true);
      }
      
      private function onColorSchemeChangeHandler(param1:ColorSchemeEvent) : void
      {
         this.drawEntry();
      }
      
      override protected function onDispose() : void
      {
         MinimapEntryController.instance.unregisterScalableEntry(this);
         this.atlasPlaceholder = null;
         this._atlasManager = null;
         App.colorSchemeMgr.removeEventListener(ColorSchemeEvent.SCHEMAS_UPDATED,this.onColorSchemeChangeHandler);
         super.onDispose();
      }
   }
}
