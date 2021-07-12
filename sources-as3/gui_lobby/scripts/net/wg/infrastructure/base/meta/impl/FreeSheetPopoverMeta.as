package net.wg.infrastructure.base.meta.impl
{
   import net.wg.data.constants.Errors;
   import net.wg.gui.lobby.personalMissions.data.FreeSheetPopoverVO;
   import net.wg.gui.lobby.personalMissions.data.PawnedSheetVO;
   import net.wg.infrastructure.base.SmartPopOverView;
   import net.wg.infrastructure.exceptions.AbstractException;
   import scaleform.clik.data.DataProvider;
   
   public class FreeSheetPopoverMeta extends SmartPopOverView
   {
       
      
      public var onTaskClick:Function;
      
      private var _freeSheetPopoverVO:FreeSheetPopoverVO;
      
      private var _dataProviderPawnedSheetVO:DataProvider;
      
      public function FreeSheetPopoverMeta()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         var _loc1_:PawnedSheetVO = null;
         if(this._freeSheetPopoverVO)
         {
            this._freeSheetPopoverVO.dispose();
            this._freeSheetPopoverVO = null;
         }
         if(this._dataProviderPawnedSheetVO)
         {
            for each(_loc1_ in this._dataProviderPawnedSheetVO)
            {
               _loc1_.dispose();
            }
            this._dataProviderPawnedSheetVO.cleanUp();
            this._dataProviderPawnedSheetVO = null;
         }
         super.onDispose();
      }
      
      public function onTaskClickS(param1:String) : void
      {
         App.utils.asserter.assertNotNull(this.onTaskClick,"onTaskClick" + Errors.CANT_NULL);
         this.onTaskClick(param1);
      }
      
      public final function as_setData(param1:Object) : void
      {
         var _loc2_:FreeSheetPopoverVO = this._freeSheetPopoverVO;
         this._freeSheetPopoverVO = new FreeSheetPopoverVO(param1);
         this.setData(this._freeSheetPopoverVO);
         if(_loc2_)
         {
            _loc2_.dispose();
         }
      }
      
      public final function as_setListDataProvider(param1:Array) : void
      {
         var _loc5_:PawnedSheetVO = null;
         var _loc2_:DataProvider = this._dataProviderPawnedSheetVO;
         this._dataProviderPawnedSheetVO = new DataProvider();
         var _loc3_:uint = param1.length;
         var _loc4_:int = 0;
         while(_loc4_ < _loc3_)
         {
            this._dataProviderPawnedSheetVO[_loc4_] = new PawnedSheetVO(param1[_loc4_]);
            _loc4_++;
         }
         this.setListDataProvider(this._dataProviderPawnedSheetVO);
         if(_loc2_)
         {
            for each(_loc5_ in _loc2_)
            {
               _loc5_.dispose();
            }
            _loc2_.cleanUp();
         }
      }
      
      protected function setData(param1:FreeSheetPopoverVO) : void
      {
         var _loc2_:String = "as_setData" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
      
      protected function setListDataProvider(param1:DataProvider) : void
      {
         var _loc2_:String = "as_setListDataProvider" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
   }
}
