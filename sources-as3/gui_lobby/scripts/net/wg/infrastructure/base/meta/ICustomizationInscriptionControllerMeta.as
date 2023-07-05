package net.wg.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;
   
   public interface ICustomizationInscriptionControllerMeta extends IEventDispatcher
   {
       
      
      function sendCharS(param1:String) : void;
      
      function finishS() : void;
      
      function removeCharS() : void;
      
      function deleteAllS() : void;
      
      function as_show(param1:uint) : void;
      
      function as_hide() : void;
      
      function as_invalidInscription(param1:Object) : void;
      
      function as_showHint(param1:Object) : void;
   }
}
