package net.wg.white_tiger.gui.battle.views.wtPlayersPanel.comps
{
   public class BotHealthBarLeft extends BotHealthBar
   {
       
      
      public function BotHealthBarLeft()
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
