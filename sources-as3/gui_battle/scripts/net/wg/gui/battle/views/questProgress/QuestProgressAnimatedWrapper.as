package net.wg.gui.battle.views.questProgress
{
   import flash.display.BlendMode;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.geom.Point;
   import flash.utils.Dictionary;
   import net.wg.data.constants.Values;
   import net.wg.data.constants.generated.QUEST_PROGRESS_BASE;
   import net.wg.data.constants.generated.QUEST_PROGRESS_BATTLE;
   import net.wg.gui.battle.views.questProgress.animated.IAnimationTopContainer;
   import net.wg.gui.battle.views.questProgress.animated.IQueueAnimProgressState;
   import net.wg.gui.battle.views.questProgress.animated.IQueueItem;
   import net.wg.gui.battle.views.questProgress.animated.QuestProgressQueueStateAnim;
   import net.wg.gui.battle.views.questProgress.animated.UpdateViewDataQueueItem;
   import net.wg.gui.battle.views.questProgress.events.QuestProgressAnimatedWrapperEvent;
   import net.wg.gui.battle.views.questProgress.helper.BattleQuestProgressConsts;
   import net.wg.gui.battle.views.questProgress.interfaces.IQuestProgressView;
   import net.wg.gui.battle.views.questProgress.interfaces.IQuestProgressViewUpdatable;
   import net.wg.gui.components.questProgress.interfaces.components.IQPItemRenderer;
   import net.wg.gui.components.questProgress.interfaces.data.IHeaderProgressData;
   import net.wg.gui.components.questProgress.interfaces.data.IQPInitData;
   import net.wg.gui.components.questProgress.interfaces.data.IQPProgressData;
   import net.wg.gui.components.questProgress.interfaces.data.IQuestProgressData;
   import net.wg.gui.components.questProgress.interfaces.data.IQuestProgressItemData;
   
   public class QuestProgressAnimatedWrapper extends EventDispatcher implements IQuestProgressViewUpdatable
   {
      
      private static const ANIM_INSTANCE_NAME:String = "qp_animation";
      
      private static const ANIM_PROGRESS_BY_PRC_STEP:int = 25;
      
      private static const FULL_PRC:int = 100;
       
      
      private var _originalView:IQuestProgressView = null;
      
      private var _animContainer:IAnimationTopContainer = null;
      
      private var _globalData:IQuestProgressData = null;
      
      private var _previousProgressData:Dictionary = null;
      
      private var _pendingQueue:Vector.<IQueueItem> = null;
      
      private var _isViewLocked:Boolean = false;
      
      private var _currentItem:IQueueItem = null;
      
      private var _isPermanentStopAnimation:Boolean = false;
      
      public function QuestProgressAnimatedWrapper(param1:IQuestProgressView, param2:IAnimationTopContainer)
      {
         super();
         this._originalView = param1;
         this._animContainer = param2;
      }
      
      private static function needProgressAnimation(param1:int, param2:int) : Boolean
      {
         param1 /= ANIM_PROGRESS_BY_PRC_STEP;
         param2 /= ANIM_PROGRESS_BY_PRC_STEP;
         return param2 > param1;
      }
      
      public final function dispose() : void
      {
         this.clearDynamicData();
         this._animContainer = null;
         this._globalData = null;
         this._originalView = null;
      }
      
      public function findItemById(param1:String) : IQPItemRenderer
      {
         return null;
      }
      
      public function init(param1:IQuestProgressData) : void
      {
         var _loc2_:IQuestProgressItemData = null;
         this.reset();
         for each(_loc2_ in param1.getData())
         {
            this._previousProgressData[_loc2_.id] = _loc2_.progressData.cloneObj();
         }
         this._originalView.init(param1);
         this._globalData = param1;
      }
      
      public function permanentStopAnimation() : void
      {
         this._isPermanentStopAnimation = true;
         this.stopAllAnimations();
      }
      
      public function update(param1:String, param2:IQPProgressData) : void
      {
         var _loc4_:IQPProgressData = null;
         var _loc5_:IQueueItem = null;
         var _loc3_:IQPInitData = this._globalData.getDataItem(param1).initData;
         if(!this._isPermanentStopAnimation && _loc3_.orderType == QUEST_PROGRESS_BASE.MAIN_ORDER_TYPE && this._originalView.isQPVisibleBySettings)
         {
            _loc4_ = param2.cloneObj();
            _loc5_ = this.checkState(_loc3_,this._originalView.findItemById(param1),this._previousProgressData[param1],_loc4_);
            if(this._isViewLocked)
            {
               this._pendingQueue.push(new UpdateViewDataQueueItem(this._originalView,param1,_loc4_));
               if(_loc5_ != null)
               {
                  this._pendingQueue.push(_loc5_);
               }
            }
            else
            {
               this._originalView.update(param1,param2);
               if(_loc5_ != null)
               {
                  this._isViewLocked = true;
                  this.runAnimItem(_loc5_);
               }
            }
            this._previousProgressData[param1] = _loc4_;
         }
         else
         {
            this._originalView.update(param1,param2);
         }
      }
      
      public function updateHeaderProgress(param1:Vector.<IHeaderProgressData>) : void
      {
         this._originalView.updateHeaderProgress(param1);
      }
      
      private function clearDynamicData() : void
      {
         if(this._currentItem)
         {
            this._currentItem.dispose();
            this._currentItem = null;
         }
         if(this._pendingQueue)
         {
            this._pendingQueue.splice(0,this._pendingQueue.length);
            this._pendingQueue = null;
         }
         if(this._previousProgressData)
         {
            App.utils.data.cleanupDynamicObject(this._previousProgressData);
            this._previousProgressData = null;
         }
      }
      
      private function reset() : void
      {
         this.stopAllAnimations();
         this._isViewLocked = false;
         this._originalView.alpha = Values.DEFAULT_ALPHA;
         this._animContainer.reset();
         this._animContainer.alpha = Values.DEFAULT_ALPHA;
      }
      
      private function stopAllAnimations() : void
      {
         this.clearDynamicData();
         this._pendingQueue = new Vector.<IQueueItem>(0);
         this._previousProgressData = new Dictionary();
      }
      
      private function nextQueueItem() : void
      {
         if(this._pendingQueue.length == 0)
         {
            if(this._currentItem)
            {
               this._currentItem.dispose();
               this._currentItem = null;
            }
            this._isViewLocked = false;
            dispatchEvent(new Event(QuestProgressAnimatedWrapperEvent.ALL_ANIM_COMPLETED));
         }
         else
         {
            this.runAnimItem(this._pendingQueue.shift());
         }
      }
      
      private function runAnimItem(param1:IQueueItem) : void
      {
         if(this._currentItem)
         {
            this._currentItem.dispose();
         }
         this._currentItem = param1;
         this._currentItem.run(this.nextQueueItem);
      }
      
      private function checkState(param1:IQPInitData, param2:IQPItemRenderer, param3:IQPProgressData, param4:IQPProgressData) : IQueueItem
      {
         var _loc9_:int = 0;
         var _loc10_:String = null;
         var _loc11_:Point = null;
         var _loc12_:IQueueAnimProgressState = null;
         var _loc5_:String = null;
         var _loc6_:String = Values.EMPTY_STR;
         var _loc7_:int = Values.ZERO;
         var _loc8_:int = Values.ZERO;
         if(param3)
         {
            if(param4.isFailed && !param3.isFailed)
            {
               _loc5_ = QUEST_PROGRESS_BATTLE.QP_ANIM_STATUS_FAILD;
               _loc6_ = QUESTS.BATTLECONDITION_TASK_STATUS_FAILED;
            }
            else if(param4.isCompleted && !param3.isCompleted)
            {
               _loc5_ = QUEST_PROGRESS_BATTLE.QP_ANIM_STATUS_COMPLETED;
               _loc6_ = QUESTS.BATTLECONDITION_TASK_STATUS_DONE;
            }
         }
         if(_loc5_ == null)
         {
            _loc9_ = param4.goal;
            _loc7_ = Boolean(param3) ? int(FULL_PRC * param3.current / _loc9_) : int(Values.ZERO);
            _loc8_ = FULL_PRC * param4.current / _loc9_;
            if(needProgressAnimation(_loc7_,_loc8_))
            {
               _loc5_ = QUEST_PROGRESS_BATTLE.QP_ANIM_STATUS_PROGRESS;
               _loc6_ = param4.metricsValue[param1.topMetricIndex].metricValue;
            }
         }
         if(_loc5_ != null)
         {
            _loc10_ = BattleQuestProgressConsts.getChartAnimItem(_loc5_,param1.progressType);
            _loc11_ = new Point(param2.x,param2.y);
            _loc12_ = IQueueAnimProgressState(App.utils.classFactory.getObject(_loc10_));
            _loc12_.blendMode = BlendMode.SCREEN;
            _loc12_.mouseEnabled = _loc12_.mouseChildren = false;
            _loc12_.name = ANIM_INSTANCE_NAME;
            _loc12_.setIcon(param1.iconID);
            _loc12_.setValue(_loc6_);
            _loc12_.setProgressPrc(_loc8_);
            _loc12_.setStartPosition(_loc11_);
            return new QuestProgressQueueStateAnim(this._originalView,_loc12_,this._animContainer);
         }
         return null;
      }
   }
}
