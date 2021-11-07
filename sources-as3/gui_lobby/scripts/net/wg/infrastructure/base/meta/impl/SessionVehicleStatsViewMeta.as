package net.wg.infrastructure.base.meta.impl
{
   import net.wg.data.constants.Errors;
   import net.wg.gui.lobby.sessionStats.data.SessionVehicleStatsViewVO;
   import net.wg.infrastructure.base.BaseDAAPIComponent;
   import net.wg.infrastructure.exceptions.AbstractException;
   
   public class SessionVehicleStatsViewMeta extends BaseDAAPIComponent
   {
       
      
      private var _sessionVehicleStatsViewVO:SessionVehicleStatsViewVO;
      
      public function SessionVehicleStatsViewMeta()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         if(this._sessionVehicleStatsViewVO)
         {
            this._sessionVehicleStatsViewVO.dispose();
            this._sessionVehicleStatsViewVO = null;
         }
         super.onDispose();
      }
      
      public final function as_setData(param1:Object) : void
      {
         var _loc2_:SessionVehicleStatsViewVO = this._sessionVehicleStatsViewVO;
         this._sessionVehicleStatsViewVO = new SessionVehicleStatsViewVO(param1);
         this.setData(this._sessionVehicleStatsViewVO);
         if(_loc2_)
         {
            _loc2_.dispose();
         }
      }
      
      protected function setData(param1:SessionVehicleStatsViewVO) : void
      {
         var _loc2_:String = "as_setData" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
   }
}
