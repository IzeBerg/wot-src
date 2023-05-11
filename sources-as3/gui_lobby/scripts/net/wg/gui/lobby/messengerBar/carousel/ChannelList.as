package net.wg.gui.lobby.messengerBar.carousel
{
   import net.wg.gui.lobby.messengerBar.carousel.data.ChannelListItemVO;
   import scaleform.clik.constants.DirectionMode;
   
   public class ChannelList extends FlexibleTileList
   {
       
      
      public function ChannelList()
      {
         super();
      }
      
      private static function isHaveBlinking(param1:Array) : Boolean
      {
         var _loc2_:ChannelListItemVO = null;
         var _loc3_:int = 0;
         while(_loc3_ < param1.length)
         {
            _loc2_ = new ChannelListItemVO(param1[_loc3_]);
            if(_loc2_.isNotified)
            {
               return true;
            }
            _loc3_++;
         }
         return false;
      }
      
      private function checkLeftScrollBarArrowBlinking(param1:Array) : void
      {
         this.setLeftScrollBarArrowBlinking(isHaveBlinking(param1));
      }
      
      private function checkRightScrollBarArrowBlinking(param1:Array) : void
      {
         this.setRightScrollBarArrowBlinking(isHaveBlinking(param1));
      }
      
      private function setLeftScrollBarArrowBlinking(param1:Boolean) : void
      {
         ChannelCarouselScrollBar(_scrollBar).setUpArrowBlinking(param1);
      }
      
      private function setRightScrollBarArrowBlinking(param1:Boolean) : void
      {
         ChannelCarouselScrollBar(_scrollBar).setDownArrowBlinking(param1);
      }
      
      override protected function updateScrollBar() : void
      {
         var _loc1_:Number = NaN;
         var _loc2_:Number = NaN;
         var _loc3_:Number = NaN;
         var _loc4_:int = 0;
         super.updateScrollBar();
         if(_dataProvider && _dataProvider.length > 0)
         {
            _loc1_ = _direction == DirectionMode.HORIZONTAL ? Number(_totalRows) : Number(_totalColumns);
            _loc2_ = _scrollPosition * _loc1_;
            _loc3_ = _loc2_ + _totalColumns * _totalRows - 1;
            if(_loc2_ > 0)
            {
               _dataProvider.requestItemRange(0,_loc2_ - 1,this.checkLeftScrollBarArrowBlinking);
            }
            else
            {
               this.setLeftScrollBarArrowBlinking(false);
            }
            _loc4_ = _dataProvider.length - 1;
            if(_loc3_ < _loc4_)
            {
               _dataProvider.requestItemRange(_loc3_ + 1,_loc4_,this.checkRightScrollBarArrowBlinking);
            }
            else
            {
               this.setRightScrollBarArrowBlinking(false);
            }
         }
      }
   }
}
