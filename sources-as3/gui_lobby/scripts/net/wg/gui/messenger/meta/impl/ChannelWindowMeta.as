package net.wg.gui.messenger.meta.impl
{
   import net.wg.data.constants.Errors;
   import net.wg.gui.lobby.messengerBar.MessengerChannelCarouselItem;
   
   public class ChannelWindowMeta extends MessengerChannelCarouselItem
   {
       
      
      public var showFAQWindow:Function;
      
      public var getClientID:Function;
      
      public function ChannelWindowMeta()
      {
         super();
      }
      
      public function showFAQWindowS() : void
      {
         App.utils.asserter.assertNotNull(this.showFAQWindow,"showFAQWindow" + Errors.CANT_NULL);
         this.showFAQWindow();
      }
      
      public function getClientIDS() : Number
      {
         App.utils.asserter.assertNotNull(this.getClientID,"getClientID" + Errors.CANT_NULL);
         return this.getClientID();
      }
   }
}
