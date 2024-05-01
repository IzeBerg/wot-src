package net.wg.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;
   
   public interface IHangarHeaderMeta extends IEventDispatcher
   {
       
      
      function onQuestBtnClickS(param1:String, param2:String) : void;
      
      function as_setData(param1:Object) : void;
      
      function as_setSecondaryEntryPointVisible(param1:Boolean) : void;
      
      function as_addEntryPoint(param1:String) : void;
      
      function as_addSecondaryEntryPoint(param1:String, param2:Boolean) : void;
   }
}
