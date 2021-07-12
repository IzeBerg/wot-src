package net.wg.infrastructure.base.meta.impl
{
   import net.wg.data.constants.Errors;
   import net.wg.infrastructure.base.BaseDAAPIComponent;
   
   public class ChannelCarouselMeta extends BaseDAAPIComponent
   {
       
      
      public var channelOpenClick:Function;
      
      public var closeAll:Function;
      
      public var channelCloseClick:Function;
      
      public var updateItemDataFocus:Function;
      
      public var updateItemDataOpened:Function;
      
      public function ChannelCarouselMeta()
      {
         super();
      }
      
      public function channelOpenClickS(param1:Number) : void
      {
         App.utils.asserter.assertNotNull(this.channelOpenClick,"channelOpenClick" + Errors.CANT_NULL);
         this.channelOpenClick(param1);
      }
      
      public function closeAllS() : void
      {
         App.utils.asserter.assertNotNull(this.closeAll,"closeAll" + Errors.CANT_NULL);
         this.closeAll();
      }
      
      public function channelCloseClickS(param1:Number) : void
      {
         App.utils.asserter.assertNotNull(this.channelCloseClick,"channelCloseClick" + Errors.CANT_NULL);
         this.channelCloseClick(param1);
      }
      
      public function updateItemDataFocusS(param1:Number, param2:String, param3:Boolean) : void
      {
         App.utils.asserter.assertNotNull(this.updateItemDataFocus,"updateItemDataFocus" + Errors.CANT_NULL);
         this.updateItemDataFocus(param1,param2,param3);
      }
      
      public function updateItemDataOpenedS(param1:Number, param2:String, param3:Boolean) : void
      {
         App.utils.asserter.assertNotNull(this.updateItemDataOpened,"updateItemDataOpened" + Errors.CANT_NULL);
         this.updateItemDataOpened(param1,param2,param3);
      }
   }
}
