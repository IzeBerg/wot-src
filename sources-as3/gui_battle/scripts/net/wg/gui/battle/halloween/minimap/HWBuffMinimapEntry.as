package net.wg.gui.battle.halloween.minimap
{
   import flash.display.Sprite;
   import net.wg.data.constants.Values;
   import net.wg.data.constants.generated.ATLAS_CONSTANTS;
   import net.wg.data.constants.generated.BATTLEATLAS;
   import net.wg.gui.battle.components.BattleUIComponent;
   import net.wg.infrastructure.managers.IAtlasManager;
   
   public class HWBuffMinimapEntry extends BattleUIComponent
   {
       
      
      public var atlasPlaceholder:Sprite = null;
      
      private var _atlasManager:IAtlasManager;
      
      public function HWBuffMinimapEntry()
      {
         this._atlasManager = App.atlasMgr;
         super();
      }
      
      override protected function onDispose() : void
      {
         this._atlasManager = null;
         this.atlasPlaceholder = null;
         super.onDispose();
      }
      
      public function setIsSpawned(param1:Boolean) : void
      {
         this._atlasManager.drawGraphics(ATLAS_CONSTANTS.BATTLE_ATLAS,!!param1 ? BATTLEATLAS.MINIMAP_LANTERN_SPAWNED : BATTLEATLAS.MINIMAP_LANTERN,this.atlasPlaceholder.graphics,Values.EMPTY_STR,true);
      }
   }
}
