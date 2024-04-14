package net.wg.gui.lobby.battleResults.managers.impl
{
   import flash.display.DisplayObject;
   import net.wg.gui.lobby.battleResults.managers.IStatsUtilsManager;
   
   public final class StatsUtilsManager implements IStatsUtilsManager
   {
      
      private static var ms_instance:StatsUtilsManager = null;
       
      
      public function StatsUtilsManager()
      {
         super();
         ms_instance = this;
      }
      
      public static function getInstance() : IStatsUtilsManager
      {
         if(ms_instance == null)
         {
            ms_instance = new StatsUtilsManager();
         }
         return ms_instance;
      }
      
      public function mergeArrays(param1:Array, param2:Array) : Array
      {
         if(param1 != null && param2 != null)
         {
            return param1.concat(param2);
         }
         if(param1 != null)
         {
            return param1;
         }
         if(param2 != null)
         {
            return param2;
         }
         return null;
      }
      
      public function positionBlockBelow(param1:DisplayObject, param2:DisplayObject, param3:Vector.<DisplayObject>, param4:int) : void
      {
         var _loc5_:int = param1.y + param1.height + param4;
         this.shiftBlockVertically(_loc5_ - param2.y,param3);
      }
      
      public function shiftBlockVertically(param1:int, param2:Vector.<DisplayObject>) : void
      {
         var _loc3_:DisplayObject = null;
         if(param1 != 0)
         {
            for each(_loc3_ in param2)
            {
               _loc3_.y += param1;
            }
         }
      }
   }
}
