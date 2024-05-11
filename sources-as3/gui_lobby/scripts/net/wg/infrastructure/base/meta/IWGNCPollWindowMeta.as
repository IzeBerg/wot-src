package net.wg.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;
   
   public interface IWGNCPollWindowMeta extends IEventDispatcher
   {
       
      
      function onBtnClickS() : void;
      
      function onLinkClickS(param1:String) : void;
      
      function as_setWindowTitle(param1:String) : void;
      
      function as_setText(param1:String) : void;
      
      function as_setButtonLbl(param1:String) : void;
   }
}
