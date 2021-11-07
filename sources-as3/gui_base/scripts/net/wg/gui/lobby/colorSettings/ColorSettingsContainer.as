package net.wg.gui.lobby.colorSettings
{
   import flash.events.Event;
   import flash.text.TextField;
   import net.wg.data.constants.Linkages;
   import net.wg.data.constants.Values;
   import net.wg.data.constants.generated.COLOR_SETTINGS;
   import net.wg.gui.components.controls.SimpleTileList;
   import net.wg.gui.interfaces.IContentSize;
   import net.wg.gui.lobby.colorSettings.components.ColorSettingsButtonRenderer;
   import net.wg.gui.lobby.colorSettings.components.ColorSettingsFiltersView;
   import net.wg.gui.lobby.colorSettings.components.ColorSettingsManualView;
   import net.wg.gui.lobby.colorSettings.vo.ColorSettingsUpdateVO;
   import net.wg.gui.lobby.colorSettings.vo.ColorSettingsVO;
   import net.wg.infrastructure.base.UIComponentEx;
   
   public class ColorSettingsContainer extends UIComponentEx implements IContentSize
   {
      
      private static const RENDERER_W:int = 410;
      
      private static const RENDERER_H:int = 82;
      
      private static const RENDERERS_GAP:int = 10;
      
      private static const BASE_WIDTH:int = 400;
       
      
      public var manualSettings:ColorSettingsManualView = null;
      
      public var filtersSettings:ColorSettingsFiltersView = null;
      
      public var settingsTypes:SimpleTileList = null;
      
      public var typesTF:TextField = null;
      
      public var typesDescTF:TextField = null;
      
      private var _settingsTypesReady:Boolean = false;
      
      private var _selectedTypeIdx:int = -1;
      
      private var _contentHeight:int = -1;
      
      public function ColorSettingsContainer()
      {
         super();
      }
      
      override protected function onBeforeDispose() : void
      {
         this.settingsTypes.removeEventListener(Event.COMPLETE,this.onSettingsTypesCompleteHandler);
         super.onBeforeDispose();
      }
      
      override protected function onDispose() : void
      {
         this.typesTF = null;
         this.typesDescTF = null;
         this.settingsTypes.dispose();
         this.settingsTypes = null;
         this.manualSettings.dispose();
         this.manualSettings = null;
         this.filtersSettings.dispose();
         this.filtersSettings = null;
         super.onDispose();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.settingsTypes.addEventListener(Event.COMPLETE,this.onSettingsTypesCompleteHandler);
         this.settingsTypes.itemRenderer = App.utils.classFactory.getClass(Linkages.COLOR_SETTINGS_BUTTON_RENDER);
         this.settingsTypes.tileWidth = RENDERER_W;
         this.settingsTypes.tileHeight = RENDERER_H;
         this.settingsTypes.horizontalGap = RENDERERS_GAP;
         this.settingsTypes.verticalGap = RENDERERS_GAP;
         this.settingsTypes.autoSize = true;
      }
      
      public function setInitialData(param1:ColorSettingsVO) : void
      {
         this.settingsTypes.dataProvider = param1.settingsTypesDP;
         this.filtersSettings.setInitialData(param1);
         this.manualSettings.setInitialData(param1);
         this.typesTF.htmlText = param1.typesHeader;
         this.typesDescTF.htmlText = param1.typesDesc;
      }
      
      public function updateData(param1:int, param2:ColorSettingsUpdateVO) : void
      {
         this.switchRendererSelected(this._selectedTypeIdx,false);
         this._selectedTypeIdx = param1 > 0 ? int(param1) : int(0);
         this.switchRendererSelected(this._selectedTypeIdx,true);
         this.applySelectedType();
         this.filtersSettings.setFilterData(param2.COLOR_GRADING_TECHNIQUE,param2.colorFilterIntensity);
         this.manualSettings.setSliderValues(param2.brightnessCorrection,param2.contrastCorrection,param2.saturationCorrection);
      }
      
      private function applySelectedType() : void
      {
         switch(this._selectedTypeIdx)
         {
            case COLOR_SETTINGS.COLOR_SETTINGS_TYPE_MANUAL:
               this.filtersSettings.visible = false;
               this.manualSettings.visible = true;
               this._contentHeight = this.manualSettings.y + this.manualSettings.height;
               break;
            case COLOR_SETTINGS.COLOR_SETTINGS_TYPE_FILTERS:
               this.filtersSettings.visible = true;
               this.manualSettings.visible = false;
               this._contentHeight = this.filtersSettings.y + this.filtersSettings.actualHeight;
               break;
            default:
               this.filtersSettings.visible = this.manualSettings.visible = false;
               this._contentHeight = this.settingsTypes.y + this.settingsTypes.height;
         }
         dispatchEvent(new Event(Event.RESIZE));
      }
      
      private function switchRendererSelected(param1:int, param2:Boolean) : void
      {
         var _loc3_:ColorSettingsButtonRenderer = null;
         if(!this._settingsTypesReady)
         {
            return;
         }
         if(param1 != Values.DEFAULT_INT)
         {
            _loc3_ = ColorSettingsButtonRenderer(this.settingsTypes.getRendererAt(param1));
            if(_loc3_ && param2 != _loc3_.selected)
            {
               _loc3_.selected = param2;
            }
         }
      }
      
      public function get contentWidth() : Number
      {
         return BASE_WIDTH;
      }
      
      public function get contentHeight() : Number
      {
         return this._contentHeight;
      }
      
      private function onSettingsTypesCompleteHandler(param1:Event) : void
      {
         this.settingsTypes.removeEventListener(Event.COMPLETE,this.onSettingsTypesCompleteHandler);
         this._settingsTypesReady = true;
         this.switchRendererSelected(this._selectedTypeIdx,true);
         this.applySelectedType();
      }
   }
}
