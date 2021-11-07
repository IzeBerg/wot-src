package net.wg.gui.battle.views.minimap.components.entries.background
{
   import flash.display.Sprite;
   import net.wg.data.constants.generated.ATLAS_CONSTANTS;
   import net.wg.gui.battle.components.BattleUIComponent;
   import net.wg.gui.battle.views.minimap.components.entries.constants.BackgroundMinimapEntryConst;
   import net.wg.infrastructure.managers.IAtlasManager;
   
   public class TutorialTargetMinimapEntry extends BattleUIComponent
   {
       
      
      public var atlasPlaceholder:Sprite = null;
      
      private var _atlasManager:IAtlasManager;
      
      public function TutorialTargetMinimapEntry()
      {
         this._atlasManager = App.atlasMgr;
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this._atlasManager.drawGraphics(ATLAS_CONSTANTS.BATTLE_ATLAS,BackgroundMinimapEntryConst.TURORIAL_ATLAS_ITEM_NAME,this.atlasPlaceholder.graphics,"",true);
      }
      
      override protected function onDispose() : void
      {
         this.atlasPlaceholder = null;
         this._atlasManager = null;
         super.onDispose();
      }
   }
}
