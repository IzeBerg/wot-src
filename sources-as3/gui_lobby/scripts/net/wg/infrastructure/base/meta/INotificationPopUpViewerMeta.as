package net.wg.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;
   
   public interface INotificationPopUpViewerMeta extends IEventDispatcher
   {
       
      
      function setListClearS() : void;
      
      function onMessageHiddenS(param1:Boolean, param2:Boolean, param3:int, param4:Number) : void;
      
      function onClickActionS(param1:uint, param2:Number, param3:String) : void;
      
      function getMessageActualTimeS(param1:Number) : String;
      
      function as_hasPopUpIndex(param1:uint, param2:Number) : Boolean;
      
      function as_appendMessage(param1:Object) : void;
      
      function as_updateMessage(param1:Object) : void;
      
      function as_removeMessage(param1:uint, param2:Number) : void;
      
      function as_removeAllMessages() : void;
      
      function as_initInfo(param1:Number, param2:Number) : void;
   }
}
