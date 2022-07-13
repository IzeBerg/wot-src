package net.wg.gui.battle.views.minimap.components.entries.fortconsumables
{
   import flash.display.Sprite;
   import net.wg.data.constants.Values;
   import net.wg.data.constants.generated.ATLAS_CONSTANTS;
   import net.wg.gui.battle.components.BattleUIComponent;
   import net.wg.gui.battle.views.minimap.components.entries.constants.FortConsumablesMinimapEntryConst;
   import net.wg.infrastructure.events.ColorSchemeEvent;
   import net.wg.infrastructure.managers.IAtlasManager;
   
   public class AOEArtilleryMinimapEntry extends BattleUIComponent
   {
       
      
      public var atlasPlaceholder:Sprite = null;
      
      private var _atlasManager:IAtlasManager;
      
      private var _isPlayerTeam:Boolean = true;
      
      public function AOEArtilleryMinimapEntry()
      {
         this._atlasManager = App.atlasMgr;
         super();
      }
      
      public function setOwningTeam(param1:Boolean) : void
      {
         this._isPlayerTeam = param1;
         if(this.atlasPlaceholder)
         {
            this.drawEntry();
         }
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.drawEntry();
         App.colorSchemeMgr.addEventListener(ColorSchemeEvent.SCHEMAS_UPDATED,this.onColorSchemeChangeHandler);
      }
      
      override protected function onDispose() : void
      {
         App.colorSchemeMgr.removeEventListener(ColorSchemeEvent.SCHEMAS_UPDATED,this.onColorSchemeChangeHandler);
         this.atlasPlaceholder = null;
         this._atlasManager = null;
         super.onDispose();
      }
      
      private function getAtlasItemName() : String
      {
         if(this._isPlayerTeam)
         {
            return FortConsumablesMinimapEntryConst.AOE_ARTILLERY_ALLY_ATLAS_ITEM_NAME;
         }
         if(App.colorSchemeMgr.getIsColorBlindS())
         {
            return FortConsumablesMinimapEntryConst.AOE_ARTILLERY_ENEMY_COLOR_BLIND_ATLAS_ITEM_NAME;
         }
         return FortConsumablesMinimapEntryConst.AOE_ARTILLERY_ENEMY_ATLAS_ITEM_NAME;
      }
      
      private function onColorSchemeChangeHandler(param1:ColorSchemeEvent) : void
      {
         this.drawEntry();
      }
      
      private function drawEntry() : void
      {
         this._atlasManager.drawGraphics(ATLAS_CONSTANTS.BATTLE_ATLAS,this.getAtlasItemName(),this.atlasPlaceholder.graphics,Values.EMPTY_STR,true);
      }
   }
}
