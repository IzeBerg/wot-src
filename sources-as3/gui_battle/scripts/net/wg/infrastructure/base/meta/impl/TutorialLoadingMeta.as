package net.wg.infrastructure.base.meta.impl
{
   import net.wg.data.VO.daapi.DAAPIArenaInfoVO;
   import net.wg.data.constants.Errors;
   import net.wg.gui.battle.battleloading.BaseBattleLoading;
   import net.wg.infrastructure.exceptions.AbstractException;
   
   public class TutorialLoadingMeta extends BaseBattleLoading
   {
       
      
      private var _dAAPIArenaInfoVO:DAAPIArenaInfoVO;
      
      public function TutorialLoadingMeta()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         if(this._dAAPIArenaInfoVO)
         {
            this._dAAPIArenaInfoVO.dispose();
            this._dAAPIArenaInfoVO = null;
         }
         super.onDispose();
      }
      
      public final function as_setTutorialArenaInfo(param1:Object) : void
      {
         var _loc2_:DAAPIArenaInfoVO = this._dAAPIArenaInfoVO;
         this._dAAPIArenaInfoVO = new DAAPIArenaInfoVO(param1);
         this.setTutorialArenaInfo(this._dAAPIArenaInfoVO);
         if(_loc2_)
         {
            _loc2_.dispose();
         }
      }
      
      protected function setTutorialArenaInfo(param1:DAAPIArenaInfoVO) : void
      {
         var _loc2_:String = "as_setTutorialArenaInfo" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
   }
}
