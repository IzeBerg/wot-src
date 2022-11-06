package net.wg.gui.lobby.battleResults
{
   public class AwardExtractor
   {
       
      
      public function AwardExtractor()
      {
         super();
      }
      
      public static function extract(param1:Array) : Array
      {
         var _loc2_:Object = null;
         var _loc3_:Array = null;
         var _loc4_:Object = null;
         var _loc7_:Object = null;
         var _loc5_:Boolean = false;
         loop0:
         for each(_loc2_ in param1)
         {
            _loc3_ = _loc2_.awards;
            for each(_loc4_ in _loc3_)
            {
               if(_loc4_.showInNewLine)
               {
                  _loc5_ = true;
                  break loop0;
               }
            }
         }
         if(!_loc5_)
         {
            return param1;
         }
         var _loc6_:Array = App.utils.data.cloneObject(param1);
         for each(_loc2_ in _loc6_)
         {
            _loc3_ = _loc2_.awards;
            for each(_loc4_ in _loc3_)
            {
               if(_loc4_.showInNewLine)
               {
                  _loc7_ = App.utils.data.cloneObject(_loc2_);
                  _loc7_.awards = [_loc4_];
                  _loc3_.splice(_loc3_.indexOf(_loc4_),1);
                  _loc6_.push(_loc7_);
                  return _loc6_;
               }
            }
         }
         return _loc6_;
      }
   }
}
