package net.wg.infrastructure.base.meta.impl
{
   import net.wg.data.constants.Errors;
   import net.wg.gui.lobby.sessionStats.data.SessionBattleStatsViewVO;
   import net.wg.infrastructure.base.BaseDAAPIComponent;
   import net.wg.infrastructure.exceptions.AbstractException;
   
   public class SessionBattleStatsViewMeta extends BaseDAAPIComponent
   {
       
      
      private var _sessionBattleStatsViewVO:SessionBattleStatsViewVO;
      
      public function SessionBattleStatsViewMeta()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         if(this._sessionBattleStatsViewVO)
         {
            this._sessionBattleStatsViewVO.dispose();
            this._sessionBattleStatsViewVO = null;
         }
         super.onDispose();
      }
      
      public final function as_setData(param1:Object) : void
      {
         var _loc2_:SessionBattleStatsViewVO = this._sessionBattleStatsViewVO;
         this._sessionBattleStatsViewVO = new SessionBattleStatsViewVO(param1);
         this.setData(this._sessionBattleStatsViewVO);
         if(_loc2_)
         {
            _loc2_.dispose();
         }
      }
      
      protected function setData(param1:SessionBattleStatsViewVO) : void
      {
         var _loc2_:String = "as_setData" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
   }
}
