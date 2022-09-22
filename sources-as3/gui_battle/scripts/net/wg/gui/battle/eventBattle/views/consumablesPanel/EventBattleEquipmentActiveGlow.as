package net.wg.gui.battle.eventBattle.views.consumablesPanel
{
   import net.wg.gui.battle.components.BattleUIComponent;
   import net.wg.gui.bootcamp.containers.AnimatedTextContainer;
   
   public class EventBattleEquipmentActiveGlow extends BattleUIComponent
   {
      
      private static const SHOW_GLOW_YELLOW_STATE:String = "yellow";
      
      private static const SHOW_GLOW_HIDE_STATE:String = "hide";
      
      private static const SHOW_GLOW_IDLE_STATE:String = "idle";
       
      
      public var tfContainer:AnimatedTextContainer = null;
      
      public function EventBattleEquipmentActiveGlow()
      {
         super();
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         this.tfContainer.text = CONTROLS.KEYBOARD_KEY_ESCAPE;
         mouseEnabled = false;
         mouseChildren = false;
      }
      
      public function glowYellow() : void
      {
         if(currentLabel != SHOW_GLOW_YELLOW_STATE)
         {
            gotoAndPlay(SHOW_GLOW_YELLOW_STATE);
         }
      }
      
      public function hideGlow() : void
      {
         if(currentFrameLabel != SHOW_GLOW_IDLE_STATE)
         {
            gotoAndPlay(SHOW_GLOW_HIDE_STATE);
         }
      }
      
      override protected function onDispose() : void
      {
         stop();
         this.tfContainer.dispose();
         this.tfContainer = null;
         super.onDispose();
      }
   }
}
