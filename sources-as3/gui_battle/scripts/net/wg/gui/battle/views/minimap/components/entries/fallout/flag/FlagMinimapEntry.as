package net.wg.gui.battle.views.minimap.components.entries.fallout.flag
{
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import net.wg.data.constants.generated.ATLAS_CONSTANTS;
   import net.wg.gui.battle.components.BattleUIComponent;
   import net.wg.gui.battle.views.minimap.components.entries.constants.AbsorptionFlagEntryConst;
   import net.wg.gui.battle.views.minimap.components.entries.constants.FlagMinimapEntryConst;
   import net.wg.infrastructure.events.ColorSchemeEvent;
   import net.wg.infrastructure.managers.IAtlasManager;
   
   public class FlagMinimapEntry extends BattleUIComponent
   {
       
      
      public var cooldown:Sprite = null;
      
      public var neutral:Sprite = null;
      
      public var purpleAnim:MovieClip = null;
      
      public var allyAnim:MovieClip = null;
      
      public var enemyAnim:MovieClip = null;
      
      private var _isColorBlind:Boolean = false;
      
      private var _state:String = "";
      
      private var _atlasManager:IAtlasManager;
      
      private const NEUTRAL:String = "neutral";
      
      private const ALLY:String = "ally";
      
      private const COOLDOWN:String = "cooldown";
      
      private const ENEMY:String = "enemy";
      
      public function FlagMinimapEntry()
      {
         this._atlasManager = App.atlasMgr;
         super();
         this.allyAnim.stop();
         this.allyAnim.visible = false;
         this.enemyAnim.stop();
         this.enemyAnim.visible = false;
         this.purpleAnim.stop();
         this.purpleAnim.visible = false;
         this._isColorBlind = App.colorSchemeMgr.getScheme(AbsorptionFlagEntryConst.COLOR_SCHEME_NAME).aliasColor == AbsorptionFlagEntryConst.ENEMY_CAPTURE_BLIND;
         App.colorSchemeMgr.addEventListener(ColorSchemeEvent.SCHEMAS_UPDATED,this.onColorSchemeChangeHandler);
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this._atlasManager.drawGraphics(ATLAS_CONSTANTS.BATTLE_ATLAS,FlagMinimapEntryConst.FLAG_COOLDOWN_ATLAS_ITEM_NAME,this.cooldown.graphics,"",true);
         this._atlasManager.drawGraphics(ATLAS_CONSTANTS.BATTLE_ATLAS,FlagMinimapEntryConst.FLAG_NEUTRAL_ATLAS_ITEM_NAME,this.neutral.graphics,"",true);
         this.cooldown.visible = false;
      }
      
      private function onColorSchemeChangeHandler(param1:ColorSchemeEvent) : void
      {
         var _loc2_:Boolean = App.colorSchemeMgr.getScheme(AbsorptionFlagEntryConst.COLOR_SCHEME_NAME).aliasColor == AbsorptionFlagEntryConst.ENEMY_CAPTURE_BLIND;
         if(this._isColorBlind != _loc2_)
         {
            this._isColorBlind = _loc2_;
            if(this._state == this.ENEMY)
            {
               this.enemyAnim.visible = false;
               this.enemyAnim.stop();
               this.purpleAnim.visible = false;
               this.purpleAnim.stop();
               this.showEnemyMarker();
            }
         }
      }
      
      public function setState(param1:String) : void
      {
         if(this._state != param1)
         {
            this._state = param1;
            this.cooldown.visible = false;
            this.neutral.visible = false;
            this.allyAnim.visible = false;
            this.allyAnim.stop();
            this.enemyAnim.visible = false;
            this.enemyAnim.stop();
            this.purpleAnim.visible = false;
            this.purpleAnim.stop();
            if(this._state == this.NEUTRAL)
            {
               this.neutral.visible = true;
            }
            else if(this._state == this.COOLDOWN)
            {
               this.cooldown.visible = true;
            }
            else if(this._state == this.ALLY)
            {
               this.allyAnim.visible = true;
               this.allyAnim.play();
            }
            else if(this._state == this.ENEMY)
            {
               this.showEnemyMarker();
            }
         }
      }
      
      private function showEnemyMarker() : void
      {
         if(this._isColorBlind)
         {
            this.purpleAnim.visible = true;
            this.purpleAnim.play();
         }
         else
         {
            this.enemyAnim.visible = true;
            this.enemyAnim.play();
         }
      }
      
      override protected function onDispose() : void
      {
         App.colorSchemeMgr.removeEventListener(ColorSchemeEvent.SCHEMAS_UPDATED,this.onColorSchemeChangeHandler);
         this.cooldown = null;
         this.neutral = null;
         this.allyAnim = null;
         this.enemyAnim = null;
         this.purpleAnim = null;
         this._atlasManager = null;
         super.onDispose();
      }
   }
}
