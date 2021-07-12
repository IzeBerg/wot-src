package net.wg.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;
   import net.wg.infrastructure.interfaces.IDAAPIModule;
   
   public interface IBaseDAAPIComponentMeta extends IEventDispatcher
   {
       
      
      function registerFlashComponentS(param1:IDAAPIModule, param2:String) : void;
      
      function isFlashComponentRegisteredS(param1:String) : Boolean;
      
      function unregisterFlashComponentS(param1:String) : void;
      
      function getAliasS() : String;
      
      function as_populate() : void;
      
      function as_dispose() : void;
   }
}
