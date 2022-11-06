package net.wg.gui.messenger.meta
{
   import flash.events.IEventDispatcher;
   
   public interface IContactsListPopoverMeta extends IEventDispatcher
   {
       
      
      function addToFriendsS(param1:Number, param2:String) : void;
      
      function addToIgnoredS(param1:Number, param2:String) : void;
      
      function isEnabledInRoamingS(param1:Number) : Boolean;
      
      function changeGroupS(param1:Number, param2:String, param3:Object) : void;
      
      function copyIntoGroupS(param1:Number, param2:Object) : void;
      
      function as_setInitInfo(param1:Object) : void;
      
      function as_editGroup(param1:String) : void;
      
      function as_removeGroup(param1:String) : void;
      
      function as_createContactNote(param1:String, param2:Number) : void;
      
      function as_editContactNote(param1:String, param2:Number) : void;
   }
}
