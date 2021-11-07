package net.wg.infrastructure.base.meta.impl
{
   import net.wg.data.constants.Errors;
   import net.wg.gui.bootcamp.data.BCTutorialPageVO;
   import net.wg.gui.components.paginator.vo.PaginatorPageNumVO;
   import net.wg.infrastructure.base.AbstractWindowView;
   import net.wg.infrastructure.exceptions.AbstractException;
   import scaleform.clik.data.DataProvider;
   
   public class HWIngameHelpWindowMeta extends AbstractWindowView
   {
       
      
      public var clickSettingWindow:Function;
      
      private var _vectorBCTutorialPageVO:Vector.<BCTutorialPageVO>;
      
      private var _dataProviderPaginatorPageNumVO:DataProvider;
      
      public function HWIngameHelpWindowMeta()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         var _loc1_:BCTutorialPageVO = null;
         var _loc2_:PaginatorPageNumVO = null;
         if(this._vectorBCTutorialPageVO)
         {
            for each(_loc1_ in this._vectorBCTutorialPageVO)
            {
               _loc1_.dispose();
            }
            this._vectorBCTutorialPageVO.splice(0,this._vectorBCTutorialPageVO.length);
            this._vectorBCTutorialPageVO = null;
         }
         if(this._dataProviderPaginatorPageNumVO)
         {
            for each(_loc2_ in this._dataProviderPaginatorPageNumVO)
            {
               _loc2_.dispose();
            }
            this._dataProviderPaginatorPageNumVO.cleanUp();
            this._dataProviderPaginatorPageNumVO = null;
         }
         super.onDispose();
      }
      
      public function clickSettingWindowS() : void
      {
         App.utils.asserter.assertNotNull(this.clickSettingWindow,"clickSettingWindow" + Errors.CANT_NULL);
         this.clickSettingWindow();
      }
      
      public final function as_setData(param1:Array) : void
      {
         var _loc5_:BCTutorialPageVO = null;
         var _loc2_:Vector.<BCTutorialPageVO> = this._vectorBCTutorialPageVO;
         this._vectorBCTutorialPageVO = new Vector.<BCTutorialPageVO>(0);
         var _loc3_:uint = param1.length;
         var _loc4_:int = 0;
         while(_loc4_ < _loc3_)
         {
            this._vectorBCTutorialPageVO[_loc4_] = new BCTutorialPageVO(param1[_loc4_]);
            _loc4_++;
         }
         this.setData(this._vectorBCTutorialPageVO);
         if(_loc2_)
         {
            for each(_loc5_ in _loc2_)
            {
               _loc5_.dispose();
            }
            _loc2_.splice(0,_loc2_.length);
         }
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
      
      protected function setData(param1:Vector.<BCTutorialPageVO>) : void
      {
         var _loc2_:String = "as_setData" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
      
      protected function setPaginatorData(param1:DataProvider) : void
      {
         var _loc2_:String = "as_setPaginatorData" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
   }
}
