package net.wg.gui.battle.views.minimap.components.entries.epic
{
   import flash.display.Sprite;
   import net.wg.data.constants.generated.ATLAS_CONSTANTS;
   import net.wg.gui.battle.components.BattleUIComponent;
   import net.wg.gui.battle.views.minimap.components.entries.constants.EpicMinimapEntryConst;
   import net.wg.infrastructure.managers.IAtlasManager;
   
   public class FrontLinePointEntry extends BattleUIComponent
   {
      
      private static const LASTLIT_TEAMKILLER:String = "lastlit_teamKiller_blue";
      
      private static const LASTLIT_ENEMY:String = "lastlit_enemy_purple";
      
      private static const LASTLIT_ALLY:String = "lastlit_squadman_yellow";
       
      
      public var atlasPlaceholder:Sprite = null;
      
      private var _atlasManager:IAtlasManager;
      
      public function FrontLinePointEntry()
      {
         this._atlasManager = App.atlasMgr;
         super();
      }
      
      override protected function onDispose() : void
      {
         this.atlasPlaceholder = null;
         this._atlasManager = null;
         super.onDispose();
      }
      
      public function setMarkerType(param1:int) : void
      {
         switch(param1)
         {
            case 0:
               this._atlasManager.drawGraphics(ATLAS_CONSTANTS.BATTLE_ATLAS,LASTLIT_TEAMKILLER,this.atlasPlaceholder.graphics,EpicMinimapEntryConst.EMPTY_DOUBLE_STR,true);
               break;
            case 1:
               this._atlasManager.drawGraphics(ATLAS_CONSTANTS.BATTLE_ATLAS,LASTLIT_ENEMY,this.atlasPlaceholder.graphics,EpicMinimapEntryConst.EMPTY_DOUBLE_STR,true);
               break;
            case 2:
               this._atlasManager.drawGraphics(ATLAS_CONSTANTS.BATTLE_ATLAS,LASTLIT_ALLY,this.atlasPlaceholder.graphics,EpicMinimapEntryConst.EMPTY_DOUBLE_STR,true);
         }
      }
   }
}
