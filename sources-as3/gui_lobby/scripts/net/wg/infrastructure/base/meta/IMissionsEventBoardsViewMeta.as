package net.wg.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;
   
   public interface IMissionsEventBoardsViewMeta extends IEventDispatcher
   {
       
      
      function openBoardViewS() : void;
      
      function participateClickS(param1:String) : void;
      
      function orderClickS(param1:String) : void;
      
      function techniqueClickS(param1:String) : void;
      
      function awardClickS(param1:String) : void;
      
      function registrationClickS(param1:String) : void;
      
      function serverClickS(param1:String, param2:String) : void;
      
      function expandS(param1:String, param2:Boolean) : void;
      
      function as_setMaintenance(param1:Boolean, param2:String, param3:String, param4:String) : void;
      
      function as_setPlayFadeInTweenEnabled(param1:Boolean) : void;
   }
}
