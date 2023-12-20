package net.wg.gui.lobby.storage.categories.storage
{
   import net.wg.gui.components.containers.GroupEx;
   import net.wg.gui.components.containers.GroupLayout;
   import scaleform.clik.constants.InvalidationType;
   
   public class ExtraParams extends GroupEx
   {
       
      
      private var _rendererWidth:int;
      
      private var _maxLines:uint;
      
      public function ExtraParams()
      {
         super();
      }
      
      override public function getProviderLength() : uint
      {
         return Boolean(dataProvider) ? uint(Math.min(dataProvider.length,this._maxLines)) : uint(0);
      }
      
      override protected function draw() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:ExtraParamsRenderer = null;
         super.draw();
         if(isInvalid(InvalidationType.SIZE))
         {
            _loc1_ = 0;
            _loc3_ = numRenderers();
            _loc4_ = GroupLayout(layout).gap;
            _loc5_ = 0;
            _loc2_ = 0;
            while(_loc2_ < _loc3_)
            {
               _loc6_ = ExtraParamsRenderer(getRendererAt(_loc2_));
               _loc6_.setMaxTextWidth(this._rendererWidth);
               _loc6_.y = _loc1_;
               _loc5_ += _loc6_.getLinesCount();
               _loc1_ += _loc6_.height + _loc4_;
               _loc2_++;
            }
            this.checkTotalLines(_loc5_);
         }
      }
      
      public function setMaxTextLines(param1:uint) : void
      {
         this._maxLines = param1;
      }
      
      public function setMaxTextWidth(param1:int) : void
      {
         this._rendererWidth = param1;
         invalidateSize();
      }
      
      private function checkTotalLines(param1:int) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:ExtraParamsRenderer = null;
         if(param1 > this._maxLines)
         {
            _loc2_ = param1;
            _loc4_ = numRenderers();
            _loc3_ = _loc4_ - 1;
            while(_loc3_ >= 0)
            {
               _loc5_ = ExtraParamsRenderer(getRendererAt(_loc3_));
               if(_loc5_.getLinesCount() > 1)
               {
                  if(_loc2_ < this._maxLines)
                  {
                     this.updateLayout();
                     invalidateSize();
                     return;
                  }
                  _loc2_ -= _loc5_.getLinesCount();
                  _loc5_.truncateText();
               }
               _loc3_--;
            }
            this.updateLayout();
         }
      }
      
      private function updateLayout() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc5_:ExtraParamsRenderer = null;
         _loc1_ = 0;
         var _loc3_:int = numRenderers();
         var _loc4_:int = GroupLayout(layout).gap;
         _loc2_ = 0;
         while(_loc2_ < _loc3_)
         {
            _loc5_ = ExtraParamsRenderer(getRendererAt(_loc2_));
            _loc5_.y = _loc1_;
            _loc1_ += _loc5_.actualHeight + _loc4_;
            _loc2_++;
         }
      }
   }
}
