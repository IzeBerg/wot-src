package net.wg.gui.components.controls.helpers
{
   import flash.display.MovieClip;
   
   public final class ComponentStatesHelper
   {
      
      private static var _instance:ComponentStatesHelper = null;
       
      
      public function ComponentStatesHelper()
      {
         super();
         _instance = this;
      }
      
      public static function getInstance() : ComponentStatesHelper
      {
         if(_instance == null)
         {
            _instance = new ComponentStatesHelper();
         }
         return _instance;
      }
      
      public function compareStatesLabels(param1:Vector.<MovieClip>) : Boolean
      {
         var _loc4_:MovieClip = null;
         var _loc5_:Array = null;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc2_:int = param1.length;
         var _loc3_:int = param1[0].currentLabels.length;
         for each(_loc4_ in param1)
         {
            if(_loc4_.currentLabels.length != _loc3_)
            {
               return false;
            }
         }
         _loc5_ = [];
         _loc6_ = 0;
         while(_loc6_ < _loc2_)
         {
            _loc5_[_loc6_] = param1[_loc6_].currentLabels;
            _loc7_ = 0;
            while(_loc7_ < _loc3_)
            {
               _loc5_[_loc6_][_loc7_] = _loc5_[_loc6_][_loc7_].name;
               _loc7_++;
            }
            _loc6_++;
         }
         _loc6_ = 1;
         while(_loc6_ < _loc2_)
         {
            _loc7_ = 0;
            while(_loc7_ < _loc3_)
            {
               if(_loc5_[_loc6_].indexOf(_loc5_[0][_loc7_]) == -1)
               {
                  return false;
               }
               _loc7_++;
            }
            _loc6_++;
         }
         return true;
      }
   }
}
