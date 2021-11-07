package net.wg.infrastructure.base.meta.impl
{
   import net.wg.data.constants.Errors;
   import net.wg.gui.battle.StatsBase;
   import net.wg.gui.battle.views.questProgress.data.QPProgressTrackingVO;
   import net.wg.gui.battle.views.questProgress.data.QuestProgressPerformVO;
   import net.wg.gui.lobby.settings.vo.TabsDataVo;
   import net.wg.infrastructure.exceptions.AbstractException;
   import scaleform.clik.data.DataProvider;
   
   public class TabbedFullStatsMeta extends StatsBase
   {
       
      
      public var onSelectQuest:Function;
      
      private var _questProgressPerformVO:QuestProgressPerformVO;
      
      private var _qPProgressTrackingVO:QPProgressTrackingVO;
      
      private var _dataProviderTabsDataVo:DataProvider;
      
      public function TabbedFullStatsMeta()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         var _loc1_:TabsDataVo = null;
         if(this._questProgressPerformVO)
         {
            this._questProgressPerformVO.dispose();
            this._questProgressPerformVO = null;
         }
         if(this._qPProgressTrackingVO)
         {
            this._qPProgressTrackingVO.dispose();
            this._qPProgressTrackingVO = null;
         }
         if(this._dataProviderTabsDataVo)
         {
            for each(_loc1_ in this._dataProviderTabsDataVo)
            {
               _loc1_.dispose();
            }
            this._dataProviderTabsDataVo.cleanUp();
            this._dataProviderTabsDataVo = null;
         }
         super.onDispose();
      }
      
      public function onSelectQuestS(param1:uint) : void
      {
         App.utils.asserter.assertNotNull(this.onSelectQuest,"onSelectQuest" + Errors.CANT_NULL);
         this.onSelectQuest(param1);
      }
      
      public final function as_questProgressPerform(param1:Object) : void
      {
         var _loc2_:QuestProgressPerformVO = this._questProgressPerformVO;
         this._questProgressPerformVO = new QuestProgressPerformVO(param1);
         this.questProgressPerform(this._questProgressPerformVO);
         if(_loc2_)
         {
            _loc2_.dispose();
         }
      }
      
      public final function as_updateProgressTracking(param1:Object) : void
      {
         var _loc2_:QPProgressTrackingVO = this._qPProgressTrackingVO;
         this._qPProgressTrackingVO = new QPProgressTrackingVO(param1);
         this.updateProgressTracking(this._qPProgressTrackingVO);
         if(_loc2_)
         {
            _loc2_.dispose();
         }
      }
      
      public final function as_updateTabs(param1:Array) : void
      {
         var _loc5_:TabsDataVo = null;
         var _loc2_:DataProvider = this._dataProviderTabsDataVo;
         this._dataProviderTabsDataVo = new DataProvider();
         var _loc3_:uint = param1.length;
         var _loc4_:int = 0;
         while(_loc4_ < _loc3_)
         {
            this._dataProviderTabsDataVo[_loc4_] = new TabsDataVo(param1[_loc4_]);
            _loc4_++;
         }
         this.updateTabs(this._dataProviderTabsDataVo);
         if(_loc2_)
         {
            for each(_loc5_ in _loc2_)
            {
               _loc5_.dispose();
            }
            _loc2_.cleanUp();
         }
      }
      
      protected function questProgressPerform(param1:QuestProgressPerformVO) : void
      {
         var _loc2_:String = "as_questProgressPerform" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
      
      protected function updateProgressTracking(param1:QPProgressTrackingVO) : void
      {
         var _loc2_:String = "as_updateProgressTracking" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
      
      protected function updateTabs(param1:DataProvider) : void
      {
         var _loc2_:String = "as_updateTabs" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
   }
}
