package net.wg.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;
   
   public interface IEventBasesPanelMeta extends IEventDispatcher
   {
       
      
      function as_setBase1ID(param1:int) : void;
      
      function as_setBase2ID(param1:int) : void;
      
      function as_setBase1State(param1:String, param2:String) : void;
      
      function as_setBase2State(param1:String, param2:String) : void;
      
      function as_setBase1Progress(param1:Number, param2:String) : void;
      
      function as_setBase2Progress(param1:Number, param2:String) : void;
      
      function as_setVisibility(param1:Boolean) : void;
      
      function as_setColorBlind(param1:Boolean) : void;
   }
}
