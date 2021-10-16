package net.wg.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;
   
   public interface IMapsTrainingGoalsMeta extends IEventDispatcher
   {
       
      
      function as_update(param1:Array) : void;
      
      function as_destroyGoal(param1:String) : void;
      
      function as_showHint(param1:String, param2:String, param3:String) : void;
      
      function as_hideHint() : void;
      
      function as_setVisible(param1:Boolean) : void;
   }
}
