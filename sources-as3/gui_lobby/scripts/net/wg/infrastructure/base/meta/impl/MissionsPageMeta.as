package net.wg.infrastructure.base.meta.impl
{
   import net.wg.data.constants.Errors;
   import net.wg.gui.lobby.missions.data.MissionTabCounterVO;
   import net.wg.gui.lobby.missions.data.MissionTabVO;
   import net.wg.infrastructure.base.AbstractView;
   import net.wg.infrastructure.exceptions.AbstractException;
   import scaleform.clik.data.DataProvider;
   
   public class MissionsPageMeta extends AbstractView
   {
       
      
      public var resetFilters:Function;
      
      public var onTabSelected:Function;
      
      public var onClose:Function;
      
      private var _dataProviderMissionTabVO:DataProvider;
      
      private var _vectorMissionTabCounterVO:Vector.<MissionTabCounterVO>;
      
      public function MissionsPageMeta()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         var _loc1_:MissionTabVO = null;
         var _loc2_:MissionTabCounterVO = null;
         if(this._dataProviderMissionTabVO)
         {
            for each(_loc1_ in this._dataProviderMissionTabVO)
            {
               _loc1_.dispose();
            }
            this._dataProviderMissionTabVO.cleanUp();
            this._dataProviderMissionTabVO = null;
         }
         if(this._vectorMissionTabCounterVO)
         {
            for each(_loc2_ in this._vectorMissionTabCounterVO)
            {
               _loc2_.dispose();
            }
            this._vectorMissionTabCounterVO.splice(0,this._vectorMissionTabCounterVO.length);
            this._vectorMissionTabCounterVO = null;
         }
         super.onDispose();
      }
      
      public function resetFiltersS() : void
      {
         App.utils.asserter.assertNotNull(this.resetFilters,"resetFilters" + Errors.CANT_NULL);
         this.resetFilters();
      }
      
      public function onTabSelectedS(param1:String, param2:String) : void
      {
         App.utils.asserter.assertNotNull(this.onTabSelected,"onTabSelected" + Errors.CANT_NULL);
         this.onTabSelected(param1,param2);
      }
      
      public function onCloseS() : void
      {
         App.utils.asserter.assertNotNull(this.onClose,"onClose" + Errors.CANT_NULL);
         this.onClose();
      }
      
      public final function as_setTabsDataProvider(param1:Array) : void
      {
         var _loc5_:MissionTabVO = null;
         var _loc2_:DataProvider = this._dataProviderMissionTabVO;
         this._dataProviderMissionTabVO = new DataProvider();
         var _loc3_:uint = param1.length;
         var _loc4_:int = 0;
         while(_loc4_ < _loc3_)
         {
            this._dataProviderMissionTabVO[_loc4_] = new MissionTabVO(param1[_loc4_]);
            _loc4_++;
         }
         this.setTabsDataProvider(this._dataProviderMissionTabVO);
         if(_loc2_)
         {
            for each(_loc5_ in _loc2_)
            {
               _loc5_.dispose();
            }
            _loc2_.cleanUp();
         }
      }
      
      public final function as_setTabsCounterData(param1:Array) : void
      {
         var _loc5_:MissionTabCounterVO = null;
         var _loc2_:Vector.<MissionTabCounterVO> = this._vectorMissionTabCounterVO;
         this._vectorMissionTabCounterVO = new Vector.<MissionTabCounterVO>(0);
         var _loc3_:uint = param1.length;
         var _loc4_:int = 0;
         while(_loc4_ < _loc3_)
         {
            this._vectorMissionTabCounterVO[_loc4_] = new MissionTabCounterVO(param1[_loc4_]);
            _loc4_++;
         }
         this.setTabsCounterData(this._vectorMissionTabCounterVO);
         if(_loc2_)
         {
            for each(_loc5_ in _loc2_)
            {
               _loc5_.dispose();
            }
            _loc2_.splice(0,_loc2_.length);
         }
      }
      
      protected function setTabsDataProvider(param1:DataProvider) : void
      {
         var _loc2_:String = "as_setTabsDataProvider" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
      
      protected function setTabsCounterData(param1:Vector.<MissionTabCounterVO>) : void
      {
         var _loc2_:String = "as_setTabsCounterData" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
   }
}
