package net.wg.infrastructure.base.meta.impl
{
   import net.wg.data.constants.Errors;
   import net.wg.gui.battle.components.BattleDisplayable;
   import net.wg.gui.battle.mapsTraining.views.goals.data.MapsTrainingGoalVO;
   import net.wg.infrastructure.exceptions.AbstractException;
   
   public class MapsTrainingGoalsMeta extends BattleDisplayable
   {
       
      
      private var _vectorMapsTrainingGoalVO:Vector.<MapsTrainingGoalVO>;
      
      public function MapsTrainingGoalsMeta()
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
      
      public final function as_update(param1:Array) : void
      {
         var _loc5_:MapsTrainingGoalVO = null;
         var _loc2_:Vector.<MapsTrainingGoalVO> = this._vectorMapsTrainingGoalVO;
         this._vectorMapsTrainingGoalVO = new Vector.<MapsTrainingGoalVO>(0);
         var _loc3_:uint = param1.length;
         var _loc4_:int = 0;
         while(_loc4_ < _loc3_)
         {
            this._vectorMapsTrainingGoalVO[_loc4_] = new MapsTrainingGoalVO(param1[_loc4_]);
            _loc4_++;
         }
         this.update(this._vectorMapsTrainingGoalVO);
         if(_loc2_)
         {
            for each(_loc5_ in _loc2_)
            {
               _loc5_.dispose();
            }
            _loc2_.splice(0,_loc2_.length);
         }
      }
      
      protected function update(param1:Vector.<MapsTrainingGoalVO>) : void
      {
         var _loc2_:String = "as_update" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
   }
}
