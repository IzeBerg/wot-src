package net.wg.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;
   
   public interface ITrainingWindowMeta extends IEventDispatcher
   {
       
      
      function updateTrainingRoomS(param1:Number, param2:Number, param3:int, param4:String) : void;
      
      function as_setData(param1:Object, param2:Array) : void;
   }
}
