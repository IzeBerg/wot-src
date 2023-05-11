package net.wg.gui.lobby.messengerBar.interfaces
{
   public interface IBaseChannelCarouselItem
   {
       
      
      function onChannelItemFocusIn() : void;
      
      function onChannelWindowFocusOut() : void;
      
      function onChannelItemShow() : void;
      
      function onChannelItemHide() : void;
      
      function getClientItemID() : Number;
      
      function getItemType() : String;
   }
}
