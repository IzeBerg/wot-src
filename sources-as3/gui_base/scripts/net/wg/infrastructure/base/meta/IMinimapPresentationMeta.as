package net.wg.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;
   
   public interface IMinimapPresentationMeta extends IEventDispatcher
   {
       
      
      function setMapS(param1:Number) : void;
      
      function setMinimapDataS(param1:int, param2:int, param3:int) : void;
      
      function as_changeMap(param1:String) : void;
      
      function as_addPoint(param1:Number, param2:Number, param3:String, param4:String, param5:String) : void;
      
      function as_addPoi(param1:Number, param2:Number, param3:String, param4:String) : void;
      
      function as_clear() : void;
   }
}
