package net.wg.infrastructure.base.meta.impl
{
   import net.wg.data.constants.Errors;
   import net.wg.gui.battle.battleloading.BaseBattleLoading;
   import net.wg.gui.battle.views.HWBattleLoading.data.LoadingDataVO;
   import net.wg.infrastructure.exceptions.AbstractException;
   
   public class HWBattleLoadingMeta extends BaseBattleLoading
   {
       
      
      private var _loadingDataVO:LoadingDataVO;
      
      public function HWBattleLoadingMeta()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         if(this._loadingDataVO)
         {
            this._loadingDataVO.dispose();
            this._loadingDataVO = null;
         }
         super.onDispose();
      }
      
      public final function as_setData(param1:Object) : void
      {
         var _loc2_:LoadingDataVO = this._loadingDataVO;
         this._loadingDataVO = new LoadingDataVO(param1);
         this.setData(this._loadingDataVO);
         if(_loc2_)
         {
            _loc2_.dispose();
         }
      }
      
      protected function setData(param1:LoadingDataVO) : void
      {
         var _loc2_:String = "as_setData" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
   }
}
