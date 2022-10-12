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
         var _loc3_:int = 0;
         var _loc4_:String = null;
         var _loc6_:String = null;
         var _loc7_:int = 0;
         var _loc8_:String = null;
         var _loc2_:String = "     ";
         var _loc5_:uint = param1.length;
         _loc3_ = 0;
         while(_loc3_ < _loc5_)
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
         while(_loc3_ < _loc5_)
         {
            _loc4_ = _loc3_.toString();
            if(_loc4_.length == 1)
            {
               _loc4_ += " ";
            }
            _loc6_ = _loc4_ + "[ ";
            _loc7_ = 0;
            while(_loc7_ < _loc5_)
            {
               _loc8_ = param1[_loc3_][_loc7_].toString();
               if(_loc8_.length == 1)
               {
                  _loc6_ += " " + _loc8_ + " ";
               }
               else
               {
                  _loc6_ += _loc8_ + " ";
               }
               _loc7_++;
            }
            _loc3_++;
         }
      }
      
      public static function printLevelsDump(param1:Array) : void
      {
         var _loc4_:Array = null;
         var _loc5_:String = null;
         var _loc6_:uint = 0;
         var _loc7_:int = 0;
         var _loc2_:uint = param1.length;
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_)
         {
            _loc4_ = param1[_loc3_];
            _loc5_ = "";
            _loc6_ = _loc4_.length;
            _loc7_ = 0;
            while(_loc7_ < _loc6_)
            {
               if(_loc4_[_loc7_] != null)
               {
                  _loc5_ += _loc4_[_loc7_].dx.toString() + " ";
               }
               else
               {
                  _loc5_ += "X ";
               }
               _loc7_++;
            }
            _loc3_++;
         }
      }
   }
}
