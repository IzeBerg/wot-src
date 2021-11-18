package net.wg.infrastructure.base.meta.impl
{
   import net.wg.data.constants.Errors;
   import net.wg.gui.lobby.epicBattles.data.EpicBattlesAfterBattleViewVO;
   import net.wg.infrastructure.base.AbstractView;
   import net.wg.infrastructure.exceptions.AbstractException;
   
   public class EpicBattlesAfterBattleViewMeta extends AbstractView
   {
       
      
      public var onIntroStartsPlaying:Function;
      
      public var onRibbonStartsPlaying:Function;
      
      public var onCloseBtnClick:Function;
      
      public var onEscapePress:Function;
      
      public var onProgressBarStartAnim:Function;
      
      public var onProgressBarCompleteAnim:Function;
      
      private var _epicBattlesAfterBattleViewVO:EpicBattlesAfterBattleViewVO;
      
      public function EpicBattlesAfterBattleViewMeta()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         if(this._epicBattlesAfterBattleViewVO)
         {
            this._epicBattlesAfterBattleViewVO.dispose();
            this._epicBattlesAfterBattleViewVO = null;
         }
         super.onDispose();
      }
      
      public function onIntroStartsPlayingS() : void
      {
         App.utils.asserter.assertNotNull(this.onIntroStartsPlaying,"onIntroStartsPlaying" + Errors.CANT_NULL);
         this.onIntroStartsPlaying();
      }
      
      public function onRibbonStartsPlayingS() : void
      {
         App.utils.asserter.assertNotNull(this.onRibbonStartsPlaying,"onRibbonStartsPlaying" + Errors.CANT_NULL);
         this.onRibbonStartsPlaying();
      }
      
      public function onCloseBtnClickS() : void
      {
         App.utils.asserter.assertNotNull(this.onCloseBtnClick,"onCloseBtnClick" + Errors.CANT_NULL);
         this.onCloseBtnClick();
      }
      
      public function onEscapePressS() : void
      {
         App.utils.asserter.assertNotNull(this.onEscapePress,"onEscapePress" + Errors.CANT_NULL);
         this.onEscapePress();
      }
      
      public function onProgressBarStartAnimS() : void
      {
         App.utils.asserter.assertNotNull(this.onProgressBarStartAnim,"onProgressBarStartAnim" + Errors.CANT_NULL);
         this.onProgressBarStartAnim();
      }
      
      public function onProgressBarCompleteAnimS() : void
      {
         App.utils.asserter.assertNotNull(this.onProgressBarCompleteAnim,"onProgressBarCompleteAnim" + Errors.CANT_NULL);
         this.onProgressBarCompleteAnim();
      }
      
      public final function as_setData(param1:Object) : void
      {
         var _loc2_:EpicBattlesAfterBattleViewVO = this._epicBattlesAfterBattleViewVO;
         this._epicBattlesAfterBattleViewVO = new EpicBattlesAfterBattleViewVO(param1);
         this.setData(this._epicBattlesAfterBattleViewVO);
         if(_loc2_)
         {
            _loc2_.dispose();
         }
      }
      
      protected function setData(param1:EpicBattlesAfterBattleViewVO) : void
      {
         var _loc2_:String = "as_setData" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
   }
}
