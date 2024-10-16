package net.wg.gui.lobby.techtree.math
{
   public class ADG_ItemLevelsBuilder
   {
       
      
      private var matrixDimension:Number;
      
      private var widthPartitioning:Number;
      
      private var maxLevelWidth:Number;
      
      private var adjacencyMatrix:Array;
      
      private var maxPaths:Array;
      
      private var levels:Array;
      
      private var fixedPaths:Object;
      
      private var parentLevelIdxs:Object;
      
      private var childrenLevelIdxs:Object;
      
      private var isCyclicReference:Boolean = false;
      
      public function ADG_ItemLevelsBuilder(param1:Number, param2:Number)
      {
         super();
         if(param1 > 0)
         {
            this.matrixDimension = param1;
            this.createEmptyAdjacencyMatrix();
         }
         this.fixedPaths = {};
         this.maxLevelWidth = param2;
      }
      
      public function addFixedPath(param1:Number, param2:Number) : void
      {
         this.fixedPaths[param1] = param2;
      }
      
      public function getChildrenLevelIdxs(param1:Number) : Array
      {
         return this.childrenLevelIdxs[param1];
      }
      
      public function getParentLevelIdxs(param1:Number) : Array
      {
         return this.parentLevelIdxs[param1];
      }
      
      public function hasCyclicReference() : Boolean
      {
         return this.isCyclicReference;
      }
      
      public function process() : void
      {
         this.isCyclicReference = false;
         this.distributionOfVerticesOnLevels();
         this.determineNodesPositionsOnLevel();
      }
      
      private function createEmptyAdjacencyMatrix() : void
      {
         var _loc2_:int = 0;
         this.adjacencyMatrix = new Array(this.matrixDimension);
         var _loc1_:int = 0;
         while(_loc1_ < this.matrixDimension)
         {
            this.adjacencyMatrix[_loc1_] = [];
            _loc2_ = 0;
            while(_loc2_ < this.matrixDimension)
            {
               this.adjacencyMatrix[_loc1_][_loc2_] = 0;
               _loc2_++;
            }
            _loc1_++;
         }
      }
      
      private function normalizeLevels() : void
      {
         var _loc1_:int = 0;
         var _loc2_:uint = this.levels.length;
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            if(this.levels[_loc1_].length > this.maxLevelWidth)
            {
               this.zipLevel(_loc1_);
            }
            _loc1_++;
         }
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            this.alignLevel(_loc1_);
            _loc1_++;
         }
      }
      
      private function alignLevel(param1:Number) : void
      {
         var _loc4_:int = 0;
         var _loc2_:Array = this.levels[param1];
         var _loc3_:Number = this.maxLevelWidth - _loc2_.length;
         _loc4_ = 0;
         while(_loc4_ < _loc3_)
         {
            _loc2_.push(null);
            _loc4_++;
         }
         var _loc5_:uint = _loc2_.length;
         _loc4_ = 0;
         while(_loc4_ < _loc5_)
         {
            if(_loc2_[_loc4_] != null)
            {
               _loc2_[_loc4_].dx = _loc4_;
            }
            _loc4_++;
         }
      }
      
      private function mapLevel(param1:Number, param2:Array) : void
      {
         var _loc3_:uint = param2.length;
         var _loc4_:Array = this.levels[param1];
         if(_loc4_ == null)
         {
            return;
         }
         var _loc5_:Array = new Array(_loc3_);
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         while(_loc7_ < _loc3_)
         {
            if(param2[_loc7_] == 0)
            {
               _loc5_[_loc7_] = null;
               _loc6_++;
            }
            else
            {
               if(_loc4_[_loc8_] == null && _loc6_ > 0)
               {
                  _loc8_++;
                  _loc6_--;
               }
               _loc5_[_loc7_] = _loc4_[_loc8_];
               if(_loc5_[_loc7_] != null)
               {
                  _loc5_[_loc7_].dx = _loc7_;
               }
               _loc8_++;
            }
            _loc7_++;
         }
         this.levels[param1] = _loc5_;
      }
      
      private function addLevelItem(param1:Number, param2:Number, param3:Boolean, param4:Boolean) : void
      {
         var _loc6_:Number = NaN;
         if(this.levels[param1] == undefined)
         {
            this.levels[param1] = [];
         }
         this.levels[param1].push(new LevelItem(param2,this.levels[param1].length,param3));
         if(!param4)
         {
            return;
         }
         var _loc5_:Array = this.adjacencyMatrix[param2];
         var _loc7_:uint = _loc5_.length;
         var _loc8_:int = 0;
         while(_loc8_ < _loc7_)
         {
            _loc6_ = _loc5_[_loc8_];
            if(_loc6_ == 1 || _loc6_ == 2)
            {
               this.removeLevelItem(param1,_loc8_);
               this.addLevelItem(param1 + 1,_loc8_,_loc6_ == 2,true);
            }
            _loc8_++;
         }
      }
      
      private function removeLevelItem(param1:Number, param2:Number) : void
      {
         var _loc3_:Array = this.levels[param1];
         var _loc4_:Array = [];
         var _loc5_:uint = _loc3_.length;
         var _loc6_:int = 0;
         while(_loc6_ < _loc5_)
         {
            if(_loc3_[_loc6_].index != param2)
            {
               _loc4_.push(_loc3_[_loc6_]);
            }
            _loc6_++;
         }
         this.levels[param1] = _loc4_;
      }
      
      private function zipLevel(param1:Number) : void
      {
         var _loc4_:uint = 0;
         var _loc5_:int = 0;
         var _loc6_:LevelItem = null;
         var _loc7_:LevelItem = null;
         var _loc8_:Array = null;
         var _loc9_:Array = null;
         var _loc10_:int = 0;
         var _loc12_:Array = null;
         var _loc13_:int = 0;
         var _loc14_:Boolean = false;
         var _loc15_:int = 0;
         var _loc16_:uint = 0;
         var _loc17_:uint = 0;
         var _loc18_:int = 0;
         var _loc19_:Number = NaN;
         if(param1 < 1)
         {
            return;
         }
         var _loc2_:Array = this.levels[param1 - 1];
         var _loc3_:uint = _loc2_.length;
         var _loc11_:int = 0;
         while(_loc11_ < _loc3_)
         {
            _loc6_ = _loc2_[_loc11_];
            if(_loc6_ != null)
            {
               _loc8_ = this.adjacencyMatrix[_loc6_.index];
               _loc4_ = _loc8_.length;
               _loc5_ = 0;
               _loc9_ = [];
               _loc10_ = 0;
               while(_loc10_ < _loc4_)
               {
                  if(_loc8_[_loc10_] == 1)
                  {
                     _loc9_.push(_loc10_);
                     _loc5_++;
                  }
                  _loc10_++;
               }
               if(_loc5_ > 1)
               {
                  _loc12_ = this.levels[param1];
                  _loc13_ = -1;
                  _loc14_ = true;
                  _loc15_ = _loc5_ == 2 ? int(0) : int(1);
                  _loc16_ = _loc12_.length;
                  _loc10_ = 0;
                  while(_loc10_ < _loc16_)
                  {
                     _loc7_ = _loc12_[_loc10_];
                     _loc17_ = _loc9_.length;
                     _loc18_ = 0;
                     while(_loc18_ < _loc17_)
                     {
                        _loc19_ = _loc9_[_loc18_];
                        if(_loc7_.index == _loc19_ && _loc5_ > _loc15_)
                        {
                           if(_loc14_)
                           {
                              _loc13_ = this.addFakeNode(_loc7_,param1,_loc6_.index);
                           }
                           else if(_loc13_ > 0)
                           {
                              this.addFakeRelations(_loc6_.index,_loc7_.index,_loc13_);
                              this.addLevelItem(param1 + 1,_loc7_.index,false,true);
                              this.removeLevelItem(param1,_loc7_.index);
                           }
                           _loc5_--;
                           _loc14_ = _loc5_ % 2 > 0 && _loc15_ > 0;
                        }
                        _loc18_++;
                     }
                     _loc10_++;
                  }
               }
            }
            _loc11_++;
         }
      }
      
      private function buildLevelsCache() : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:Array = null;
         var _loc6_:LevelItem = null;
         var _loc8_:Array = null;
         var _loc9_:uint = 0;
         var _loc10_:Array = null;
         var _loc11_:Array = null;
         var _loc12_:int = 0;
         var _loc13_:Number = NaN;
         this.parentLevelIdxs = {};
         this.childrenLevelIdxs = {};
         var _loc1_:uint = this.levels.length;
         var _loc7_:Array = new Array(_loc1_);
         _loc3_ = 0;
         while(_loc3_ < _loc1_)
         {
            _loc5_ = this.levels[_loc3_];
            _loc7_[_loc3_] = {};
            _loc2_ = _loc5_.length;
            _loc4_ = 0;
            while(_loc4_ < _loc2_)
            {
               _loc6_ = _loc5_[_loc4_];
               if(_loc6_ != null)
               {
                  _loc7_[_loc3_][_loc6_.index] = _loc4_;
               }
               _loc4_++;
            }
            _loc3_++;
         }
         _loc1_ = this.levels.length;
         _loc3_ = 0;
         while(_loc3_ < _loc1_)
         {
            _loc5_ = this.levels[_loc3_];
            _loc2_ = _loc5_.length;
            _loc4_ = 0;
            while(_loc4_ < _loc2_)
            {
               _loc6_ = _loc5_[_loc4_];
               if(_loc6_ != null)
               {
                  _loc8_ = this.adjacencyMatrix[_loc6_.index];
                  _loc9_ = _loc8_.length;
                  _loc10_ = [];
                  _loc11_ = [];
                  _loc12_ = 0;
                  while(_loc12_ < _loc9_)
                  {
                     _loc13_ = _loc8_[_loc12_];
                     if(_loc13_ == 1 || _loc13_ == 2)
                     {
                        _loc10_.push(_loc7_[_loc3_ + 1][_loc12_]);
                     }
                     if(_loc13_ == -1 || _loc13_ == -2)
                     {
                        _loc11_.push(_loc7_[_loc3_ - 1][_loc12_]);
                     }
                     _loc12_++;
                  }
                  this.parentLevelIdxs[_loc6_.index] = _loc11_;
                  this.childrenLevelIdxs[_loc6_.index] = _loc10_;
               }
               _loc4_++;
            }
            _loc3_++;
         }
      }
      
      private function addFakeRelations(param1:Number, param2:Number, param3:Number) : void
      {
         this.adjacencyMatrix[param3][param2] = 2;
         this.adjacencyMatrix[param2][param3] = -2;
         this.adjacencyMatrix[param3][param1] = -2;
         this.adjacencyMatrix[param1][param3] = 2;
      }
      
      private function addFakeNode(param1:LevelItem, param2:Number, param3:Number) : Number
      {
         var _loc5_:int = 0;
         var _loc4_:uint = param1.index;
         this.adjacencyMatrix[param3][_loc4_] = 0;
         this.adjacencyMatrix[_loc4_][param3] = 0;
         _loc5_ = 0;
         while(_loc5_ < this.matrixDimension)
         {
            this.adjacencyMatrix[_loc5_].push(0);
            _loc5_++;
         }
         var _loc6_:Number = this.matrixDimension;
         ++this.matrixDimension;
         var _loc7_:Array = new Array(this.matrixDimension);
         var _loc8_:uint = _loc7_.length;
         _loc5_ = 0;
         while(_loc5_ < _loc8_)
         {
            _loc7_[_loc5_] = 0;
            _loc5_++;
         }
         this.adjacencyMatrix.push(_loc7_);
         this.addFakeRelations(param3,_loc4_,_loc6_);
         this.addLevelItem(param2 + 1,param1.index,param1.fake,true);
         param1.index = _loc6_;
         param1.fake = true;
         return _loc6_;
      }
      
      private function addFakeNodes(param1:LevelItem, param2:Number, param3:Number, param4:int) : Number
      {
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         while(_loc7_ < param4)
         {
            _loc6_ = this.addFakeNode(param1,param2,param3);
            if(_loc7_ == 0)
            {
               _loc5_ = _loc6_;
            }
            param1 = this.levels[param2][this.levels[param2].length - 1];
            _loc7_++;
         }
         return _loc5_;
      }
      
      private function hasFakeNode(param1:Number) : Boolean
      {
         var _loc2_:Array = this.levels[param1];
         var _loc3_:uint = _loc2_.length;
         var _loc4_:int = 0;
         while(_loc4_ < _loc3_)
         {
            if(_loc2_[_loc4_] != null && _loc2_[_loc4_].fake)
            {
               return true;
            }
            _loc4_++;
         }
         return false;
      }
      
      private function searchMaxPathLegth(param1:Number, param2:Number, param3:Array, param4:Number) : void
      {
         if(param4 > 20)
         {
            this.isCyclicReference = true;
            this.maxPaths[param2] = -1;
            return;
         }
         if(param3[param1] == -1 && (this.maxPaths[param2] < param4 || this.maxPaths[param2] == undefined))
         {
            this.maxPaths[param2] = param4;
            if(param4 > this.widthPartitioning)
            {
               this.widthPartitioning = param4;
            }
            return;
         }
         var _loc5_:uint = param3.length;
         var _loc6_:int = 0;
         while(_loc6_ < _loc5_)
         {
            if(_loc6_ != param1)
            {
               if(param3[_loc6_] == -1)
               {
                  this.searchMaxPathLegth(param1,param2,this.adjacencyMatrix[_loc6_],param4 + 1);
               }
            }
            _loc6_++;
         }
      }
      
      private function distributionOfVerticesOnLevels() : void
      {
         var _loc1_:int = 0;
         var _loc3_:Number = NaN;
         var _loc6_:LevelItem = null;
         var _loc7_:uint = 0;
         var _loc8_:Number = NaN;
         var _loc9_:Array = null;
         var _loc10_:uint = 0;
         var _loc11_:int = 0;
         this.maxPaths = new Array(this.matrixDimension);
         this.widthPartitioning = 0;
         this.maxPaths[0] = 0;
         _loc1_ = 1;
         while(_loc1_ < this.matrixDimension)
         {
            this.searchMaxPathLegth(0,_loc1_,this.adjacencyMatrix[_loc1_],1);
            _loc1_++;
         }
         var _loc2_:Number = 0;
         this.levels = new Array(this.widthPartitioning);
         this.addLevelItem(0,0,false,false);
         var _loc4_:uint = this.maxPaths.length;
         var _loc5_:Object = {};
         _loc1_ = 1;
         while(_loc1_ < _loc4_)
         {
            _loc3_ = this.maxPaths[_loc1_];
            _loc2_ = this.fixedPaths[_loc1_];
            this.addLevelItem(_loc3_,_loc1_,false,false);
            if(!isNaN(_loc2_) && _loc3_ < _loc2_)
            {
               _loc6_ = this.levels[_loc3_][this.levels[_loc3_].length - 1];
               _loc7_ = _loc6_.index;
               _loc8_ = _loc2_ - _loc3_;
               _loc9_ = this.adjacencyMatrix[_loc1_];
               _loc10_ = _loc9_.length;
               _loc11_ = 0;
               while(_loc11_ < _loc10_)
               {
                  if(_loc9_[_loc11_] == -1)
                  {
                     if(_loc5_[_loc11_] == null)
                     {
                        _loc5_[_loc11_] = this.addFakeNodes(_loc6_,_loc3_,_loc11_,_loc8_);
                     }
                     else
                     {
                        this.adjacencyMatrix[_loc7_][_loc5_[_loc11_]] = -2;
                        this.adjacencyMatrix[_loc5_[_loc11_]][_loc7_] = 2;
                        this.adjacencyMatrix[_loc7_][_loc11_] = 0;
                        this.adjacencyMatrix[_loc11_][_loc7_] = 0;
                        this.addLevelItem(_loc2_,_loc7_,false,true);
                        this.removeLevelItem(_loc3_,_loc7_);
                     }
                  }
                  _loc11_++;
               }
            }
            _loc1_++;
         }
         this.normalizeLevels();
      }
      
      private function getLines(param1:Number, param2:Boolean) : Array
      {
         var _loc4_:LevelLine = null;
         var _loc9_:int = 0;
         var _loc10_:Array = null;
         var _loc11_:LevelItem = null;
         var _loc12_:LevelItem = null;
         var _loc16_:int = 0;
         var _loc17_:int = 0;
         var _loc3_:Array = [];
         if(param1 == 0)
         {
            return _loc3_;
         }
         var _loc5_:Array = this.levels[param1];
         var _loc6_:uint = _loc5_.length;
         var _loc7_:Array = this.levels[!!param2 ? param1 + 1 : param1 - 1];
         if(!_loc7_)
         {
            return _loc3_;
         }
         var _loc8_:Number = _loc7_.length;
         var _loc13_:int = !!param2 ? int(1) : int(-1);
         var _loc14_:int = !!param2 ? int(2) : int(-2);
         var _loc15_:int = 0;
         while(_loc15_ < _loc6_)
         {
            _loc11_ = _loc5_[_loc15_];
            if(_loc11_ != null)
            {
               _loc10_ = this.adjacencyMatrix[_loc11_.index];
               _loc9_ = _loc10_.length;
               _loc16_ = 0;
               while(_loc16_ < _loc9_)
               {
                  if(_loc10_[_loc16_] == _loc13_ || _loc10_[_loc16_] == _loc14_)
                  {
                     _loc17_ = 0;
                     while(_loc17_ < _loc8_)
                     {
                        _loc12_ = _loc7_[_loc17_];
                        if(_loc12_ != null && _loc12_.index == _loc16_)
                        {
                           _loc4_ = !!param2 ? LevelLine.makeByNext(_loc11_,_loc12_) : LevelLine.makeByTop(_loc11_,_loc12_);
                           _loc3_.push(_loc4_);
                           break;
                        }
                        _loc17_++;
                     }
                  }
                  _loc16_++;
               }
            }
            _loc15_++;
         }
         return _loc3_;
      }
      
      private function getCrossingCost(param1:Array) : Number
      {
         var _loc4_:LevelLine = null;
         var _loc5_:LevelLine = null;
         var _loc6_:uint = 0;
         var _loc7_:uint = 0;
         var _loc10_:Number = NaN;
         var _loc2_:Number = 0;
         var _loc3_:uint = param1.length;
         var _loc8_:int = _loc3_ - 1;
         var _loc9_:int = 0;
         while(_loc9_ < _loc8_)
         {
            _loc4_ = param1[_loc9_];
            _loc10_ = _loc9_ + 1;
            while(_loc10_ < _loc3_)
            {
               _loc5_ = param1[_loc10_];
               _loc6_ = _loc4_.start - _loc5_.start;
               _loc7_ = _loc4_.end - _loc5_.end;
               if((_loc5_.start - _loc4_.start) * (_loc5_.end - _loc4_.end) < 0 && _loc6_ * _loc7_ < 0 || _loc4_.start != _loc4_.end && _loc6_ == _loc7_ && Math.abs(_loc6_) == 1)
               {
                  _loc2_ += this.maxLevelWidth + 1;
               }
               _loc10_++;
            }
            _loc9_++;
         }
         return _loc2_;
      }
      
      private function getCrossingCostEx(param1:Array) : Number
      {
         var _loc4_:LevelLine = null;
         var _loc5_:LevelLine = null;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc10_:int = 0;
         var _loc11_:uint = 0;
         var _loc12_:uint = 0;
         var _loc13_:uint = 0;
         var _loc14_:uint = 0;
         var _loc2_:Number = 0;
         var _loc3_:uint = param1.length;
         var _loc8_:int = _loc3_ - 1;
         var _loc9_:int = 0;
         while(_loc9_ < _loc8_)
         {
            _loc4_ = param1[_loc9_];
            _loc10_ = _loc9_ + 1;
            while(_loc10_ < _loc3_)
            {
               _loc5_ = param1[_loc10_];
               _loc11_ = _loc4_.start;
               _loc12_ = _loc5_.start;
               _loc13_ = _loc4_.end;
               _loc14_ = _loc5_.end;
               _loc6_ = _loc11_ - _loc12_;
               _loc7_ = _loc13_ - _loc14_;
               if((_loc12_ - _loc11_) * (_loc14_ - _loc13_) < 0 && _loc6_ * _loc7_ < 0 || _loc11_ != _loc13_ && _loc12_ != _loc14_ && (_loc13_ >= _loc12_ && _loc11_ <= _loc14_ || _loc14_ <= _loc11_ && _loc13_ <= _loc12_) && _loc11_ != _loc12_)
               {
                  _loc2_ += this.maxLevelWidth + 1;
               }
               _loc10_++;
            }
            _loc9_++;
         }
         return _loc2_;
      }
      
      private function getTotalCost(param1:Array) : Number
      {
         var _loc3_:LevelLine = null;
         var _loc2_:Number = this.getCrossingCostEx(param1);
         var _loc4_:uint = param1.length;
         var _loc5_:int = 0;
         while(_loc5_ < _loc4_)
         {
            _loc3_ = param1[_loc5_];
            if(_loc3_.start != _loc3_.end)
            {
               _loc2_ += Math.abs(_loc3_.start - _loc3_.end);
            }
            _loc5_++;
         }
         return _loc2_;
      }
      
      private function findMaxChildCount(param1:Array) : Number
      {
         var _loc4_:int = 0;
         if(this.isCyclicReference || param1 == null)
         {
            return 0;
         }
         var _loc2_:Array = [];
         var _loc3_:int = 0;
         _loc4_ = 0;
         while(_loc4_ < param1.length)
         {
            if(param1[_loc4_] == 1 || param1[_loc4_] == 2)
            {
               _loc3_++;
               _loc2_.push(_loc4_);
            }
            _loc4_++;
         }
         var _loc5_:uint = _loc2_.length;
         _loc4_ = 0;
         while(_loc4_ < _loc5_)
         {
            _loc3_ = Math.max(this.findMaxChildCount(this.adjacencyMatrix[_loc2_[_loc4_]]),_loc3_);
            _loc4_++;
         }
         return _loc3_;
      }
      
      private function breedNodesByNextRelations(param1:Number) : void
      {
         var _loc4_:int = 0;
         var _loc5_:LevelItem = null;
         var _loc11_:int = 0;
         var _loc2_:Array = this.levels[param1];
         var _loc3_:uint = _loc2_.length;
         var _loc6_:int = 0;
         var _loc7_:Array = new Array(_loc3_);
         _loc4_ = 0;
         while(_loc4_ < _loc3_)
         {
            _loc7_[_loc4_] = 1;
            _loc4_++;
         }
         _loc4_ = 0;
         while(_loc4_ < _loc3_)
         {
            _loc5_ = _loc2_[_loc4_];
            if(_loc5_ == null)
            {
               _loc6_++;
               if(_loc2_[_loc4_ - 1] != null && _loc2_[_loc4_ - 1].fake && _loc2_[_loc4_ + 1] != null)
               {
                  if(_loc4_ == 1)
                  {
                     _loc6_ = 0;
                  }
                  break;
               }
            }
            else if(_loc6_ > 0)
            {
               _loc6_ = 0;
               break;
            }
            _loc4_++;
         }
         if(_loc6_ < 1)
         {
            return;
         }
         var _loc8_:Boolean = false;
         var _loc9_:int = 0;
         var _loc10_:int = 0;
         _loc4_ = 0;
         while(_loc4_ < _loc3_)
         {
            _loc5_ = _loc2_[_loc4_];
            if(_loc5_ != null)
            {
               _loc9_ = this.findMaxChildCount(this.adjacencyMatrix[_loc5_.index]) - 1;
               if(_loc9_ > 0)
               {
                  _loc11_ = 0;
                  while(_loc11_ < _loc9_ && _loc6_ > 0)
                  {
                     if(_loc4_ + _loc11_ + 1 < _loc3_)
                     {
                        _loc7_[_loc4_ + _loc11_ + _loc10_ + 1] = 0;
                        _loc8_ = true;
                     }
                     _loc11_++;
                     _loc6_--;
                  }
                  _loc10_ = _loc11_;
               }
            }
            _loc4_++;
         }
         if(!_loc8_)
         {
            return;
         }
         this.mapLevel(param1,_loc7_);
      }
      
      private function makeMinCrossing(param1:Number, param2:Boolean) : Number
      {
         var i:int = 0;
         var node:LevelItem = null;
         var other:LevelItem = null;
         var crossings:Array = null;
         var lines:Array = null;
         var row:int = 0;
         var column:int = 0;
         var position:Object = null;
         var x:int = 0;
         var levelIdx:Number = param1;
         var next:Boolean = param2;
         var checkLevel:Array = this.levels[levelIdx];
         var checkLevelLen:uint = checkLevel.length;
         var holdDxs:Array = new Array(checkLevelLen);
         var matrix:Array = new Array(checkLevelLen);
         i = 0;
         while(i < checkLevelLen)
         {
            holdDxs[i] = checkLevel[i] != null ? checkLevel[i].dx : 0;
            i++;
         }
         i = 0;
         while(i < checkLevelLen)
         {
            node = checkLevel[i];
            crossings = new Array(checkLevelLen);
            x = 0;
            while(x < checkLevelLen)
            {
               other = null;
               if(i != x)
               {
                  if(node != null)
                  {
                     node.dx = x;
                  }
                  other = checkLevel[x];
                  if(other != null)
                  {
                     other.dx = i;
                  }
               }
               lines = this.getLines(levelIdx,next);
               crossings[x] = this.getTotalCost(lines);
               if(other != null)
               {
                  other.dx = x;
               }
               x++;
            }
            if(node != null)
            {
               node.dx = holdDxs[i];
            }
            matrix[i] = crossings;
            i++;
         }
         var algo:HungarianAlgorithm = new HungarianAlgorithm();
         var result:Array = algo.compute(algo.makeCostMatrix(matrix,function(param1:Number):Number
         {
            return param1;
         }));
         var newLevel:Array = new Array(checkLevelLen);
         var profit:Number = 0;
         var length:uint = result.length;
         i = 0;
         while(i < length)
         {
            position = result[i];
            row = position.row;
            column = position.column;
            node = checkLevel[row];
            if(node != null)
            {
               node.dx = column;
            }
            newLevel[column] = node;
            profit += matrix[row][column];
            i++;
         }
         this.levels[levelIdx] = newLevel;
         return profit;
      }
      
      private function findNodePositionInLevel(param1:Number, param2:Boolean) : Array
      {
         var _loc9_:Array = null;
         var _loc3_:int = -1;
         var _loc4_:int = 0;
         var _loc5_:int = int.MAX_VALUE;
         var _loc6_:int = 0;
         var _loc7_:int = this.maxLevelWidth * this.maxLevelWidth;
         var _loc8_:int = 0;
         while(_loc3_ != 0 && _loc6_ != 3 && _loc4_ != _loc3_ && _loc8_ < _loc7_)
         {
            _loc4_ = _loc3_;
            _loc3_ = this.makeMinCrossing(param1,param2);
            _loc9_ = this.getLines(param1,param2);
            _loc3_ *= this.getTotalCost(_loc9_);
            if(_loc3_ <= _loc5_)
            {
               _loc6_ = _loc3_ == _loc5_ ? int(_loc6_ + 1) : int(0);
               _loc5_ = _loc3_;
            }
            _loc8_++;
         }
         return _loc9_;
      }
      
      private function determineNodesPositionsOnLevel() : void
      {
         var _loc1_:Array = null;
         var _loc4_:Number = NaN;
         this.breedNodesByNextRelations(1);
         var _loc2_:uint = this.levels.length;
         var _loc3_:int = 2;
         while(_loc3_ < _loc2_)
         {
            _loc1_ = this.findNodePositionInLevel(_loc3_,false);
            if(this.hasFakeNode(_loc3_))
            {
               this.breedNodesByNextRelations(_loc3_);
            }
            if(this.getCrossingCostEx(_loc1_) > 0)
            {
               _loc4_ = this.makeMinCrossing(_loc3_ - 1,true);
               if(_loc4_ != 0 && _loc3_ == _loc2_ - 1)
               {
                  this.findNodePositionInLevel(_loc3_,false);
               }
            }
            _loc3_++;
         }
         this.buildLevelsCache();
      }
      
      public function get matrix() : Array
      {
         return this.adjacencyMatrix;
      }
      
      public function get nodesByLevel() : Array
      {
         return this.levels;
      }
      
      public function get levelDimension() : Object
      {
         var _loc3_:int = 0;
         var _loc4_:Array = null;
         var _loc1_:uint = this.levels.length;
         var _loc2_:int = 0;
         var _loc5_:int = 1;
         while(_loc5_ < _loc1_)
         {
            _loc4_ = this.levels[_loc5_];
            _loc3_ = _loc4_.length;
            while(_loc3_ >= 0)
            {
               if(_loc4_[_loc3_] != null)
               {
                  break;
               }
               _loc3_--;
            }
            _loc2_ = Math.max(_loc3_ + 1,_loc2_);
            _loc5_++;
         }
         return {
            "row":this.levels.length,
            "column":_loc2_
         };
      }
   }
}

class LevelItem
{
    
   
   public var index:uint;
   
   public var dx:uint;
   
   public var fake:Boolean;
   
   function LevelItem(param1:uint, param2:uint, param3:Boolean)
   {
      super();
      this.index = param1;
      this.dx = param2;
      this.fake = param3;
   }
}

class LevelLine
{
    
   
   public var start:uint;
   
   public var end:uint;
   
   public var parent:uint;
   
   public var child:uint;
   
   function LevelLine(param1:uint, param2:uint, param3:uint, param4:uint)
   {
      super();
      this.start = param1;
      this.end = param2;
      this.parent = param3;
      this.child = param4;
   }
   
   public static function makeByTop(param1:LevelItem, param2:LevelItem) : LevelLine
   {
      return new LevelLine(param2.dx,param1.dx,param2.index,param1.index);
   }
   
   public static function makeByNext(param1:LevelItem, param2:LevelItem) : LevelLine
   {
      return new LevelLine(param1.dx,param2.dx,param1.index,param2.index);
   }
}
