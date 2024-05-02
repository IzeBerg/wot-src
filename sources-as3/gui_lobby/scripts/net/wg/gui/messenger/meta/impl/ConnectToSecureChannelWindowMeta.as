package net.wg.gui.messenger.meta.impl
{
   import net.wg.data.constants.Errors;
   import net.wg.infrastructure.base.AbstractWindowView;
   
   public class ConnectToSecureChannelWindowMeta extends AbstractWindowView
   {
       
      
      public var sendPassword:Function;
      
      public var cancelPassword:Function;
      
      public function ConnectToSecureChannelWindowMeta()
      {
         super();
      }
      
      public function sendPasswordS(param1:String) : void
      {
         App.utils.asserter.assertNotNull(this.sendPassword,"sendPassword" + Errors.CANT_NULL);
         this.sendPassword(param1);
      }
      
      public function cancelPasswordS() : void
      {
         App.utils.asserter.assertNotNull(this.cancelPassword,"cancelPassword" + Errors.CANT_NULL);
         this.cancelPassword();
      }
   }
}
