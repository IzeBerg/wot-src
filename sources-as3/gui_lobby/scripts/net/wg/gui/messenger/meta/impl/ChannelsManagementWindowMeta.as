package net.wg.gui.messenger.meta.impl
{
   import net.wg.data.constants.Errors;
   import net.wg.infrastructure.base.AbstractWindowView;
   
   public class ChannelsManagementWindowMeta extends AbstractWindowView
   {
       
      
      public var getSearchLimitLabel:Function;
      
      public var searchToken:Function;
      
      public var joinToChannel:Function;
      
      public var createChannel:Function;
      
      public function ChannelsManagementWindowMeta()
      {
         super();
      }
      
      public function getSearchLimitLabelS() : String
      {
         App.utils.asserter.assertNotNull(this.getSearchLimitLabel,"getSearchLimitLabel" + Errors.CANT_NULL);
         return this.getSearchLimitLabel();
      }
      
      public function searchTokenS(param1:String) : void
      {
         App.utils.asserter.assertNotNull(this.searchToken,"searchToken" + Errors.CANT_NULL);
         this.searchToken(param1);
      }
      
      public function joinToChannelS(param1:Number) : void
      {
         App.utils.asserter.assertNotNull(this.joinToChannel,"joinToChannel" + Errors.CANT_NULL);
         this.joinToChannel(param1);
      }
      
      public function createChannelS(param1:String, param2:Boolean, param3:String, param4:String) : void
      {
         App.utils.asserter.assertNotNull(this.createChannel,"createChannel" + Errors.CANT_NULL);
         this.createChannel(param1,param2,param3,param4);
      }
   }
}
