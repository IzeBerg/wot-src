package net.wg.infrastructure.base.meta.impl
{
   import net.wg.data.constants.Errors;
   import net.wg.gui.lobby.epicBattles.data.EpicBattlesPrestigeViewVO;
   import net.wg.infrastructure.base.AbstractView;
   import net.wg.infrastructure.exceptions.AbstractException;
   
   public class EpicBattlesPrestigeViewMeta extends AbstractView
   {
       
      
      public var onCloseBtnClick:Function;
      
      public var onEscapePress:Function;
      
      public var onResetBtnClick:Function;
      
      public var onBackBtnClick:Function;
      
      private var _epicBattlesPrestigeViewVO:EpicBattlesPrestigeViewVO;
      
      public function EpicBattlesPrestigeViewMeta()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         if(this._epicBattlesPrestigeViewVO)
         {
            this._epicBattlesPrestigeViewVO.dispose();
            this._epicBattlesPrestigeViewVO = null;
         }
         super.onDispose();
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
      
      public function onResetBtnClickS() : void
      {
         App.utils.asserter.assertNotNull(this.onResetBtnClick,"onResetBtnClick" + Errors.CANT_NULL);
         this.onResetBtnClick();
      }
      
      public function onBackBtnClickS() : void
      {
         App.utils.asserter.assertNotNull(this.onBackBtnClick,"onBackBtnClick" + Errors.CANT_NULL);
         this.onBackBtnClick();
      }
      
      public final function as_setData(param1:Object) : void
      {
         var _loc2_:EpicBattlesPrestigeViewVO = this._epicBattlesPrestigeViewVO;
         this._epicBattlesPrestigeViewVO = new EpicBattlesPrestigeViewVO(param1);
         this.setData(this._epicBattlesPrestigeViewVO);
         if(_loc2_)
         {
            _loc2_.dispose();
         }
      }
      
      protected function setData(param1:EpicBattlesPrestigeViewVO) : void
      {
         var _loc2_:String = "as_setData" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
   }
}
