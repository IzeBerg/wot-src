package net.wg.gui.lobby.colorSettings.components
{
   import flash.events.Event;
   import flash.text.TextField;
   import net.wg.data.constants.Linkages;
   import net.wg.data.constants.Values;
   import net.wg.gui.components.controls.LabelControl;
   import net.wg.gui.components.controls.SimpleTileList;
   import net.wg.gui.components.controls.Slider;
   import net.wg.gui.lobby.colorSettings.events.ColorSettingsRendererEvent;
   import net.wg.gui.lobby.colorSettings.events.ColorSettingsSliderEvent;
   import net.wg.gui.lobby.colorSettings.vo.ColorSettingsVO;
   import net.wg.infrastructure.base.UIComponentEx;
   import scaleform.clik.events.SliderEvent;
   
   public class ColorSettingsFiltersView extends UIComponentEx
   {
      
      private static const RENDERERS_GAP:int = 20;
      
      private static const INVALID_SETTINGS:String = "INVALID_SETTINGS";
      
      private static const RENDERER_W:int = 192;
      
      private static const RENDERER_H:int = 70;
       
      
      public var titleTF:TextField = null;
      
      public var filterPowerLabel:LabelControl = null;
      
      public var filterPowerSlider:Slider = null;
      
      public var filtersList:SimpleTileList = null;
      
      private var _settingsTypesReady:Boolean = false;
      
      private var _selectedIndex:int = -1;
      
      private var _filterPower:int = 0;
      
      public function ColorSettingsFiltersView()
      {
         super();
      }
      
      override protected function onBeforeDispose() : void
      {
         this.filtersList.removeEventListener(Event.COMPLETE,this.onFiltersListCompleteHandler);
         removeEventListener(ColorSettingsRendererEvent.FILTER_SELECTED,this.onSettingsTypesFilterSelectedHandler);
         this.filterPowerSlider.removeEventListener(SliderEvent.VALUE_CHANGE,this.onFilterPowerSliderValueChangeHandler);
         super.onBeforeDispose();
      }
      
      override protected function onDispose() : void
      {
         this.titleTF = null;
         this.filterPowerLabel.dispose();
         this.filterPowerLabel = null;
         this.filterPowerSlider.dispose();
         this.filterPowerSlider = null;
         this.filtersList.dispose();
         this.filtersList = null;
         super.onDispose();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         addEventListener(ColorSettingsRendererEvent.FILTER_SELECTED,this.onSettingsTypesFilterSelectedHandler);
         this.filtersList.addEventListener(Event.COMPLETE,this.onFiltersListCompleteHandler);
         this.filtersList.itemRenderer = App.utils.classFactory.getClass(Linkages.COLOR_SETTINGS_FILTER_RENDER);
         this.filtersList.tileWidth = RENDERER_W;
         this.filtersList.tileHeight = RENDERER_H;
         this.filtersList.horizontalGap = RENDERERS_GAP;
         this.filtersList.verticalGap = RENDERERS_GAP;
         this.filtersList.autoSize = true;
         this.filterPowerSlider.addEventListener(SliderEvent.VALUE_CHANGE,this.onFilterPowerSliderValueChangeHandler);
         this.filterPowerSlider.maximum = 100;
         this.filterPowerSlider.minimum = 0;
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(INVALID_SETTINGS))
         {
            this.filterPowerSlider.value = this._filterPower;
         }
      }
      
      public function setFilterData(param1:int, param2:Number) : void
      {
         if(param1 != this._selectedIndex)
         {
            this.switchRendererSelected(this._selectedIndex,false);
            this._selectedIndex = param1;
            this.switchRendererSelected(this._selectedIndex,true);
         }
         this._filterPower = param2;
         invalidate(INVALID_SETTINGS);
      }
      
      public function setInitialData(param1:ColorSettingsVO) : void
      {
         this.titleTF.htmlText = param1.filtersHeader;
         this.filterPowerLabel.text = param1.filterPowerLabel;
         this.filtersList.dataProvider = param1.filtersTypesDP;
      }
      
      private function switchRendererSelected(param1:int, param2:Boolean) : void
      {
         var _loc3_:ColorSettingsFilterRenderer = null;
         if(!this._settingsTypesReady)
         {
            return;
         }
         if(param1 != Values.DEFAULT_INT)
         {
            _loc3_ = ColorSettingsFilterRenderer(this.filtersList.getRendererAt(param1));
            if(_loc3_ && param2 != _loc3_.selected)
            {
               _loc3_.selected = param2;
            }
         }
      }
      
      private function onFiltersListCompleteHandler(param1:Event) : void
      {
         this.filtersList.removeEventListener(Event.COMPLETE,this.onFiltersListCompleteHandler);
         this._settingsTypesReady = true;
         this.switchRendererSelected(this._selectedIndex,true);
      }
      
      private function onSettingsTypesFilterSelectedHandler(param1:ColorSettingsRendererEvent) : void
      {
         this.switchRendererSelected(this._selectedIndex,false);
         this._selectedIndex = param1.itemIndex;
         this.switchRendererSelected(this._selectedIndex,true);
      }
      
      private function onFilterPowerSliderValueChangeHandler(param1:SliderEvent) : void
      {
         dispatchEvent(new ColorSettingsSliderEvent(ColorSettingsSliderEvent.FILTER_POWER_SLIDER_CHANGE,param1.value));
      }
   }
}
