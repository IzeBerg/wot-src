package net.wg.infrastructure.base.meta.impl
{
   import net.wg.data.constants.Errors;
   import net.wg.gui.lobby.vehicleCustomization.data.propertiesSheet.CustomizationPropertiesSheetVO;
   import net.wg.infrastructure.base.BaseDAAPIComponent;
   import net.wg.infrastructure.exceptions.AbstractException;
   
   public class CustomizationPropertiesSheetMeta extends BaseDAAPIComponent
   {
       
      
      public var onActionBtnClick:Function;
      
      public var elementControlsHide:Function;
      
      public var onClose:Function;
      
      public var registerInscriptionController:Function;
      
      private var _customizationPropertiesSheetVO:CustomizationPropertiesSheetVO;
      
      public function CustomizationPropertiesSheetMeta()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         if(this._customizationPropertiesSheetVO)
         {
            this._customizationPropertiesSheetVO.dispose();
            this._customizationPropertiesSheetVO = null;
         }
         super.onDispose();
      }
      
      public function onActionBtnClickS(param1:int, param2:int) : void
      {
         App.utils.asserter.assertNotNull(this.onActionBtnClick,"onActionBtnClick" + Errors.CANT_NULL);
         this.onActionBtnClick(param1,param2);
      }
      
      public function elementControlsHideS() : void
      {
         App.utils.asserter.assertNotNull(this.elementControlsHide,"elementControlsHide" + Errors.CANT_NULL);
         this.elementControlsHide();
      }
      
      public function onCloseS() : void
      {
         App.utils.asserter.assertNotNull(this.onClose,"onClose" + Errors.CANT_NULL);
         this.onClose();
      }
      
      public function registerInscriptionControllerS(param1:Object, param2:Object) : void
      {
         App.utils.asserter.assertNotNull(this.registerInscriptionController,"registerInscriptionController" + Errors.CANT_NULL);
         this.registerInscriptionController(param1,param2);
      }
      
      public final function as_setDataAndShow(param1:Object) : void
      {
         var _loc2_:CustomizationPropertiesSheetVO = this._customizationPropertiesSheetVO;
         this._customizationPropertiesSheetVO = new CustomizationPropertiesSheetVO(param1);
         this.setDataAndShow(this._customizationPropertiesSheetVO);
         if(_loc2_)
         {
            _loc2_.dispose();
         }
      }
      
      protected function setDataAndShow(param1:CustomizationPropertiesSheetVO) : void
      {
         var _loc2_:String = "as_setDataAndShow" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
   }
}
