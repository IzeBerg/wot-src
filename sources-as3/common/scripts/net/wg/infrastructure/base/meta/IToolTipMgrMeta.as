package net.wg.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;
   
   public interface IToolTipMgrMeta extends IEventDispatcher
   {
       
      
      function onCreateComplexTooltipS(param1:String, param2:String) : void;
      
      function onCreateTypedTooltipS(param1:String, param2:Array, param3:String) : void;
      
      function onHideTooltipS(param1:String) : void;
      
      function onCreateWulfTooltipS(param1:String, param2:Array, param3:int, param4:int) : void;
      
      function as_show(param1:Object, param2:String, param3:Boolean) : void;
      
      function as_hide() : void;
   }
}
