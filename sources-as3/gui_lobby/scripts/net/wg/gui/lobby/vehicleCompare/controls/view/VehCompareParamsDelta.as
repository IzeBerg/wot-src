package net.wg.gui.lobby.vehicleCompare.controls.view
{
   import flash.display.DisplayObject;
   import net.wg.data.constants.Linkages;
   import net.wg.gui.lobby.vehicleCompare.data.VehCompareParamsDeltaVO;
   import net.wg.infrastructure.base.UIComponentEx;
   import scaleform.clik.constants.InvalidationType;
   
   public class VehCompareParamsDelta extends UIComponentEx
   {
      
      private static const BUBBLE_OFFSET_Y:int = 10;
      
      private static const REVERTED_LINES_OFFSET:int = 2;
      
      private static const NOT_REVERTED_LINES_OFFSET:int = 1;
      
      private static const ALPHA_DIST:int = 100;
      
      private static const SCROLL_INV:String = "ScrollInv";
       
      
      private var _bubbles:Vector.<VehCompareBubble>;
      
      private var _data:VehCompareParamsDeltaVO;
      
      private var _scrollPosition:Number = 0;
      
      public function VehCompareParamsDelta()
      {
         this._bubbles = new Vector.<VehCompareBubble>(0);
         super();
         mouseEnabled = mouseChildren = false;
      }
      
      override protected function onDispose() : void
      {
         var _loc1_:DisplayObject = null;
         for each(_loc1_ in this._bubbles)
         {
            removeChild(_loc1_);
         }
         this._bubbles.splice(0,this._bubbles.length);
         this._bubbles = null;
         this._data = null;
         super.onDispose();
      }
      
      override protected function draw() : void
      {
         var _loc1_:VehCompareBubble = null;
         var _loc2_:int = 0;
         var _loc3_:Boolean = false;
         var _loc4_:String = null;
         var _loc5_:int = 0;
         var _loc6_:Boolean = false;
         var _loc7_:Number = NaN;
         var _loc8_:Number = NaN;
         super.draw();
         if(this._data && isInvalid(InvalidationType.DATA))
         {
            this.hideAllBubbles();
            if(this._data.deltas)
            {
               _loc2_ = this._data.deltas.length;
               _loc3_ = this._data.paramIndex == 0;
               _loc5_ = 0;
               while(_loc5_ < _loc2_)
               {
                  if(this._bubbles.length <= _loc5_)
                  {
                     _loc1_ = this.createBubble();
                  }
                  else
                  {
                     _loc1_ = this._bubbles[_loc5_];
                  }
                  _loc4_ = this._data.deltas[_loc5_];
                  _loc6_ = _loc4_ != null && _loc4_ != "";
                  if(_loc6_)
                  {
                     this.updateBubbleData(_loc5_,_loc1_,_loc3_);
                  }
                  _loc1_.visible = _loc6_;
                  _loc5_++;
               }
               if(_loc3_)
               {
                  y = VehCompareVehParamRenderer.LINE_HEIGHT * (this._data.paramIndex + REVERTED_LINES_OFFSET) + BUBBLE_OFFSET_Y;
               }
               else
               {
                  y = VehCompareVehParamRenderer.LINE_HEIGHT * (this._data.paramIndex + NOT_REVERTED_LINES_OFFSET) - BUBBLE_OFFSET_Y;
               }
               visible = this._data.paramIndex != -1;
               invalidate(SCROLL_INV);
            }
         }
         if(isInvalid(SCROLL_INV))
         {
            _loc7_ = x - this._scrollPosition + ALPHA_DIST - (VehCompareVehParamRenderer.LINE_WIDTH >> 1);
            for each(_loc1_ in this._bubbles)
            {
               _loc8_ = Math.min((_loc1_.x + _loc7_) / ALPHA_DIST,1);
               _loc8_ = _loc8_ < 0 ? Number(0) : Number(_loc8_);
               _loc1_.alpha = _loc8_;
            }
         }
      }
      
      public function setData(param1:VehCompareParamsDeltaVO) : void
      {
         this._data = param1;
         invalidateData();
      }
      
      public function updateScrollPosition(param1:Number) : void
      {
         this._scrollPosition = param1;
         invalidate(SCROLL_INV);
      }
      
      private function createBubble() : VehCompareBubble
      {
         var _loc1_:VehCompareBubble = App.utils.classFactory.getComponent(Linkages.VEH_CMP_BUBBLE_UI,VehCompareBubble);
         addChild(_loc1_);
         this._bubbles.push(_loc1_);
         return _loc1_;
      }
      
      private function hideAllBubbles() : void
      {
         var _loc1_:VehCompareBubble = null;
         for each(_loc1_ in this._bubbles)
         {
            _loc1_.text = "";
            _loc1_.visible = false;
         }
      }
      
      private function updateBubbleData(param1:int, param2:VehCompareBubble, param3:Boolean) : void
      {
         var _loc4_:String = this._data.deltas[param1];
         param2.text = _loc4_;
         param2.isReverted = param3;
         param2.x = VehCompareVehParamRenderer.LINE_WIDTH * (param1 + 0.5);
         param2.y = -VehCompareVehParamRenderer.LINE_HEIGHT;
      }
   }
}
