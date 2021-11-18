package net.wg.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;
   
   public interface ISkillDropMeta extends IEventDispatcher
   {
       
      
      function calcDropSkillsParamsS(param1:String, param2:Number) : Array;
      
      function dropSkillsS(param1:Number) : void;
      
      function as_setData(param1:Object) : void;
      
      function as_updateRetrainButtonsData(param1:Array) : void;
   }
}
