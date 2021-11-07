package net.wg.gui.battle.views.questProgress
{
   import flash.display.DisplayObject;
   import flash.utils.Dictionary;
   import net.wg.data.constants.Errors;
   import net.wg.data.constants.InvalidationType;
   import net.wg.gui.battle.components.BattleDisplayable;
   import net.wg.gui.battle.views.questProgress.interfaces.IQuestProgressView;
   import net.wg.gui.components.questProgress.events.QuestProgressComponentEvent;
   import net.wg.gui.components.questProgress.interfaces.components.IQPItemOrConditionIcon;
   import net.wg.gui.components.questProgress.interfaces.components.IQPItemRenderer;
   import net.wg.gui.components.questProgress.interfaces.data.IHeaderProgressData;
   import net.wg.gui.components.questProgress.interfaces.data.IQPInitData;
   import net.wg.gui.components.questProgress.interfaces.data.IQPProgressData;
   import net.wg.gui.components.questProgress.interfaces.data.IQuestProgressData;
   import net.wg.gui.components.questProgress.interfaces.data.IQuestProgressItemData;
   
   public class QuestProgressView extends BattleDisplayable implements IQuestProgressView
   {
      
      private static const INVALID_LAYOUT:uint = InvalidationType.SYSTEM_FLAGS_BORDER << 1;
       
      
      private var _questID:int = -1;
      
      private var _items:Vector.<IQPItemRenderer> = null;
      
      private var _orItems:Vector.<IQPItemOrConditionIcon> = null;
      
      private var _isInitCompleted:Boolean = false;
      
      private var _itemsMap:Dictionary = null;
      
      private var _lockedItemsId:Vector.<String> = null;
      
      public function QuestProgressView()
      {
         super();
         this._lockedItemsId = new Vector.<String>();
      }
      
      override protected function onBeforeDispose() : void
      {
         this.removeDynamicData();
         super.onBeforeDispose();
      }
      
      override protected function onDispose() : void
      {
         this._lockedItemsId.splice(0,this._lockedItemsId.length);
         this._lockedItemsId = null;
         super.onDispose();
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(INVALID_LAYOUT))
         {
            this.doLayout();
         }
      }
      
      public function addConditionItem(param1:DisplayObject) : void
      {
         addChild(param1);
      }
      
      public function findItemById(param1:String) : IQPItemRenderer
      {
         return param1 in this._itemsMap ? this._itemsMap[param1] : null;
      }
      
      public function hideView(param1:Function, param2:int) : void
      {
      }
      
      public final function init(param1:IQuestProgressData) : void
      {
         if(this._questID != param1.questID)
         {
            this.reset();
            this._questID = param1.questID;
         }
         this.initData(param1);
         this._isInitCompleted = true;
      }
      
      public function playSnd(param1:String) : void
      {
      }
      
      public function removeConditionItem(param1:DisplayObject) : void
      {
         removeChild(param1);
      }
      
      public function showView(param1:Function, param2:int) : void
      {
      }
      
      public final function update(param1:String, param2:IQPProgressData) : void
      {
         this.updateData(param1,param2);
      }
      
      public function updateHeaderProgress(param1:Vector.<IHeaderProgressData>) : void
      {
         this.onUpdateHeaderProgress(param1);
      }
      
      protected function updateData(param1:String, param2:IQPProgressData) : void
      {
         this.updateItemById(param1,param2);
      }
      
      protected function initData(param1:IQuestProgressData) : void
      {
         var _loc2_:IQPItemRenderer = null;
         var _loc3_:IQPItemOrConditionIcon = null;
         if(this._items == null)
         {
            this.createItems(param1);
            for each(_loc2_ in this._items)
            {
               this.addConditionItem(DisplayObject(_loc2_));
            }
            for each(_loc3_ in this._orItems)
            {
               this.addConditionItem(DisplayObject(_loc3_));
            }
         }
         else
         {
            this.updateItems(param1);
         }
         this.invalidateLayout();
      }
      
      protected function reset() : void
      {
         this.removeDynamicData();
         this._isInitCompleted = false;
      }
      
      protected function invalidateLayout() : void
      {
         invalidate(INVALID_LAYOUT);
      }
      
      protected function getViewType() : String
      {
         App.utils.asserter.assert(false,"getViewType" + Errors.ABSTRACT_INVOKE);
         return null;
      }
      
      protected function doLayout() : void
      {
      }
      
      protected function getRendererLinkage() : String
      {
         App.utils.asserter.assert(false,"getRendererLinkage" + Errors.ABSTRACT_INVOKE);
         return null;
      }
      
      protected function getRendererOrLinkage() : String
      {
         App.utils.asserter.assert(false,"getRendererOrLinkage" + Errors.ABSTRACT_INVOKE);
         return null;
      }
      
      protected function isHidden(param1:IQPInitData) : Boolean
      {
         return false;
      }
      
      protected function onUpdateHeaderProgress(param1:Vector.<IHeaderProgressData>) : void
      {
      }
      
      protected function hasLockedItems() : Boolean
      {
         return this._lockedItemsId.length > 0;
      }
      
      private function updateItemRenderer(param1:IQPItemRenderer, param2:IQPProgressData) : void
      {
         param1.update(param2);
         var _loc3_:Boolean = param2.isLocked;
         var _loc4_:int = this._lockedItemsId.indexOf(param1.id);
         if(_loc4_ >= 0)
         {
            if(!_loc3_)
            {
               this._lockedItemsId.splice(_loc4_,1);
               this.invalidateLayout();
            }
         }
         else if(_loc3_)
         {
            this._lockedItemsId.push(param1.id);
            this.invalidateLayout();
         }
      }
      
      private function removeDynamicData() : void
      {
         var _loc1_:IQPItemRenderer = null;
         var _loc2_:IQPItemOrConditionIcon = null;
         App.utils.data.cleanupDynamicObject(this._itemsMap);
         this._itemsMap = null;
         if(this._items)
         {
            for each(_loc1_ in this._items)
            {
               this.removeConditionItem(DisplayObject(_loc1_));
               _loc1_.removeEventListener(QuestProgressComponentEvent.LAYOUT_COMPLETED,this.onItemRendererLayoutCompletedHandler);
               _loc1_.dispose();
            }
            this._items.splice(0,this._items.length);
            this._items = null;
         }
         if(this._orItems)
         {
            for each(_loc2_ in this._orItems)
            {
               this.removeConditionItem(DisplayObject(_loc2_));
            }
            this._orItems.splice(0,this._orItems.length);
            this._orItems = null;
         }
         this._lockedItemsId.splice(0,this._lockedItemsId.length);
      }
      
      private function updateItemById(param1:String, param2:IQPProgressData) : void
      {
         var _loc3_:IQPItemRenderer = this.findItemById(param1);
         if(_loc3_)
         {
            if(_loc3_.isHidden != param2.isHidden)
            {
               this.invalidateLayout();
            }
            this.updateItemRenderer(_loc3_,param2);
         }
      }
      
      private function createItems(param1:IQuestProgressData) : void
      {
         var _loc4_:IQPItemRenderer = null;
         var _loc7_:IQuestProgressItemData = null;
         this._itemsMap = new Dictionary();
         this._items = new Vector.<IQPItemRenderer>(0);
         this._orItems = new Vector.<IQPItemOrConditionIcon>();
         var _loc2_:String = this.getViewType();
         var _loc3_:IQPItemOrConditionIcon = null;
         var _loc5_:IQPItemRenderer = null;
         var _loc6_:Vector.<IQuestProgressItemData> = param1.getData();
         for each(_loc7_ in _loc6_)
         {
            if(!this.isHidden(_loc7_.initData))
            {
               _loc4_ = App.utils.classFactory.getComponent(this.getRendererLinkage(),IQPItemRenderer);
               _loc4_.addEventListener(QuestProgressComponentEvent.LAYOUT_COMPLETED,this.onItemRendererLayoutCompletedHandler);
               _loc4_.viewType = _loc2_;
               _loc4_.id = _loc7_.id;
               _loc4_.init(_loc7_.initData);
               _loc4_.initMetrics(_loc7_.progressData.metricsValue,_loc7_.progressData.state);
               this.updateItemRenderer(_loc4_,_loc7_.progressData);
               _loc4_.validateNow();
               this._items.push(_loc4_);
               this._itemsMap[_loc7_.id] = _loc4_;
               if(_loc5_ && _loc5_.isInOrGroup && _loc4_.isInOrGroup && _loc5_.orderType == _loc7_.initData.orderType)
               {
                  _loc3_ = App.utils.classFactory.getComponent(this.getRendererOrLinkage(),IQPItemOrConditionIcon);
                  _loc3_.setItems(_loc5_,_loc4_);
                  this._orItems.push(_loc3_);
               }
               _loc5_ = _loc4_;
            }
         }
      }
      
      private function updateItems(param1:IQuestProgressData) : void
      {
         var _loc2_:IQPItemRenderer = null;
         var _loc4_:IQuestProgressItemData = null;
         var _loc3_:Vector.<IQuestProgressItemData> = param1.getData();
         for each(_loc4_ in _loc3_)
         {
            if(!this.isHidden(_loc4_.initData))
            {
               _loc2_ = this.findItemById(_loc4_.id);
               if(_loc2_)
               {
                  this.updateItemRenderer(_loc2_,_loc4_.progressData);
               }
            }
         }
      }
      
      public function get isQPVisibleBySettings() : Boolean
      {
         return true;
      }
      
      protected function get items() : Vector.<IQPItemRenderer>
      {
         return this._items;
      }
      
      protected function get orItems() : Vector.<IQPItemOrConditionIcon>
      {
         return this._orItems;
      }
      
      protected function get isInitCompleted() : Boolean
      {
         return this._isInitCompleted;
      }
      
      private function onItemRendererLayoutCompletedHandler(param1:QuestProgressComponentEvent) : void
      {
         this.invalidateLayout();
      }
   }
}
