package net.wg.gui.battle.views.minimap.components.entries.vehicle
{
   import flash.display.Sprite;
   import net.wg.data.constants.generated.ATLAS_CONSTANTS;
   import net.wg.gui.battle.components.BattleUIComponent;
   import net.wg.infrastructure.managers.IAtlasManager;
   
   public class VehicleAnimationMinimapEntry extends BattleUIComponent
   {
       
      
      public var atlasContainer:Sprite = null;
      
      private var _atlasManager:IAtlasManager;
      
      public function VehicleAnimationMinimapEntry()
      {
         this._atlasManager = App.atlasMgr;
         super();
      }
      
      override protected function onDispose() : void
      {
         this._atlasManager = null;
         this.atlasContainer = null;
         super.onDispose();
      }
      
      public function drawEntry(param1:String) : void
      {
         this._atlasManager.drawGraphics(ATLAS_CONSTANTS.BATTLE_ATLAS,param1,this.atlasContainer.graphics,"",true);
      }
   }
}
