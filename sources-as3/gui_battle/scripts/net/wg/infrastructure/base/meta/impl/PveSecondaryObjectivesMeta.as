package net.wg.infrastructure.base.meta.impl
{
   import net.wg.data.constants.Errors;
   import net.wg.gui.battle.components.BattleDisplayable;
   import net.wg.gui.battle.pveBase.views.secondaryObjectives.data.PveObjectVO;
   import net.wg.infrastructure.exceptions.AbstractException;
   
   public class PveSecondaryObjectivesMeta extends BattleDisplayable
   {
       
      
      private var _pveObjectVO:PveObjectVO;
      
      public function PveSecondaryObjectivesMeta()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         if(this._pveObjectVO)
         {
            this._pveObjectVO.dispose();
            this._pveObjectVO = null;
         }
         super.onDispose();
      }
      
      public final function as_addObject(param1:Object) : void
      {
         var _loc2_:PveObjectVO = this._pveObjectVO;
         this._pveObjectVO = new PveObjectVO(param1);
         this.addObject(this._pveObjectVO);
         if(_loc2_)
         {
            _loc2_.dispose();
         }
      }
      
      protected function addObject(param1:PveObjectVO) : void
      {
         var _loc2_:String = "as_addObject" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
   }
}
