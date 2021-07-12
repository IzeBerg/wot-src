package net.wg.gui.battle.views.minimap.components.entries.fallout.repair
{
   import flash.display.Sprite;
   import net.wg.data.constants.generated.ATLAS_CONSTANTS;
   import net.wg.gui.battle.components.BattleUIComponent;
   import net.wg.gui.battle.views.minimap.components.entries.constants.RepairMinimapEntryConst;
   import net.wg.infrastructure.managers.IAtlasManager;
   
   public class AllyRepairMinimapEntry extends BattleUIComponent
   {
       
      
      public var active:Sprite = null;
      
      public var cooldown:Sprite = null;
      
      private var _atlasManager:IAtlasManager;
      
      public function AllyRepairMinimapEntry()
      {
         this._atlasManager = App.atlasMgr;
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this._atlasManager.drawGraphics(ATLAS_CONSTANTS.BATTLE_ATLAS,RepairMinimapEntryConst.ALLY_REPAIR_ACTIVE_ATLAS_ITEM_NAME,this.active.graphics,"",true);
         this._atlasManager.drawGraphics(ATLAS_CONSTANTS.BATTLE_ATLAS,RepairMinimapEntryConst.ALLY_REPAIR_COOLDOWN_ATLAS_ITEM_NAME,this.cooldown.graphics,"",true);
         this.cooldown.visible = false;
      }
      
      public function setCooldown(param1:Boolean) : void
      {
         if(param1)
         {
            this.active.visible = false;
            this.cooldown.visible = true;
         }
         else
         {
            this.active.visible = true;
            this.cooldown.visible = false;
         }
      }
      
      override protected function onDispose() : void
      {
         this.active = null;
         this.cooldown = null;
         this._atlasManager = null;
         super.onDispose();
      }
   }
}
