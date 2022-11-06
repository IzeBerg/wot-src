package net.wg.infrastructure.base.meta.impl
{
   import net.wg.data.constants.Errors;
   import net.wg.gui.lobby.eventBoards.data.EventBoardTableFilterVO;
   import net.wg.infrastructure.base.SmartPopOverView;
   import net.wg.infrastructure.exceptions.AbstractException;
   
   public class EventBoardsResultFilterPopoverViewMeta extends SmartPopOverView
   {
       
      
      public var changeFilter:Function;
      
      private var _eventBoardTableFilterVO:EventBoardTableFilterVO;
      
      public function EventBoardsResultFilterPopoverViewMeta()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         if(this._eventBoardTableFilterVO)
         {
            this._eventBoardTableFilterVO.dispose();
            this._eventBoardTableFilterVO = null;
         }
         super.onDispose();
      }
      
      public function changeFilterS(param1:int) : void
      {
         App.utils.asserter.assertNotNull(this.changeFilter,"changeFilter" + Errors.CANT_NULL);
         this.changeFilter(param1);
      }
      
      public final function as_setInitData(param1:Object) : void
      {
         var _loc2_:EventBoardTableFilterVO = this._eventBoardTableFilterVO;
         this._eventBoardTableFilterVO = new EventBoardTableFilterVO(param1);
         this.setInitData(this._eventBoardTableFilterVO);
         if(_loc2_)
         {
            _loc2_.dispose();
         }
      }
      
      protected function setInitData(param1:EventBoardTableFilterVO) : void
      {
         var _loc2_:String = "as_setInitData" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
   }
}
