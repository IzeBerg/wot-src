package net.wg.gui.battle.views.minimap.components.entries.comp7
{
   import flash.display.Sprite;
   import net.wg.data.constants.Values;
   import net.wg.data.constants.generated.ATLAS_CONSTANTS;
   import net.wg.data.constants.generated.COMP7_CONSTS;
   import net.wg.gui.battle.components.BattleUIComponent;
   import net.wg.infrastructure.managers.IAtlasManager;
   
   public class Comp7PointReconMinimapEntry extends BattleUIComponent
   {
       
      
      public var atlasPlaceholder:Sprite = null;
      
      private var _atlasManager:IAtlasManager;
      
      public function Comp7PointReconMinimapEntry()
      {
         this._atlasManager = App.atlasMgr;
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this._atlasManager.drawGraphics(ATLAS_CONSTANTS.BATTLE_ATLAS,COMP7_CONSTS.MINIMAP_ROLE_SKILL_POINT_RECON,this.atlasPlaceholder.graphics,Values.EMPTY_STR,true);
      }
      
      override protected function onDispose() : void
      {
         this.atlasPlaceholder = null;
         this._atlasManager = null;
         super.onDispose();
      }
   }
}
