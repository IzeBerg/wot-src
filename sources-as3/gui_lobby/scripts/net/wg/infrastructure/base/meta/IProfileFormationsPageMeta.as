package net.wg.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;
   
   public interface IProfileFormationsPageMeta extends IEventDispatcher
   {
       
      
      function showFortS() : void;
      
      function createFortS() : void;
      
      function onClanLinkNavigateS(param1:String) : void;
      
      function as_setClanInfo(param1:Object) : void;
      
      function as_setFortInfo(param1:Object) : void;
      
      function as_setClanEmblem(param1:String) : void;
   }
}
