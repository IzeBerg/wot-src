package net.wg.infrastructure.base.meta.impl
{
   import net.wg.data.constants.Errors;
   import net.wg.gui.battle.battleRoyale.data.BattleRoyaleFullStatsVO;
   import net.wg.gui.battle.battleRoyale.views.components.fullStats.nationsVehiclesCounter.data.BattleRoyaleNationsVehiclesCounterVO;
   import net.wg.gui.battle.components.BattleDisplayable;
   import net.wg.infrastructure.exceptions.AbstractException;
   
   public class BattleRoyaleFullStatsMeta extends BattleDisplayable
   {
       
      
      private var _battleRoyaleFullStatsVO:BattleRoyaleFullStatsVO;
      
      private var _battleRoyaleNationsVehiclesCounterVO:BattleRoyaleNationsVehiclesCounterVO;
      
      public function BattleRoyaleFullStatsMeta()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         if(this._battleRoyaleFullStatsVO)
         {
            this._battleRoyaleFullStatsVO.dispose();
            this._battleRoyaleFullStatsVO = null;
         }
         if(this._battleRoyaleNationsVehiclesCounterVO)
         {
            this._battleRoyaleNationsVehiclesCounterVO.dispose();
            this._battleRoyaleNationsVehiclesCounterVO = null;
         }
         super.onDispose();
      }
      
      public final function as_setData(param1:Object) : void
      {
         var _loc2_:BattleRoyaleFullStatsVO = this._battleRoyaleFullStatsVO;
         this._battleRoyaleFullStatsVO = new BattleRoyaleFullStatsVO(param1);
         this.setData(this._battleRoyaleFullStatsVO);
         if(_loc2_)
         {
            _loc2_.dispose();
         }
      }
      
      public final function as_updateNationsVehiclesCounter(param1:Object) : void
      {
         var _loc2_:BattleRoyaleNationsVehiclesCounterVO = this._battleRoyaleNationsVehiclesCounterVO;
         this._battleRoyaleNationsVehiclesCounterVO = new BattleRoyaleNationsVehiclesCounterVO(param1);
         this.updateNationsVehiclesCounter(this._battleRoyaleNationsVehiclesCounterVO);
         if(_loc2_)
         {
            _loc2_.dispose();
         }
      }
      
      protected function setData(param1:BattleRoyaleFullStatsVO) : void
      {
         var _loc2_:String = "as_setData" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
      
      protected function updateNationsVehiclesCounter(param1:BattleRoyaleNationsVehiclesCounterVO) : void
      {
         var _loc2_:String = "as_updateNationsVehiclesCounter" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
   }
}
