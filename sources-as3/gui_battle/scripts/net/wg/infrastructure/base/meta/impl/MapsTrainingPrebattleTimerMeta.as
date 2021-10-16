package net.wg.infrastructure.base.meta.impl
{
   import net.wg.data.constants.Errors;
   import net.wg.gui.battle.mapsTraining.views.goals.data.MapsTrainingGoalVO;
   import net.wg.gui.battle.views.prebattleTimer.PrebattleTimer;
   import net.wg.infrastructure.exceptions.AbstractException;
   
   public class MapsTrainingPrebattleTimerMeta extends PrebattleTimer
   {
       
      
      private var _vectorMapsTrainingGoalVO:Vector.<MapsTrainingGoalVO>;
      
      public function MapsTrainingPrebattleTimerMeta()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         var _loc1_:MapsTrainingGoalVO = null;
         if(this._vectorMapsTrainingGoalVO)
         {
            for each(_loc1_ in this._vectorMapsTrainingGoalVO)
            {
               _loc1_.dispose();
            }
            this._vectorMapsTrainingGoalVO.splice(0,this._vectorMapsTrainingGoalVO.length);
            this._vectorMapsTrainingGoalVO = null;
         }
         super.onDispose();
      }
      
      public final function as_update(param1:Array, param2:String) : void
      {
         var _loc6_:MapsTrainingGoalVO = null;
         var _loc3_:Vector.<MapsTrainingGoalVO> = this._vectorMapsTrainingGoalVO;
         this._vectorMapsTrainingGoalVO = new Vector.<MapsTrainingGoalVO>(0);
         var _loc4_:uint = param1.length;
         var _loc5_:int = 0;
         while(_loc5_ < _loc4_)
         {
            this._vectorMapsTrainingGoalVO[_loc5_] = new MapsTrainingGoalVO(param1[_loc5_]);
            _loc5_++;
         }
         this.update(this._vectorMapsTrainingGoalVO,param2);
         if(_loc3_)
         {
            for each(_loc6_ in _loc3_)
            {
               _loc6_.dispose();
            }
            _loc3_.splice(0,_loc3_.length);
         }
      }
      
      protected function update(param1:Vector.<MapsTrainingGoalVO>, param2:String) : void
      {
         var _loc3_:String = "as_update" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc3_);
         throw new AbstractException(_loc3_);
      }
   }
}
