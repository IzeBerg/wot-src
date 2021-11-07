package net.wg.infrastructure.base.meta.impl
{
   import net.wg.data.constants.Errors;
   import net.wg.gui.battle.components.BattleDisplayable;
   import net.wg.gui.battle.eventBattle.views.battleHints.data.HintInfoVO;
   import net.wg.infrastructure.exceptions.AbstractException;
   
   public class BattleHintMeta extends BattleDisplayable
   {
       
      
      private var _hintInfoVO:HintInfoVO;
      
      public function BattleHintMeta()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         if(this._hintInfoVO)
         {
            this._hintInfoVO.dispose();
            this._hintInfoVO = null;
         }
         super.onDispose();
      }
      
      public final function as_showHint(param1:String, param2:Object) : void
      {
         var _loc3_:HintInfoVO = this._hintInfoVO;
         this._hintInfoVO = new HintInfoVO(param2);
         this.showHint(param1,this._hintInfoVO);
         if(_loc3_)
         {
            _loc3_.dispose();
         }
      }
      
      protected function showHint(param1:String, param2:HintInfoVO) : void
      {
         var _loc3_:String = "as_showHint" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc3_);
         throw new AbstractException(_loc3_);
      }
   }
}
