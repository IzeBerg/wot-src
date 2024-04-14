package net.wg.infrastructure.base.meta.impl
{
   import net.wg.data.constants.Errors;
   import net.wg.gui.components.controls.tabs.OrangeTabsMenuVO;
   import net.wg.infrastructure.base.BaseDAAPIComponent;
   import net.wg.infrastructure.exceptions.AbstractException;
   import scaleform.clik.data.DataProvider;
   
   public class StorageCategoryInHangarViewMeta extends BaseDAAPIComponent
   {
       
      
      public var setActiveState:Function;
      
      private var _dataProviderOrangeTabsMenuVO:DataProvider;
      
      public function StorageCategoryInHangarViewMeta()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         var _loc1_:OrangeTabsMenuVO = null;
         if(this._dataProviderOrangeTabsMenuVO)
         {
            for each(_loc1_ in this._dataProviderOrangeTabsMenuVO)
            {
               _loc1_.dispose();
            }
            this._dataProviderOrangeTabsMenuVO.cleanUp();
            this._dataProviderOrangeTabsMenuVO = null;
         }
         super.onDispose();
      }
      
      public function setActiveStateS(param1:Boolean) : void
      {
         App.utils.asserter.assertNotNull(this.setActiveState,"setActiveState" + Errors.CANT_NULL);
         this.setActiveState(param1);
      }
      
      public final function as_setTabsData(param1:Array) : void
      {
         var _loc5_:OrangeTabsMenuVO = null;
         var _loc2_:DataProvider = this._dataProviderOrangeTabsMenuVO;
         this._dataProviderOrangeTabsMenuVO = new DataProvider();
         var _loc3_:uint = param1.length;
         var _loc4_:int = 0;
         while(_loc4_ < _loc3_)
         {
            this._dataProviderOrangeTabsMenuVO[_loc4_] = new OrangeTabsMenuVO(param1[_loc4_]);
            _loc4_++;
         }
         this.setTabsData(this._dataProviderOrangeTabsMenuVO);
         if(_loc2_)
         {
            for each(_loc5_ in _loc2_)
            {
               _loc5_.dispose();
            }
            _loc2_.cleanUp();
         }
      }
      
      protected function setTabsData(param1:DataProvider) : void
      {
         var _loc2_:String = "as_setTabsData" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
   }
}
