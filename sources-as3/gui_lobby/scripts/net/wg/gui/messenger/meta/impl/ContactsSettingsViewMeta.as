package net.wg.gui.messenger.meta.impl
{
   import net.wg.data.constants.Errors;
   import net.wg.gui.messenger.views.BaseContactView;
   
   public class ContactsSettingsViewMeta extends BaseContactView
   {
       
      
      public var showOfflineUsers:Function;
      
      public var showOthers:Function;
      
      public var messagesNotFromContacts:Function;
      
      public function ContactsSettingsViewMeta()
      {
         super();
      }
      
      public function showOfflineUsersS(param1:Boolean) : void
      {
         App.utils.asserter.assertNotNull(this.showOfflineUsers,"showOfflineUsers" + Errors.CANT_NULL);
         this.showOfflineUsers(param1);
      }
      
      public function showOthersS(param1:Boolean) : void
      {
         App.utils.asserter.assertNotNull(this.showOthers,"showOthers" + Errors.CANT_NULL);
         this.showOthers(param1);
      }
      
      public function messagesNotFromContactsS(param1:Number) : void
      {
         App.utils.asserter.assertNotNull(this.messagesNotFromContacts,"messagesNotFromContacts" + Errors.CANT_NULL);
         this.messagesNotFromContacts(param1);
      }
   }
}
