package net.wg.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;
   
   public interface IBattleTutorialMeta extends IEventDispatcher
   {
       
      
      function as_populateProgressBar(param1:int, param2:int) : void;
      
      function as_setTrainingProgressBar(param1:int) : void;
      
      function as_setChapterProgressBar(param1:int, param2:int) : void;
      
      function as_showGreeting(param1:String, param2:String, param3:String) : void;
      
      function as_setChapterInfo(param1:String) : void;
      
      function as_showNextTask(param1:String, param2:String, param3:Object) : void;
      
      function as_showHint(param1:String, param2:String, param3:String, param4:String) : void;
      
      function as_hideGreeting(param1:String) : void;
   }
}
