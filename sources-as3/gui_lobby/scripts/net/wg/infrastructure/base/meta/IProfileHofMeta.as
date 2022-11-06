package net.wg.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;
   
   public interface IProfileHofMeta extends IEventDispatcher
   {
       
      
      function showVehiclesRatingS() : void;
      
      function showAchievementsRatingS() : void;
      
      function changeStatusS() : void;
      
      function as_setStatus(param1:String) : void;
      
      function as_setBackground(param1:String) : void;
      
      function as_setBtnCounters(param1:Array) : void;
      
      function as_showServiceView(param1:String, param2:String) : void;
      
      function as_hideServiceView() : void;
      
      function as_showWaiting(param1:String) : void;
      
      function as_hideWaiting() : void;
   }
}
