package net.wg.gui.bootcamp
{
   import flash.display.DisplayObject;
   import net.wg.gui.lobby.techtree.interfaces.IRenderer;
   import net.wg.gui.lobby.techtree.sub.ResearchItems;
   import net.wg.infrastructure.base.meta.IBCHighlightsMeta;
   
   public class BCHighlightsOverlay extends BCHighlightsBase implements IBCHighlightsMeta
   {
       
      
      public function BCHighlightsOverlay()
      {
         super();
      }
      
      override protected function getContextRenderer(param1:DisplayObject, param2:String, param3:Object) : DisplayObject
      {
         var _loc5_:ResearchItems = null;
         var _loc6_:int = 0;
         var _loc7_:uint = 0;
         var _loc8_:IRenderer = null;
         var _loc9_:int = 0;
         var _loc10_:int = 0;
         var _loc11_:Object = null;
         var _loc4_:DisplayObject = super.getContextRenderer(param1,param2,param3);
         if(_loc4_ != null)
         {
            return _loc4_;
         }
         if(param1 is ResearchItems)
         {
            _loc5_ = ResearchItems(param1);
            _loc6_ = 0;
            _loc7_ = _loc5_.rGraphics.numChildren;
            while(_loc6_ < _loc7_)
            {
               if(_loc5_.rGraphics.getChildAt(_loc6_) is IRenderer)
               {
                  _loc8_ = IRenderer(_loc5_.rGraphics.getChildAt(_loc6_));
                  _loc9_ = _loc8_.index;
                  _loc10_ = _loc5_.dataProvider.length;
                  if(_loc9_ > -1 && _loc10_ > _loc9_)
                  {
                     _loc11_ = _loc5_.dataProvider.getItemAt(_loc9_);
                     if(checkForParamMatch(_loc11_,param2,param3))
                     {
                        return DisplayObject(_loc8_);
                     }
                  }
               }
               _loc6_++;
            }
         }
         return null;
      }
   }
}
