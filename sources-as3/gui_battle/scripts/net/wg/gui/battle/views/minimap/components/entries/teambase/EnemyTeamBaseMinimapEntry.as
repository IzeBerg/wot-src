package net.wg.gui.battle.views.minimap.components.entries.teambase
{
   import flash.display.Sprite;
   import net.wg.data.constants.generated.ATLAS_CONSTANTS;
   import net.wg.gui.battle.views.minimap.MinimapEntryController;
   import net.wg.gui.battle.views.minimap.components.entries.constants.TeamBaseMinimapEntryConst;
   import net.wg.gui.battle.views.minimap.components.entries.personal.PingFlashMinimapEntry;
   import net.wg.gui.battle.views.minimap.constants.MinimapColorConst;
   import net.wg.infrastructure.events.ColorSchemeEvent;
   import net.wg.infrastructure.managers.IAtlasManager;
   
   public class EnemyTeamBaseMinimapEntry extends PingFlashMinimapEntry
   {
      
      private static const COLOR_BLIND_FRAME:int = 2;
      
      private static const NORMAL_COLOR_FRAME:int = 1;
       
      
      private var _pointNumber:int = -1;
      
      public var atlasPlaceholder:Sprite = null;
      
      private var _atlasManager:IAtlasManager;
      
      public function EnemyTeamBaseMinimapEntry()
      {
         this._atlasManager = App.atlasMgr;
         super();
         MinimapEntryController.instance.registerScalableEntry(this);
         this.checkForColorBlindMode();
         mouseEnabled = mouseChildren = false;
         this.atlasPlaceholder.mouseEnabled = this.atlasPlaceholder.mouseChildren = false;
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
      
      override protected function SetAtlasPlaceholderVisible(param1:Boolean) : void
      {
         if(this.atlasPlaceholder == null)
         {
            return;
         }
         this.atlasPlaceholder.visible = param1;
      }
      
      override protected function onDispose() : void
      {
         MinimapEntryController.instance.unregisterScalableEntry(this);
         this.atlasPlaceholder = null;
         this._atlasManager = null;
         App.colorSchemeMgr.removeEventListener(ColorSchemeEvent.SCHEMAS_UPDATED,this.onColorSchemeChangeHandler);
         super.onDispose();
      }
      
      private function drawEntry() : void
      {
         this._atlasManager.drawGraphics(ATLAS_CONSTANTS.BATTLE_ATLAS,TeamBaseMinimapEntryConst.ENEMY_TEAM_BASE_ATLAS_ITEM_NAME + "_" + App.colorSchemeMgr.getScheme(MinimapColorConst.TEAM_POINT_BASE_RED).aliasColor + "_" + this._pointNumber,this.atlasPlaceholder.graphics,"",true);
      }
      
      private function onColorSchemeChangeHandler(param1:ColorSchemeEvent) : void
      {
         this.drawEntry();
         storeFrameAnimations();
         this.checkForColorBlindMode();
         setState(getCurrentState(),false);
      }
      
      private function checkForColorBlindMode() : void
      {
         gotoAndStop(!!App.colorSchemeMgr.getIsColorBlindS() ? COLOR_BLIND_FRAME : NORMAL_COLOR_FRAME);
      }
   }
}
