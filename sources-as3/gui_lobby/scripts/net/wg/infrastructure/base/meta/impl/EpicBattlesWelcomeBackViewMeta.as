package net.wg.infrastructure.base.meta.impl
{
   import net.wg.data.constants.Errors;
   import net.wg.gui.lobby.epicBattles.data.EpicBattlesWelcomeBackViewVO;
   import net.wg.infrastructure.base.AbstractScreen;
   import net.wg.infrastructure.exceptions.AbstractException;
   
   public class EpicBattlesWelcomeBackViewMeta extends AbstractScreen
   {
       
      
      public var onBackBtnClicked:Function;
      
      public var onCloseBtnClicked:Function;
      
      public var onContinueBtnClicked:Function;
      
      public var onChangesLinkClicked:Function;
      
      public var playVideo:Function;
      
      private var _epicBattlesWelcomeBackViewVO:EpicBattlesWelcomeBackViewVO;
      
      public function EpicBattlesWelcomeBackViewMeta()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         if(this._epicBattlesWelcomeBackViewVO)
         {
            this._epicBattlesWelcomeBackViewVO.dispose();
            this._epicBattlesWelcomeBackViewVO = null;
         }
         super.onDispose();
      }
      
      public function onBackBtnClickedS() : void
      {
         App.utils.asserter.assertNotNull(this.onBackBtnClicked,"onBackBtnClicked" + Errors.CANT_NULL);
         this.onBackBtnClicked();
      }
      
      public function onCloseBtnClickedS() : void
      {
         App.utils.asserter.assertNotNull(this.onCloseBtnClicked,"onCloseBtnClicked" + Errors.CANT_NULL);
         this.onCloseBtnClicked();
      }
      
      public function onContinueBtnClickedS() : void
      {
         App.utils.asserter.assertNotNull(this.onContinueBtnClicked,"onContinueBtnClicked" + Errors.CANT_NULL);
         this.onContinueBtnClicked();
      }
      
      public function onChangesLinkClickedS() : void
      {
         App.utils.asserter.assertNotNull(this.onChangesLinkClicked,"onChangesLinkClicked" + Errors.CANT_NULL);
         this.onChangesLinkClicked();
      }
      
      public function playVideoS() : void
      {
         App.utils.asserter.assertNotNull(this.playVideo,"playVideo" + Errors.CANT_NULL);
         this.playVideo();
      }
      
      public final function as_setInitData(param1:Object) : void
      {
         var _loc2_:EpicBattlesWelcomeBackViewVO = this._epicBattlesWelcomeBackViewVO;
         this._epicBattlesWelcomeBackViewVO = new EpicBattlesWelcomeBackViewVO(param1);
         this.setInitData(this._epicBattlesWelcomeBackViewVO);
         if(_loc2_)
         {
            _loc2_.dispose();
         }
      }
      
      protected function setInitData(param1:EpicBattlesWelcomeBackViewVO) : void
      {
         var _loc2_:String = "as_setInitData" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
   }
}
