package net.wg.gui.lobby.techtree.controls
{
   import flash.display.Sprite;
   import flash.geom.Rectangle;
   import net.wg.data.constants.Linkages;
   import net.wg.data.constants.Values;
   import net.wg.gui.lobby.techtree.helpers.LevelHeaderInfo;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class LevelsContainer extends Sprite implements IDisposable
   {
      
      private static const MSG_UNIQUE:String = "UIID is unique value and can not be modified.";
      
      private static const SCALE9_RECT:Rectangle = new Rectangle(0,0,1,1);
       
      
      private var _delimiters:Vector.<LevelDelimiter>;
      
      private var _uiid:uint = 4.294967295E9;
      
      public function LevelsContainer()
      {
         super();
         scale9Grid = SCALE9_RECT;
         tabEnabled = mouseChildren = mouseEnabled = false;
         this._delimiters = new Vector.<LevelDelimiter>();
      }
      
      private static function updateLevelDelimiter(param1:LevelDelimiter, param2:int, param3:int, param4:int, param5:int, param6:int, param7:Boolean) : void
      {
         param1.levelNumber = param6;
         param1.showDelimeters = param7;
         param1.x = param2;
         param1.y = param3;
         param1.setSize(param4,param5);
      }
      
      public final function dispose() : void
      {
         this.onDispose();
      }
      
      public function hideLevelHighlight() : void
      {
         var _loc1_:LevelDelimiter = null;
         for each(_loc1_ in this._delimiters)
         {
            if(_loc1_)
            {
               _loc1_.hideLevelHighlight();
            }
         }
      }
      
      public function showLevelHighlight(param1:int) : void
      {
         if(param1 > 0 && param1 <= this._delimiters.length)
         {
            this._delimiters[param1 - 1].showLevelHighlight();
         }
      }
      
      public function updateLevels(param1:Vector.<LevelHeaderInfo>, param2:int, param3:int) : int
      {
         var _loc5_:LevelHeaderInfo = null;
         var _loc6_:LevelDelimiter = null;
         var _loc9_:int = 0;
         var _loc10_:int = 0;
         var _loc12_:Boolean = false;
         var _loc4_:int = param1.length;
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         var _loc11_:Boolean = false;
         while(this._delimiters.length > _loc4_)
         {
            this.removeLevelDelimiter(this._delimiters.pop());
         }
         var _loc13_:int = 0;
         while(_loc13_ < _loc4_)
         {
            _loc5_ = param1[_loc13_];
            _loc6_ = null;
            _loc11_ = false;
            if(_loc13_ >= this._delimiters.length)
            {
               this._delimiters.push(null);
            }
            if(!_loc5_)
            {
               if(this._delimiters[_loc13_] != null)
               {
                  if(this.removeLevelDelimiter(this._delimiters[_loc13_]))
                  {
                     this._delimiters[_loc13_] = null;
                  }
               }
            }
            else
            {
               if(_loc13_ == 0)
               {
                  if(param1[_loc13_ + 1] != null)
                  {
                     _loc7_ = _loc8_ = param1[_loc13_ + 1].start - _loc5_.end - param3 >> 1;
                  }
                  else
                  {
                     _loc7_ = _loc8_ = _loc5_.start;
                  }
               }
               else
               {
                  if(param1[_loc13_ - 1] != null)
                  {
                     _loc7_ = _loc5_.start - param3 - param1[_loc13_ - 1].end >> 1;
                  }
                  if(_loc13_ < _loc4_ - 1 && param1[_loc13_ + 1] != null)
                  {
                     _loc8_ = param1[_loc13_ + 1].start - _loc5_.end - param3 >> 1;
                  }
                  else
                  {
                     _loc8_ = _loc7_;
                  }
               }
               _loc10_ = _loc5_.start - _loc7_;
               _loc9_ = _loc5_.end - _loc5_.start + param3 + _loc7_ + _loc8_;
               _loc6_ = this._delimiters[_loc13_];
               _loc12_ = _loc13_ < _loc4_ - 1;
               if(_loc6_ != null)
               {
                  updateLevelDelimiter(_loc6_,_loc10_,0,_loc9_,param2,_loc5_.level,_loc12_);
               }
               else
               {
                  _loc6_ = App.utils.classFactory.getComponent(Linkages.NATION_TREE_LEVEL_RENDERER,LevelDelimiter,{
                     "x":_loc10_,
                     "y":0,
                     "width":_loc9_,
                     "height":param2,
                     "levelNumber":_loc5_.level,
                     "showDelimeters":_loc12_
                  });
                  _loc11_ = true;
               }
               if(_loc6_ != null)
               {
                  _loc6_.validateNow();
                  if(_loc11_)
                  {
                     addChild(_loc6_);
                     this._delimiters[_loc13_] = _loc6_;
                  }
               }
            }
            _loc13_++;
         }
         return _loc8_;
      }
      
      protected function onDispose() : void
      {
         var _loc1_:LevelDelimiter = null;
         while(this._delimiters.length)
         {
            _loc1_ = this._delimiters.pop();
            if(_loc1_)
            {
               _loc1_.dispose();
            }
         }
         this._delimiters = null;
         while(numChildren > 0)
         {
            removeChildAt(0);
         }
      }
      
      private function removeLevelDelimiter(param1:LevelDelimiter) : Boolean
      {
         var _loc2_:Boolean = false;
         if(param1 && contains(param1))
         {
            removeChild(param1);
            param1.dispose();
            _loc2_ = true;
         }
         return _loc2_;
      }
      
      [Inspectable(defaultValue="EMPTY_UIID")]
      public function get UIID() : uint
      {
         return this._uiid;
      }
      
      public function set UIID(param1:uint) : void
      {
         if(this._uiid != Values.EMPTY_UIID)
         {
            App.utils.asserter.assert(this._uiid == param1,MSG_UNIQUE);
         }
         this._uiid = param1;
      }
   }
}
