package net.wg.gui.battle.eventBattle.views.introVideoPage
{
   import net.wg.gui.bootcamp.introVideoPage.containers.IntroLogoContainer;
   import net.wg.gui.components.controls.UILoaderAlt;
   
   public class EventIntroLogoContainer extends IntroLogoContainer
   {
       
      
      public var logo:UILoaderAlt = null;
      
      public function EventIntroLogoContainer()
      {
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.logo.source = RES_ICONS.MAPS_ICONS_EVENT_LOADING_INTROLOGO;
      }
      
      override protected function onDispose() : void
      {
         this.logo.dispose();
         this.logo = null;
         super.onDispose();
      }
   }
}
