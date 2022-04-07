package net.wg.infrastructure.base.meta.impl
{
   import net.wg.data.constants.Errors;
   import net.wg.infrastructure.base.AbstractWindowView;
   
   public class FreeXPInfoWindowMeta extends AbstractWindowView
   {
       
      
      public var onSubmitButton:Function;
      
      public var onCancelButton:Function;
      
      public function FreeXPInfoWindowMeta()
      {
         super();
      }
      
      public function onSubmitButtonS() : void
      {
         App.utils.asserter.assertNotNull(this.onSubmitButton,"onSubmitButton" + Errors.CANT_NULL);
         this.onSubmitButton();
      }
      
      public function onCancelButtonS() : void
      {
         App.utils.asserter.assertNotNull(this.onCancelButton,"onCancelButton" + Errors.CANT_NULL);
         this.onCancelButton();
      }
   }
}
