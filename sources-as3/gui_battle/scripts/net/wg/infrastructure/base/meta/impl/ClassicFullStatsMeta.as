package net.wg.infrastructure.base.meta.impl
{
   import net.wg.data.constants.Errors;
   import net.wg.gui.battle.TabbedFullStats;
   import net.wg.gui.battle.views.questProgress.data.QPProgressTrackingVO;
   import net.wg.gui.battle.views.questProgress.data.QuestProgressPerformVO;
   import net.wg.infrastructure.exceptions.AbstractException;
   
   public class ClassicFullStatsMeta extends TabbedFullStats
   {
       
      
      public var onSelectQuest:Function;
      
      public var onStatsTableVisibiltyToggled:Function;
      
      private var _questProgressPerformVO:QuestProgressPerformVO;
      
      private var _qPProgressTrackingVO:QPProgressTrackingVO;
      
      public function ClassicFullStatsMeta()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
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
         super.onDispose();
      }
      
      public function onSelectQuestS(param1:uint) : void
      {
         App.utils.asserter.assertNotNull(this.onSelectQuest,"onSelectQuest" + Errors.CANT_NULL);
         this.onSelectQuest(param1);
      }
      
      public function onStatsTableVisibiltyToggledS(param1:Boolean) : void
      {
         App.utils.asserter.assertNotNull(this.onStatsTableVisibiltyToggled,"onStatsTableVisibiltyToggled" + Errors.CANT_NULL);
         this.onStatsTableVisibiltyToggled(param1);
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
   }
}
