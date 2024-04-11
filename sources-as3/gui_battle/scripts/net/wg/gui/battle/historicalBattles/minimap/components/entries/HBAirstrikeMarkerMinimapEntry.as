package net.wg.gui.battle.historicalBattles.minimap.components.entries
{
   import net.wg.gui.battle.views.minimap.components.entries.arty.ArtyMarkerMinimapEntry;
   
   public class HBAirstrikeMarkerMinimapEntry extends ArtyMarkerMinimapEntry
   {
      
      private static const LOOP_ANIMATION_START:int = 52;
      
      private static const LOOP_ANIMATION_END:int = 108;
       
      
      public function HBAirstrikeMarkerMinimapEntry()
      {
         super();
         animMc.addFrameScript(LOOP_ANIMATION_END,this.loopAnimation);
         animMc.stop();
      }
      
      override protected function onDispose() : void
      {
         animMc.addFrameScript(LOOP_ANIMATION_END,null);
         super.onDispose();
      }
      
      private function loopAnimation() : void
      {
         animMc.gotoAndPlay(LOOP_ANIMATION_START);
      }
   }
}
