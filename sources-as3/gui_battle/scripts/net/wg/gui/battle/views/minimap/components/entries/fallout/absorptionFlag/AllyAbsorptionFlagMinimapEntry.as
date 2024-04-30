package net.wg.gui.battle.views.minimap.components.entries.fallout.absorptionFlag
{
   import flash.display.Sprite;
   import net.wg.data.constants.generated.ATLAS_CONSTANTS;
   import net.wg.gui.battle.components.BattleUIComponent;
   import net.wg.gui.battle.views.minimap.components.entries.constants.AbsorptionFlagEntryConst;
   import net.wg.gui.battle.views.minimap.components.entries.fallout.absorptionFlag.containers.AbsorptionFlagAnimContainer;
   import net.wg.infrastructure.managers.IAtlasManager;
   
   public class AllyAbsorptionFlagMinimapEntry extends BattleUIComponent
   {
       
      
      public var absorptionFlag:Sprite = null;
      
      public var capturePointAnim:AbsorptionFlagAnimContainer = null;
      
      private var _atlasManager:IAtlasManager;
      
      private const START_FRAME:int = 0;
      
      public function AllyAbsorptionFlagMinimapEntry()
      {
         this._atlasManager = App.atlasMgr;
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this._atlasManager.drawGraphics(ATLAS_CONSTANTS.BATTLE_ATLAS,AbsorptionFlagEntryConst.ALLY_ABSORPTION_FLAG_ATLAS_ITEM_NAME,this.absorptionFlag.graphics,"",true);
         this._atlasManager.drawGraphics(ATLAS_CONSTANTS.BATTLE_ATLAS,AbsorptionFlagEntryConst.ALLY_ABSORPTION_FLAG_ANIM_ATLAS_ITEM_NAME,this.capturePointAnim.animItem.graphics,"",true);
         this.capturePointAnim.visible = false;
      }
      
      public function setAnimated(param1:Boolean) : void
      {
         if(param1)
         {
            this.absorptionFlag.visible = false;
            this.capturePointAnim.visible = true;
            this.capturePointAnim.gotoAndPlay(this.START_FRAME);
         }
         else
         {
            this.absorptionFlag.visible = true;
            this.capturePointAnim.visible = false;
            this.capturePointAnim.stop();
         }
      }
      
      override protected function onDispose() : void
      {
         this.absorptionFlag = null;
         this.capturePointAnim.dispose();
         this.capturePointAnim = null;
         this._atlasManager = null;
         super.onDispose();
      }
   }
}
