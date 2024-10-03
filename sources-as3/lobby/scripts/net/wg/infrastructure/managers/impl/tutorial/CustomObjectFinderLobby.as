package net.wg.infrastructure.managers.impl.tutorial
{
   import flash.display.DisplayObject;
   import flash.display.DisplayObjectContainer;
   import net.wg.gui.components.carousels.ScrollerViewPort;
   import net.wg.gui.components.controls.SimpleTileList;
   import net.wg.gui.components.controls.SoundButtonEx;
   import net.wg.gui.lobby.techtree.interfaces.IRenderer;
   import net.wg.gui.lobby.techtree.interfaces.IResearchDataProvider;
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
         var _loc12_:SimpleTileList = null;
         var _loc13_:IListItemRenderer = null;
         var _loc14_:DisplayObject = null;
         var _loc15_:SoundButtonEx = null;
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
         if(param1 is SimpleTileList)
         {
            _loc12_ = SimpleTileList(param1);
            if(_loc12_)
            {
               _loc6_ = _loc12_.length;
               _loc13_ = null;
               _loc4_ = 0;
               while(_loc4_ < _loc6_)
               {
                  _loc13_ = _loc12_.getRendererAt(_loc4_);
                  _loc9_ = _loc13_.getData();
                  if(checkForParamsMatch(_loc9_,param2))
                  {
                     return DisplayObject(_loc13_);
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
                  _loc14_ = _loc8_.getChildAt(_loc4_);
                  if(_loc14_ is SoundButtonEx)
                  {
                     _loc15_ = SoundButtonEx(_loc14_);
                     _loc9_ = _loc15_.data;
                     if(checkForParamsMatch(_loc9_,param2))
                     {
                        return DisplayObject(_loc15_);
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
