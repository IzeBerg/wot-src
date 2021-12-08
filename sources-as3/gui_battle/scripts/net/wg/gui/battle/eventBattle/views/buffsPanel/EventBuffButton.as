package net.wg.gui.battle.eventBattle.views.buffsPanel
{
   import net.wg.gui.battle.components.BattleAtlasSprite;
   import net.wg.gui.battle.components.buttons.BattleToolTipButton;
   
   public class EventBuffButton extends BattleToolTipButton
   {
       
      
      public var iconLoader:BattleAtlasSprite = null;
      
      public function EventBuffButton()
      {
         super();
         isAllowedToShowToolTipOnDisabledState = true;
         hideToolTipOnClickActions = false;
      }
      
      public function set icon(param1:String) : void
      {
         this.iconLoader.imageName = param1;
      }
      
      override protected function onDispose() : void
      {
         this.iconLoader = null;
         super.onDispose();
      }
   }
}
