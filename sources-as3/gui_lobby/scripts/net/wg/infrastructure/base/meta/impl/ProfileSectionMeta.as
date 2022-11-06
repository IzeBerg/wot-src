package net.wg.infrastructure.base.meta.impl
{
   import net.wg.data.constants.Errors;
   import net.wg.infrastructure.base.BaseDAAPIComponent;
   
   public class ProfileSectionMeta extends BaseDAAPIComponent
   {
       
      
      public var setActive:Function;
      
      public var requestData:Function;
      
      public var requestDossier:Function;
      
      public function ProfileSectionMeta()
      {
         super();
      }
      
      public function setActiveS(param1:Boolean) : void
      {
         App.utils.asserter.assertNotNull(this.setActive,"setActive" + Errors.CANT_NULL);
         this.setActive(param1);
      }
      
      public function requestDataS(param1:int) : void
      {
         App.utils.asserter.assertNotNull(this.requestData,"requestData" + Errors.CANT_NULL);
         this.requestData(param1);
      }
      
      public function requestDossierS(param1:String) : void
      {
         App.utils.asserter.assertNotNull(this.requestDossier,"requestDossier" + Errors.CANT_NULL);
         this.requestDossier(param1);
      }
   }
}
