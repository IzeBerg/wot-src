package net.wg.infrastructure.base.meta.impl
{
   import net.wg.data.constants.Errors;
   import net.wg.gui.lobby.profile.pages.ProfileSection;
   
   public class ProfileFormationsPageMeta extends ProfileSection
   {
       
      
      public var showFort:Function;
      
      public var createFort:Function;
      
      public var onClanLinkNavigate:Function;
      
      public function ProfileFormationsPageMeta()
      {
         super();
      }
      
      public function showFortS() : void
      {
         App.utils.asserter.assertNotNull(this.showFort,"showFort" + Errors.CANT_NULL);
         this.showFort();
      }
      
      public function createFortS() : void
      {
         App.utils.asserter.assertNotNull(this.createFort,"createFort" + Errors.CANT_NULL);
         this.createFort();
      }
      
      public function onClanLinkNavigateS(param1:String) : void
      {
         App.utils.asserter.assertNotNull(this.onClanLinkNavigate,"onClanLinkNavigate" + Errors.CANT_NULL);
         this.onClanLinkNavigate(param1);
      }
   }
}
