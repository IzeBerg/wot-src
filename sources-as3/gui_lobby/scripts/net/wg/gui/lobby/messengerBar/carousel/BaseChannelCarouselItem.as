package net.wg.gui.lobby.messengerBar.carousel
{
   import flash.display.InteractiveObject;
   import net.wg.data.constants.Values;
   import net.wg.gui.lobby.messengerBar.carousel.events.MessengerBarChannelCarouselEvent;
   import net.wg.gui.lobby.messengerBar.interfaces.IBaseChannelCarouselItem;
   import net.wg.infrastructure.base.AbstractWindowView;
   
   public class BaseChannelCarouselItem extends AbstractWindowView implements IBaseChannelCarouselItem
   {
       
      
      public function BaseChannelCarouselItem()
      {
         super();
      }
      
      override public function handleWindowClose() : void
      {
         this.onChannelItemHide();
         super.handleWindowClose();
      }
      
      override public function handleWindowMinimize() : void
      {
         this.onChannelItemHide();
         super.handleWindowMinimize();
      }
      
      override protected function onSetModalFocus(param1:InteractiveObject) : void
      {
         super.onSetModalFocus(param1);
         this.onChannelItemFocusIn();
      }
      
      override protected function onLeaveModalFocus() : void
      {
         super.onLeaveModalFocus();
         this.onChannelWindowFocusOut();
      }
      
      override protected function onPopulate() : void
      {
         super.onPopulate();
         this.onChannelItemShow();
      }
      
      public function getClientItemID() : Number
      {
         return Number.NaN;
      }
      
      public function getItemType() : String
      {
         return Values.EMPTY_STR;
      }
      
      public function onChannelItemFocusIn() : void
      {
         this.dispatchCustomEvent(MessengerBarChannelCarouselEvent.CHANNEL_WINDOW_FOCUS_IN);
      }
      
      public function onChannelItemHide() : void
      {
         this.dispatchCustomEvent(MessengerBarChannelCarouselEvent.CHANNEL_WINDOW_HIDE);
      }
      
      public function onChannelItemShow() : void
      {
         this.dispatchCustomEvent(MessengerBarChannelCarouselEvent.CHANNEL_WINDOW_SHOW);
      }
      
      public function onChannelWindowFocusOut() : void
      {
         this.dispatchCustomEvent(MessengerBarChannelCarouselEvent.CHANNEL_WINDOW_FOCUS_OUT);
      }
      
      private function dispatchCustomEvent(param1:String) : void
      {
         var _loc2_:Number = this.getClientItemID();
         App.utils.asserter.assert(!isNaN(_loc2_),"Var clientId has empty NaN value.");
         var _loc3_:String = this.getItemType();
         App.utils.asserter.assert(_loc3_ != Values.EMPTY_STR,"Var itemType has empty string value. Method getWindowType() must be override");
         window.windowContent.dispatchEvent(new MessengerBarChannelCarouselEvent(param1,_loc2_,_loc3_));
      }
   }
}
