package net.wg.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;
   
   public interface ICrewMeta extends IEventDispatcher
   {
       
      
      function onShowRecruitWindowClickS(param1:Object, param2:Boolean) : void;
      
      function unloadAllTankmanS() : void;
      
      function equipTankmanS(param1:String, param2:Number) : void;
      
      function updateTankmenS() : void;
      
      function openPersonalCaseS(param1:String, param2:uint) : void;
      
      function onCrewDogMoreInfoClickS() : void;
      
      function onCrewDogItemClickS() : void;
      
      function as_tankmenResponse(param1:Object) : void;
      
      function as_dogResponse(param1:String) : void;
      
      function as_setDogTooltip(param1:String) : void;
   }
}
