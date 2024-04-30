package net.wg.gui.battle.views.minimap.components.entries.fallout.absorptionFlag
{
   import flash.display.Sprite;
   import net.wg.data.constants.generated.ATLAS_CONSTANTS;
   import net.wg.gui.battle.components.BattleUIComponent;
   import net.wg.gui.battle.views.minimap.components.entries.constants.AbsorptionFlagEntryConst;
   import net.wg.infrastructure.events.ColorSchemeEvent;
   import net.wg.infrastructure.managers.IAtlasManager;
   
   public class EnemyAbsorptionFlagMinimapEntry extends BattleUIComponent
   {
       
      
      public var absorptionFlag:Sprite = null;
      
      private var _atlasManager:IAtlasManager;
      
      private var _isColorBlind:Boolean = false;
      
      public function EnemyAbsorptionFlagMinimapEntry()
      {
         this._atlasManager = App.atlasMgr;
         super();
         this._isColorBlind = App.colorSchemeMgr.getScheme(AbsorptionFlagEntryConst.COLOR_SCHEME_NAME).aliasColor == AbsorptionFlagEntryConst.ENEMY_CAPTURE_BLIND;
         App.colorSchemeMgr.addEventListener(ColorSchemeEvent.SCHEMAS_UPDATED,this.onColorSchemeChangeHandler);
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.updateMarker();
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
         var _loc1_:String = AbsorptionFlagEntryConst.ENEMY_ABSORPTION_FLAG_ATLAS_ITEM_NAME;
         if(this._isColorBlind)
         {
            _loc1_ = AbsorptionFlagEntryConst.PURPLE_ABSORPTION_FLAG_ATLAS_ITEM_NAME;
         }
         this._atlasManager.drawGraphics(ATLAS_CONSTANTS.BATTLE_ATLAS,_loc1_,this.absorptionFlag.graphics,"",true);
      }
      
      public function setAnimated(param1:Boolean) : void
      {
      }
      
      override protected function onDispose() : void
      {
         App.colorSchemeMgr.removeEventListener(ColorSchemeEvent.SCHEMAS_UPDATED,this.onColorSchemeChangeHandler);
         this.absorptionFlag = null;
         this._atlasManager = null;
         super.onDispose();
      }
   }
}
