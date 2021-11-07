package net.wg.gui.battle.views.epicScorePanel.components
{
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import net.wg.gui.battle.components.BattleUIComponent;
   import net.wg.gui.battle.components.EpicProgressCircle;
   import net.wg.infrastructure.events.ColorSchemeEvent;
   
   public class SectorBaseScoreEntry extends BattleUIComponent
   {
       
      
      public var progressCapture:EpicProgressCircle = null;
      
      public var baseId:MovieClip = null;
      
      public var colourBG:Sprite = null;
      
      public function SectorBaseScoreEntry()
      {
         super();
         this.setColorBlindMode(App.colorSchemeMgr.getIsColorBlindS());
      }
      
      override protected function onDispose() : void
      {
         this.progressCapture.dispose();
         this.progressCapture = null;
         this.baseId.stop();
         this.baseId = null;
         this.colourBG = null;
         App.colorSchemeMgr.removeEventListener(ColorSchemeEvent.SCHEMAS_UPDATED,this.onColorSchemasUpdatedHandler);
         super.onDispose();
      }
      
      public function setBaseId(param1:int) : void
      {
         this.baseId.gotoAndStop(param1);
         App.colorSchemeMgr.addEventListener(ColorSchemeEvent.SCHEMAS_UPDATED,this.onColorSchemasUpdatedHandler);
      }
      
      private function onColorSchemasUpdatedHandler(param1:ColorSchemeEvent) : void
      {
         this.setColorBlindMode(App.colorSchemeMgr.getIsColorBlindS());
      }
      
      private function setColorBlindMode(param1:Boolean) : void
      {
         this.progressCapture.setColorBlindMode(param1);
      }
   }
}
