package net.wg.infrastructure.base.meta.impl
{
   import net.wg.data.constants.Errors;
   import net.wg.gui.lobby.profile.pages.technique.ProfileTechnique;
   
   public class ProfileTechniquePageMeta extends ProfileTechnique
   {
       
      
      public var setIsInHangarSelected:Function;
      
      public function ProfileTechniquePageMeta()
      {
         super();
      }
      
      public function setIsInHangarSelectedS(param1:Boolean) : void
      {
         App.utils.asserter.assertNotNull(this.setIsInHangarSelected,"setIsInHangarSelected" + Errors.CANT_NULL);
         this.setIsInHangarSelected(param1);
      }
   }
}
