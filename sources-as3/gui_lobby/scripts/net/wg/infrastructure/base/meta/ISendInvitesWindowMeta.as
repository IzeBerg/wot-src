package net.wg.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;
   
   public interface ISendInvitesWindowMeta extends IEventDispatcher
   {
       
      
      function showErrorS(param1:String) : void;
      
      function setOnlineFlagS(param1:Boolean) : void;
      
      function sendInvitesS(param1:Array, param2:String) : void;
      
      function getAllAvailableContactsS() : Array;
      
      function as_onReceiveSendInvitesCooldown(param1:uint) : void;
      
      function as_setDefaultOnlineFlag(param1:Boolean) : void;
      
      function as_setInvalidUserTags(param1:Array) : void;
      
      function as_setWindowTitle(param1:String) : void;
      
      function as_onContactUpdated(param1:Object) : void;
      
      function as_onListStateChanged(param1:Boolean) : void;
      
      function as_enableDescription(param1:Boolean) : void;
      
      function as_enableMassSend(param1:Boolean, param2:String) : void;
   }
}
