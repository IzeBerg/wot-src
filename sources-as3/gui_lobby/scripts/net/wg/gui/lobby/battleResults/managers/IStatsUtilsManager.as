package net.wg.gui.lobby.battleResults.managers
{
   import flash.display.DisplayObject;
   
   public interface IStatsUtilsManager
   {
       
      
      function mergeArrays(param1:Array, param2:Array) : Array;
      
      function shiftBlockVertically(param1:int, param2:Vector.<DisplayObject>) : void;
      
      function positionBlockBelow(param1:DisplayObject, param2:DisplayObject, param3:Vector.<DisplayObject>, param4:int) : void;
   }
}
