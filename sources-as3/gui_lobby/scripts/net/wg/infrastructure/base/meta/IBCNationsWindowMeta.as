package net.wg.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;
   
   public interface IBCNationsWindowMeta extends IEventDispatcher
   {
       
      
      function onNationSelectedS(param1:String) : void;
      
      function onNationShowS(param1:String) : void;
      
      function as_selectNation(param1:uint, param2:Array) : void;
   }
}
