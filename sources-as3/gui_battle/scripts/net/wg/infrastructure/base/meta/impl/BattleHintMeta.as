package net.wg.infrastructure.base.meta.impl
{
   import net.wg.data.constants.Errors;
   import net.wg.gui.battle.components.BattleDisplayable;
   import net.wg.gui.battle.views.battleHint.vo.BattleHintVO;
   import net.wg.infrastructure.exceptions.AbstractException;
   
   public class BattleHintMeta extends BattleDisplayable
   {
       
      
      public var onFadeOutFinished:Function;
      
      private var _battleHintVO:BattleHintVO;
      
      public function BattleHintMeta()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         if(this._battleHintVO)
         {
            this._battleHintVO.dispose();
            this._battleHintVO = null;
         }
         super.onDispose();
      }
      
      public function onFadeOutFinishedS() : void
      {
         App.utils.asserter.assertNotNull(this.onFadeOutFinished,"onFadeOutFinished" + Errors.CANT_NULL);
         this.onFadeOutFinished();
      }
      
      public final function as_showHint(param1:Object) : void
      {
         var _loc2_:BattleHintVO = this._battleHintVO;
         this._battleHintVO = new BattleHintVO(param1);
         this.showHint(this._battleHintVO);
         if(_loc2_)
         {
            _loc2_.dispose();
         }
      }
      
      protected function showHint(param1:BattleHintVO) : void
      {
         var _loc2_:String = "as_showHint" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
   }
}
