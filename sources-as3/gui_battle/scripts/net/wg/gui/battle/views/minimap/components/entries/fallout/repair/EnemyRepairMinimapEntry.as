package net.wg.gui.battle.views.minimap.components.entries.fallout.repair
{
   import flash.display.Sprite;
   import net.wg.data.constants.generated.ATLAS_CONSTANTS;
   import net.wg.gui.battle.components.BattleUIComponent;
   import net.wg.gui.battle.views.minimap.components.entries.constants.AbsorptionFlagEntryConst;
   import net.wg.gui.battle.views.minimap.components.entries.constants.RepairMinimapEntryConst;
   import net.wg.infrastructure.events.ColorSchemeEvent;
   import net.wg.infrastructure.managers.IAtlasManager;
   
   public class EnemyRepairMinimapEntry extends BattleUIComponent
   {
       
      
      public var active:Sprite = null;
      
      public var activePurple:Sprite = null;
      
      public var cooldown:Sprite = null;
      
      public var cooldownPurple:Sprite = null;
      
      private var _atlasManager:IAtlasManager;
      
      private var _isCooldown:Boolean = false;
      
      private var _isColorBlind:Boolean = false;
      
      public function EnemyRepairMinimapEntry()
      {
         this._atlasManager = App.atlasMgr;
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this._atlasManager.drawGraphics(ATLAS_CONSTANTS.BATTLE_ATLAS,RepairMinimapEntryConst.ENEMY_REPAIR_ACTIVE_ATLAS_ITEM_NAME,this.active.graphics,"",true);
         this._atlasManager.drawGraphics(ATLAS_CONSTANTS.BATTLE_ATLAS,RepairMinimapEntryConst.ENEMY_REPAIR_ACTIVE_PURPLE_ATLAS_ITEM_NAME,this.activePurple.graphics,"",true);
         this._atlasManager.drawGraphics(ATLAS_CONSTANTS.BATTLE_ATLAS,RepairMinimapEntryConst.ENEMY_REPAIR_COOLDOWN_ATLAS_ITEM_NAME,this.cooldown.graphics,"",true);
         this._atlasManager.drawGraphics(ATLAS_CONSTANTS.BATTLE_ATLAS,RepairMinimapEntryConst.ENEMY_REPAIR_COOLDOWN_PURPLE_ATLAS_ITEM_NAME,this.cooldownPurple.graphics,"",true);
         this._isColorBlind = App.colorSchemeMgr.getScheme(AbsorptionFlagEntryConst.COLOR_SCHEME_NAME).aliasColor == AbsorptionFlagEntryConst.ENEMY_CAPTURE_BLIND;
         App.colorSchemeMgr.addEventListener(ColorSchemeEvent.SCHEMAS_UPDATED,this.onColorSchemeChangeHandler);
         this.updateMarker();
      }
      
      public function setCooldown(param1:Boolean) : void
      {
         if(this._isCooldown != param1)
         {
            this._isCooldown = param1;
            this.updateMarker();
         }
      }
      
      private function onColorSchemeChangeHandler(param1:ColorSchemeEvent) : void
      {
         var _loc2_:Boolean = App.colorSchemeMgr.getScheme(AbsorptionFlagEntryConst.COLOR_SCHEME_NAME).aliasColor == AbsorptionFlagEntryConst.ENEMY_CAPTURE_BLIND;
         if(this._isColorBlind != _loc2_)
         {
            this._isColorBlind = _loc2_;
            this.updateMarker();
         }
      }
      
      private function updateMarker() : void
      {
         this.active.visible = false;
         this.activePurple.visible = false;
         this.cooldown.visible = false;
         this.cooldownPurple.visible = false;
         if(this._isCooldown)
         {
            if(this._isColorBlind)
            {
               this.cooldownPurple.visible = true;
            }
            else
            {
               this.cooldown.visible = true;
            }
         }
         else if(this._isColorBlind)
         {
            this.activePurple.visible = true;
         }
         else
         {
            this.active.visible = true;
         }
      }
      
      override protected function onDispose() : void
      {
         App.colorSchemeMgr.removeEventListener(ColorSchemeEvent.SCHEMAS_UPDATED,this.onColorSchemeChangeHandler);
         this.active = null;
         this.activePurple = null;
         this.cooldown = null;
         this.cooldownPurple = null;
         this._atlasManager = null;
         super.onDispose();
      }
   }
}
