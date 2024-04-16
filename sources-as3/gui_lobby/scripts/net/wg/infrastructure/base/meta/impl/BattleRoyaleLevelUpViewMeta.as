package net.wg.infrastructure.base.meta.impl
{
   import net.wg.data.constants.Errors;
   import net.wg.gui.lobby.battleRoyale.levelUpView.data.BattleRoyaleLevelUpViewVO;
   import net.wg.infrastructure.base.AbstractView;
   import net.wg.infrastructure.exceptions.AbstractException;
   
   public class BattleRoyaleLevelUpViewMeta extends AbstractView
   {
       
      
      public var onIntroStartsPlaying:Function;
      
      public var onRibbonStartsPlaying:Function;
      
      public var onCloseBtnClick:Function;
      
      public var onEscapePress:Function;
      
      private var _battleRoyaleLevelUpViewVO:BattleRoyaleLevelUpViewVO;
      
      public function BattleRoyaleLevelUpViewMeta()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         if(this._battleRoyaleLevelUpViewVO)
         {
            this._battleRoyaleLevelUpViewVO.dispose();
            this._battleRoyaleLevelUpViewVO = null;
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
      
      public final function as_setData(param1:Object) : void
      {
         var _loc2_:BattleRoyaleLevelUpViewVO = this._battleRoyaleLevelUpViewVO;
         this._battleRoyaleLevelUpViewVO = new BattleRoyaleLevelUpViewVO(param1);
         this.setData(this._battleRoyaleLevelUpViewVO);
         if(_loc2_)
         {
            _loc2_.dispose();
         }
      }
      
      protected function setData(param1:BattleRoyaleLevelUpViewVO) : void
      {
         var _loc2_:String = "as_setData" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
   }
}
