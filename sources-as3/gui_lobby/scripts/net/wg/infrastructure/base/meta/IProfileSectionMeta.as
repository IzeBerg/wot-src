package net.wg.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;
   
   public interface IProfileSectionMeta extends IEventDispatcher
   {
       
      
      function setActiveS(param1:Boolean) : void;
      
      function requestDataS(param1:int) : void;
      
      function requestDossierS(param1:String) : void;
      
      function as_update(param1:Object) : void;
      
      function as_setInitData(param1:Object) : void;
      
      function as_responseDossier(param1:String, param2:Object, param3:String, param4:String) : void;
   }
}
