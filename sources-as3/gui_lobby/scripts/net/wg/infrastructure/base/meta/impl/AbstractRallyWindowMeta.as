package net.wg.infrastructure.base.meta.impl
{
   import net.wg.data.constants.Errors;
   import net.wg.gui.lobby.messengerBar.PrebattleChannelCarouselItem;
   
   public class AbstractRallyWindowMeta extends PrebattleChannelCarouselItem
   {
       
      
      public var canGoBack:Function;
      
      public var onBrowseRallies:Function;
      
      public var onCreateRally:Function;
      
      public var onJoinRally:Function;
      
      public function AbstractRallyWindowMeta()
      {
         super();
      }
      
      public function canGoBackS() : Boolean
      {
         App.utils.asserter.assertNotNull(this.canGoBack,"canGoBack" + Errors.CANT_NULL);
         return this.canGoBack();
      }
      
      public function onBrowseRalliesS() : void
      {
         App.utils.asserter.assertNotNull(this.onBrowseRallies,"onBrowseRallies" + Errors.CANT_NULL);
         this.onBrowseRallies();
      }
      
      public function onCreateRallyS() : void
      {
         App.utils.asserter.assertNotNull(this.onCreateRally,"onCreateRally" + Errors.CANT_NULL);
         this.onCreateRally();
      }
      
      public function onJoinRallyS(param1:Number, param2:int, param3:Number) : void
      {
         App.utils.asserter.assertNotNull(this.onJoinRally,"onJoinRally" + Errors.CANT_NULL);
         this.onJoinRally(param1,param2,param3);
      }
   }
}
