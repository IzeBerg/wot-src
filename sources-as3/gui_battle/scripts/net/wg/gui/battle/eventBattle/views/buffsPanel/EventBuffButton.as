package net.wg.gui.battle.eventBattle.views.buffsPanel
{
   import flash.display.MovieClip;
   import net.wg.gui.battle.components.buttons.BattleToolTipButton;
   
   public class EventBuffButton extends BattleToolTipButton
   {
       
      
      public var id:String = "";
      
      public var iconLoader:EventBuffIcon = null;
      
      public var hitMc:MovieClip = null;
      
      public function EventBuffButton()
      {
         super();
         isAllowedToShowToolTipOnDisabledState = true;
         hideToolTipOnClickActions = false;
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         if(this.hitMc != null)
         {
            this.hitMc.mouseEnabled = false;
            hitArea = this.hitMc;
         }
      }
      
      public function set icon(param1:String) : void
      {
         this.iconLoader.iconPath = param1;
      }
      
      override protected function onDispose() : void
      {
         this.iconLoader.dispose();
         this.iconLoader = null;
         this.hitMc = null;
         super.onDispose();
      }
   }
}
