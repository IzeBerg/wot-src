package net.wg.gui.prebattle.meta
{
   import flash.events.IEventDispatcher;
   
   public interface IBattleSessionWindowMeta extends IEventDispatcher
   {
       
      
      function requestToAssignMemberS(param1:Number) : void;
      
      function requestToUnassignMemberS(param1:Number) : void;
      
      function canMoveToAssignedS(param1:Number) : Boolean;
      
      function canMoveToUnassignedS(param1:Number) : Boolean;
      
      function setSelectedFilterS(param1:String) : void;
      
      function onCantMoveSS(param1:Number) : void;
      
      function as_setStartTime(param1:String) : void;
      
      function as_setTotalPlayersCount(param1:String) : void;
      
      function as_setInfo(param1:Boolean, param2:String, param3:String, param4:String, param5:String, param6:String, param7:String, param8:String, param9:int, param10:int, param11:uint) : void;
      
      function as_setWinnerIfDraw(param1:int) : void;
      
      function as_setNationsLimits(param1:Array) : void;
      
      function as_setClassesLimits(param1:Object, param2:Boolean) : void;
      
      function as_setCommonLimits(param1:String, param2:Number) : void;
      
      function as_setPlayersCountText(param1:String) : void;
      
      function as_setFilters(param1:Array, param2:uint) : void;
   }
}
