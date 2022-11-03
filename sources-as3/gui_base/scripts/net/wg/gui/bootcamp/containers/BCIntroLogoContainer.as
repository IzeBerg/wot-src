package net.wg.gui.bootcamp.containers
{
   import net.wg.gui.bootcamp.introVideoPage.containers.IntroLogoContainer;
   import net.wg.gui.gameloading.LoadingLogo;
   
   public class BCIntroLogoContainer extends IntroLogoContainer
   {
       
      
      public var wotLogo:LoadingLogo = null;
      
      public function BCIntroLogoContainer()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         this.wotLogo.dispose();
         this.wotLogo = null;
         super.onDispose();
      }
   }
}
