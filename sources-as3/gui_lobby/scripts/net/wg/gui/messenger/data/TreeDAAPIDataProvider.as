package net.wg.gui.messenger.data
{
   import net.wg.data.daapi.base.DAAPIDataProvider;
   
   public class TreeDAAPIDataProvider extends DAAPIDataProvider
   {
       
      
      private var InfoClass:Class;
      
      private var currentIndex:uint = 0;
      
      public function TreeDAAPIDataProvider(param1:Class = null)
      {
         this.InfoClass = TreeItemInfo;
         super();
         if(param1)
         {
            this.InfoClass = param1;
         }
      }
      
      override public function requestItemAt(param1:uint, param2:Function = null) : Object
      {
         var _loc4_:Object = null;
         var _loc5_:uint = 0;
         var _loc6_:int = 0;
         var _loc7_:ItemSearchResult = null;
         var _loc3_:Array = super.requestItemRange(0,super.length);
         if(_loc3_)
         {
            _loc5_ = _loc3_.length;
            this.currentIndex = 0;
            _loc6_ = 0;
            while(_loc6_ < _loc5_)
            {
               _loc7_ = this.getItemAt(_loc3_[_loc6_],param1,null);
               if(_loc7_.item)
               {
                  _loc4_ = _loc7_.item;
                  break;
               }
               _loc6_++;
            }
         }
         if(param2 != null)
         {
            param2(_loc4_);
         }
         return _loc4_;
      }
      
      override public function requestItemRange(param1:int, param2:int, param3:Function = null) : Array
      {
         var _loc5_:Array = null;
         var _loc6_:uint = 0;
         var _loc7_:int = 0;
         var _loc8_:uint = 0;
         var _loc9_:Boolean = false;
         var _loc4_:Array = super.requestItemRange(0,super.length);
         if(_loc4_)
         {
            _loc5_ = [];
            this.currentIndex = 0;
            _loc6_ = Boolean(_loc4_) ? uint(_loc4_.length) : uint(0);
            _loc7_ = param2 + 1 - param1;
            _loc8_ = 0;
            while(_loc8_ < _loc6_)
            {
               _loc9_ = this.processAddVisibleItems(_loc4_[_loc8_],_loc5_,param1,_loc7_);
               if(_loc9_)
               {
                  break;
               }
               _loc8_++;
            }
         }
         if(param3 != null)
         {
            param3(_loc5_);
         }
         return _loc5_;
      }
      
      private function getItemAt(param1:Object, param2:uint, param3:ITreeItemInfo) : ItemSearchResult
      {
         var _loc5_:Array = null;
         var _loc6_:uint = 0;
         var _loc7_:int = 0;
         var _loc8_:ItemSearchResult = null;
         var _loc4_:ITreeItemInfo = new this.InfoClass(param1);
         _loc4_.parent = param3;
         if(this.currentIndex == param2)
         {
            return new ItemSearchResult(this.currentIndex,_loc4_);
         }
         ++this.currentIndex;
         if(_loc4_.isBrunch && _loc4_.isOpened)
         {
            _loc5_ = _loc4_.children;
            _loc6_ = _loc5_.length;
            _loc7_ = 0;
            while(_loc7_ < _loc6_)
            {
               _loc8_ = this.getItemAt(_loc5_[_loc7_],param2,_loc4_);
               if(_loc8_.item)
               {
                  return _loc8_;
               }
               _loc7_++;
            }
         }
         return new ItemSearchResult(this.currentIndex,null);
      }
      
      private function processAddVisibleItems(param1:Object, param2:Array, param3:int, param4:int, param5:ITreeItemInfo = null) : Boolean
      {
         var _loc7_:Array = null;
         var _loc8_:uint = 0;
         var _loc9_:int = 0;
         var _loc10_:Boolean = false;
         var _loc6_:ITreeItemInfo = new this.InfoClass(param1);
         if(param2.length < param4)
         {
            if(this.currentIndex >= param3)
            {
               _loc6_.parent = param5;
               param2.push(_loc6_);
            }
            ++this.currentIndex;
            if(_loc6_.isBrunch && _loc6_.isOpened)
            {
               _loc7_ = _loc6_.children;
               _loc8_ = Boolean(_loc7_) ? uint(_loc7_.length) : uint(0);
               _loc9_ = 0;
               while(_loc9_ < _loc8_)
               {
                  _loc10_ = this.processAddVisibleItems(_loc7_[_loc9_],param2,param3,param4,_loc6_);
                  if(_loc10_)
                  {
                     return true;
                  }
                  _loc9_++;
               }
            }
            return false;
         }
         return true;
      }
      
      private function getVisibleChildrenCount(param1:Object) : int
      {
         var _loc4_:uint = 0;
         var _loc5_:int = 0;
         var _loc2_:ITreeItemInfo = new this.InfoClass(param1);
         var _loc3_:int = 1;
         if(_loc2_.isBrunch)
         {
            if(_loc2_.isOpened)
            {
               _loc4_ = _loc2_.children.length;
               _loc5_ = 0;
               while(_loc5_ < _loc4_)
               {
                  _loc3_ += this.getVisibleChildrenCount(_loc2_.children[_loc5_]);
                  _loc5_++;
               }
            }
         }
         return _loc3_;
      }
      
      override public function get length() : uint
      {
         var _loc4_:uint = 0;
         var _loc5_:int = 0;
         var _loc1_:uint = super.length;
         var _loc2_:Array = super.requestItemRange(0,_loc1_);
         var _loc3_:int = 0;
         if(_loc2_)
         {
            _loc4_ = _loc2_.length;
            _loc5_ = 0;
            while(_loc5_ < _loc4_)
            {
               _loc3_ += this.getVisibleChildrenCount(_loc2_[_loc5_]);
               _loc5_++;
            }
         }
         return _loc3_;
      }
   }
}

import net.wg.gui.messenger.data.ITreeItemInfo;

class ItemSearchResult
{
    
   
   public var index:uint;
   
   public var item:ITreeItemInfo;
   
   function ItemSearchResult(param1:uint, param2:ITreeItemInfo)
   {
      super();
      this.index = param1;
      this.item = param2;
   }
}
