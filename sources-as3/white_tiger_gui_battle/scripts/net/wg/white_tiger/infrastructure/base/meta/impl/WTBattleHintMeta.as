package net.wg.white_tiger.infrastructure.base.meta.impl
{
   import net.wg.data.constants.Errors;
   import net.wg.gui.battle.components.BattleDisplayable;
   import net.wg.infrastructure.exceptions.AbstractException;
   import net.wg.white_tiger.gui.battle.views.wtBattleHints.data.HintInfoVO;
   
   public class WTBattleHintMeta extends BattleDisplayable
   {
       
      
      private var _hintInfoVO:HintInfoVO;
      
      public function WTBattleHintMeta()
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
      
      public final function as_showHint(param1:Object) : void
      {
         var _loc2_:HintInfoVO = this._hintInfoVO;
         this._hintInfoVO = new HintInfoVO(param1);
         this.showHint(this._hintInfoVO);
         if(_loc2_)
         {
            _loc2_.dispose();
         }
      }
      
      protected function showHint(param1:HintInfoVO) : void
      {
         var _loc2_:String = "as_showHint" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
   }
}
