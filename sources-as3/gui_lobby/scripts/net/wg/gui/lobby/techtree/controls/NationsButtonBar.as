package net.wg.gui.lobby.techtree.controls
{
   import net.wg.gui.components.advanced.ButtonBarEx;
   import net.wg.gui.lobby.techtree.data.vo.TechTreeNationMenuItemVO;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.controls.Button;
   import scaleform.clik.core.UIComponent;
   
   public class NationsButtonBar extends ButtonBarEx
   {
      
      public static const TOP_ALIGN:String = "top";
      
      public static const CENTER_ALIGN:String = "center";
      
      public static const BOTTOM_ALIGN:String = "bottom";
      
      private static const RENDERERS_SCALE_DEFAULT:uint = 1;
      
      private static const SPACING_DEFAULT:uint = 21;
       
      
      private var _tabVAlign:String;
      
      private var _rendererScale:Number = 1;
      
      public function NationsButtonBar()
      {
         super();
         mouseEnabled = false;
      }
      
      private static function measureOriginalRendererHeight(param1:NationButton) : Number
      {
         return param1.contentSize.height;
      }
      
      override public function toString() : String
      {
         return "[WG NationsButtonBar " + name + "]";
      }
      
      override protected function draw() : void
      {
         if(isInvalid(InvalidationType.SELECTED_INDEX))
         {
            invalidate(InvalidationType.RENDERERS);
         }
         super.draw();
      }
      
      override protected function populateRendererData(param1:Button, param2:uint) : void
      {
         var _loc3_:TechTreeNationMenuItemVO = TechTreeNationMenuItemVO(_dataProvider[param2]);
         var _loc4_:NationButton = NationButton(param1);
         _loc4_.isTooltipSpecial = _loc3_.isTooltipSpecial;
         _loc4_.setDiscountVisible(_loc3_.hasDiscount);
         _loc4_.setEarlyAccessVisible(_loc3_.hasEarlyAccess);
         super.populateRendererData(param1,param2);
      }
      
      override protected function updateRenderers() : void
      {
         var _loc2_:Number = NaN;
         var _loc3_:int = 0;
         var _loc4_:Number = NaN;
         super.updateRenderers();
         var _loc1_:uint = _renderers.length;
         if(_loc1_ > 0 && _dataProvider.length >= _loc1_)
         {
            _loc3_ = this.measureOriginalContentHeight();
            if(height < _loc3_)
            {
               _loc2_ = height / _loc3_;
               _spacing = _loc2_ * SPACING_DEFAULT;
            }
            else
            {
               _loc2_ = RENDERERS_SCALE_DEFAULT;
               _spacing = SPACING_DEFAULT;
            }
            this.updateRenderersScale(_loc2_);
            _loc4_ = 0;
            switch(this.tabVAlign)
            {
               case CENTER_ALIGN:
                  _loc4_ = (height >> 1) - (this.measureScaledContentHeight() >> 1);
                  break;
               case BOTTOM_ALIGN:
                  _loc4_ = actualHeight - this.measureScaledContentHeight();
            }
            this.updateRenderersPosition(_loc4_);
         }
      }
      
      public function measureOriginalContentHeight() : Number
      {
         return this.measureContentHeight(measureOriginalRendererHeight,SPACING_DEFAULT);
      }
      
      public function measureScaledContentHeight() : Number
      {
         return this.measureContentHeight(this.measureScaledRendererHeight,_spacing);
      }
      
      private function updateRenderersScale(param1:Number) : void
      {
         var _loc2_:NationButton = null;
         this._rendererScale = param1;
         for each(_loc2_ in _renderers)
         {
            _loc2_.setFlagScale(param1);
         }
      }
      
      private function updateRenderersPosition(param1:Number) : void
      {
         var _loc2_:NationButton = null;
         var _loc3_:int = 0;
         for each(_loc2_ in _renderers)
         {
            _loc2_.y = param1 | 0;
            _loc3_ = this.measureScaledRendererHeight(_loc2_);
            param1 += _loc3_ + (_spacing | 0);
            _loc2_.x = 0.5 * (width - _loc2_.contentSize.width);
         }
      }
      
      private function measureScaledRendererHeight(param1:NationButton) : Number
      {
         return param1.contentSize.height * this._rendererScale;
      }
      
      private function measureContentHeight(param1:Function, param2:Number) : Number
      {
         var _loc4_:UIComponent = null;
         var _loc3_:Number = _renderers.length > 0 ? Number(-param2) : Number(0);
         for each(_loc4_ in _renderers)
         {
            _loc3_ += param1(_loc4_) + param2;
         }
         return _loc3_;
      }
      
      override public function set selectedIndex(param1:int) : void
      {
         super.selectedIndex = param1;
         invalidate(InvalidationType.SELECTED_INDEX);
      }
      
      [Inspectable(defaultValue="top",type="list",enumeration="top,center,bottom")]
      public function get tabVAlign() : String
      {
         return this._tabVAlign;
      }
      
      public function set tabVAlign(param1:String) : void
      {
         if(this._tabVAlign != param1)
         {
            this._tabVAlign = param1;
            invalidate();
         }
      }
   }
}
