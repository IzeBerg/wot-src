package net.wg.infrastructure.interfaces
{
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public interface IDialogDispatcher extends IDisposable
   {
       
      
      function set onClose(param1:Function) : void;
      
      function get onClose() : Function;
      
      function set onSubmit(param1:Function) : void;
      
      function get onSubmit() : Function;
      
      function set onButtonClick(param1:Function) : void;
      
      function get onButtonClick() : Function;
      
      function set handlersInfo(param1:Array) : void;
      
      function get handlersInfo() : Array;
   }
}
