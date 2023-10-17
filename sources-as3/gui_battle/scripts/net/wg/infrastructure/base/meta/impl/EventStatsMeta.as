package net.wg.infrastructure.base.meta.impl
{
   import net.wg.data.constants.Errors;
   import net.wg.gui.battle.components.BattleDisplayable;
   import net.wg.gui.battle.eventBattle.views.eventStats.VO.EventStatsPlayerVO;
   import net.wg.infrastructure.exceptions.AbstractException;
   
   public class EventStatsMeta extends BattleDisplayable
   {
       
      
      private var _vectorEventStatsPlayerVO:Vector.<EventStatsPlayerVO>;
      
      public function EventStatsMeta()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         var _loc1_:EventStatsPlayerVO = null;
         if(this._vectorEventStatsPlayerVO)
         {
            for each(_loc1_ in this._vectorEventStatsPlayerVO)
            {
               _loc1_.dispose();
            }
            this._vectorEventStatsPlayerVO.splice(0,this._vectorEventStatsPlayerVO.length);
            this._vectorEventStatsPlayerVO = null;
         }
         super.onDispose();
      }
      
      public final function as_updatePlayerStats(param1:Array) : void
      {
         var _loc5_:EventStatsPlayerVO = null;
         var _loc2_:Vector.<EventStatsPlayerVO> = this._vectorEventStatsPlayerVO;
         this._vectorEventStatsPlayerVO = new Vector.<EventStatsPlayerVO>(0);
         var _loc3_:uint = param1.length;
         var _loc4_:int = 0;
         while(_loc4_ < _loc3_)
         {
            this._vectorEventStatsPlayerVO[_loc4_] = new EventStatsPlayerVO(param1[_loc4_]);
            _loc4_++;
         }
         this.updatePlayerStats(this._vectorEventStatsPlayerVO);
         if(_loc2_)
         {
            for each(_loc5_ in _loc2_)
            {
               _loc5_.dispose();
            }
            _loc2_.splice(0,_loc2_.length);
         }
      }
      
      protected function updatePlayerStats(param1:Vector.<EventStatsPlayerVO>) : void
      {
         var _loc2_:String = "as_updatePlayerStats" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
   }
}
