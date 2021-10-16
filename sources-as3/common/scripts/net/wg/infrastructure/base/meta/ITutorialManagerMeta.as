package net.wg.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;
   
   public interface ITutorialManagerMeta extends IEventDispatcher
   {
       
      
      function onComponentFoundS(param1:String, param2:String) : Array;
      
      function onComponentDisposedS(param1:String) : void;
      
      function onTriggerActivatedS(param1:String, param2:String, param3:Boolean) : void;
      
      function onEffectCompletedS(param1:String, param2:String) : void;
      
      function onUbTrackedVarChangedS(param1:String, param2:String, param3:String, param4:Object) : void;
      
      function as_setSystemEnabled(param1:Boolean) : void;
      
      function as_setDescriptions(param1:Object) : void;
      
      function as_setCriteria(param1:String, param2:String) : void;
      
      function as_setTriggers(param1:String, param2:Array) : void;
      
      function as_showEffect(param1:String, param2:String, param3:String, param4:Object) : void;
      
      function as_hideEffect(param1:String, param2:String, param3:String, param4:String) : void;
      
      function as_setComponentViewCriteria(param1:String, param2:String) : void;
      
      function as_getComponentGlobalBounds(param1:String, param2:String) : Object;
      
      function as_getComponentPath(param1:String, param2:String) : String;
      
      function as_setConditions(param1:Object) : void;
      
      function as_externalComponentFound(param1:String, param2:String, param3:Object) : void;
      
      function as_updateExternalComponent(param1:String, param2:String, param3:Object) : void;
      
      function as_disposeExternalComponent(param1:String, param2:String) : void;
   }
}
