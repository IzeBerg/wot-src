package net.wg.infrastructure.base.meta.impl
{
   import net.wg.data.constants.Errors;
   import net.wg.gui.lobby.epicBattles.data.EpicBattlesInfoViewVO;
   import net.wg.infrastructure.base.AbstractView;
   import net.wg.infrastructure.exceptions.AbstractException;
   
   public class EpicBattlesInfoViewMeta extends AbstractView
   {
       
      
      public var onEscapePress:Function;
      
      public var onCloseBtnClick:Function;
      
      public var onManageAbilitiesBtnClick:Function;
      
      public var onPrestigeBtnClick:Function;
      
      public var onGameRewardsBtnClick:Function;
      
      public var onInfoBtnClick:Function;
      
      public var onShowRewardVehicleInGarageBtnClick:Function;
      
      private var _epicBattlesInfoViewVO:EpicBattlesInfoViewVO;
      
      public function EpicBattlesInfoViewMeta()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         if(this._epicBattlesInfoViewVO)
         {
            this._epicBattlesInfoViewVO.dispose();
            this._epicBattlesInfoViewVO = null;
         }
         super.onDispose();
      }
      
      public function onEscapePressS() : void
      {
         App.utils.asserter.assertNotNull(this.onEscapePress,"onEscapePress" + Errors.CANT_NULL);
         this.onEscapePress();
      }
      
      public function onCloseBtnClickS() : void
      {
         App.utils.asserter.assertNotNull(this.onCloseBtnClick,"onCloseBtnClick" + Errors.CANT_NULL);
         this.onCloseBtnClick();
      }
      
      public function onManageAbilitiesBtnClickS() : void
      {
         App.utils.asserter.assertNotNull(this.onManageAbilitiesBtnClick,"onManageAbilitiesBtnClick" + Errors.CANT_NULL);
         this.onManageAbilitiesBtnClick();
      }
      
      public function onPrestigeBtnClickS() : void
      {
         App.utils.asserter.assertNotNull(this.onPrestigeBtnClick,"onPrestigeBtnClick" + Errors.CANT_NULL);
         this.onPrestigeBtnClick();
      }
      
      public function onGameRewardsBtnClickS() : void
      {
         App.utils.asserter.assertNotNull(this.onGameRewardsBtnClick,"onGameRewardsBtnClick" + Errors.CANT_NULL);
         this.onGameRewardsBtnClick();
      }
      
      public function onInfoBtnClickS() : void
      {
         App.utils.asserter.assertNotNull(this.onInfoBtnClick,"onInfoBtnClick" + Errors.CANT_NULL);
         this.onInfoBtnClick();
      }
      
      public function onShowRewardVehicleInGarageBtnClickS() : void
      {
         App.utils.asserter.assertNotNull(this.onShowRewardVehicleInGarageBtnClick,"onShowRewardVehicleInGarageBtnClick" + Errors.CANT_NULL);
         this.onShowRewardVehicleInGarageBtnClick();
      }
      
      public final function as_setData(param1:Object) : void
      {
         var _loc2_:EpicBattlesInfoViewVO = this._epicBattlesInfoViewVO;
         this._epicBattlesInfoViewVO = new EpicBattlesInfoViewVO(param1);
         this.setData(this._epicBattlesInfoViewVO);
         if(_loc2_)
         {
            _loc2_.dispose();
         }
      }
      
      protected function setData(param1:EpicBattlesInfoViewVO) : void
      {
         var _loc2_:String = "as_setData" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
   }
}
