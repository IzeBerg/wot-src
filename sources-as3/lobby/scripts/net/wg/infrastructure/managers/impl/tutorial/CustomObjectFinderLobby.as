package net.wg.infrastructure.managers.impl.tutorial
{
   import flash.display.DisplayObject;
   import flash.display.DisplayObjectContainer;
   import net.wg.gui.components.carousels.ScrollerViewPort;
   import net.wg.gui.components.controls.SimpleTileList;
   import net.wg.gui.components.controls.SoundButtonEx;
   import net.wg.gui.lobby.techtree.interfaces.INationTreeDataProvider;
   import net.wg.gui.lobby.techtree.interfaces.IRenderer;
   import net.wg.gui.lobby.techtree.interfaces.IResearchDataProvider;
   import net.wg.gui.lobby.techtree.sub.NationTree;
   import net.wg.gui.lobby.techtree.sub.ResearchItems;
   import scaleform.clik.interfaces.IListItemRenderer;
   
   public class CustomObjectFinderLobby extends CustomObjectFinderBase
   {
       
      
      public function CustomObjectFinderLobby()
      {
         super();
      }
      
      override public function getObjectByParams(param1:DisplayObject, param2:Object) : DisplayObject
      {
         var _loc10_:ResearchItems = null;
         var _loc11_:IResearchDataProvider = null;
         var _loc12_:NationTree = null;
         var _loc13_:INationTreeDataProvider = null;
         var _loc14_:int = 0;
         var _loc15_:SimpleTileList = null;
         var _loc16_:IListItemRenderer = null;
         var _loc17_:DisplayObject = null;
         var _loc18_:SoundButtonEx = null;
         var _loc3_:DisplayObject = super.getObjectByParams(param1,param2);
         if(_loc3_ != null)
         {
            return _loc3_;
         }
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:IRenderer = null;
         var _loc8_:DisplayObjectContainer = null;
         var _loc9_:Object = null;
         if(param1 is ResearchItems)
         {
            _loc10_ = ResearchItems(param1);
            _loc8_ = _loc10_.rGraphics;
            _loc11_ = _loc10_.dataProvider;
            _loc6_ = _loc8_.numChildren;
            _loc4_ = 0;
            while(_loc4_ < _loc6_)
            {
               _loc7_ = _loc8_.getChildAt(_loc4_) as IRenderer;
               if(_loc7_)
               {
                  _loc5_ = _loc7_.index;
                  if(_loc5_ > -1 && _loc11_.length > _loc5_)
                  {
                     _loc9_ = _loc11_.getItemAt(_loc5_);
                     if(checkForParamsMatch(_loc9_,param2))
                     {
                        return DisplayObject(_loc7_);
                     }
                  }
               }
               _loc4_++;
            }
         }
         if(param1 is NationTree)
         {
            _loc12_ = NationTree(param1);
            _loc8_ = _loc12_.ntGraphics;
            _loc13_ = _loc12_.dataProvider;
            _loc14_ = _loc13_.length;
            _loc6_ = _loc8_.numChildren;
            _loc4_ = 0;
            while(_loc4_ < _loc6_)
            {
               _loc7_ = _loc8_.getChildAt(_loc4_) as IRenderer;
               if(_loc7_)
               {
                  _loc5_ = _loc7_.index;
                  if(_loc5_ > -1 && _loc14_ > _loc5_)
                  {
                     _loc9_ = _loc13_.getItemAt(_loc5_);
                     if(checkForParamsMatch(_loc9_,param2))
                     {
                        return DisplayObject(_loc7_);
                     }
                  }
               }
               _loc4_++;
            }
         }
         if(param1 is SimpleTileList)
         {
            _loc15_ = SimpleTileList(param1);
            if(_loc15_)
            {
               _loc6_ = _loc15_.length;
               _loc16_ = null;
               _loc4_ = 0;
               while(_loc4_ < _loc6_)
               {
                  _loc16_ = _loc15_.getRendererAt(_loc4_);
                  _loc9_ = _loc16_.getData();
                  if(checkForParamsMatch(_loc9_,param2))
                  {
                     return DisplayObject(_loc16_);
                  }
                  _loc4_++;
               }
            }
         }
         if(param1 is ScrollerViewPort)
         {
            _loc8_ = ScrollerViewPort(param1);
            if(_loc8_)
            {
               _loc6_ = _loc8_.numChildren;
               while(_loc4_ < _loc6_)
               {
                  _loc17_ = _loc8_.getChildAt(_loc4_);
                  if(_loc17_ is SoundButtonEx)
                  {
                     _loc18_ = SoundButtonEx(_loc17_);
                     _loc9_ = _loc18_.data;
                     if(checkForParamsMatch(_loc9_,param2))
                     {
                        return DisplayObject(_loc18_);
                     }
                  }
                  _loc4_++;
               }
            }
         }
         return null;
      }
   }
}
