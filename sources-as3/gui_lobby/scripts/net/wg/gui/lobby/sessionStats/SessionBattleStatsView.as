package net.wg.gui.lobby.sessionStats
{
   import flash.display.InteractiveObject;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import net.wg.data.constants.Linkages;
   import net.wg.data.constants.generated.TEXT_ALIGN;
   import net.wg.gui.components.common.containers.TiledLayout;
   import net.wg.gui.components.containers.GroupEx;
   import net.wg.gui.components.containers.VerticalGroupLayout;
   import net.wg.gui.components.controls.ScrollingListEx;
   import net.wg.gui.interfaces.ISoundButtonEx;
   import net.wg.gui.lobby.components.IResizableContent;
   import net.wg.gui.lobby.sessionStats.data.SessionBattleStatsViewVO;
   import net.wg.gui.lobby.sessionStats.data.SessionStatsOverviewVO;
   import net.wg.gui.lobby.sessionStats.events.SessionStatsPopoverResizeEvent;
   import net.wg.infrastructure.base.meta.impl.SessionBattleStatsViewMeta;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.events.ButtonEvent;
   
   public class SessionBattleStatsView extends SessionBattleStatsViewMeta implements IResizableContent
   {
      
      public static const TILE_COLS:int = 2;
      
      public static const TILE_GAP:int = 25;
      
      public static const TILE_WIDTH:int = 132;
      
      public static const TILE_HEIGHT:int = 40;
      
      public static const COLLAPSE_GAP:int = 7;
      
      private static const TOTAL_GAP:int = 8;
      
      private static const ROW_HEIGHT:int = 31;
      
      private static const LIST_GAP:int = 10;
      
      private static const VERTICAL_GAP_BETWEEN_BLOCKS:Number = 30;
      
      private static const VERTICAL_PADDING_FOR_TOTALS_BG:Number = 15;
      
      private static const EXTERNAL_SIZE_SET:String = "external_set_size";
       
      
      public var lastBattle:GroupEx = null;
      
      public var total:GroupEx = null;
      
      public var collapseBtn:ISoundButtonEx = null;
      
      public var collapsedList:ScrollingListEx = null;
      
      public var totalBg:MovieClip = null;
      
      public var hoverBg:MovieClip = null;
      
      private var _data:SessionBattleStatsViewVO = null;
      
      public function SessionBattleStatsView()
      {
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         var _loc1_:TiledLayout = new TiledLayout(TILE_WIDTH,TILE_HEIGHT,TILE_COLS,TEXT_ALIGN.LEFT);
         _loc1_.gap = TILE_GAP;
         this.lastBattle.layout = _loc1_;
         this.lastBattle.itemRendererLinkage = Linkages.SESSION_LAST_BATTLE_STATS_RENDERER_UI;
         var _loc2_:VerticalGroupLayout = new VerticalGroupLayout();
         _loc2_.gap = TOTAL_GAP;
         this.total.layout = _loc2_;
         this.total.itemRendererLinkage = Linkages.SESSION_TOTAL_STATS_RENDERER_UI;
         this.collapsedList.itemRenderer = App.utils.classFactory.getClass(Linkages.SESSION_BATTLE_EFFICIENCY_STATS_RENDERER_UI);
         this.collapsedList.scrollBar = Linkages.SCROLL_BAR;
         this.collapsedList.rowHeight = ROW_HEIGHT;
         this.collapsedList._gap = LIST_GAP;
         this.collapsedList.smartScrollBar = true;
         this.collapsedList.widthAutoResize = false;
         this.collapsedList.visible = this.collapseBtn.toggle;
         this.collapseBtn.toggle = true;
         this.collapseBtn.useHtmlText = true;
         this.collapseBtn.addEventListener(ButtonEvent.CLICK,this.onCollapseBtnClickHandler);
         this.collapseBtn.addEventListener(MouseEvent.ROLL_OVER,this.onCollapseBtnRollOverHandler);
         this.collapseBtn.addEventListener(MouseEvent.ROLL_OUT,this.onCollapseBtnRollOutHandler);
         this.lastBattle.addEventListener(Event.RESIZE,this.onGroupResized);
         this.total.addEventListener(Event.RESIZE,this.onGroupResized);
      }
      
      override protected function draw() : void
      {
         var _loc1_:Number = NaN;
         var _loc2_:Number = NaN;
         var _loc3_:Number = NaN;
         var _loc4_:Number = NaN;
         super.draw();
         if(this._data != null)
         {
            if(isInvalid(InvalidationType.DATA))
            {
               this.lastBattle.dataProvider = this._data.lastBattle;
               this.total.dataProvider = this._data.total;
               this.collapsedList.dataProvider = this._data.battleEfficiency;
               this.collapsedList.validateNow();
               this.collapseBtn.label = this._data.collapseLabel;
            }
            if(isInvalid(InvalidationType.SIZE))
            {
               _loc1_ = this.lastBattle.y + this.lastBattle.height;
               this.total.y = _loc1_ + VERTICAL_GAP_BETWEEN_BLOCKS + VERTICAL_PADDING_FOR_TOTALS_BG;
               this.totalBg.y = _loc1_ + VERTICAL_GAP_BETWEEN_BLOCKS;
               this.totalBg.height = this.total.height + (VERTICAL_PADDING_FOR_TOTALS_BG << 1);
            }
            if(isInvalid(EXTERNAL_SIZE_SET))
            {
               if(this.collapsedList.visible)
               {
                  _loc2_ = height - this.collapsedList.y;
                  _loc3_ = this._data.battleEfficiency.length * ROW_HEIGHT;
                  _loc4_ = _loc2_ - _loc3_ - LIST_GAP;
                  if(_loc4_ > 0)
                  {
                     this.collapsedList.height = _loc3_;
                     dispatchEvent(new SessionStatsPopoverResizeEvent(SessionStatsPopoverResizeEvent.EXTRA_SIZED,_loc4_));
                  }
                  else
                  {
                     this.collapsedList.height = _loc2_;
                  }
               }
            }
         }
      }
      
      override protected function onDispose() : void
      {
         this.lastBattle.removeEventListener(Event.RESIZE,this.onGroupResized);
         this.lastBattle.dispose();
         this.lastBattle = null;
         this.total.removeEventListener(Event.RESIZE,this.onGroupResized);
         this.total.dispose();
         this.total = null;
         this.collapsedList.dispose();
         this.collapsedList = null;
         this.collapseBtn.removeEventListener(MouseEvent.ROLL_OVER,this.onCollapseBtnRollOverHandler);
         this.collapseBtn.removeEventListener(MouseEvent.ROLL_OUT,this.onCollapseBtnRollOutHandler);
         this.collapseBtn.removeEventListener(ButtonEvent.CLICK,this.onCollapseBtnClickHandler);
         this.collapseBtn.dispose();
         this.collapseBtn = null;
         this.totalBg = null;
         this.hoverBg = null;
         this._data = null;
         super.onDispose();
      }
      
      override protected function setData(param1:SessionBattleStatsViewVO) : void
      {
         this._data = param1;
         invalidateData();
      }
      
      private function onGroupResized(param1:Event) : void
      {
         invalidateSize();
      }
      
      private function onCollapseBtnClickHandler(param1:ButtonEvent) : void
      {
         this.expand(this.collapseBtn.selected);
      }
      
      private function expand(param1:Boolean) : void
      {
         this.collapsedList.visible = param1;
         dispatchEvent(new SessionStatsPopoverResizeEvent(SessionStatsPopoverResizeEvent.EXPANDED,this.collapseBtn.selected));
         invalidateSize();
      }
      
      private function onCollapseBtnRollOverHandler(param1:MouseEvent) : void
      {
         this.hoverBg.visible = true;
      }
      
      private function onCollapseBtnRollOutHandler(param1:MouseEvent) : void
      {
         this.hoverBg.visible = false;
      }
      
      public function canShowAutomatically() : Boolean
      {
         return true;
      }
      
      public function update(param1:Object) : void
      {
         if(!param1)
         {
            return;
         }
         var _loc2_:SessionStatsOverviewVO = SessionStatsOverviewVO(param1);
         this.collapseBtn.selected = _loc2_.isExpanded;
         this.expand(_loc2_.isExpanded);
      }
      
      public function getComponentForFocus() : InteractiveObject
      {
         return this;
      }
      
      public function setViewSize(param1:Number, param2:Number) : void
      {
         _width = param1;
         _height = param2;
         invalidate(EXTERNAL_SIZE_SET);
      }
      
      public function get centerOffset() : int
      {
         return 0;
      }
      
      public function set centerOffset(param1:int) : void
      {
      }
      
      public function get active() : Boolean
      {
         return false;
      }
      
      public function set active(param1:Boolean) : void
      {
      }
   }
}
