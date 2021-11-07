package net.wg.infrastructure.base.meta.impl
{
   import net.wg.data.constants.Errors;
   import net.wg.gui.battle.battleRoyale.data.BattleRoyaleEventHeaderVO;
   import net.wg.gui.battle.battleloading.BattleLoading;
   import net.wg.infrastructure.exceptions.AbstractException;
   
   public class BattleRoyaleLoadingMeta extends BattleLoading
   {
       
      
      private var _battleRoyaleEventHeaderVO:BattleRoyaleEventHeaderVO;
      
      public function BattleRoyaleLoadingMeta()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         if(this._battleRoyaleEventHeaderVO)
         {
            this._battleRoyaleEventHeaderVO.dispose();
            this._battleRoyaleEventHeaderVO = null;
         }
         super.onDispose();
      }
      
      public final function as_setHeaderData(param1:Object) : void
      {
         var _loc2_:BattleRoyaleEventHeaderVO = this._battleRoyaleEventHeaderVO;
         this._battleRoyaleEventHeaderVO = new BattleRoyaleEventHeaderVO(param1);
         this.setHeaderData(this._battleRoyaleEventHeaderVO);
         if(_loc2_)
         {
            _loc2_.dispose();
         }
      }
      
      protected function setHeaderData(param1:BattleRoyaleEventHeaderVO) : void
      {
         var _loc2_:String = "as_setHeaderData" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
   }
}
