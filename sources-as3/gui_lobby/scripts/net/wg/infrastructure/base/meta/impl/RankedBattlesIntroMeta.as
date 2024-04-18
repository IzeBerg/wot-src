package net.wg.infrastructure.base.meta.impl
{
   import net.wg.data.constants.Errors;
   import net.wg.gui.lobby.hangar.data.AlertMessageBlockVO;
   import net.wg.gui.lobby.rankedBattles19.data.RankedBattlesIntroVO;
   import net.wg.gui.lobby.rankedBattles19.data.RankedIntroBeforeSeasonBlockVO;
   import net.wg.infrastructure.base.AbstractScreen;
   import net.wg.infrastructure.exceptions.AbstractException;
   
   public class RankedBattlesIntroMeta extends AbstractScreen
   {
       
      
      public var onClose:Function;
      
      public var onAcceptClick:Function;
      
      public var onDetailedClick:Function;
      
      public var onPlayVideoClick:Function;
      
      private var _rankedBattlesIntroVO:RankedBattlesIntroVO;
      
      private var _alertMessageBlockVO:AlertMessageBlockVO;
      
      private var _rankedIntroBeforeSeasonBlockVO:RankedIntroBeforeSeasonBlockVO;
      
      public function RankedBattlesIntroMeta()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         if(this._rankedBattlesIntroVO)
         {
            this._rankedBattlesIntroVO.dispose();
            this._rankedBattlesIntroVO = null;
         }
         if(this._alertMessageBlockVO)
         {
            this._alertMessageBlockVO.dispose();
            this._alertMessageBlockVO = null;
         }
         if(this._rankedIntroBeforeSeasonBlockVO)
         {
            this._rankedIntroBeforeSeasonBlockVO.dispose();
            this._rankedIntroBeforeSeasonBlockVO = null;
         }
         super.onDispose();
      }
      
      public function onCloseS() : void
      {
         App.utils.asserter.assertNotNull(this.onClose,"onClose" + Errors.CANT_NULL);
         this.onClose();
      }
      
      public function onAcceptClickS() : void
      {
         App.utils.asserter.assertNotNull(this.onAcceptClick,"onAcceptClick" + Errors.CANT_NULL);
         this.onAcceptClick();
      }
      
      public function onDetailedClickS() : void
      {
         App.utils.asserter.assertNotNull(this.onDetailedClick,"onDetailedClick" + Errors.CANT_NULL);
         this.onDetailedClick();
      }
      
      public function onPlayVideoClickS() : void
      {
         App.utils.asserter.assertNotNull(this.onPlayVideoClick,"onPlayVideoClick" + Errors.CANT_NULL);
         this.onPlayVideoClick();
      }
      
      public final function as_setData(param1:Object) : void
      {
         var _loc2_:RankedBattlesIntroVO = this._rankedBattlesIntroVO;
         this._rankedBattlesIntroVO = new RankedBattlesIntroVO(param1);
         this.setData(this._rankedBattlesIntroVO);
         if(_loc2_)
         {
            _loc2_.dispose();
         }
      }
      
      public final function as_setAlertMessageBlockData(param1:Object) : void
      {
         var _loc2_:AlertMessageBlockVO = this._alertMessageBlockVO;
         this._alertMessageBlockVO = new AlertMessageBlockVO(param1);
         this.setAlertMessageBlockData(this._alertMessageBlockVO);
         if(_loc2_)
         {
            _loc2_.dispose();
         }
      }
      
      public final function as_setBeforeSeasonBlockData(param1:Object) : void
      {
         var _loc2_:RankedIntroBeforeSeasonBlockVO = this._rankedIntroBeforeSeasonBlockVO;
         this._rankedIntroBeforeSeasonBlockVO = new RankedIntroBeforeSeasonBlockVO(param1);
         this.setBeforeSeasonBlockData(this._rankedIntroBeforeSeasonBlockVO);
         if(_loc2_)
         {
            _loc2_.dispose();
         }
      }
      
      protected function setData(param1:RankedBattlesIntroVO) : void
      {
         var _loc2_:String = "as_setData" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
      
      protected function setAlertMessageBlockData(param1:AlertMessageBlockVO) : void
      {
         var _loc2_:String = "as_setAlertMessageBlockData" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
      
      protected function setBeforeSeasonBlockData(param1:RankedIntroBeforeSeasonBlockVO) : void
      {
         var _loc2_:String = "as_setBeforeSeasonBlockData" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
   }
}
