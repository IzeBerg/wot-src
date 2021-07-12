package net.wg.infrastructure.base.meta.impl
{
   import net.wg.data.constants.Errors;
   import net.wg.gui.components.paginator.vo.PaginatorPageNumVO;
   import net.wg.gui.lobby.linkedSet.data.LinkedSetDetailsOverlayVO;
   import net.wg.gui.lobby.linkedSet.data.LinkedSetDetailsVideoVO;
   import net.wg.infrastructure.base.BaseDAAPIComponent;
   import net.wg.infrastructure.exceptions.AbstractException;
   import scaleform.clik.data.DataProvider;
   
   public class LinkedSetDetailsOverlayMeta extends BaseDAAPIComponent
   {
       
      
      public var startClick:Function;
      
      public var setPage:Function;
      
      private var _linkedSetDetailsOverlayVO:LinkedSetDetailsOverlayVO;
      
      private var _linkedSetDetailsVideoVO:LinkedSetDetailsVideoVO;
      
      private var _dataProviderPaginatorPageNumVO:DataProvider;
      
      public function LinkedSetDetailsOverlayMeta()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         var _loc1_:PaginatorPageNumVO = null;
         if(this._linkedSetDetailsOverlayVO)
         {
            this._linkedSetDetailsOverlayVO.dispose();
            this._linkedSetDetailsOverlayVO = null;
         }
         if(this._linkedSetDetailsVideoVO)
         {
            this._linkedSetDetailsVideoVO.dispose();
            this._linkedSetDetailsVideoVO = null;
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
      
      public function startClickS(param1:String) : void
      {
         App.utils.asserter.assertNotNull(this.startClick,"startClick" + Errors.CANT_NULL);
         this.startClick(param1);
      }
      
      public function setPageS(param1:int) : void
      {
         App.utils.asserter.assertNotNull(this.setPage,"setPage" + Errors.CANT_NULL);
         this.setPage(param1);
      }
      
      public final function as_setData(param1:Object) : void
      {
         var _loc2_:LinkedSetDetailsOverlayVO = this._linkedSetDetailsOverlayVO;
         this._linkedSetDetailsOverlayVO = new LinkedSetDetailsOverlayVO(param1);
         this.setData(this._linkedSetDetailsOverlayVO);
         if(_loc2_)
         {
            _loc2_.dispose();
         }
      }
      
      public final function as_setDataVideo(param1:Object) : void
      {
         var _loc2_:LinkedSetDetailsVideoVO = this._linkedSetDetailsVideoVO;
         this._linkedSetDetailsVideoVO = new LinkedSetDetailsVideoVO(param1);
         this.setDataVideo(this._linkedSetDetailsVideoVO);
         if(_loc2_)
         {
            _loc2_.dispose();
         }
      }
      
      public final function as_setColorPages(param1:Array) : void
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
         this.setColorPages(this._dataProviderPaginatorPageNumVO);
         if(_loc2_)
         {
            for each(_loc5_ in _loc2_)
            {
               _loc5_.dispose();
            }
            _loc2_.cleanUp();
         }
      }
      
      protected function setData(param1:LinkedSetDetailsOverlayVO) : void
      {
         var _loc2_:String = "as_setData" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
      
      protected function setDataVideo(param1:LinkedSetDetailsVideoVO) : void
      {
         var _loc2_:String = "as_setDataVideo" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
      
      protected function setColorPages(param1:DataProvider) : void
      {
         var _loc2_:String = "as_setColorPages" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
   }
}
