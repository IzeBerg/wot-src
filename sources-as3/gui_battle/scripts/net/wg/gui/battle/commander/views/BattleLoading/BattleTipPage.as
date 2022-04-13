package net.wg.gui.battle.commander.views.BattleLoading
{
   import net.wg.gui.bootcamp.containers.TutorialPageContainer;
   
   public class BattleTipPage extends TutorialPageContainer
   {
       
      
      public function BattleTipPage()
      {
         super();
      }
      
      public function updateTextPosition(param1:int, param2:int, param3:int, param4:int, param5:int, param6:int) : void
      {
         var _loc7_:int = 0;
         if(txtHeader1)
         {
            _loc7_ = param1 >> 1;
            txtHeader1.width = _loc7_;
            txtHeader1.x = param3 + (param1 - _loc7_ >> 1);
            txtHeader1.y = param2 - txtHeader1.height - param4 - param6 >> 0;
         }
      }
   }
}
