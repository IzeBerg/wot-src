package net.wg.gui.battle.eventBattle.views.minimap.entries
{
   import net.wg.data.constants.generated.ATLAS_CONSTANTS;
   import net.wg.data.constants.generated.BATTLEATLAS;
   
   public class EventGeneratorMinimapEntry extends EventIndexedMinimapEntry
   {
       
      
      public function EventGeneratorMinimapEntry()
      {
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         _atlasManager.drawGraphics(ATLAS_CONSTANTS.BATTLE_ATLAS,BATTLEATLAS.WT_GENERATOR,placeholder.graphics,"",true);
      }
      
      public function setAlpha(param1:Number) : void
      {
         alpha = param1;
      }
   }
}
