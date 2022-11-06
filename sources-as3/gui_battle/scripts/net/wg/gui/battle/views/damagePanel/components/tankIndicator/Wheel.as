package net.wg.gui.battle.views.damagePanel.components.tankIndicator
{
   import net.wg.gui.battle.views.damagePanel.components.DamagePanelItemFrameStates;
   
   public class Wheel extends DamagePanelItemFrameStates
   {
       
      
      public function Wheel()
      {
         super();
      }
      
      public function setState(param1:String) : void
      {
         gotoAndStop(param1);
      }
   }
}
