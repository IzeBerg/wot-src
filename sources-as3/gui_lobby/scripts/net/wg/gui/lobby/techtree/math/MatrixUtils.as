package net.wg.gui.lobby.techtree.math
{
   public class MatrixUtils
   {
       
      
      public function MatrixUtils()
      {
         super();
      }
      
      public static function printMatrixDump(param1:Array) : void
      {
         var _loc3_:Number = NaN;
         var _loc4_:String = null;
         var _loc5_:String = null;
         var _loc6_:Number = NaN;
         var _loc7_:String = null;
         var _loc2_:String = "     ";
         _loc3_ = 0;
         while(_loc3_ < param1.length)
         {
            _loc4_ = _loc3_.toString();
            if(_loc4_.length == 1)
            {
               _loc4_ += " ";
            }
            _loc2_ += _loc4_ + " ";
            _loc3_++;
         }
         _loc3_ = 0;
         while(_loc3_ < param1.length)
         {
            _loc4_ = _loc3_.toString();
            if(_loc4_.length == 1)
            {
               _loc4_ += " ";
            }
            _loc5_ = _loc4_ + "[ ";
            _loc6_ = 0;
            while(_loc6_ < param1.length)
            {
               _loc7_ = param1[_loc3_][_loc6_].toString();
               if(_loc7_.length == 1)
               {
                  _loc5_ += " " + _loc7_ + " ";
               }
               else
               {
                  _loc5_ += _loc7_ + " ";
               }
               _loc6_++;
            }
            _loc3_++;
         }
      }
      
      public static function printLevelsDump(param1:Array) : void
      {
         var _loc3_:Array = null;
         var _loc4_:String = null;
         var _loc5_:Number = NaN;
         var _loc2_:Number = 0;
         while(_loc2_ < param1.length)
         {
            _loc3_ = param1[_loc2_];
            _loc4_ = "";
            _loc5_ = 0;
            while(_loc5_ < _loc3_.length)
            {
               if(_loc3_[_loc5_] != null)
               {
                  _loc4_ += _loc3_[_loc5_].dx.toString() + " ";
               }
               else
               {
                  _loc4_ += "X ";
               }
               _loc5_++;
            }
            _loc2_++;
         }
      }
   }
}
