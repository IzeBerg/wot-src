package net.wg.gui.battle.views.questProgress
{
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import net.wg.data.constants.Values;
   import net.wg.data.constants.generated.QUEST_PROGRESS_BASE;
   import net.wg.gui.battle.views.questProgress.components.QuestProgressTracking;
   import net.wg.gui.battle.views.questProgress.data.QPProgressTrackingVO;
   import net.wg.gui.battle.views.questProgress.events.QuestProgressTabEvent;
   import net.wg.gui.battle.views.questProgress.interfaces.IQuestProgressViewOperationSelector;
   import net.wg.gui.components.common.FrameStateCmpnt;
   import net.wg.gui.components.controls.ScrollBar;
   import net.wg.gui.components.controls.UILoaderAlt;
   import net.wg.gui.components.questProgress.components.headerProgress.HeaderProgressContainer;
   import net.wg.gui.components.questProgress.interfaces.components.IQPItemOrConditionIcon;
   import net.wg.gui.components.questProgress.interfaces.components.IQPItemRenderer;
   import net.wg.gui.components.questProgress.interfaces.data.IHeaderProgressData;
   import net.wg.gui.components.questProgress.interfaces.data.IQuestProgressData;
   import net.wg.infrastructure.managers.ITooltipMgr;
   
   public class QuestProgressTabView extends QuestProgressView implements IQuestProgressViewOperationSelector
   {
      
      private static const ITEMS_GAP:int = 25;
      
      private static const ITEMS_START_POINT_MAIN_X:int = 0;
      
      private static const ITEMS_START_POINT_ADD_X:int = 491;
      
      private static const MOUSE_WHEEL_DELTA_FACTOR:int = 2;
      
      private static const CONDITIONS_CONTAINER_START_Y:int = 120;
      
      private static const SCROLL_AND_MASK_Y_SHIFT:int = -5;
      
      private static const ADDITIONAL_CONTENT_HEIGHT:int = 59;
      
      private static const DEF_CONTAINER_HEIGHT:int = 235;
      
      private static const PAGE_SCROLL_SIZE:int = 10;
      
      private static const LOCK_X_SHIFT:int = -2;
      
      private static const CONTAINER_TOP_MARGIN:int = 10;
       
      
      public var bg:FrameStateCmpnt = null;
      
      public var addConditionTf:TextField = null;
      
      public var mainConditionTf:TextField = null;
      
      public var progressTracking:QuestProgressTracking = null;
      
      public var headerContainer:HeaderProgressContainer = null;
      
      public var conditionsContainer:Sprite = null;
      
      public var conditionsContainerHitMc:Sprite = null;
      
      public var conditionsContainerMask:Sprite = null;
      
      public var scrollBar:ScrollBar = null;
      
      public var lock:UILoaderAlt = null;
      
      private var _startContainerY:int = 120;
      
      private var _containerHeight:int = 0;
      
      private var _toolTipMgr:ITooltipMgr;
      
      public function QuestProgressTabView()
      {
         this._toolTipMgr = App.toolTipMgr;
         super();
      }
      
      override public function addConditionItem(param1:DisplayObject) : void
      {
         this.conditionsContainer.addChild(param1);
      }
      
      override public function removeConditionItem(param1:DisplayObject) : void
      {
         this.conditionsContainer.removeChild(param1);
      }
      
      override protected function initData(param1:IQuestProgressData) : void
      {
         super.initData(param1);
         var _loc2_:int = !!param1.isHeaderHasProgress ? int(Values.ZERO) : int(ADDITIONAL_CONTENT_HEIGHT);
         this._startContainerY = CONDITIONS_CONTAINER_START_Y - _loc2_;
         this.conditionsContainer.y = this._startContainerY;
         var _loc3_:int = this._startContainerY + SCROLL_AND_MASK_Y_SHIFT;
         var _loc4_:int = DEF_CONTAINER_HEIGHT + _loc2_;
         this.conditionsContainerMask.y = _loc3_;
         this.scrollBar.y = _loc3_;
         this.conditionsContainerHitMc.y = _loc3_;
         this.conditionsContainerMask.height = _loc4_;
         this.scrollBar.height = _loc4_;
         this.conditionsContainerHitMc.height = _loc4_;
         this.headerContainer.setData(param1.headerConditions,ITEMS_START_POINT_MAIN_X,ITEMS_START_POINT_ADD_X);
      }
      
      override protected function onUpdateHeaderProgress(param1:Vector.<IHeaderProgressData>) : void
      {
         this.headerContainer.updateHeaderProgress(param1);
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.bg.allowResize = true;
         this.mainConditionTf.text = PERSONAL_MISSIONS.DETAILEDVIEW_CONDITIONSLABEL;
         this.addConditionTf.text = PERSONAL_MISSIONS.DETAILEDVIEW_CONDITIONSFULLYLABEL;
         this.conditionsContainer.hitArea = this.conditionsContainerHitMc;
         this.conditionsContainer.addEventListener(MouseEvent.MOUSE_WHEEL,this.onConditionsContainerMouseWheelHandler);
         this.scrollBar.addEventListener(Event.SCROLL,this.onScrollBarScrollHandler);
         this.progressTracking.addEventListener(QuestProgressTabEvent.QUEST_SELECT,this.onProgressTrackingQuestSelectHandler);
         this.lock.addEventListener(MouseEvent.ROLL_OVER,this.onLockRollOverHandler);
         this.lock.addEventListener(MouseEvent.ROLL_OUT,this.onLockRollOutHandler);
         this.lock.source = RES_ICONS.MAPS_ICONS_PERSONALMISSIONS_LOCK_PROGRESS;
      }
      
      override protected function getRendererLinkage() : String
      {
         return QUEST_PROGRESS_BASE.QP_VIEW_RENDERER_TAB;
      }
      
      override protected function getRendererOrLinkage() : String
      {
         return QUEST_PROGRESS_BASE.QP_OR_CONDITION_ICON_TAB;
      }
      
      override protected function doLayout() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:IQPItemRenderer = null;
         var _loc4_:IQPItemOrConditionIcon = null;
         if(items)
         {
            _loc1_ = 0;
            _loc2_ = 0;
            for each(_loc3_ in items)
            {
               _loc3_.visible = !_loc3_.isHidden;
               if(!_loc3_.isHidden)
               {
                  if(_loc3_.orderType == QUEST_PROGRESS_BASE.MAIN_ORDER_TYPE)
                  {
                     _loc3_.x = ITEMS_START_POINT_MAIN_X;
                     _loc3_.y = _loc1_;
                     _loc1_ += _loc3_.height + ITEMS_GAP;
                  }
                  else
                  {
                     _loc3_.x = ITEMS_START_POINT_ADD_X;
                     _loc3_.y = _loc2_;
                     _loc2_ += _loc3_.height + ITEMS_GAP;
                  }
               }
            }
            this._containerHeight = Math.max(_loc1_,_loc1_) - ITEMS_GAP;
            for each(_loc4_ in orItems)
            {
               _loc4_.x = _loc4_.previousItem.x + (_loc4_.previousItem.chartMetrics.width >> 1);
               _loc4_.y = _loc4_.item.y + _loc4_.previousItem.y + _loc4_.previousItem.chartMetrics.height >> 1;
            }
            this.scrollBar.position = 0;
         }
         this.updateScrollBar();
         this.lock.visible = hasLockedItems();
         if(this.lock.visible)
         {
            this.lock.x = this.addConditionTf.x + this.addConditionTf.textWidth + LOCK_X_SHIFT;
         }
         super.doLayout();
      }
      
      override protected function getViewType() : String
      {
         return QUEST_PROGRESS_BASE.VIEW_TYPE_TAB;
      }
      
      override protected function onDispose() : void
      {
         this.mainConditionTf = null;
         this.addConditionTf = null;
         this.bg.dispose();
         this.bg = null;
         this.headerContainer.dispose();
         this.headerContainer = null;
         this.progressTracking.removeEventListener(QuestProgressTabEvent.QUEST_SELECT,this.onProgressTrackingQuestSelectHandler);
         this.progressTracking.dispose();
         this.progressTracking = null;
         this.scrollBar.removeEventListener(Event.SCROLL,this.onScrollBarScrollHandler);
         this.scrollBar.dispose();
         this.scrollBar = null;
         this.conditionsContainerHitMc = null;
         this.conditionsContainerMask = null;
         this.conditionsContainer.removeEventListener(MouseEvent.MOUSE_WHEEL,this.onConditionsContainerMouseWheelHandler);
         this.conditionsContainer = null;
         this.lock.removeEventListener(MouseEvent.ROLL_OVER,this.onLockRollOverHandler);
         this.lock.removeEventListener(MouseEvent.ROLL_OUT,this.onLockRollOutHandler);
         this.lock.dispose();
         this.lock = null;
         this._toolTipMgr = null;
         super.onDispose();
      }
      
      public function updateProgressTracking(param1:QPProgressTrackingVO) : void
      {
         this.progressTracking.update(param1);
      }
      
      private function updateScrollBar() : void
      {
         var _loc1_:int = this._containerHeight + CONTAINER_TOP_MARGIN;
         if(_loc1_ > this.conditionsContainerHitMc.height)
         {
            this.scrollBar.visible = true;
            this.scrollBar.setScrollProperties(_loc1_,0,_loc1_ - this.conditionsContainerHitMc.height,PAGE_SCROLL_SIZE);
         }
         else
         {
            this.scrollBar.visible = false;
         }
      }
      
      private function updateContainerPosByScroll() : void
      {
         this.conditionsContainer.y = this._startContainerY - this.scrollBar.position;
      }
      
      private function onProgressTrackingQuestSelectHandler(param1:QuestProgressTabEvent) : void
      {
         dispatchEvent(param1);
      }
      
      private function onConditionsContainerMouseWheelHandler(param1:MouseEvent) : void
      {
         if(this.scrollBar.visible)
         {
            this.scrollBar.position -= param1.delta * MOUSE_WHEEL_DELTA_FACTOR | 0;
            this.updateContainerPosByScroll();
         }
      }
      
      private function onScrollBarScrollHandler(param1:Event) : void
      {
         this.updateContainerPosByScroll();
      }
      
      private function onLockRollOutHandler(param1:MouseEvent) : void
      {
         this._toolTipMgr.hide();
      }
      
      private function onLockRollOverHandler(param1:MouseEvent) : void
      {
         this._toolTipMgr.show(PERSONAL_MISSIONS.DETAILEDVIEW_TOOLTIPS_LOCKED);
      }
   }
}
