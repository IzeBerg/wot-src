package net.wg.infrastructure.managers.impl.tutorial
{
   import flash.display.DisplayObject;
   import flash.display.DisplayObjectContainer;
   import net.wg.infrastructure.interfaces.ICustomObjectFinder;
   import net.wg.infrastructure.interfaces.IListViewPort;
   import scaleform.clik.controls.Button;
   import scaleform.clik.controls.ButtonBar;
   import scaleform.clik.controls.CoreList;
   import scaleform.clik.controls.DropdownMenu;
   import scaleform.clik.interfaces.IListItemRenderer;
   
   public class CustomObjectFinderBase implements ICustomObjectFinder
   {
       
      
      public function CustomObjectFinderBase()
      {
         super();
      }
      
      public function getObjectByParams(param1:DisplayObject, param2:Object) : DisplayObject
      {
         var _loc8_:IListViewPort = null;
         var _loc9_:CoreList = null;
         var _loc10_:ButtonBar = null;
         var _loc11_:Button = null;
         var _loc3_:IListItemRenderer = null;
         var _loc4_:Object = null;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:DisplayObjectContainer = null;
         if(param1 is IListViewPort)
         {
            _loc8_ = IListViewPort(param1);
            _loc6_ = _loc8_.numChildren;
            while(_loc5_ < _loc6_)
            {
               _loc3_ = _loc8_.getChildAt(_loc5_) as IListItemRenderer;
               if(_loc3_)
               {
                  _loc4_ = _loc3_.getData();
                  if(this.checkForParamsMatch(_loc4_,param2))
                  {
                     return DisplayObject(_loc3_);
                  }
               }
               _loc5_++;
            }
         }
         if(param1 is CoreList)
         {
            _loc9_ = CoreList(param1);
            _loc7_ = _loc9_.container;
            _loc5_ = 0;
            if(_loc7_)
            {
               _loc6_ = _loc7_.numChildren;
               while(_loc5_ < _loc6_)
               {
                  _loc3_ = _loc7_.getChildAt(_loc5_) as IListItemRenderer;
                  if(_loc3_)
                  {
                     _loc4_ = _loc3_.getData();
                     if(this.checkForParamsMatch(_loc4_,param2))
                     {
                        return DisplayObject(_loc3_);
                     }
                  }
                  _loc5_++;
               }
            }
         }
         if(param1 is ButtonBar)
         {
            _loc10_ = ButtonBar(param1);
            _loc7_ = _loc10_.container;
            if(_loc7_)
            {
               _loc6_ = _loc7_.numChildren;
               _loc11_ = null;
               while(_loc5_ < _loc6_)
               {
                  _loc11_ = _loc7_.getChildAt(_loc5_) as Button;
                  if(_loc11_)
                  {
                     if(this.checkForParamsMatch(_loc11_.data,param2))
                     {
                        return DisplayObject(_loc11_);
                     }
                  }
                  _loc5_++;
               }
            }
         }
         return null;
      }
      
      public function validateObjectPath(param1:Vector.<DisplayObject>) : Boolean
      {
         var _loc4_:DisplayObjectContainer = null;
         var _loc5_:DisplayObject = null;
         var _loc2_:uint = param1.length - 1;
         var _loc3_:int = _loc2_;
         while(_loc3_ > 0)
         {
            _loc4_ = param1[_loc3_ - 1] as DisplayObjectContainer;
            _loc5_ = param1[_loc3_];
            if(_loc4_)
            {
               if(!_loc4_.contains(_loc5_) && (!(_loc4_ is DropdownMenu) || DropdownMenu(_loc4_).dropDownref !== _loc5_))
               {
                  return false;
               }
            }
            _loc3_--;
         }
         return true;
      }
      
      protected function checkForParamsMatch(param1:Object, param2:Object) : Boolean
      {
         var _loc3_:* = null;
         if(!param1)
         {
            return false;
         }
         for(_loc3_ in param2)
         {
            if(!param1.hasOwnProperty(_loc3_))
            {
               return false;
            }
            if(String(param1[_loc3_]) != param2[_loc3_])
            {
               return false;
            }
         }
         return true;
      }
   }
}
