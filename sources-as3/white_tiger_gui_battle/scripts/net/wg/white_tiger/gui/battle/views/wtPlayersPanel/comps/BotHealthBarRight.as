package net.wg.white_tiger.gui.battle.views.wtPlayersPanel.comps
{
   public class BotHealthBarRight extends BotHealthBar
   {
       
      
      public function BotHealthBarRight()
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
