package net.wg.gui.battle.views.epicMessagesPanel.components
{
   import flash.display.MovieClip;
   import net.wg.gui.battle.components.BattleUIComponent;
   import net.wg.gui.battle.components.EpicProgressCircle;
   
   public class MessageBaseMarker extends BattleUIComponent
   {
       
      
      public var baseId:MovieClip = null;
      
      public var captureCircle:EpicProgressCircle = null;
      
      public function MessageBaseMarker()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         this.captureCircle.dispose();
         this.captureCircle = null;
         this.baseId = null;
         super.onDispose();
      }
   }
}
