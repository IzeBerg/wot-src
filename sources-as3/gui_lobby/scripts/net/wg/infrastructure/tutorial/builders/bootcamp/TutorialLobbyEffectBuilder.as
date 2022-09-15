package net.wg.infrastructure.tutorial.builders.bootcamp
{
   import net.wg.gui.lobby.LobbyPage;
   
   public class TutorialLobbyEffectBuilder extends TutorialVisibilityEffectBuilder
   {
       
      
      public function TutorialLobbyEffectBuilder()
      {
         super();
      }
      
      override protected function createEffect(param1:Object) : void
      {
         super.createEffect(param1);
         LobbyPage(view).updateStage(App.appWidth,App.appHeight);
      }
   }
}
