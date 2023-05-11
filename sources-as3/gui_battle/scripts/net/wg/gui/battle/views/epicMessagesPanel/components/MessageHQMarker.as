package net.wg.gui.battle.views.epicMessagesPanel.components
{
   import flash.display.MovieClip;
   import net.wg.gui.battle.components.BattleUIComponent;
   
   public class MessageHQMarker extends BattleUIComponent
   {
       
      
      public var epicHQId:MovieClip = null;
      
      public var hqProgress:MovieClip = null;
      
      public function MessageHQMarker()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         this.epicHQId = null;
         this.hqProgress = null;
         super.onDispose();
      }
   }
}
