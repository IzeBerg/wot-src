package net.wg.gui.lobby.demonstration
{
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.text.TextField;
   import net.wg.data.ListDAAPIDataProvider;
   import net.wg.gui.components.advanced.ButtonBarEx;
   import net.wg.gui.components.controls.InfoIcon;
   import net.wg.gui.components.controls.ResizableScrollPane;
   import net.wg.gui.components.controls.SoundButtonEx;
   import net.wg.gui.lobby.demonstration.data.MapItemVO;
   import net.wg.gui.lobby.settings.components.RadioButtonBar;
   import net.wg.infrastructure.base.meta.IDemonstratorWindowMeta;
   import net.wg.infrastructure.base.meta.impl.DemonstratorWindowMeta;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.data.DataProvider;
   import scaleform.clik.events.ButtonEvent;
   import scaleform.clik.events.IndexEvent;
   import scaleform.clik.events.ListEvent;
   import scaleform.clik.interfaces.IDataProvider;
   
   public class DemonstratorWindow extends DemonstratorWindowMeta implements IDemonstratorWindowMeta
   {
      
      private static const INVALIDATE_EXTENDED_SETTINGS:String = "extendedSettings";
      
      private static const WINDOW_FORM_PADDING:int = 30;
      
      private static const WINDOW_HEIGHT:int = 551;
      
      private static const SCROLLBAR_PADDING:int = 10;
      
      private static const SCROLL_PANE_WIDTH:int = 810;
      
      private static const SCROLL_PANE_HEIGHT:Object = {
         0:490,
         1:374
      };
      
      private static const SCROLL_PANE_Y:Object = {
         0:34,
         1:148
      };
       
      
      public var tabs:ButtonBarEx = null;
      
      public var tabLine:Sprite = null;
      
      public var lvlLabel:TextField = null;
      
      public var lvlButtonBar:RadioButtonBar = null;
      
      public var spawnLabel:TextField = null;
      
      public var spawnButtonBar:RadioButtonBar = null;
      
      public var scrollPane:ResizableScrollPane = null;
      
      public var topLip:MovieClip = null;
      
      public var bottomLip:MovieClip = null;
      
      public var mapListContainer:MapListContainer = null;
      
      public var warningIcon:InfoIcon = null;
      
      public var battleButton:SoundButtonEx = null;
      
      private var _dataProvider:IDataProvider = null;
      
      private var _extendedSettings:Array = null;
      
      private var _isExtendedSettingsEnabled:Boolean = false;
      
      public function DemonstratorWindow()
      {
         super();
         this._extendedSettings = [this.lvlLabel,this.lvlButtonBar,this.spawnLabel,this.spawnButtonBar];
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.lvlLabel.text = MENU.DEMONSTRATOR_WINDOW_LVL;
         this.spawnLabel.text = MENU.DEMONSTRATOR_WINDOW_SPAWNLABEL;
         this.scrollPane.target = this.mapListContainer;
         this.scrollPane.scrollBarShiftHorizontal = SCROLLBAR_PADDING;
         this.mapListContainer.dataProvider = this._dataProvider;
         this.battleButton.label = MENU.DEMONSTRATOR_WINDOW_BUTTON;
         this.warningIcon.tooltip = TOOLTIPS.DEMONSTRATOR_PLATOONWARNING;
         this.topLip.mouseEnabled = false;
         this.bottomLip.mouseEnabled = false;
         this.tabs.addEventListener(IndexEvent.INDEX_CHANGE,this.onTabIndexChangeHandler);
         this.lvlButtonBar.addEventListener(IndexEvent.INDEX_CHANGE,this.onLvlButtonBarIndexChangeHandler);
         this.spawnButtonBar.addEventListener(IndexEvent.INDEX_CHANGE,this.onSpawnButtonBarIndexChangeHandler);
         this.mapListContainer.addEventListener(ListEvent.ITEM_CLICK,this.onMapListItemClickHandler);
         this.battleButton.addEventListener(ButtonEvent.CLICK,this.onBattleButtonClickHandler);
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(INVALIDATE_EXTENDED_SETTINGS))
         {
            this.validateExtendedSettings();
         }
         if(isInvalid(InvalidationType.SIZE))
         {
            this.validateSize();
         }
      }
      
      override protected function onPopulate() : void
      {
         height = WINDOW_HEIGHT;
         super.onPopulate();
         this._dataProvider = new ListDAAPIDataProvider(MapItemVO);
         this._dataProvider.addEventListener(Event.CHANGE,this.onDataProviderChangeHandler);
         window.useBottomBtns = true;
         window.title = MENU.DEMONSTRATOR_WINDOW_TITLE;
         window.formBgPadding.top += WINDOW_FORM_PADDING;
      }
      
      override protected function setGameplayTabs(param1:Array, param2:int) : void
      {
         this.tabs.dataProvider.cleanUp();
         this.tabs.dataProvider = new DataProvider(param1);
         this.tabs.selectedIndex = param2;
      }
      
      override protected function setLevels(param1:Array, param2:int) : void
      {
         this.lvlButtonBar.dataProvider.cleanUp();
         this.lvlButtonBar.dataProvider = new DataProvider(param1);
         this.lvlButtonBar.selectedIndex = param2;
      }
      
      override protected function setSpawns(param1:Array, param2:int) : void
      {
         this.spawnButtonBar.dataProvider.cleanUp();
         this.spawnButtonBar.dataProvider = new DataProvider(param1);
         this.spawnButtonBar.selectedIndex = param2;
      }
      
      override protected function onDispose() : void
      {
         this._dataProvider.removeEventListener(Event.CHANGE,this.onDataProviderChangeHandler);
         this._dataProvider.cleanUp();
         this._dataProvider = null;
         this.tabs.removeEventListener(IndexEvent.INDEX_CHANGE,this.onTabIndexChangeHandler);
         this.tabs.dispose();
         this.tabs = null;
         this.lvlLabel = null;
         this.spawnLabel = null;
         this.lvlButtonBar.removeEventListener(IndexEvent.INDEX_CHANGE,this.onLvlButtonBarIndexChangeHandler);
         this.lvlButtonBar.dispose();
         this.lvlButtonBar = null;
         this.spawnButtonBar.removeEventListener(IndexEvent.INDEX_CHANGE,this.onSpawnButtonBarIndexChangeHandler);
         this.spawnButtonBar.dispose();
         this.spawnButtonBar = null;
         this.scrollPane.dispose();
         this.scrollPane = null;
         this.mapListContainer.removeEventListener(ListEvent.ITEM_CLICK,this.onMapListItemClickHandler);
         this.mapListContainer = null;
         this.warningIcon.dispose();
         this.warningIcon = null;
         this.battleButton.removeEventListener(ButtonEvent.CLICK,this.onBattleButtonClickHandler);
         this.battleButton.dispose();
         this.battleButton = null;
         this._extendedSettings.splice(0,this._extendedSettings.length);
         this._extendedSettings = null;
         this.tabLine = null;
         this.topLip = null;
         this.bottomLip = null;
         super.onDispose();
      }
      
      public function as_enableBattleButton(param1:Boolean) : void
      {
         this.battleButton.enabled = param1;
      }
      
      public function as_enableExtendedSettings(param1:Boolean) : void
      {
         this._isExtendedSettingsEnabled = param1;
         invalidate(INVALIDATE_EXTENDED_SETTINGS);
      }
      
      public function as_enablePlatoonWarning(param1:Boolean) : void
      {
         this.warningIcon.enabled = this.warningIcon.visible = param1;
      }
      
      public function as_getDP() : Object
      {
         return this._dataProvider;
      }
      
      private function validateExtendedSettings() : void
      {
         var _loc1_:DisplayObject = null;
         for each(_loc1_ in this._extendedSettings)
         {
            _loc1_.visible = this._isExtendedSettingsEnabled;
         }
         invalidateSize();
         this.topLip.visible = this._isExtendedSettingsEnabled;
      }
      
      private function validateSize() : void
      {
         this.scrollPane.y = SCROLL_PANE_Y[int(this._isExtendedSettingsEnabled)];
         this.scrollPane.setSize(SCROLL_PANE_WIDTH,SCROLL_PANE_HEIGHT[int(this._isExtendedSettingsEnabled)]);
      }
      
      private function onBattleButtonClickHandler(param1:ButtonEvent) : void
      {
         onBattleStartS();
      }
      
      private function onSpawnButtonBarIndexChangeHandler(param1:IndexEvent) : void
      {
         onSpawnSelectedS(param1.index);
      }
      
      private function onLvlButtonBarIndexChangeHandler(param1:IndexEvent) : void
      {
         onLvlSelectedS(param1.index);
      }
      
      private function onMapListItemClickHandler(param1:ListEvent) : void
      {
         this.mapListContainer.selectedIndex = param1.index;
         onMapSelectedS(param1.index);
      }
      
      private function onDataProviderChangeHandler(param1:Event) : void
      {
         this.mapListContainer.selectedIndex = -1;
         this.mapListContainer.setListHeight(this._dataProvider.length);
         this.scrollPane.invalidateSize();
      }
      
      private function onTabIndexChangeHandler(param1:IndexEvent) : void
      {
         onGameplaySelectedS(param1.index);
      }
   }
}
