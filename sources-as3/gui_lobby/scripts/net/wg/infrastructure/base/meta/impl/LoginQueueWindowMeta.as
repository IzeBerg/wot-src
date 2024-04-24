package net.wg.infrastructure.base.meta.impl
{
   import net.wg.data.constants.Errors;
   import net.wg.infrastructure.base.AbstractWindowView;
   
   public class LoginQueueWindowMeta extends AbstractWindowView
   {
       
      
      public var onCancelClick:Function;
      
      public var onAutoLoginClick:Function;
      
      public function LoginQueueWindowMeta()
      {
         super();
      }
      
      public function onCancelClickS() : void
      {
         App.utils.asserter.assertNotNull(this.onCancelClick,"onCancelClick" + Errors.CANT_NULL);
         this.onCancelClick();
      }
      
      public function onAutoLoginClickS() : void
      {
         App.utils.asserter.assertNotNull(this.onAutoLoginClick,"onAutoLoginClick" + Errors.CANT_NULL);
         this.onAutoLoginClick();
      }
   }
}
