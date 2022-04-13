package net.wg.gui.battle.views.minimap.components.entries.vehicle
{
   import flash.display.Sprite;
   import net.wg.data.constants.generated.ATLAS_CONSTANTS;
   import net.wg.gui.battle.components.BattleUIComponent;
   import net.wg.infrastructure.managers.IAtlasManager;
   
   public class VehicleAnimationMinimapEntry extends BattleUIComponent
   {
       
      
      private var _atlasManager:IAtlasManager;
      
      public var atlasContainer:Sprite = null;
      
      public function VehicleAnimationMinimapEntry()
      {
         this._atlasManager = App.atlasMgr;
         super();
         mouseEnabled = mouseChildren = false;
         this.atlasContainer.mouseEnabled = this.atlasContainer.mouseChildren = false;
      }
      
      public function drawEntry(param1:String) : void
      {
         mouseEnabled = mouseChildren = false;
         this._atlasManager.drawGraphics(ATLAS_CONSTANTS.BATTLE_ATLAS,param1,this.atlasContainer.graphics,"",true);
      }
      
      override protected function onDispose() : void
      {
         this.atlasContainer = null;
         super.onDispose();
      }
   }
}
