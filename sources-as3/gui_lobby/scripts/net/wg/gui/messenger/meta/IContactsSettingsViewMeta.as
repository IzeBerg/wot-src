package net.wg.gui.messenger.meta
{
   import flash.events.IEventDispatcher;
   
   public interface IContactsSettingsViewMeta extends IEventDispatcher
   {
       
      
      function showOfflineUsersS(param1:Boolean) : void;
      
      function showOthersS(param1:Boolean) : void;
      
      function messagesNotFromContactsS(param1:Number) : void;
   }
}
