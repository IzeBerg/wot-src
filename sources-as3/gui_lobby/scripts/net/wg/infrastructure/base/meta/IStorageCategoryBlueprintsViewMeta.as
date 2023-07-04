package net.wg.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;
   
   public interface IStorageCategoryBlueprintsViewMeta extends IEventDispatcher
   {
       
      
      function navigateToBlueprintScreenS(param1:int) : void;
      
      function selectConvertibleS(param1:Boolean) : void;
      
      function as_updateIntelligenceData(param1:Object) : void;
      
      function as_updateNationalFragments(param1:Array) : void;
      
      function as_updateCanConvert(param1:Boolean) : void;
   }
}
