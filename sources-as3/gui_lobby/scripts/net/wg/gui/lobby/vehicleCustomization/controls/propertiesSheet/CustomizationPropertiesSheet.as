package net.wg.gui.lobby.vehicleCustomization.controls.propertiesSheet
{
   import flash.events.Event;
   import net.wg.data.Aliases;
   import net.wg.data.constants.SoundTypes;
   import net.wg.data.constants.generated.CUSTOMIZATION_ALIASES;
   import net.wg.gui.lobby.vehicleCustomization.CustomizationAnchorSwitchers;
   import net.wg.gui.lobby.vehicleCustomization.controls.propertiesSheet.inscriptionController.CustomizationInscriptionController;
   import net.wg.gui.lobby.vehicleCustomization.data.propertiesSheet.CustomizationPropertiesSheetVO;
   import net.wg.gui.lobby.vehicleCustomization.events.CustomizationCarouselScrollEvent;
   import net.wg.gui.lobby.vehicleCustomization.events.CustomizationEvent;
   import net.wg.gui.lobby.vehicleCustomization.events.CustomizationSoundEvent;
   import net.wg.gui.lobby.vehicleCustomization.events.propertiesSheet.CustomizationSheetRendererEvent;
   import net.wg.infrastructure.base.meta.ICustomizationPropertiesSheetMeta;
   import net.wg.infrastructure.base.meta.impl.CustomizationPropertiesSheetMeta;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.ui.InputDetails;
   
   public class CustomizationPropertiesSheet extends CustomizationPropertiesSheetMeta implements ICustomizationPropertiesSheetMeta
   {
      
      public static const OFFSET_X:int = 49;
      
      public static const OFFSET_Y:int = 318;
      
      private static const SWITCHERS_H_OFFSET:int = -12;
      
      private static const ELEMENT_CONTROLS_SMALL_SCALE:Number = 0.85;
      
      private static const ELEMENT_CONTROLS_NORMAL_SCALE:Number = 1;
      
      private static const ELEMENT_CONTROLS_SMALL_HEIGHT:int = 900;
      
      private static const CLOSE_STATUS_INVALID:String = "closeStatusInvalid";
       
      
      public var elementsControls:CustomizationSheetElementControls = null;
      
      public var anchorSwitchers:CustomizationAnchorSwitchers = null;
      
      public var customInscriptionController:CustomizationInscriptionController = null;
      
      private var _model:CustomizationPropertiesSheetVO = null;
      
      private var _isShown:Boolean = false;
      
      public function CustomizationPropertiesSheet()
      {
         super();
      }
      
      override protected function onPopulate() : void
      {
         super.onPopulate();
         registerFlashComponentS(this.customInscriptionController,Aliases.CUSTOMIZATION_INSCRIPTION_CONTROLLER);
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         registerInscriptionControllerS(this.customInscriptionController,this.customInscriptionController.lines);
         this.anchorSwitchers.mouseEnabled = false;
         this.anchorSwitchers.visible = false;
         addEventListener(CustomizationSheetRendererEvent.ACTION_BTN_CLICK,this.onActionBtnClickHandler);
         this.elementsControls.addEventListener(CustomizationEvent.ELEMENTS_CONROLS_HIDE,this.onElementsControlHideHandler);
         App.stage.addEventListener(Event.RESIZE,this.onStageResizeHandler);
         this.onStageResizeHandler();
      }
      
      override protected function onDispose() : void
      {
         removeEventListener(CustomizationSheetRendererEvent.ACTION_BTN_CLICK,this.onActionBtnClickHandler);
         this.elementsControls.removeEventListener(CustomizationEvent.ELEMENTS_CONROLS_HIDE,this.onElementsControlHideHandler);
         App.stage.removeEventListener(Event.RESIZE,this.onStageResizeHandler);
         this.elementsControls.dispose();
         this.elementsControls = null;
         this.anchorSwitchers.dispose();
         this.anchorSwitchers = null;
         this.customInscriptionController = null;
         this._model = null;
         super.onDispose();
      }
      
      public function as_setArrowsStates(param1:Boolean, param2:Boolean) : void
      {
         dispatchEvent(new CustomizationCarouselScrollEvent(CustomizationCarouselScrollEvent.AVAILABLE_PAGING,param1,param2,true));
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(this._model != null && isInvalid(InvalidationType.DATA))
         {
            this.elementsControls.setRenderers(this._model);
            this.anchorSwitchers.visible = this._model.showSwitchers;
            if(this._model.showSwitchers)
            {
               this.anchorSwitchers.setGapOffset(!!this._model.isNarrowSlot ? int(SWITCHERS_H_OFFSET) : int(0));
            }
            dispatchEvent(new CustomizationEvent(CustomizationEvent.SHOW_PROPERTIES_SHEET,false));
            if(!this._isShown)
            {
               this._isShown = true;
               dispatchEvent(new CustomizationSoundEvent(CustomizationSoundEvent.PLAY_SOUND,CUSTOMIZATION_ALIASES.SOUND_RADIAL_BIG));
            }
         }
         if(this._isShown && isInvalid(CLOSE_STATUS_INVALID))
         {
            dispatchEvent(new CustomizationSoundEvent(CustomizationSoundEvent.PLAY_SOUND,SoundTypes.CUSTOMIZATION_BIG_CLOSE));
            this.elementsControls.hideElementsAnimation();
            this.anchorSwitchers.visible = false;
            this._isShown = false;
            dispatchEvent(new CustomizationEvent(CustomizationEvent.CLOSE_PROPERTIES_SHEET));
         }
      }
      
      override protected function setDataAndShow(param1:CustomizationPropertiesSheetVO) : void
      {
         this._model = param1;
         invalidateData();
      }
      
      public function as_hide() : void
      {
         invalidate(CLOSE_STATUS_INVALID);
         validateNow();
      }
      
      public function onKeyDownHandler(param1:InputDetails = null) : void
      {
         if(this._isShown)
         {
            this.anchorSwitchers.onKeyDownHandler(param1);
         }
      }
      
      private function onStageResizeHandler(param1:Event = null) : void
      {
         var _loc2_:Number = App.appHeight > ELEMENT_CONTROLS_SMALL_HEIGHT ? Number(ELEMENT_CONTROLS_NORMAL_SCALE) : Number(ELEMENT_CONTROLS_SMALL_SCALE);
         this.elementsControls.scaleX = this.elementsControls.scaleY = _loc2_;
      }
      
      private function onElementsControlHideHandler(param1:CustomizationEvent) : void
      {
         elementControlsHide();
      }
      
      private function onActionBtnClickHandler(param1:CustomizationSheetRendererEvent) : void
      {
         onActionBtnClickS(param1.actionType,param1.actionData);
      }
   }
}
