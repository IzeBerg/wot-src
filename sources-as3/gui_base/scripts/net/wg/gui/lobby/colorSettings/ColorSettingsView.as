package net.wg.gui.lobby.colorSettings
{
   import flash.display.Graphics;
   import flash.display.InteractiveObject;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.KeyboardEvent;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import flash.ui.Keyboard;
   import net.wg.data.constants.Cursors;
   import net.wg.data.constants.DragType;
   import net.wg.data.constants.Values;
   import net.wg.data.constants.generated.COLOR_SETTINGS;
   import net.wg.gui.components.controls.ResizableScrollPane;
   import net.wg.gui.interfaces.ISoundButtonEx;
   import net.wg.gui.lobby.colorSettings.events.ColorSettingsRendererEvent;
   import net.wg.gui.lobby.colorSettings.events.ColorSettingsSliderEvent;
   import net.wg.gui.lobby.colorSettings.vo.ColorSettingsUpdateVO;
   import net.wg.gui.lobby.colorSettings.vo.ColorSettingsVO;
   import net.wg.infrastructure.base.meta.IColorSettingsViewMeta;
   import net.wg.infrastructure.base.meta.impl.ColorSettingsViewMeta;
   import net.wg.infrastructure.interfaces.entity.IDraggable;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.events.ButtonEvent;
   
   public class ColorSettingsView extends ColorSettingsViewMeta implements IColorSettingsViewMeta, IDraggable
   {
      
      private static const INVALID_SETTINGS:String = "INVALID_SETTINGS";
      
      private static const INVALID_BEFORE_AFTER:String = "INVALID_BEFORE_AFTER";
      
      private static const BG_ALPHA:Number = 0.7;
      
      private static const BEFORE_AFTER_ALPHA:Number = 0.4;
      
      private static const TEXTS_OFFSET_X:int = 30;
      
      private static const TEXTS_OFFSET_Y:int = 60;
       
      
      public var stageHit:Sprite = null;
      
      public var titleTF:TextField = null;
      
      public var beforeTF:TextField = null;
      
      public var afterTF:TextField = null;
      
      public var bottomControls:MovieClip = null;
      
      public var scrollPane:ResizableScrollPane = null;
      
      public var beforeAfterPxBg:MovieClip = null;
      
      public var panelPxBg:MovieClip = null;
      
      public var onePxWhite:MovieClip = null;
      
      private var _dragOffsetX:Number = 0;
      
      private var _dragOffsetY:Number = 0;
      
      private var _colorSettingsContainer:ColorSettingsContainer = null;
      
      private var _selectedTypeIdx:int = -1;
      
      private var _applyBtn:ISoundButtonEx = null;
      
      private var _cancelBtn:ISoundButtonEx = null;
      
      private var _data:ColorSettingsVO = null;
      
      private var _update:ColorSettingsUpdateVO = null;
      
      private var _panelWidth:int = -1;
      
      private var _resetDragParams:Boolean = false;
      
      private var _smallPanelHeight:int = -1;
      
      private var _isManualSelected:Boolean = false;
      
      public function ColorSettingsView()
      {
         super();
      }
      
      override protected function onBeforeDispose() : void
      {
         App.cursor.unRegisterDragging(this);
         if(App.gameInputMgr)
         {
            App.gameInputMgr.clearKeyHandler(Keyboard.ESCAPE,KeyboardEvent.KEY_DOWN,this.onEscapeKeyDown);
         }
         this.stageHit.removeEventListener(MouseEvent.MOUSE_WHEEL,this.onStageHitMouseWheelHandler);
         this.stageHit.removeEventListener(MouseEvent.ROLL_OUT,this.onStageHitRollOutHandler);
         this._applyBtn.removeEventListener(ButtonEvent.CLICK,this.onApplyBtnClickHandler);
         this._cancelBtn.removeEventListener(ButtonEvent.CLICK,this.onCancelBtnClickHandler);
         this._colorSettingsContainer.manualSettings.resetButton.removeEventListener(ButtonEvent.CLICK,this.onResetBtnClickHandler);
         this._colorSettingsContainer.filtersSettings.removeEventListener(ColorSettingsSliderEvent.FILTER_POWER_SLIDER_CHANGE,this.onFiltersSettingsFilterPowerSliderChangeHandler);
         this._colorSettingsContainer.manualSettings.removeEventListener(ColorSettingsSliderEvent.BRIGHTNESS_SLIDER_CHANGE,this.onManualSettingsBrightnessSliderChangeHandler);
         this._colorSettingsContainer.manualSettings.removeEventListener(ColorSettingsSliderEvent.CONTRAST_SLIDER_CHANGE,this.onManualSettingsContrastSliderChangeHandler);
         this._colorSettingsContainer.manualSettings.removeEventListener(ColorSettingsSliderEvent.SATURATION_SLIDER_CHANGE,this.onManualSettingsSaturationSliderChangeHandler);
         this._colorSettingsContainer.manualSettings.removeEventListener(ColorSettingsRendererEvent.RESET_CLICKED,this.onManualSettingsResetClickedHandler);
         this._colorSettingsContainer.removeEventListener(ColorSettingsRendererEvent.SETTINGS_TYPE_SELECTED,this.onSettingsTypesSettingsTypeSelectedHandler);
         this._colorSettingsContainer.filtersSettings.removeEventListener(ColorSettingsRendererEvent.FILTER_SELECTED,this.onSettingsTypesFilterSelectedHandler);
         super.onBeforeDispose();
      }
      
      override protected function onDispose() : void
      {
         this.scrollPane.dispose();
         this.scrollPane = null;
         this.beforeAfterPxBg = null;
         this._data = null;
         this._update = null;
         this.bottomControls = null;
         this.titleTF = null;
         this._applyBtn = null;
         this._cancelBtn = null;
         this._colorSettingsContainer = null;
         this.stageHit = null;
         this.beforeTF = null;
         this.afterTF = null;
         this.panelPxBg = null;
         this.beforeAfterPxBg = null;
         this.onePxWhite = null;
         super.onDispose();
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         this._applyBtn = this.bottomControls.applyButton;
         this._cancelBtn = this.bottomControls.cancelButton;
         this._colorSettingsContainer = ColorSettingsContainer(this.scrollPane.target);
         this._panelWidth = this.bottomControls.width;
         this._smallPanelHeight = this.bottomControls.height;
         this.afterTF.visible = this.beforeTF.visible = false;
         this.afterTF.autoSize = TextFieldAutoSize.LEFT;
         this.beforeTF.autoSize = TextFieldAutoSize.LEFT;
         this.titleTF.autoSize = TextFieldAutoSize.LEFT;
         this.panelPxBg.alpha = BG_ALPHA;
         this.panelPxBg.x = 0;
         this.panelPxBg.y = this._smallPanelHeight;
         this.panelPxBg.width = this._panelWidth;
         this.beforeAfterPxBg.alpha = BEFORE_AFTER_ALPHA;
         this.beforeAfterPxBg.x = this._panelWidth;
         this.beforeAfterPxBg.height = this._smallPanelHeight;
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         if(App.gameInputMgr)
         {
            App.gameInputMgr.setKeyHandler(Keyboard.ESCAPE,KeyboardEvent.KEY_DOWN,this.onEscapeKeyDown,true,null,getFocusIndex());
         }
         App.cursor.registerDragging(this,Cursors.ROTATE);
         this.stageHit.addEventListener(MouseEvent.MOUSE_WHEEL,this.onStageHitMouseWheelHandler);
         this.stageHit.addEventListener(MouseEvent.ROLL_OUT,this.onStageHitRollOutHandler);
         this._applyBtn.addEventListener(ButtonEvent.CLICK,this.onApplyBtnClickHandler);
         this._cancelBtn.addEventListener(ButtonEvent.CLICK,this.onCancelBtnClickHandler);
         this._colorSettingsContainer.manualSettings.resetButton.addEventListener(ButtonEvent.CLICK,this.onResetBtnClickHandler);
         this._colorSettingsContainer.filtersSettings.addEventListener(ColorSettingsSliderEvent.FILTER_POWER_SLIDER_CHANGE,this.onFiltersSettingsFilterPowerSliderChangeHandler);
         this._colorSettingsContainer.manualSettings.addEventListener(ColorSettingsSliderEvent.BRIGHTNESS_SLIDER_CHANGE,this.onManualSettingsBrightnessSliderChangeHandler);
         this._colorSettingsContainer.manualSettings.addEventListener(ColorSettingsSliderEvent.CONTRAST_SLIDER_CHANGE,this.onManualSettingsContrastSliderChangeHandler);
         this._colorSettingsContainer.manualSettings.addEventListener(ColorSettingsSliderEvent.SATURATION_SLIDER_CHANGE,this.onManualSettingsSaturationSliderChangeHandler);
         this._colorSettingsContainer.manualSettings.addEventListener(ColorSettingsRendererEvent.RESET_CLICKED,this.onManualSettingsResetClickedHandler);
         this._colorSettingsContainer.addEventListener(ColorSettingsRendererEvent.SETTINGS_TYPE_SELECTED,this.onSettingsTypesSettingsTypeSelectedHandler);
         this._colorSettingsContainer.filtersSettings.addEventListener(ColorSettingsRendererEvent.FILTER_SELECTED,this.onSettingsTypesFilterSelectedHandler);
      }
      
      override protected function initData(param1:ColorSettingsVO) : void
      {
         this._data = param1;
         invalidateData();
      }
      
      override protected function updateData(param1:int, param2:ColorSettingsUpdateVO) : void
      {
         this.updateTabIdx(param1);
         this._update = param2;
         invalidate(INVALID_SETTINGS);
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(this._data)
         {
            if(isInvalid(InvalidationType.DATA))
            {
               this.titleTF.htmlText = this._data.header;
               this._cancelBtn.label = this._data.cancelLabel;
               this._applyBtn.label = this._data.applyLabel;
               closeBtn.label = this._data.closeLabel;
               this.afterTF.htmlText = this._data.afterStr;
               this.beforeTF.htmlText = this._data.beforeStr;
               this._colorSettingsContainer.setInitialData(this._data);
            }
            if(isInvalid(INVALID_BEFORE_AFTER))
            {
               this.updateBeforeAfter();
            }
         }
         if(this._update && isInvalid(INVALID_SETTINGS))
         {
            this._colorSettingsContainer.updateData(this._selectedTypeIdx,this._update);
         }
      }
      
      override protected function layoutElements() : void
      {
         super.layoutElements();
         this.bottomControls.y = _originalHeight - this._smallPanelHeight;
         closeBtn.x = this._panelWidth - closeBtn.width - CLOSE_BTN_BORDER_OFFSET;
         var _loc1_:int = _originalHeight - (this._smallPanelHeight << 1);
         this.scrollPane.y = this._smallPanelHeight;
         this.scrollPane.height = _loc1_;
         this.panelPxBg.height = _loc1_;
         this.stageHit.x = this.bottomControls.width;
         this.stageHit.width = _originalWidth - this.bottomControls.width;
         this.stageHit.height = _originalHeight;
         this.updateBeforeAfter();
         setViewWidthS(this._panelWidth * App.appScale);
      }
      
      override protected function onEscapeKeyDown() : void
      {
         onCloseS();
      }
      
      override protected function onCloseBtn() : void
      {
         onCloseS();
      }
      
      public function getDragType() : String
      {
         return DragType.SOFT;
      }
      
      public function getHitArea() : InteractiveObject
      {
         return this.stageHit;
      }
      
      public function onDragging(param1:Number, param2:Number) : void
      {
         var _loc3_:Number = !!this._resetDragParams ? Number(0) : Number(-(this._dragOffsetX - stage.mouseX));
         var _loc4_:Number = !!this._resetDragParams ? Number(0) : Number(-(this._dragOffsetY - stage.mouseY));
         this._resetDragParams = false;
         this._dragOffsetX = stage.mouseX;
         this._dragOffsetY = stage.mouseY;
         moveSpaceS(_loc3_,_loc4_,0);
      }
      
      public function onEndDrag() : void
      {
      }
      
      public function onStartDrag() : void
      {
         this._dragOffsetX = stage.mouseX;
         this._dragOffsetY = stage.mouseY;
      }
      
      private function updateBeforeAfter() : void
      {
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc1_:int = _originalHeight - (this._smallPanelHeight << 1);
         var _loc2_:int = _originalWidth - this._panelWidth;
         var _loc3_:Graphics = graphics;
         this.onePxWhite.visible = this.beforeAfterPxBg.visible = this.afterTF.visible = this.beforeTF.visible = this._isManualSelected;
         if(this._isManualSelected)
         {
            _loc4_ = this._panelWidth + (_loc2_ >> 1);
            this.beforeTF.x = _loc4_ + TEXTS_OFFSET_X;
            _loc5_ = _originalHeight - TEXTS_OFFSET_Y;
            this.afterTF.y = _loc5_;
            this.beforeTF.y = _loc5_;
            this.beforeAfterPxBg.y = this._smallPanelHeight + _loc1_;
            this.beforeAfterPxBg.width = _loc2_;
            this.onePxWhite.x = _loc4_;
            this.onePxWhite.height = _originalHeight;
         }
      }
      
      private function updateTabIdx(param1:int) : void
      {
         if(this._selectedTypeIdx != param1)
         {
            this._selectedTypeIdx = param1;
            this._isManualSelected = param1 == COLOR_SETTINGS.COLOR_SETTINGS_TYPE_MANUAL;
            invalidate(INVALID_BEFORE_AFTER);
         }
      }
      
      private function onStageHitMouseWheelHandler(param1:MouseEvent) : void
      {
         moveSpaceS(0,0,param1.delta * 200);
      }
      
      private function onStageHitRollOutHandler(param1:MouseEvent) : void
      {
         this._resetDragParams = true;
      }
      
      private function onManualSettingsResetClickedHandler(param1:ColorSettingsRendererEvent) : void
      {
         onResetS();
      }
      
      private function onSettingsTypesFilterSelectedHandler(param1:ColorSettingsRendererEvent) : void
      {
         var _loc2_:int = param1.itemIndex;
         if(_loc2_ != Values.DEFAULT_INT)
         {
            this._update.COLOR_GRADING_TECHNIQUE = _loc2_;
            onSettingsChangeS(COLOR_SETTINGS.COLOR_GRADING_TECHNIQUE,_loc2_);
         }
      }
      
      private function onSettingsTypesSettingsTypeSelectedHandler(param1:ColorSettingsRendererEvent) : void
      {
         this.updateTabIdx(param1.itemIndex);
         if(this._selectedTypeIdx != Values.DEFAULT_INT)
         {
            onTabSelectedS(this._selectedTypeIdx);
         }
      }
      
      private function onManualSettingsSaturationSliderChangeHandler(param1:ColorSettingsSliderEvent) : void
      {
         var _loc2_:int = param1.sliderValue;
         if(_loc2_ != Values.DEFAULT_INT)
         {
            this._update.saturationCorrection = _loc2_;
            onSettingsChangeS(COLOR_SETTINGS.SATURATION_CORRECTON,_loc2_);
         }
      }
      
      private function onManualSettingsContrastSliderChangeHandler(param1:ColorSettingsSliderEvent) : void
      {
         var _loc2_:int = param1.sliderValue;
         if(_loc2_ != Values.DEFAULT_INT)
         {
            this._update.contrastCorrection = _loc2_;
            onSettingsChangeS(COLOR_SETTINGS.CONTRAST_CORRECTION,_loc2_);
         }
      }
      
      private function onManualSettingsBrightnessSliderChangeHandler(param1:ColorSettingsSliderEvent) : void
      {
         var _loc2_:int = param1.sliderValue;
         if(_loc2_ != Values.DEFAULT_INT)
         {
            this._update.brightnessCorrection = _loc2_;
            onSettingsChangeS(COLOR_SETTINGS.BRIGHTNESS_CORRECTION,_loc2_);
         }
      }
      
      private function onFiltersSettingsFilterPowerSliderChangeHandler(param1:ColorSettingsSliderEvent) : void
      {
         var _loc2_:int = param1.sliderValue;
         if(_loc2_ != Values.DEFAULT_INT)
         {
            this._update.colorFilterIntensity = _loc2_;
            onSettingsChangeS(COLOR_SETTINGS.COLOR_FILTER_INTENSITY,_loc2_);
         }
      }
      
      private function onResetBtnClickHandler(param1:ButtonEvent) : void
      {
         onResetS();
      }
      
      private function onCancelBtnClickHandler(param1:ButtonEvent) : void
      {
         onCloseS();
      }
      
      private function onApplyBtnClickHandler(param1:ButtonEvent) : void
      {
         onApplyS(this._update);
      }
   }
}
