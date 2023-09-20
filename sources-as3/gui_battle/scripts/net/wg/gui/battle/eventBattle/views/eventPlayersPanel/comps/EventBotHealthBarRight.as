package net.wg.gui.battle.eventBattle.views.eventPlayersPanel.comps
{
   public class EventBotHealthBarRight extends EventBotHealthBar
   {
       
      
      public function EventBotHealthBarRight()
      {
         super();
      }
      
      override public function showHp(param1:Number) : void
      {
         super.showHp(param1);
         var _loc2_:Number = getHpMaskX();
         fxMask.x = Math.min(prevMaskX,_loc2_);
      }
   }
}
