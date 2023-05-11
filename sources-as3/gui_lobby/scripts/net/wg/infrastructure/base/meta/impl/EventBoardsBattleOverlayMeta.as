package net.wg.infrastructure.base.meta.impl
{
   import net.wg.data.constants.Errors;
   import net.wg.gui.lobby.eventBoards.data.BattleExperienceBlockVO;
   import net.wg.gui.lobby.eventBoards.data.BattleStatisticsBlockVO;
   import net.wg.gui.lobby.eventBoards.data.EventBoardTableHeaderVO;
   import net.wg.gui.lobby.eventBoards.data.EventBoardTableRendererContainerVO;
   import net.wg.gui.lobby.eventBoards.data.EventBoardsBattleOverlayVO;
   import net.wg.infrastructure.base.BaseDAAPIComponent;
   import net.wg.infrastructure.exceptions.AbstractException;
   
   public class EventBoardsBattleOverlayMeta extends BaseDAAPIComponent
   {
       
      
      private var _eventBoardsBattleOverlayVO:EventBoardsBattleOverlayVO;
      
      private var _battleExperienceBlockVO:BattleExperienceBlockVO;
      
      private var _battleStatisticsBlockVO:BattleStatisticsBlockVO;
      
      private var _eventBoardTableHeaderVO:EventBoardTableHeaderVO;
      
      private var _eventBoardTableRendererContainerVO:EventBoardTableRendererContainerVO;
      
      public function EventBoardsBattleOverlayMeta()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         if(this._eventBoardsBattleOverlayVO)
         {
            this._eventBoardsBattleOverlayVO.dispose();
            this._eventBoardsBattleOverlayVO = null;
         }
         if(this._battleExperienceBlockVO)
         {
            this._battleExperienceBlockVO.dispose();
            this._battleExperienceBlockVO = null;
         }
         if(this._battleStatisticsBlockVO)
         {
            this._battleStatisticsBlockVO.dispose();
            this._battleStatisticsBlockVO = null;
         }
         if(this._eventBoardTableHeaderVO)
         {
            this._eventBoardTableHeaderVO.dispose();
            this._eventBoardTableHeaderVO = null;
         }
         if(this._eventBoardTableRendererContainerVO)
         {
            this._eventBoardTableRendererContainerVO.dispose();
            this._eventBoardTableRendererContainerVO = null;
         }
         super.onDispose();
      }
      
      public final function as_setData(param1:Object) : void
      {
         var _loc2_:EventBoardsBattleOverlayVO = this._eventBoardsBattleOverlayVO;
         this._eventBoardsBattleOverlayVO = new EventBoardsBattleOverlayVO(param1);
         this.setData(this._eventBoardsBattleOverlayVO);
         if(_loc2_)
         {
            _loc2_.dispose();
         }
      }
      
      public final function as_setExperienceData(param1:Object) : void
      {
         var _loc2_:BattleExperienceBlockVO = this._battleExperienceBlockVO;
         this._battleExperienceBlockVO = new BattleExperienceBlockVO(param1);
         this.setExperienceData(this._battleExperienceBlockVO);
         if(_loc2_)
         {
            _loc2_.dispose();
         }
      }
      
      public final function as_setStatisticsData(param1:Object) : void
      {
         var _loc2_:BattleStatisticsBlockVO = this._battleStatisticsBlockVO;
         this._battleStatisticsBlockVO = new BattleStatisticsBlockVO(param1);
         this.setStatisticsData(this._battleStatisticsBlockVO);
         if(_loc2_)
         {
            _loc2_.dispose();
         }
      }
      
      public final function as_setTableHeaderData(param1:Object) : void
      {
         var _loc2_:EventBoardTableHeaderVO = this._eventBoardTableHeaderVO;
         this._eventBoardTableHeaderVO = new EventBoardTableHeaderVO(param1);
         this.setTableHeaderData(this._eventBoardTableHeaderVO);
         if(_loc2_)
         {
            _loc2_.dispose();
         }
      }
      
      public final function as_setTableData(param1:Object) : void
      {
         var _loc2_:EventBoardTableRendererContainerVO = this._eventBoardTableRendererContainerVO;
         this._eventBoardTableRendererContainerVO = new EventBoardTableRendererContainerVO(param1);
         this.setTableData(this._eventBoardTableRendererContainerVO);
         if(_loc2_)
         {
            _loc2_.dispose();
         }
      }
      
      protected function setData(param1:EventBoardsBattleOverlayVO) : void
      {
         var _loc2_:String = "as_setData" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
      
      protected function setExperienceData(param1:BattleExperienceBlockVO) : void
      {
         var _loc2_:String = "as_setExperienceData" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
      
      protected function setStatisticsData(param1:BattleStatisticsBlockVO) : void
      {
         var _loc2_:String = "as_setStatisticsData" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
      
      protected function setTableHeaderData(param1:EventBoardTableHeaderVO) : void
      {
         var _loc2_:String = "as_setTableHeaderData" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
      
      protected function setTableData(param1:EventBoardTableRendererContainerVO) : void
      {
         var _loc2_:String = "as_setTableData" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
   }
}
