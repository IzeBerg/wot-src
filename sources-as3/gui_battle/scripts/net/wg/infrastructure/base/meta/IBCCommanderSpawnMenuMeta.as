package net.wg.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;
   
   public interface IBCCommanderSpawnMenuMeta extends IEventDispatcher
   {
       
      
      function as_showFooterHintText(param1:Boolean, param2:String) : void;
      
      function as_showButtonArrowHint(param1:Boolean, param2:String) : void;
      
      function as_setEnemyNameVisibility(param1:Boolean) : void;
   }
}
