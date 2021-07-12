package net.wg.gui.components.tooltips
{
   import flash.text.TextField;
   import net.wg.gui.components.controls.IconText;
   import net.wg.gui.components.tooltips.VO.ToolTipBlockResultVO;
   import net.wg.gui.components.tooltips.helpers.Utils;
   
   public class ToolTipSpecial extends ToolTipBase
   {
      
      public static var ID_BUY_PRICE:String = "buy_price";
      
      public static var ID_SELL_PRICE:String = "sell_price";
      
      public static var ID_UNLOCK_PRICE:String = "unlock_price";
      
      public static var ID_HIDDEN_VEHICLE_COUNT:String = "hiddenVehicleCount";
       
      
      protected var blockResults:Vector.<ToolTipBlockResultVO> = null;
      
      public function ToolTipSpecial()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         var _loc1_:ToolTipBlockResultVO = null;
         var _loc2_:TextField = null;
         var _loc3_:TextField = null;
         var _loc4_:Vector.<IconText> = null;
         var _loc5_:IconText = null;
         if(this.blockResults)
         {
            for each(_loc1_ in this.blockResults)
            {
               _loc2_ = _loc1_.headerTextField;
               if(_loc2_ != null)
               {
                  content.removeChild(_loc2_);
                  _loc1_.headerTextField = null;
               }
               _loc3_ = _loc1_.leftTextField;
               if(_loc3_ != null)
               {
                  content.removeChild(_loc3_);
                  _loc1_.leftTextField = null;
               }
               _loc4_ = _loc1_.elRightList;
               for each(_loc5_ in _loc4_)
               {
                  content.removeChild(_loc5_);
               }
               _loc4_.splice(0,_loc4_.length);
            }
            this.blockResults.splice(0,this.blockResults.length);
            this.blockResults = null;
         }
         super.onDispose();
      }
      
      override protected function updateSize() : void
      {
         if(contentWidth == 0 || contentWidth < content.width)
         {
            contentWidth = content.width;
         }
         background.width = contentWidth + contentMargin.right + bgShadowMargin.right | 0;
         background.height = content.height + contentMargin.bottom + bgShadowMargin.bottom | 0;
      }
      
      protected function updatePositions() : void
      {
         var _loc1_:ToolTipBlockResultVO = null;
         var _loc2_:Number = NaN;
         var _loc3_:Separator = null;
         var _loc4_:IconText = null;
         for each(_loc1_ in this.blockResults)
         {
            _loc1_.leftTextField.width = leftPartMaxW;
            for each(_loc4_ in _loc1_.elRightList)
            {
               _loc4_.x = _loc1_.leftTextField.x + leftPartMaxW + Utils.instance.MARGIN_BEETWEEN_LEFT_AND_RIGHT_BLOCKS | 0;
            }
         }
         _loc2_ = content.width + contentMargin.right + bgShadowMargin.right;
         for each(_loc3_ in separators)
         {
            _loc3_.x = _loc2_ - _loc3_.width >> 1;
         }
      }
   }
}
