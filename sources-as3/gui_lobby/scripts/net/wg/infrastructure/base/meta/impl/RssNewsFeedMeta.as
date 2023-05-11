package net.wg.infrastructure.base.meta.impl
{
   import net.wg.data.constants.Errors;
   import net.wg.gui.login.impl.vo.RssItemVo;
   import net.wg.infrastructure.base.BaseDAAPIComponent;
   import net.wg.infrastructure.exceptions.AbstractException;
   
   public class RssNewsFeedMeta extends BaseDAAPIComponent
   {
       
      
      public var openBrowser:Function;
      
      private var _vectorRssItemVo:Vector.<RssItemVo>;
      
      public function RssNewsFeedMeta()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         var _loc1_:RssItemVo = null;
         if(this._vectorRssItemVo)
         {
            for each(_loc1_ in this._vectorRssItemVo)
            {
               _loc1_.dispose();
            }
            this._vectorRssItemVo.splice(0,this._vectorRssItemVo.length);
            this._vectorRssItemVo = null;
         }
         super.onDispose();
      }
      
      public function openBrowserS(param1:String) : void
      {
         App.utils.asserter.assertNotNull(this.openBrowser,"openBrowser" + Errors.CANT_NULL);
         this.openBrowser(param1);
      }
      
      public final function as_updateFeed(param1:Array) : void
      {
         var _loc5_:RssItemVo = null;
         var _loc2_:Vector.<RssItemVo> = this._vectorRssItemVo;
         this._vectorRssItemVo = new Vector.<RssItemVo>(0);
         var _loc3_:uint = param1.length;
         var _loc4_:int = 0;
         while(_loc4_ < _loc3_)
         {
            this._vectorRssItemVo[_loc4_] = new RssItemVo(param1[_loc4_]);
            _loc4_++;
         }
         this.updateFeed(this._vectorRssItemVo);
         if(_loc2_)
         {
            for each(_loc5_ in _loc2_)
            {
               _loc5_.dispose();
            }
            _loc2_.splice(0,_loc2_.length);
         }
      }
      
      protected function updateFeed(param1:Vector.<RssItemVo>) : void
      {
         var _loc2_:String = "as_updateFeed" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
   }
}
