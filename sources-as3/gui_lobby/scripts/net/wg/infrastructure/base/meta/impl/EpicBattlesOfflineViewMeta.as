package net.wg.infrastructure.base.meta.impl
{
   import net.wg.data.constants.Errors;
   import net.wg.gui.lobby.epicBattles.data.EpicBattlesOfflineViewVO;
   import net.wg.infrastructure.base.AbstractView;
   import net.wg.infrastructure.exceptions.AbstractException;
   
   public class EpicBattlesOfflineViewMeta extends AbstractView
   {
       
      
      public var onCloseBtnClick:Function;
      
      public var onAboutButtonClick:Function;
      
      public var onEscapePress:Function;
      
      private var _epicBattlesOfflineViewVO:EpicBattlesOfflineViewVO;
      
      public function EpicBattlesOfflineViewMeta()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         if(this._epicBattlesOfflineViewVO)
         {
            this._epicBattlesOfflineViewVO.dispose();
            this._epicBattlesOfflineViewVO = null;
         }
         super.onDispose();
      }
      
      public function onCloseBtnClickS() : void
      {
         App.utils.asserter.assertNotNull(this.onCloseBtnClick,"onCloseBtnClick" + Errors.CANT_NULL);
         this.onCloseBtnClick();
      }
      
      public function onAboutButtonClickS() : void
      {
         App.utils.asserter.assertNotNull(this.onAboutButtonClick,"onAboutButtonClick" + Errors.CANT_NULL);
         this.onAboutButtonClick();
      }
      
      public function onEscapePressS() : void
      {
         App.utils.asserter.assertNotNull(this.onEscapePress,"onEscapePress" + Errors.CANT_NULL);
         this.onEscapePress();
      }
      
      public final function as_setData(param1:Object) : void
      {
         var _loc2_:EpicBattlesOfflineViewVO = this._epicBattlesOfflineViewVO;
         this._epicBattlesOfflineViewVO = new EpicBattlesOfflineViewVO(param1);
         this.setData(this._epicBattlesOfflineViewVO);
         if(_loc2_)
         {
            _loc2_.dispose();
         }
      }
      
      protected function setData(param1:EpicBattlesOfflineViewVO) : void
      {
         var _loc2_:String = "as_setData" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
   }
}
