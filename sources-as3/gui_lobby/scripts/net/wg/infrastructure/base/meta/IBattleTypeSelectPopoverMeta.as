package net.wg.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;
   
   public interface IBattleTypeSelectPopoverMeta extends IEventDispatcher
   {
       
      
      function selectFightS(param1:String) : void;
      
      function demoClickS() : void;
      
      function getTooltipDataS(param1:String, param2:Boolean) : Object;
      
      function as_update(param1:Array, param2:Array, param3:Boolean, param4:Boolean) : void;
      
      function as_showMiniClientInfo(param1:String, param2:String) : void;
   }
}
