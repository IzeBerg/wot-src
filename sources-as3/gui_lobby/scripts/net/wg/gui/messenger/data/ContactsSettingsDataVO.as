package net.wg.gui.messenger.data
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class ContactsSettingsDataVO extends DAAPIDataClass
   {
       
      
      public var showOfflineUsers:Boolean;
      
      public var showOthersCategory:Boolean;
      
      public var messagesNotFromContacts:uint = 0;
      
      public function ContactsSettingsDataVO(param1:Object)
      {
         super(param1);
      }
   }
}
