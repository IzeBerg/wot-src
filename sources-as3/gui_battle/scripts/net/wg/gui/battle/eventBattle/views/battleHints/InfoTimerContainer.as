package net.wg.gui.battle.eventBattle.views.battleHints
{
   import net.wg.gui.battle.eventBattle.views.battleHints.data.HintInfoVO;
   
   public class InfoTimerContainer extends InfoContainer
   {
       
      
      public function InfoTimerContainer()
      {
         super();
      }
      
      override public function showHint(param1:HintInfoVO) : void
      {
         super.showHint(param1);
         var _loc2_:TextContainerTimer = txtMessage as TextContainerTimer;
         if(_loc2_)
         {
            _loc2_.setTimer(param1.timer);
         }
      }
   }
}
