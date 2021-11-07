package net.wg.infrastructure.base.meta.impl
{
   import net.wg.data.constants.Errors;
   import net.wg.gui.battle.components.BattleDisplayable;
   import net.wg.gui.battle.views.epicInGameRank.data.EpicInGameRankVO;
   import net.wg.infrastructure.exceptions.AbstractException;
   
   public class EpicInGameRankMeta extends BattleDisplayable
   {
       
      
      public var levelUpAnimationComplete:Function;
      
      private var _epicInGameRankVO:EpicInGameRankVO;
      
      public function EpicInGameRankMeta()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         if(this._epicInGameRankVO)
         {
            this._epicInGameRankVO.dispose();
            this._epicInGameRankVO = null;
         }
         super.onDispose();
      }
      
      public function levelUpAnimationCompleteS() : void
      {
         App.utils.asserter.assertNotNull(this.levelUpAnimationComplete,"levelUpAnimationComplete" + Errors.CANT_NULL);
         this.levelUpAnimationComplete();
      }
      
      public final function as_setRank(param1:Object) : void
      {
         var _loc2_:EpicInGameRankVO = this._epicInGameRankVO;
         this._epicInGameRankVO = new EpicInGameRankVO(param1);
         this.setRank(this._epicInGameRankVO);
         if(_loc2_)
         {
            _loc2_.dispose();
         }
      }
      
      protected function setRank(param1:EpicInGameRankVO) : void
      {
         var _loc2_:String = "as_setRank" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
   }
}
