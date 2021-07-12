package net.wg.gui.prebattle.meta
{
   import flash.events.IEventDispatcher;
   
   public interface IPrequeueWindowMeta extends IEventDispatcher
   {
       
      
      function requestToEnqueueS() : void;
      
      function requestToLeaveS() : void;
      
      function showFAQWindowS() : void;
      
      function isEnqueueBtnEnabledS() : Boolean;
      
      function isLeaveBtnEnabledS() : Boolean;
      
      function as_enableLeaveBtn(param1:Boolean) : void;
      
      function as_enableEnqueueBtn(param1:Boolean) : void;
   }
}
