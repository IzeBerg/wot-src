package net.wg.gui.prebattle.meta.impl
{
   import net.wg.data.constants.Errors;
   import net.wg.infrastructure.base.AbstractWindowView;
   
   public class ReceivedInviteWindowMeta extends AbstractWindowView
   {
       
      
      public var acceptInvite:Function;
      
      public var declineInvite:Function;
      
      public var cancelInvite:Function;
      
      public function ReceivedInviteWindowMeta()
      {
         super();
      }
      
      public function acceptInviteS() : void
      {
         App.utils.asserter.assertNotNull(this.acceptInvite,"acceptInvite" + Errors.CANT_NULL);
         this.acceptInvite();
      }
      
      public function declineInviteS() : void
      {
         App.utils.asserter.assertNotNull(this.declineInvite,"declineInvite" + Errors.CANT_NULL);
         this.declineInvite();
      }
      
      public function cancelInviteS() : void
      {
         App.utils.asserter.assertNotNull(this.cancelInvite,"cancelInvite" + Errors.CANT_NULL);
         this.cancelInvite();
      }
   }
}
