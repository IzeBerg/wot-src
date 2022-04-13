package net.wg.gui.components.tooltips.layout
{
   import flash.display.DisplayObject;
   import net.wg.data.VO.PaddingVO;
   import net.wg.data.constants.generated.BLOCKS_TOOLTIP_TYPES;
   import net.wg.gui.components.tooltips.inblocks.data.BlockDataItemVO;
   import net.wg.gui.components.tooltips.inblocks.interfaces.ITooltipBlock;
   import net.wg.gui.components.tooltips.inblocks.interfaces.ITooltipBlocks;
   
   public class TooltipHorizontalLayout extends BaseTooltipLayout
   {
       
      
      public function TooltipHorizontalLayout()
      {
         super();
      }
      
      override public function measureBlock(param1:ITooltipBlock, param2:BlockDataItemVO) : void
      {
         var _loc3_:PaddingVO = param2.padding;
         if(param2.blockWidth > 0)
         {
            param1.setBlockWidth(param2.blockWidth - (_loc3_ != null ? _loc3_.left + _loc3_.right : 0));
         }
      }
      
      override public function arrange(param1:ITooltipBlocks) : void
      {
         var _loc5_:ITooltipBlock = null;
         var _loc6_:DisplayObject = null;
         var _loc7_:PaddingVO = null;
         var _loc8_:Boolean = false;
         var _loc2_:Vector.<BlockDataItemVO> = param1.data.blocks;
         var _loc3_:int = _loc2_.length;
         var _loc4_:int = param1.data.layoutGap;
         var _loc9_:int = _loc3_ > 0 ? int(-_loc4_) : int(0);
         var _loc10_:int = 0;
         var _loc11_:int = 0;
         var _loc12_:int = 0;
         while(_loc12_ < _loc3_)
         {
            _loc5_ = param1.blocks[_loc12_];
            _loc7_ = _loc2_[_loc12_].padding;
            _loc8_ = _loc7_ != null;
            _loc10_ = !!_loc8_ ? int(_loc7_.top) : int(0);
            _loc9_ += (!!_loc8_ ? _loc7_.left : 0) + _loc4_;
            _loc6_ = _loc5_.getDisplayObject();
            _loc6_.x = _loc9_ | 0;
            _loc6_.y = _loc10_;
            _loc9_ += _loc5_.getWidth() + (!!_loc8_ ? _loc7_.right : 0);
            _loc10_ += _loc5_.getHeight() + (!!_loc8_ ? _loc7_.bottom : 0);
            _loc11_ = Math.max(_loc10_,_loc11_);
            _loc12_++;
         }
         _measuredWidth = _loc9_;
         if(_loc5_ != null && param1.data.stretchLastElement && _expectedWidth > 0)
         {
            _loc5_.setBlockWidth(_loc5_.getWidth() + _expectedWidth - _measuredWidth);
            _measuredWidth = _expectedWidth;
         }
         _measuredHeight = _loc11_;
         var _loc13_:String = param1.data.layoutAlign;
         var _loc14_:int = 0;
         switch(_loc13_)
         {
            case BLOCKS_TOOLTIP_TYPES.ALIGN_CENTER:
               _loc14_ = _expectedWidth - _measuredWidth >> 1;
               break;
            case BLOCKS_TOOLTIP_TYPES.ALIGN_RIGHT:
               _loc14_ = _expectedWidth - _measuredWidth;
         }
         _loc12_ = 0;
         while(_loc12_ < _loc3_)
         {
            _loc5_ = param1.blocks[_loc12_];
            _loc5_.getDisplayObject().x = _loc5_.getDisplayObject().x + _loc14_;
            _loc12_++;
         }
      }
   }
}
