package net.wg.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;
   
   public interface ITeamBasesPanelMeta extends IEventDispatcher
   {
       
      
      function as_add(param1:Number, param2:Number, param3:String, param4:String, param5:Number, param6:String, param7:String) : void;
      
      function as_remove(param1:Number) : void;
      
      function as_stopCapture(param1:Number, param2:Number) : void;
      
      function as_updateCaptureData(param1:Number, param2:Number, param3:Number, param4:String, param5:String, param6:String, param7:String) : void;
      
      function as_setCaptured(param1:Number, param2:String) : void;
      
      function as_setOffsetForEnemyPoints() : void;
      
      function as_clear() : void;
   }
}
