package net.wg.infrastructure.base.meta.impl
{
   import net.wg.data.constants.Errors;
   import net.wg.infrastructure.base.AbstractView;
   
   public class ProfileMeta extends AbstractView
   {
       
      
      public var onCloseProfile:Function;
      
      public function ProfileMeta()
      {
         super();
      }
      
      public function onCloseProfileS() : void
      {
         App.utils.asserter.assertNotNull(this.onCloseProfile,"onCloseProfile" + Errors.CANT_NULL);
         this.onCloseProfile();
      }
   }
}
