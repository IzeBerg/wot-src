package net.wg.infrastructure.base.meta.impl
{
   import net.wg.data.constants.Errors;
   import net.wg.gui.lobby.sessionStats.data.SessionStatsPopoverVO;
   import net.wg.infrastructure.base.SmartPopOverView;
   import net.wg.infrastructure.exceptions.AbstractException;
   
   public class SessionStatsPopoverMeta extends SmartPopOverView
   {
       
      
      private var _sessionStatsPopoverVO:SessionStatsPopoverVO;
      
      public function SessionStatsPopoverMeta()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         if(this._sessionStatsPopoverVO)
         {
            this._sessionStatsPopoverVO.dispose();
            this._sessionStatsPopoverVO = null;
         }
         super.onDispose();
      }
      
      public final function as_setData(param1:Object) : void
      {
         var _loc2_:SessionStatsPopoverVO = this._sessionStatsPopoverVO;
         this._sessionStatsPopoverVO = new SessionStatsPopoverVO(param1);
         this.setData(this._sessionStatsPopoverVO);
         if(_loc2_)
         {
            _loc2_.dispose();
         }
      }
      
      protected function setData(param1:SessionStatsPopoverVO) : void
      {
         var _loc2_:String = "as_setData" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
   }
}
