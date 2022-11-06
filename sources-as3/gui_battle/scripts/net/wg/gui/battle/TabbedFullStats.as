package net.wg.gui.battle
{
   import net.wg.data.constants.Linkages;
   import net.wg.data.constants.LobbyMetrics;
   import net.wg.gui.components.advanced.ContentTabBar;
   import net.wg.infrastructure.base.meta.ITabbedFullStatsMeta;
   import net.wg.infrastructure.base.meta.impl.TabbedFullStatsMeta;
   import net.wg.infrastructure.interfaces.IDAAPIDataClass;
   import scaleform.clik.data.DataProvider;
   import scaleform.clik.events.IndexEvent;
   
   public class TabbedFullStats extends TabbedFullStatsMeta implements ITabbedFullStatsMeta
   {
      
      private static const MIN_TABS_RENDERER_WIDTH:int = 134;
      
      private static const TABS_Y:int = 141;
      
      private static const TABS_SMALL_Y:int = 98;
      
      private static const TITLE_SMALL_Y_SHIFT:int = 58;
       
      
      public var tabs:ContentTabBar = null;
      
      private var _lastSelectedTabIndex:int = 0;
      
      public function TabbedFullStats()
      {
         super();
      }
      
      override public function setQuestStatus(param1:IDAAPIDataClass) : void
      {
         if(visible)
         {
            this.updateCurrentTab();
         }
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.tabs.itemRendererName = Linkages.CONTENT_TAB_RENDERER;
         this.tabs.minRendererWidth = MIN_TABS_RENDERER_WIDTH;
         this.tabs.addEventListener(IndexEvent.INDEX_CHANGE,this.onTabsIndexChangeHandler);
      }
      
      override protected function updateTabs(param1:DataProvider) : void
      {
         this.tabs.dataProvider = param1;
      }
      
      override protected function onDispose() : void
      {
         this.tabs.removeEventListener(IndexEvent.INDEX_CHANGE,this.onTabsIndexChangeHandler);
         this.tabs.dispose();
         this.tabs = null;
         super.onDispose();
      }
      
      override protected function doUpdateSizeTop(param1:Number, param2:Number) : void
      {
         super.doUpdateSizeTop(param1,param2);
         this.tabs.y = param2 < MIN_HEIGHT ? Number(TABS_SMALL_Y) : Number(TABS_Y);
      }
      
      override protected function getTitleY() : int
      {
         var _loc1_:int = height - LobbyMetrics.MIN_STAGE_HEIGHT >> 2;
         return this.tabs.y + TITLE_SMALL_Y_SHIFT + _loc1_;
      }
      
      override protected function initTitle() : void
      {
      }
      
      public function as_resetActiveTab() : void
      {
         this.tabs.selectedIndex = this._lastSelectedTabIndex;
      }
      
      public function as_setActiveTab(param1:Number) : void
      {
         this._lastSelectedTabIndex = this.tabs.selectedIndex;
         this.tabs.selectedIndex = param1;
      }
      
      public function as_isFDEvent(param1:Boolean) : void
      {
      }
      
      protected function updateCurrentTab() : void
      {
         var _loc1_:Boolean = false;
         statsTable.visible = this.tabs.selectedIndex == 0;
         _loc1_ = statsTable.visible;
         title.visible = _loc1_;
         if(_loc1_)
         {
            setTitle();
         }
      }
      
      override public function set visible(param1:Boolean) : void
      {
         if(param1 && title.visible)
         {
            title.validateNow();
         }
         super.visible = param1;
      }
      
      private function onTabsIndexChangeHandler(param1:IndexEvent) : void
      {
         this.updateCurrentTab();
      }
   }
}
