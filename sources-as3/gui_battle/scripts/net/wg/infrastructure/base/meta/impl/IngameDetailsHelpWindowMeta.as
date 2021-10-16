package net.wg.infrastructure.base.meta.impl
{
   import net.wg.data.constants.Errors;
   import net.wg.gui.battle.windows.vo.IngameDetailsPageVO;
   import net.wg.gui.components.paginator.vo.PaginatorPageNumVO;
   import net.wg.infrastructure.base.AbstractWindowView;
   import net.wg.infrastructure.exceptions.AbstractException;
   import scaleform.clik.data.DataProvider;
   
   public class IngameDetailsHelpWindowMeta extends AbstractWindowView
   {
       
      
      public var requestPageData:Function;
      
      private var _dataProviderPaginatorPageNumVO:DataProvider;
      
      private var _ingameDetailsPageVO:IngameDetailsPageVO;
      
      public function IngameDetailsHelpWindowMeta()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         var _loc1_:PaginatorPageNumVO = null;
         if(this._dataProviderPaginatorPageNumVO)
         {
            for each(_loc1_ in this._dataProviderPaginatorPageNumVO)
            {
               _loc1_.dispose();
            }
            this._dataProviderPaginatorPageNumVO.cleanUp();
            this._dataProviderPaginatorPageNumVO = null;
         }
         if(this._ingameDetailsPageVO)
         {
            this._ingameDetailsPageVO.dispose();
            this._ingameDetailsPageVO = null;
         }
         super.onDispose();
      }
      
      public function requestPageDataS(param1:int) : void
      {
         App.utils.asserter.assertNotNull(this.requestPageData,"requestPageData" + Errors.CANT_NULL);
         this.requestPageData(param1);
      }
      
      public final function as_setPaginatorData(param1:Array) : void
      {
         var _loc5_:PaginatorPageNumVO = null;
         var _loc2_:DataProvider = this._dataProviderPaginatorPageNumVO;
         this._dataProviderPaginatorPageNumVO = new DataProvider();
         var _loc3_:uint = param1.length;
         var _loc4_:int = 0;
         while(_loc4_ < _loc3_)
         {
            this._dataProviderPaginatorPageNumVO[_loc4_] = new PaginatorPageNumVO(param1[_loc4_]);
            _loc4_++;
         }
         this.setPaginatorData(this._dataProviderPaginatorPageNumVO);
         if(_loc2_)
         {
            for each(_loc5_ in _loc2_)
            {
               _loc5_.dispose();
            }
            _loc2_.cleanUp();
         }
      }
      
      public final function as_setPageData(param1:Object) : void
      {
         var _loc2_:IngameDetailsPageVO = this._ingameDetailsPageVO;
         this._ingameDetailsPageVO = this.getIngameDetailsPageVOForData(param1);
         this.setPageData(this._ingameDetailsPageVO);
         if(_loc2_)
         {
            _loc2_.dispose();
         }
      }
      
      protected function setPaginatorData(param1:DataProvider) : void
      {
         var _loc2_:String = "as_setPaginatorData" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
      
      protected function getIngameDetailsPageVOForData(param1:Object) : IngameDetailsPageVO
      {
         var _loc2_:String = "getIngameDetailsPageVOForData" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
      
      protected function setPageData(param1:IngameDetailsPageVO) : void
      {
         var _loc2_:String = "as_setPageData" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
   }
}
