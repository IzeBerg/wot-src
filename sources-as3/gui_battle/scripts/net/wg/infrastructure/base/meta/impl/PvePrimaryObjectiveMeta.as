package net.wg.infrastructure.base.meta.impl
{
   import net.wg.data.constants.Errors;
   import net.wg.gui.battle.components.BattleDisplayable;
   import net.wg.gui.battle.pveBase.views.primaryObjective.data.PvePrimaryObjectiveVO;
   import net.wg.infrastructure.exceptions.AbstractException;
   
   public class PvePrimaryObjectiveMeta extends BattleDisplayable
   {
       
      
      private var _pvePrimaryObjectiveVO:PvePrimaryObjectiveVO;
      
      public function PvePrimaryObjectiveMeta()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         if(this._pvePrimaryObjectiveVO)
         {
            this._pvePrimaryObjectiveVO.dispose();
            this._pvePrimaryObjectiveVO = null;
         }
         super.onDispose();
      }
      
      public final function as_setData(param1:Object) : void
      {
         var _loc2_:PvePrimaryObjectiveVO = this._pvePrimaryObjectiveVO;
         this._pvePrimaryObjectiveVO = new PvePrimaryObjectiveVO(param1);
         this.setData(this._pvePrimaryObjectiveVO);
         if(_loc2_)
         {
            _loc2_.dispose();
         }
      }
      
      protected function setData(param1:PvePrimaryObjectiveVO) : void
      {
         var _loc2_:String = "as_setData" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
   }
}
