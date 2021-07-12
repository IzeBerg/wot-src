package net.wg.infrastructure.base.meta.impl
{
   import net.wg.data.constants.Errors;
   import net.wg.gui.lobby.eventBoards.data.EventBoardTableHeaderVO;
   import net.wg.gui.lobby.eventBoards.data.EventBoardTableRendererContainerVO;
   import net.wg.gui.lobby.eventBoards.data.EventBoardsTableViewHeaderVO;
   import net.wg.gui.lobby.eventBoards.data.EventBoardsTableViewStatusVO;
   import net.wg.infrastructure.base.AbstractView;
   import net.wg.infrastructure.exceptions.AbstractException;
   
   public class EventBoardsTableViewMeta extends AbstractView
   {
       
      
      public var closeView:Function;
      
      public var setMyPlace:Function;
      
      public var participateStatusClick:Function;
      
      public var playerClick:Function;
      
      public var showNextAward:Function;
      
      private var _eventBoardsTableViewHeaderVO:EventBoardsTableViewHeaderVO;
      
      private var _eventBoardsTableViewStatusVO:EventBoardsTableViewStatusVO;
      
      private var _eventBoardTableRendererContainerVO:EventBoardTableRendererContainerVO;
      
      private var _eventBoardTableHeaderVO:EventBoardTableHeaderVO;
      
      private var _eventBoardTableRendererContainerVO1:EventBoardTableRendererContainerVO;
      
      public function EventBoardsTableViewMeta()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         if(this._eventBoardsTableViewHeaderVO)
         {
            this._eventBoardsTableViewHeaderVO.dispose();
            this._eventBoardsTableViewHeaderVO = null;
         }
         if(this._eventBoardsTableViewStatusVO)
         {
            this._eventBoardsTableViewStatusVO.dispose();
            this._eventBoardsTableViewStatusVO = null;
         }
         if(this._eventBoardTableRendererContainerVO)
         {
            this._eventBoardTableRendererContainerVO.dispose();
            this._eventBoardTableRendererContainerVO = null;
         }
         if(this._eventBoardTableHeaderVO)
         {
            this._eventBoardTableHeaderVO.dispose();
            this._eventBoardTableHeaderVO = null;
         }
         if(this._eventBoardTableRendererContainerVO1)
         {
            this._eventBoardTableRendererContainerVO1.dispose();
            this._eventBoardTableRendererContainerVO1 = null;
         }
         super.onDispose();
      }
      
      public function closeViewS() : void
      {
         App.utils.asserter.assertNotNull(this.closeView,"closeView" + Errors.CANT_NULL);
         this.closeView();
      }
      
      public function setMyPlaceS() : void
      {
         App.utils.asserter.assertNotNull(this.setMyPlace,"setMyPlace" + Errors.CANT_NULL);
         this.setMyPlace();
      }
      
      public function participateStatusClickS() : void
      {
         App.utils.asserter.assertNotNull(this.participateStatusClick,"participateStatusClick" + Errors.CANT_NULL);
         this.participateStatusClick();
      }
      
      public function playerClickS(param1:Number) : void
      {
         App.utils.asserter.assertNotNull(this.playerClick,"playerClick" + Errors.CANT_NULL);
         this.playerClick(param1);
      }
      
      public function showNextAwardS(param1:Boolean) : void
      {
         App.utils.asserter.assertNotNull(this.showNextAward,"showNextAward" + Errors.CANT_NULL);
         this.showNextAward(param1);
      }
      
      public final function as_setHeaderData(param1:Object) : void
      {
         var _loc2_:EventBoardsTableViewHeaderVO = this._eventBoardsTableViewHeaderVO;
         this._eventBoardsTableViewHeaderVO = new EventBoardsTableViewHeaderVO(param1);
         this.setHeaderData(this._eventBoardsTableViewHeaderVO);
         if(_loc2_)
         {
            _loc2_.dispose();
         }
      }
      
      public final function as_setStatusData(param1:Object) : void
      {
         var _loc2_:EventBoardsTableViewStatusVO = this._eventBoardsTableViewStatusVO;
         this._eventBoardsTableViewStatusVO = new EventBoardsTableViewStatusVO(param1);
         this.setStatusData(this._eventBoardsTableViewStatusVO);
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
      
      public final function as_setAwardsStripes(param1:Object) : void
      {
         var _loc2_:EventBoardTableRendererContainerVO = this._eventBoardTableRendererContainerVO1;
         this._eventBoardTableRendererContainerVO1 = new EventBoardTableRendererContainerVO(param1);
         this.setAwardsStripes(this._eventBoardTableRendererContainerVO1);
         if(_loc2_)
         {
            _loc2_.dispose();
         }
      }
      
      protected function setHeaderData(param1:EventBoardsTableViewHeaderVO) : void
      {
         var _loc2_:String = "as_setHeaderData" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
      
      protected function setStatusData(param1:EventBoardsTableViewStatusVO) : void
      {
         var _loc2_:String = "as_setStatusData" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
      
      protected function setTableData(param1:EventBoardTableRendererContainerVO) : void
      {
         var _loc2_:String = "as_setTableData" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
      
      protected function setTableHeaderData(param1:EventBoardTableHeaderVO) : void
      {
         var _loc2_:String = "as_setTableHeaderData" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
      
      protected function setAwardsStripes(param1:EventBoardTableRendererContainerVO) : void
      {
         var _loc2_:String = "as_setAwardsStripes" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
   }
}
