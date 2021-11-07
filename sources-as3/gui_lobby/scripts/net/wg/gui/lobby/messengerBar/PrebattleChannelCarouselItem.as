package net.wg.gui.lobby.messengerBar
{
   import net.wg.data.constants.generated.MESSENGER_CHANNEL_CAROUSEL_ITEM_TYPES;
   import net.wg.gui.lobby.messengerBar.carousel.BaseChannelCarouselItem;
   
   public class PrebattleChannelCarouselItem extends BaseChannelCarouselItem
   {
       
      
      public function PrebattleChannelCarouselItem()
      {
         super();
      }
      
      override public function getItemType() : String
      {
         return MESSENGER_CHANNEL_CAROUSEL_ITEM_TYPES.CHANNEL_CAROUSEL_ITEM_TYPE_PREBATTLE;
      }
   }
}
