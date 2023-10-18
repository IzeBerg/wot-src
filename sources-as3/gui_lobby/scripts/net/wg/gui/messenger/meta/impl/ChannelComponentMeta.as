package net.wg.gui.messenger.meta.impl
{
   import net.wg.data.constants.Errors;
   import net.wg.infrastructure.base.BaseDAAPIComponent;
   
   public class ChannelComponentMeta extends BaseDAAPIComponent
   {
       
      
      public var isJoined:Function;
      
      public var sendMessage:Function;
      
      public var getHistory:Function;
      
      public var getMessageMaxLength:Function;
      
      public var onLinkClick:Function;
      
      public function ChannelComponentMeta()
      {
         super();
      }
      
      public function isJoinedS() : Boolean
      {
         App.utils.asserter.assertNotNull(this.isJoined,"isJoined" + Errors.CANT_NULL);
         return this.isJoined();
      }
      
      public function sendMessageS(param1:String) : Boolean
      {
         App.utils.asserter.assertNotNull(this.sendMessage,"sendMessage" + Errors.CANT_NULL);
         return this.sendMessage(param1);
      }
      
      public function getHistoryS() : String
      {
         App.utils.asserter.assertNotNull(this.getHistory,"getHistory" + Errors.CANT_NULL);
         return this.getHistory();
      }
      
      public function getMessageMaxLengthS() : int
      {
         App.utils.asserter.assertNotNull(this.getMessageMaxLength,"getMessageMaxLength" + Errors.CANT_NULL);
         return this.getMessageMaxLength();
      }
      
      public function onLinkClickS(param1:String) : void
      {
         App.utils.asserter.assertNotNull(this.onLinkClick,"onLinkClick" + Errors.CANT_NULL);
         this.onLinkClick(param1);
      }
   }
}
