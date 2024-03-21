package net.wg.infrastructure.base.meta.impl
{
   import net.wg.data.constants.Errors;
   import net.wg.infrastructure.base.AbstractWindowView;
   
   public class LegalInfoWindowMeta extends AbstractWindowView
   {
       
      
      public var getLegalInfo:Function;
      
      public var onCancelClick:Function;
      
      public function LegalInfoWindowMeta()
      {
         super();
      }
      
      public function getLegalInfoS() : void
      {
         App.utils.asserter.assertNotNull(this.getLegalInfo,"getLegalInfo" + Errors.CANT_NULL);
         this.getLegalInfo();
      }
      
      public function onCancelClickS() : void
      {
         App.utils.asserter.assertNotNull(this.onCancelClick,"onCancelClick" + Errors.CANT_NULL);
         this.onCancelClick();
      }
   }
}
