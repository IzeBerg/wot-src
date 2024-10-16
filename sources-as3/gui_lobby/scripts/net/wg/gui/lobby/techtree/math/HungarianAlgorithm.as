package net.wg.gui.lobby.techtree.math
{
   public final class HungarianAlgorithm
   {
       
      
      private var C:Array;
      
      private var rowCovered:Array;
      
      private var columnCovered:Array;
      
      private var n:uint;
      
      private var Z0Row:Number;
      
      private var Z0Column:Number;
      
      private var marked:Array;
      
      private var path:Array;
      
      public function HungarianAlgorithm()
      {
         super();
      }
      
      private static function padMatrix(param1:Array, param2:Number = 0) : Array
      {
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc8_:Array = null;
         var _loc3_:int = 0;
         var _loc4_:uint = param1.length;
         var _loc5_:int = _loc4_;
         _loc6_ = 0;
         while(_loc6_ < _loc5_)
         {
            _loc8_ = param1[_loc6_];
            _loc3_ = Math.max(_loc3_,_loc8_.length);
            _loc6_++;
         }
         _loc5_ = Math.max(_loc3_,_loc5_);
         var _loc9_:Array = [];
         _loc6_ = 0;
         while(_loc6_ < _loc4_)
         {
            _loc8_ = param1[_loc6_];
            _loc7_ = _loc8_.length;
            while(_loc7_ < _loc5_)
            {
               _loc8_.push(param2);
               _loc7_++;
            }
            _loc9_.push(_loc8_);
            _loc6_++;
         }
         while(_loc6_ < _loc5_)
         {
            _loc8_ = [];
            _loc7_ = 0;
            while(_loc7_ < _loc5_)
            {
               _loc8_.push(param2);
               _loc7_++;
            }
            _loc9_.push(_loc8_);
            _loc6_++;
         }
         return _loc9_;
      }
      
      private static function makeMatrix(param1:Number, param2:Number) : Array
      {
         var _loc4_:Array = null;
         var _loc6_:int = 0;
         var _loc3_:Array = [];
         var _loc5_:int = 0;
         while(_loc5_ < param1)
         {
            _loc4_ = [];
            _loc6_ = 0;
            while(_loc6_ < param1)
            {
               _loc4_.push(param2);
               _loc6_++;
            }
            _loc3_.push(_loc4_);
            _loc5_++;
         }
         return _loc3_;
      }
      
      public function compute(param1:Array) : Array
      {
         var _loc4_:int = 0;
         var _loc8_:int = 0;
         this.C = padMatrix(param1);
         this.n = this.C.length;
         var _loc2_:uint = param1.length;
         var _loc3_:uint = param1[0].length;
         this.rowCovered = [];
         _loc4_ = 0;
         while(_loc4_ < this.n)
         {
            this.rowCovered.push(false);
            _loc4_++;
         }
         this.columnCovered = [];
         _loc4_ = 0;
         while(_loc4_ < this.n)
         {
            this.columnCovered.push(false);
            _loc4_++;
         }
         this.Z0Row = 0;
         this.Z0Column = 0;
         this.path = makeMatrix(this.n * 2,0);
         this.marked = makeMatrix(this.n,0);
         var _loc5_:int = 1;
         var _loc6_:Boolean = false;
         while(!_loc6_)
         {
            switch(_loc5_)
            {
               case 1:
                  _loc5_ = this.step1();
                  break;
               case 2:
                  _loc5_ = this.step2();
                  break;
               case 3:
                  _loc5_ = this.step3();
                  break;
               case 4:
                  _loc5_ = this.step4();
                  break;
               case 5:
                  _loc5_ = this.step5();
                  break;
               case 6:
                  _loc5_ = this.step6();
                  break;
               case 7:
                  _loc6_ = true;
                  break;
            }
         }
         var _loc7_:Array = [];
         _loc4_ = 0;
         while(_loc4_ < _loc2_)
         {
            _loc8_ = 0;
            while(_loc8_ < _loc3_)
            {
               if(this.marked[_loc4_][_loc8_] == 1)
               {
                  _loc7_.push({
                     "row":_loc4_,
                     "column":_loc8_
                  });
               }
               _loc8_++;
            }
            _loc4_++;
         }
         return _loc7_;
      }
      
      public function makeCostMatrix(param1:Array, param2:Function) : Array
      {
         var _loc6_:Array = null;
         var _loc7_:Array = null;
         var _loc8_:uint = 0;
         var _loc9_:Number = NaN;
         var _loc3_:Array = [];
         var _loc4_:uint = param1.length;
         var _loc5_:int = 0;
         while(_loc5_ < _loc4_)
         {
            _loc6_ = param1[_loc5_];
            _loc7_ = [];
            _loc8_ = _loc6_.length;
            _loc9_ = 0;
            while(_loc9_ < _loc8_)
            {
               _loc7_.push(param2(_loc6_[_loc9_]));
               _loc9_++;
            }
            _loc3_.push(_loc7_);
            _loc5_++;
         }
         return _loc3_;
      }
      
      private function clearCovers() : void
      {
         var _loc1_:int = 0;
         while(_loc1_ < this.n)
         {
            this.rowCovered[_loc1_] = false;
            this.columnCovered[_loc1_] = false;
            _loc1_++;
         }
      }
      
      private function findZero() : Object
      {
         var _loc5_:int = 0;
         var _loc1_:int = -1;
         var _loc2_:int = -1;
         var _loc3_:int = 0;
         var _loc4_:Boolean = false;
         while(!_loc4_)
         {
            _loc5_ = 0;
            while(true)
            {
               if(this.C[_loc3_][_loc5_] == 0 && !this.rowCovered[_loc3_] && !this.columnCovered[_loc5_])
               {
                  _loc1_ = _loc3_;
                  _loc2_ = _loc5_;
                  _loc4_ = true;
               }
               _loc5_ += 1;
               if(_loc5_ >= this.n)
               {
                  break;
               }
            }
            _loc3_ += 1;
            if(_loc3_ >= this.n)
            {
               _loc4_ = true;
            }
         }
         return {
            "row":_loc1_,
            "col":_loc2_
         };
      }
      
      private function findSmallest() : Number
      {
         var _loc3_:uint = 0;
         var _loc1_:Number = Number.MAX_VALUE;
         var _loc2_:uint = 0;
         while(_loc2_ < this.n)
         {
            _loc3_ = 0;
            while(_loc3_ < this.n)
            {
               if(!this.rowCovered[_loc2_] && !this.columnCovered[_loc3_])
               {
                  if(_loc1_ > this.C[_loc2_][_loc3_])
                  {
                     _loc1_ = this.C[_loc2_][_loc3_];
                  }
               }
               _loc3_++;
            }
            _loc2_++;
         }
         return _loc1_;
      }
      
      private function findStarInRow(param1:int) : int
      {
         var _loc2_:int = -1;
         var _loc3_:uint = 0;
         while(_loc3_ < this.n)
         {
            if(this.marked[param1][_loc3_] == 1)
            {
               _loc2_ = _loc3_;
               break;
            }
            _loc3_++;
         }
         return _loc2_;
      }
      
      private function findStarInCol(param1:int) : int
      {
         var _loc2_:int = -1;
         var _loc3_:int = 0;
         while(_loc3_ < this.n)
         {
            if(this.marked[_loc3_][param1] == 1)
            {
               _loc2_ = _loc3_;
               break;
            }
            _loc3_++;
         }
         return _loc2_;
      }
      
      private function findPrimeInRow(param1:int) : int
      {
         var _loc2_:int = -1;
         var _loc3_:int = 0;
         while(_loc3_ < this.n)
         {
            if(this.marked[param1][_loc3_] == 2)
            {
               _loc2_ = _loc3_;
               break;
            }
            _loc3_++;
         }
         return _loc2_;
      }
      
      private function convertPath(param1:Array, param2:int) : void
      {
         var _loc3_:Number = param2 + 1;
         var _loc4_:int = 0;
         while(_loc4_ < _loc3_)
         {
            if(this.marked[param1[_loc4_][0]][param1[_loc4_][1]] == 1)
            {
               this.marked[param1[_loc4_][0]][param1[_loc4_][1]] = 0;
            }
            else
            {
               this.marked[param1[_loc4_][0]][param1[_loc4_][1]] = 1;
            }
            _loc4_++;
         }
      }
      
      private function erasePrimes() : void
      {
         var _loc2_:uint = 0;
         var _loc1_:uint = 0;
         while(_loc1_ < this.n)
         {
            _loc2_ = 0;
            while(_loc2_ < this.n)
            {
               if(this.marked[_loc1_][_loc2_] == 2)
               {
                  this.marked[_loc1_][_loc2_] = 0;
               }
               _loc2_++;
            }
            _loc1_++;
         }
      }
      
      private function step1() : int
      {
         var _loc2_:Array = null;
         var _loc3_:int = 0;
         var _loc4_:uint = 0;
         var _loc1_:int = 0;
         while(_loc1_ < this.n)
         {
            _loc2_ = this.C[_loc1_];
            _loc3_ = int.MAX_VALUE;
            _loc4_ = 0;
            while(_loc4_ < this.n)
            {
               _loc3_ = Math.min(_loc2_[_loc4_],_loc3_);
               _loc4_++;
            }
            _loc4_ = 0;
            while(_loc4_ < this.n)
            {
               _loc2_[_loc4_] -= _loc3_;
               _loc4_++;
            }
            _loc1_++;
         }
         return 2;
      }
      
      private function step2() : int
      {
         var _loc2_:Array = null;
         var _loc3_:int = 0;
         var _loc1_:int = 0;
         while(_loc1_ < this.n)
         {
            _loc2_ = this.C[_loc1_];
            _loc3_ = 0;
            while(_loc3_ < this.n)
            {
               if(_loc2_[_loc3_] == 0 && !this.columnCovered[_loc3_] && !this.rowCovered[_loc1_])
               {
                  this.marked[_loc1_][_loc3_] = 1;
                  this.columnCovered[_loc3_] = true;
                  this.rowCovered[_loc1_] = true;
               }
               _loc3_++;
            }
            _loc1_++;
         }
         this.clearCovers();
         return 3;
      }
      
      private function step3() : int
      {
         var _loc3_:int = 0;
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         while(_loc2_ < this.n)
         {
            _loc3_ = 0;
            while(_loc3_ < this.n)
            {
               if(this.marked[_loc2_][_loc3_] == 1)
               {
                  this.columnCovered[_loc3_] = true;
                  _loc1_ += 1;
               }
               _loc3_++;
            }
            _loc2_++;
         }
         return _loc1_ >= this.n ? int(7) : int(4);
      }
      
      private function step4() : int
      {
         var _loc6_:Object = null;
         var _loc1_:int = 0;
         var _loc2_:Boolean = false;
         var _loc3_:int = -1;
         var _loc4_:int = -1;
         var _loc5_:int = -1;
         while(!_loc2_)
         {
            _loc6_ = this.findZero();
            _loc3_ = _loc6_.row;
            _loc4_ = _loc6_.col;
            if(_loc3_ < 0)
            {
               _loc2_ = true;
               _loc1_ = 6;
            }
            else
            {
               this.marked[_loc3_][_loc4_] = 2;
               _loc5_ = this.findStarInRow(_loc3_);
               if(_loc5_ >= 0)
               {
                  _loc4_ = _loc5_;
                  this.rowCovered[_loc3_] = true;
                  this.columnCovered[_loc4_] = false;
               }
               else
               {
                  _loc2_ = true;
                  this.Z0Row = _loc3_;
                  this.Z0Column = _loc4_;
                  _loc1_ = 5;
               }
            }
         }
         return _loc1_;
      }
      
      private function step5() : int
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc1_:int = 0;
         this.path[_loc1_][0] = this.Z0Row;
         this.path[_loc1_][1] = this.Z0Column;
         var _loc2_:Boolean = false;
         while(!_loc2_)
         {
            _loc3_ = this.findStarInCol(this.path[_loc1_][1]);
            if(_loc3_ >= 0)
            {
               _loc1_ += 1;
               this.path[_loc1_][0] = _loc3_;
               this.path[_loc1_][1] = this.path[_loc1_ - 1][1];
            }
            else
            {
               _loc2_ = true;
            }
            if(!_loc2_)
            {
               _loc4_ = this.findPrimeInRow(this.path[_loc1_][0]);
               _loc1_ += 1;
               this.path[_loc1_][0] = this.path[_loc1_ - 1][0];
               this.path[_loc1_][1] = _loc4_;
            }
         }
         this.convertPath(this.path,_loc1_);
         this.clearCovers();
         this.erasePrimes();
         return 3;
      }
      
      private function step6() : int
      {
         var _loc3_:int = 0;
         var _loc1_:int = this.findSmallest();
         var _loc2_:int = 0;
         while(_loc2_ < this.n)
         {
            _loc3_ = 0;
            while(_loc3_ < this.n)
            {
               if(this.rowCovered[_loc2_])
               {
                  this.C[_loc2_][_loc3_] += _loc1_;
               }
               if(!this.columnCovered[_loc3_])
               {
                  this.C[_loc2_][_loc3_] -= _loc1_;
               }
               _loc3_++;
            }
            _loc2_++;
         }
         return 4;
      }
   }
}
