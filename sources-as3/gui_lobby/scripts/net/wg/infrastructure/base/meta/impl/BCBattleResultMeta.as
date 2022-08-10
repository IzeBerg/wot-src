package net.wg.infrastructure.base.meta.impl
{
   import net.wg.data.constants.Errors;
   import net.wg.gui.bootcamp.battleResult.data.BCBattleViewVO;
   import net.wg.infrastructure.base.AbstractView;
   import net.wg.infrastructure.exceptions.AbstractException;
   
   public class BCBattleResultMeta extends AbstractView
   {
       
      
      public var click:Function;
      
      public var onAnimationAwardStart:Function;
      
      public var onToolTipShow:Function;
      
      public var onVideoButtonClick:Function;
      
      private var _bCBattleViewVO:BCBattleViewVO;
      
      public function BCBattleResultMeta()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         if(this._bCBattleViewVO)
         {
            this._bCBattleViewVO.dispose();
            this._bCBattleViewVO = null;
         }
         super.onDispose();
      }
      
      public function clickS() : void
      {
         App.utils.asserter.assertNotNull(this.click,"click" + Errors.CANT_NULL);
         this.click();
      }
      
      public function onAnimationAwardStartS(param1:String) : void
      {
         App.utils.asserter.assertNotNull(this.onAnimationAwardStart,"onAnimationAwardStart" + Errors.CANT_NULL);
         this.onAnimationAwardStart(param1);
      }
      
      public function onToolTipShowS(param1:String) : void
      {
         App.utils.asserter.assertNotNull(this.onToolTipShow,"onToolTipShow" + Errors.CANT_NULL);
         this.onToolTipShow(param1);
      }
      
      public function onVideoButtonClickS(param1:int) : void
      {
         App.utils.asserter.assertNotNull(this.onVideoButtonClick,"onVideoButtonClick" + Errors.CANT_NULL);
         this.onVideoButtonClick(param1);
      }
      
      public final function as_setData(param1:Object) : void
      {
         var _loc2_:BCBattleViewVO = this._bCBattleViewVO;
         this._bCBattleViewVO = new BCBattleViewVO(param1);
         this.setData(this._bCBattleViewVO);
         if(_loc2_)
         {
            _loc2_.dispose();
         }
      }
      
      protected function setData(param1:BCBattleViewVO) : void
      {
         var _loc2_:String = "as_setData" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
   }
}
