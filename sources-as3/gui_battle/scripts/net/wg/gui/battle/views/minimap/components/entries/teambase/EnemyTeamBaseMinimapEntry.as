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
      
      private static const DIVIDE_100:Number = 0.01;
      
      private static const CAPTURE_ALPHA:Number = 0.7;
       
      
      public var atlasPlaceholder:Sprite = null;
      
      public var marker:MinimapProgressCircle = null;
      
      private var _pointNumber:int = -1;
      
      private var _atlasManager:IAtlasManager;
      
      public function EnemyTeamBaseMinimapEntry()
      {
         this._atlasManager = App.atlasMgr;
         super();
         this.marker.visible = false;
         this.marker.setIsAlly(true);
         MinimapEntryController.instance.registerScalableEntry(this);
         this.checkForColorBlindMode();
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
         this.marker.dispose();
         this.marker = null;
         App.colorSchemeMgr.removeEventListener(ColorSchemeEvent.SCHEMAS_UPDATED,this.onColorSchemeMgrSchemasUpdatedHandler);
         super.onDispose();
      }
      
      public function setPointNumber(param1:int) : void
      {
         this._pointNumber = param1;
         this.drawEntry();
         App.colorSchemeMgr.addEventListener(ColorSchemeEvent.SCHEMAS_UPDATED,this.onColorSchemeMgrSchemasUpdatedHandler);
      }
      
      public function setProgress(param1:int) : void
      {
         this.atlasPlaceholder.alpha = param1 > 0 ? Number(CAPTURE_ALPHA) : Number(1);
         this.marker.visible = param1 > 0;
         this.marker.updateProgress(param1 * DIVIDE_100);
      }
      
      private function drawEntry() : void
      {
         this._atlasManager.drawGraphics(ATLAS_CONSTANTS.BATTLE_ATLAS,TeamBaseMinimapEntryConst.ENEMY_TEAM_BASE_ATLAS_ITEM_NAME + "_" + App.colorSchemeMgr.getScheme(MinimapColorConst.TEAM_POINT_BASE_RED).aliasColor + "_" + this._pointNumber,this.atlasPlaceholder.graphics,"",true);
      }
      
      private function checkForColorBlindMode() : void
      {
         gotoAndStop(!!App.colorSchemeMgr.getIsColorBlindS() ? COLOR_BLIND_FRAME : NORMAL_COLOR_FRAME);
      }
      
      private function onColorSchemeMgrSchemasUpdatedHandler(param1:ColorSchemeEvent) : void
      {
         this.drawEntry();
         storeFrameAnimations();
         this.checkForColorBlindMode();
         setState(getCurrentState(),false);
      }
   }
}
