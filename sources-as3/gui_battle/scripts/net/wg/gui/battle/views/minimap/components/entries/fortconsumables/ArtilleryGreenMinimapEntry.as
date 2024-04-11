package net.wg.gui.battle.views.minimap.components.entries.fortconsumables
{
   import flash.display.Sprite;
   import net.wg.data.constants.generated.ATLAS_CONSTANTS;
   import net.wg.gui.battle.components.BattleUIComponent;
   import net.wg.gui.battle.views.minimap.components.entries.constants.EpicMinimapEntryConst;
   import net.wg.gui.battle.views.minimap.components.entries.constants.FortConsumablesMinimapEntryConst;
   import net.wg.infrastructure.managers.IAtlasManager;
   
   public class ArtilleryGreenMinimapEntry extends BattleUIComponent
   {
       
      
      public var atlasPlaceholder:Sprite = null;
      
      private var _atlasManager:IAtlasManager;
      
      public function ArtilleryGreenMinimapEntry()
      {
         this._atlasManager = App.atlasMgr;
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this._atlasManager.drawGraphics(ATLAS_CONSTANTS.BATTLE_ATLAS,FortConsumablesMinimapEntryConst.ARTILLERY_GREEN_ATLAS_ITEM_NAME,this.atlasPlaceholder.graphics,EpicMinimapEntryConst.EMPTY_DOUBLE_STR,true);
      }
      
      override protected function onDispose() : void
      {
         this.atlasPlaceholder = null;
         this._atlasManager = null;
         super.onDispose();
      }
   }
}
