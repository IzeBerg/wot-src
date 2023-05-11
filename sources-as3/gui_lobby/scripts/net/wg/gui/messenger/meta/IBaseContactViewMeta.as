package net.wg.gui.messenger.meta
{
   import flash.events.IEventDispatcher;
   
   public interface IBaseContactViewMeta extends IEventDispatcher
   {
       
      
      function onOkS(param1:Object) : void;
      
      function onCancelS() : void;
      
      function as_update(param1:Object) : void;
      
      function as_setOkBtnEnabled(param1:Boolean) : void;
      
      function as_setInitData(param1:Object) : void;
      
      function as_closeView() : void;
   }
}
