package net.wg.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;
   
   public interface IStorageCategoryCustomizationViewMeta extends IEventDispatcher
   {
       
      
      function navigateToCustomizationS() : void;
      
      function sellCustomizationItemS(param1:Number, param2:Number) : void;
      
      function previewItemS(param1:Number, param2:Number) : void;
   }
}
