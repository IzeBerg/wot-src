package net.wg.infrastructure.base.meta.impl
{
   import net.wg.data.constants.Errors;
   import net.wg.gui.lobby.storage.data.BlueprintsFragmentVO;
   import net.wg.infrastructure.exceptions.AbstractException;
   import scaleform.clik.data.DataProvider;
   
   public class StorageCategoryBlueprintsViewMeta extends StorageCarouselEnvironmentMeta
   {
       
      
      public var navigateToBlueprintScreen:Function;
      
      public var selectConvertible:Function;
      
      private var _blueprintsFragmentVO:BlueprintsFragmentVO;
      
      private var _dataProviderBlueprintsFragmentVO:DataProvider;
      
      public function StorageCategoryBlueprintsViewMeta()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         var _loc1_:BlueprintsFragmentVO = null;
         if(this._blueprintsFragmentVO)
         {
            this._blueprintsFragmentVO.dispose();
            this._blueprintsFragmentVO = null;
         }
         if(this._dataProviderBlueprintsFragmentVO)
         {
            for each(_loc1_ in this._dataProviderBlueprintsFragmentVO)
            {
               _loc1_.dispose();
            }
            this._dataProviderBlueprintsFragmentVO.cleanUp();
            this._dataProviderBlueprintsFragmentVO = null;
         }
         super.onDispose();
      }
      
      public function navigateToBlueprintScreenS(param1:int) : void
      {
         App.utils.asserter.assertNotNull(this.navigateToBlueprintScreen,"navigateToBlueprintScreen" + Errors.CANT_NULL);
         this.navigateToBlueprintScreen(param1);
      }
      
      public function selectConvertibleS(param1:Boolean) : void
      {
         App.utils.asserter.assertNotNull(this.selectConvertible,"selectConvertible" + Errors.CANT_NULL);
         this.selectConvertible(param1);
      }
      
      public final function as_updateIntelligenceData(param1:Object) : void
      {
         var _loc2_:BlueprintsFragmentVO = this._blueprintsFragmentVO;
         this._blueprintsFragmentVO = new BlueprintsFragmentVO(param1);
         this.updateIntelligenceData(this._blueprintsFragmentVO);
         if(_loc2_)
         {
            _loc2_.dispose();
         }
      }
      
      public final function as_updateNationalFragments(param1:Array) : void
      {
         var _loc5_:BlueprintsFragmentVO = null;
         var _loc2_:DataProvider = this._dataProviderBlueprintsFragmentVO;
         this._dataProviderBlueprintsFragmentVO = new DataProvider();
         var _loc3_:uint = param1.length;
         var _loc4_:int = 0;
         while(_loc4_ < _loc3_)
         {
            this._dataProviderBlueprintsFragmentVO[_loc4_] = new BlueprintsFragmentVO(param1[_loc4_]);
            _loc4_++;
         }
         this.updateNationalFragments(this._dataProviderBlueprintsFragmentVO);
         if(_loc2_)
         {
            for each(_loc5_ in _loc2_)
            {
               _loc5_.dispose();
            }
            _loc2_.cleanUp();
         }
      }
      
      protected function updateIntelligenceData(param1:BlueprintsFragmentVO) : void
      {
         var _loc2_:String = "as_updateIntelligenceData" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
      
      protected function updateNationalFragments(param1:DataProvider) : void
      {
         var _loc2_:String = "as_updateNationalFragments" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
   }
}
