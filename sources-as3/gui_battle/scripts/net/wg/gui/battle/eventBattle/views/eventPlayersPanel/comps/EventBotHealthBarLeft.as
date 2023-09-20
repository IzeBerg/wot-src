package net.wg.gui.battle.eventBattle.views.eventPlayersPanel.comps
{
   public class EventBotHealthBarLeft extends EventBotHealthBar
   {
       
      
      public function EventBotHealthBarLeft()
      {
         super();
      }
      
      override public function showHp(param1:Number) : void
      {
         super.showHp(param1);
         var _loc2_:Number = getHpMaskWidth();
         fxMask.x = Math.min(prevMaskWidth,_loc2_);
      }
   }
}
