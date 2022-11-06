package net.wg.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;
   
   public interface IInputCheckerMeta extends IEventDispatcher
   {
       
      
      function sendUserInputS(param1:String, param2:Boolean) : void;
      
      function as_setTitle(param1:String) : void;
      
      function as_setBody(param1:String) : void;
      
      function as_setErrorMsg(param1:String) : void;
      
      function as_setFormattedControlNumber(param1:String) : void;
      
      function as_setOriginalControlNumber(param1:String) : void;
      
      function as_invalidUserText(param1:Boolean) : void;
   }
}
