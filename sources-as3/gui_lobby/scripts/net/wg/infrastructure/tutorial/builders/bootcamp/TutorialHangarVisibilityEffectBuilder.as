package net.wg.infrastructure.tutorial.builders.bootcamp
{
   import net.wg.gui.lobby.hangar.Hangar;
   
   public class TutorialHangarVisibilityEffectBuilder extends TutorialVisibilityEffectBuilder
   {
       
      
      public function TutorialHangarVisibilityEffectBuilder()
      {
         super();
      }
      
      override protected function updateComponent() : void
      {
         super.updateComponent();
         Hangar(view).updateAmmunitionPanelPosition();
      }
   }
}
