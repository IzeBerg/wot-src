package net.wg.gui.lobby.missions
{
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import net.wg.data.ListDAAPIDataProvider;
   import net.wg.data.constants.generated.MISSIONS_ALIASES;
   import net.wg.gui.components.advanced.events.DummyEvent;
   import net.wg.gui.components.controls.ScrollBar;
   import net.wg.gui.components.controls.events.ScrollEvent;
   import net.wg.gui.lobby.missions.components.MissionsList;
   import net.wg.gui.lobby.missions.data.MissionCardViewVO;
   import net.wg.infrastructure.base.meta.IMissionsListViewBaseMeta;
   import net.wg.infrastructure.base.meta.impl.MissionsListViewBaseMeta;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.events.ListEvent;
   import scaleform.clik.interfaces.IDataProvider;
   
   public class MissionsListViewBase extends MissionsListViewBaseMeta implements IMissionsListViewBaseMeta
   {
      
      private static const LIST_TOP_OFFSET:int = 70;
      
      private static const LIST_BOTTOM_OFFSET:int = 70;
      
      private static const LIST_MASK_TOP_OFFSET:int = 53;
      
      private static const LINKAGE_IMAGE_RENDERER_UI:String = "MissionPackRendererUI";
      
      private static const DEFAULT_SCROLL_STEP:int = 7;
      
      private static const BOTTOM_BG_OFFSET:int = 1;
       
      
      public var list:MissionsList;
      
      public var scrollBar:ScrollBar;
      
      public var bottomShadowBg:Sprite;
      
      private var _questsDataProvider:IDataProvider;
      
      private var _scrollStepSize:int = 7;
      
      private var _ignoreScrollBarHandler:Boolean = false;
      
      public function MissionsListViewBase()
      {
         super();
         this._questsDataProvider = new ListDAAPIDataProvider(dataProviderClass);
         if(this.list)
         {
            this.list.itemRendererClassName = LINKAGE_IMAGE_RENDERER_UI;
            this.list.dataProvider = this._questsDataProvider;
         }
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         if(this.list)
         {
            this.list.verticalScrollStep = this._scrollStepSize;
            this.list.maskOffsetTop = LIST_MASK_TOP_OFFSET;
            this.list.paddingTop = LIST_TOP_OFFSET;
            this.list.paddingBottom = LIST_BOTTOM_OFFSET;
            this.list.addEventListener(Event.SCROLL,this.onListScrollHandler);
            this.list.addEventListener(ScrollEvent.UPDATE_SIZE,this.onListUpdateSizeHandler);
            this.list.addEventListener(ListEvent.ITEM_CLICK,this.onListItemClickHandler);
            this.list.addEventListener(DummyEvent.CLICK,this.onDummyClickHandler);
         }
         if(this.scrollBar)
         {
            this.scrollBar.addEventListener(Event.SCROLL,this.onScrollBarScrollHandler);
         }
         if(this.bottomShadowBg)
         {
            this.bottomShadowBg.mouseEnabled = false;
         }
         if(dummy)
         {
            dummy.addEventListener(DummyEvent.CLICK,this.onDummyClickHandler);
         }
         if(bgLoader)
         {
            bgLoader.addEventListener(MouseEvent.MOUSE_WHEEL,this.onBgLoaderMouseWheelHandler);
         }
      }
      
      override protected function onDispose() : void
      {
         if(this.list)
         {
            this.list.removeEventListener(Event.SCROLL,this.onListScrollHandler);
            this.list.removeEventListener(ScrollEvent.UPDATE_SIZE,this.onListUpdateSizeHandler);
            this.list.removeEventListener(ListEvent.ITEM_CLICK,this.onListItemClickHandler);
            this.list.removeEventListener(DummyEvent.CLICK,this.onDummyClickHandler);
            this.list.dispose();
            this.list = null;
         }
         if(this.scrollBar)
         {
            this.scrollBar.removeEventListener(Event.SCROLL,this.onScrollBarScrollHandler);
            this.scrollBar.dispose();
            this.scrollBar = null;
         }
         if(bgLoader)
         {
            bgLoader.removeEventListener(MouseEvent.MOUSE_WHEEL,this.onBgLoaderMouseWheelHandler);
         }
         this._questsDataProvider.cleanUp();
         this._questsDataProvider = null;
         this.bottomShadowBg = null;
         super.onDispose();
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(InvalidationType.SIZE))
         {
            this.updateSize();
         }
      }
      
      override protected function setDummyVisible(param1:Boolean) : void
      {
         super.setDummyVisible(param1);
         if(this.list)
         {
            this.list.visible = !param1;
         }
         if(this.scrollBar)
         {
            this.scrollBar.visible = !param1;
         }
         if(this.bottomShadowBg)
         {
            this.bottomShadowBg.visible = !param1;
         }
      }
      
      public function as_getDP() : Object
      {
         return this._questsDataProvider;
      }
      
      public function as_scrollToItem(param1:String, param2:String) : void
      {
         this.list.scrollToItem(param1,param2);
      }
      
      protected function updateSize() : void
      {
         var _loc1_:int = _width < MISSIONS_ALIASES.MISSION_RENDERER_WIDTH_SWITCH ? int(MISSIONS_ALIASES.MISSION_RENDERER_WIDTH_SMALL) : int(MISSIONS_ALIASES.MISSION_RENDERER_WIDTH_LARGE);
         var _loc2_:int = getHeight();
         if(this.list)
         {
            this.list.setSize(_loc1_,_loc2_);
            this.list.x = _width - _loc1_ >> 1;
         }
         if(this.scrollBar)
         {
            this.scrollBar.height = _loc2_;
            this.scrollBar.x = width - this.scrollBar.width | 0;
            if(this.bottomShadowBg)
            {
               this.bottomShadowBg.width = _width - this.scrollBar.width | 0;
               this.bottomShadowBg.y = _loc2_ - this.bottomShadowBg.height + BOTTOM_BG_OFFSET | 0;
            }
         }
      }
      
      protected function getPageSize() : int
      {
         if(this.list)
         {
            return this.list.height;
         }
         return 0;
      }
      
      private function updateScrollBarProperties() : void
      {
         if(this.scrollBar)
         {
            this.scrollBar.setScrollProperties(this.getPageSize(),0,this.list.maxVerticalScrollPosition,this._scrollStepSize);
            this.scrollBar.position = this.list.verticalScrollPosition;
            if(this.list.visible)
            {
               this.scrollBar.visible = this.list.maxVerticalScrollPosition != 0;
            }
         }
      }
      
      private function onDummyClickHandler(param1:DummyEvent) : void
      {
         dummyClickedS(param1.clickType);
      }
      
      private function onListScrollHandler(param1:Event) : void
      {
         if(this.scrollBar)
         {
            this._ignoreScrollBarHandler = true;
            this.scrollBar.position = this.list.verticalScrollPosition;
            this._ignoreScrollBarHandler = false;
         }
      }
      
      private function onListUpdateSizeHandler(param1:ScrollEvent) : void
      {
         this._ignoreScrollBarHandler = true;
         this.updateScrollBarProperties();
         this._ignoreScrollBarHandler = false;
      }
      
      private function onScrollBarScrollHandler(param1:Event) : void
      {
         if(!this._ignoreScrollBarHandler && this.list)
         {
            this.list.scrollTo(this.scrollBar.position);
         }
      }
      
      private function onListItemClickHandler(param1:ListEvent) : void
      {
         var _loc2_:MissionCardViewVO = MissionCardViewVO(param1.itemData);
         openMissionDetailsViewS(_loc2_.eventID,_loc2_.blockID);
      }
      
      private function onBgLoaderMouseWheelHandler(param1:MouseEvent) : void
      {
         if(this.list)
         {
            this.list.dispatchEvent(param1.clone());
         }
      }
   }
}
