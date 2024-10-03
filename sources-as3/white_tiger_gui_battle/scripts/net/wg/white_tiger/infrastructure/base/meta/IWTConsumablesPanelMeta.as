package net.wg.white_tiger.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;
   
   public interface IWTConsumablesPanelMeta extends IEventDispatcher
   {
       
      
      function as_setChargeProgress(param1:int, param2:Number, param3:Boolean) : void;
      
      function as_setSelected(param1:int, param2:Boolean) : void;
      
      function as_setDebuffView(param1:int, param2:Boolean) : void;
   }
}
