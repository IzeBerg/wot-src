package net.wg.gui.battle.views.damagePanel.components.modules
{
   import net.wg.gui.battle.views.damagePanel.components.DamagePanelItemFrameStates;
   
   public class ModuleWarningAnim extends DamagePanelItemFrameStates
   {
      
      private static const LAST_ANIM_FRAME:int = 76;
       
      
      public function ModuleWarningAnim()
      {
         super();
         stop();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         addFrameScript(LAST_ANIM_FRAME,this.onAnimEnd);
      }
      
      private function onAnimEnd() : void
      {
         visible = false;
      }
   }
}
