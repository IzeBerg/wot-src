package net.wg.infrastructure.base.meta.impl
{
   import net.wg.data.constants.Errors;
   import net.wg.gui.battle.eventBattle.views.loading.data.EventLoadingVO;
   import net.wg.infrastructure.base.AbstractView;
   import net.wg.infrastructure.exceptions.AbstractException;
   
   public class EventLoadingMeta extends AbstractView
   {
       
      
      private var _eventLoadingVO:EventLoadingVO;
      
      public function EventLoadingMeta()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         if(this._eventLoadingVO)
         {
            this._eventLoadingVO.dispose();
            this._eventLoadingVO = null;
         }
         super.onDispose();
      }
      
      public final function as_setData(param1:Object) : void
      {
         var _loc2_:EventLoadingVO = this._eventLoadingVO;
         this._eventLoadingVO = new EventLoadingVO(param1);
         this.setData(this._eventLoadingVO);
         if(_loc2_)
         {
            _loc2_.dispose();
         }
      }
      
      protected function setData(param1:EventLoadingVO) : void
      {
         var _loc2_:String = "as_setData" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
   }
}
