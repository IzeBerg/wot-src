package net.wg.infrastructure.base.meta.impl
{
   import net.wg.data.constants.Errors;
   import net.wg.gui.components.paginator.vo.PaginatorPageNumVO;
   import net.wg.gui.lobby.manualChapter.data.ManualChapterContainerVO;
   import net.wg.infrastructure.base.AbstractView;
   import net.wg.infrastructure.exceptions.AbstractException;
   import scaleform.clik.data.DataProvider;
   
   public class ManualChapterViewMeta extends AbstractView
   {
       
      
      public var closeView:Function;
      
      public var pageButtonClicked:Function;
      
      public var buttonHighlighted:Function;
      
      public var onPreviewClicked:Function;
      
      public var onPageChanged:Function;
      
      private var _manualChapterContainerVO:ManualChapterContainerVO;
      
      private var _dataProviderPaginatorPageNumVO:DataProvider;
      
      public function ManualChapterViewMeta()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         var _loc1_:PaginatorPageNumVO = null;
         if(this._manualChapterContainerVO)
         {
            this._manualChapterContainerVO.dispose();
            this._manualChapterContainerVO = null;
         }
         if(this._dataProviderPaginatorPageNumVO)
         {
            for each(_loc1_ in this._dataProviderPaginatorPageNumVO)
            {
               _loc1_.dispose();
            }
            this._dataProviderPaginatorPageNumVO.cleanUp();
            this._dataProviderPaginatorPageNumVO = null;
         }
         super.onDispose();
      }
      
      public function closeViewS() : void
      {
         App.utils.asserter.assertNotNull(this.closeView,"closeView" + Errors.CANT_NULL);
         this.closeView();
      }
      
      public function pageButtonClickedS(param1:String) : void
      {
         App.utils.asserter.assertNotNull(this.pageButtonClicked,"pageButtonClicked" + Errors.CANT_NULL);
         this.pageButtonClicked(param1);
      }
      
      public function buttonHighlightedS() : void
      {
         App.utils.asserter.assertNotNull(this.buttonHighlighted,"buttonHighlighted" + Errors.CANT_NULL);
         this.buttonHighlighted();
      }
      
      public function onPreviewClickedS(param1:String) : void
      {
         App.utils.asserter.assertNotNull(this.onPreviewClicked,"onPreviewClicked" + Errors.CANT_NULL);
         this.onPreviewClicked(param1);
      }
      
      public function onPageChangedS(param1:String) : void
      {
         App.utils.asserter.assertNotNull(this.onPageChanged,"onPageChanged" + Errors.CANT_NULL);
         this.onPageChanged(param1);
      }
      
      public final function as_setInitData(param1:Object) : void
      {
         var _loc2_:ManualChapterContainerVO = this._manualChapterContainerVO;
         this._manualChapterContainerVO = new ManualChapterContainerVO(param1);
         this.setInitData(this._manualChapterContainerVO);
         if(_loc2_)
         {
            _loc2_.dispose();
         }
      }
      
      public final function as_setPages(param1:Array) : void
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
         this.setPages(this._dataProviderPaginatorPageNumVO);
         if(_loc2_)
         {
            for each(_loc5_ in _loc2_)
            {
               _loc5_.dispose();
            }
            _loc2_.cleanUp();
         }
      }
      
      protected function setInitData(param1:ManualChapterContainerVO) : void
      {
         var _loc2_:String = "as_setInitData" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
      
      protected function setPages(param1:DataProvider) : void
      {
         var _loc2_:String = "as_setPages" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
   }
}
