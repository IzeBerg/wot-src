package net.wg.gui.battle.views.questProgress
{
   import fl.motion.easing.Cubic;
   import fl.motion.easing.Quartic;
   import flash.display.FrameLabel;
   import flash.display.Sprite;
   import net.wg.data.constants.Values;
   import net.wg.data.constants.generated.BATTLE_SOUND;
   import net.wg.data.constants.generated.QUEST_PROGRESS_BASE;
   import net.wg.gui.battle.views.questProgress.components.QPFlag;
   import net.wg.gui.battle.views.questProgress.components.QPLock;
   import net.wg.gui.battle.views.questProgress.helper.QuestProgressTopViewItemsPos;
   import net.wg.gui.components.questProgress.events.QuestProgressComponentEvent;
   import net.wg.gui.components.questProgress.interfaces.components.IQPItemOrConditionIcon;
   import net.wg.gui.components.questProgress.interfaces.components.IQPItemRenderer;
   import net.wg.gui.components.questProgress.interfaces.data.IQPInitData;
   import net.wg.gui.components.questProgress.interfaces.data.IQuestProgressData;
   import net.wg.gui.utils.FrameHelper;
   import net.wg.infrastructure.base.meta.IQuestProgressTopViewMeta;
   import net.wg.infrastructure.base.meta.impl.QuestProgressTopViewMeta;
   import scaleform.clik.motion.Tween;
   
   public class QuestProgressTopView extends QuestProgressTopViewMeta implements IQuestProgressTopViewMeta
   {
      
      private static const FRAME_LABEL_INIT:String = "init";
      
      private static const FRAME_LABEL_SHOW:String = "firstShow";
      
      private static const FRAME_LABEL_SHOWN:String = "shown";
      
      private static const ALPHA_SHOW:int = 1;
      
      private static const ALPHA_HIDE:int = 0;
      
      private static const FADE_IN_DURATION:int = 1000;
      
      private static const START_FLAG_X:int = -128;
      
      private static const VIEW_TWEEN_DURATION:int = 500;
      
      private static const Y_ANIM_DIFF:int = 35;
      
      private static const OR_ITEM_STATIC_Y_POS:int = -6;
       
      
      public var shadow:Sprite = null;
      
      public var separator:Sprite = null;
      
      public var flag:QPFlag = null;
      
      public var lock:QPLock = null;
      
      private var _separatorPositionAfterTaskIndex:int = -1;
      
      private var _frameHelper:FrameHelper = null;
      
      private var _isAllowLayoutContent:Boolean = false;
      
      private var _viewTween:Tween = null;
      
      private var _flagTween:Tween = null;
      
      private var _separatorTween:Tween = null;
      
      private var _itemsTween:Vector.<Tween> = null;
      
      private var _orItemsTween:Vector.<Tween> = null;
      
      private var _positions:QuestProgressTopViewItemsPos = null;
      
      private var _flagWidth:int = 0;
      
      private var _isViewYAnimInProgress:Boolean = false;
      
      private var _hideViewCompleteCallback:Function = null;
      
      private var _y:int = 0;
      
      private var _isQPVisibleBySettings:Boolean = false;
      
      private var _flagVisibilityBySettings:Boolean = false;
      
      private var _isAllowShowContentByTimer:Boolean = false;
      
      private var _isUseAnim:Boolean = false;
      
      private var _isContentShown:Boolean = false;
      
      public function QuestProgressTopView()
      {
         super();
         this._positions = new QuestProgressTopViewItemsPos();
      }
      
      override public function hideView(param1:Function, param2:int) : void
      {
         this.clearViewTween();
         this._isViewYAnimInProgress = true;
         this._hideViewCompleteCallback = param1;
         this._viewTween = new Tween(VIEW_TWEEN_DURATION,this,{
            "alpha":Values.ZERO,
            "y":this.y + Y_ANIM_DIFF
         },{
            "paused":true,
            "ease":Cubic.easeIn,
            "delay":param2,
            "onComplete":this.onViewHideCompleted
         });
         this._viewTween.fastTransform = false;
         this._viewTween.reset();
         this._viewTween.paused = false;
      }
      
      override public function playSnd(param1:String) : void
      {
         onPlaySoundS(param1);
      }
      
      override protected function initData(param1:IQuestProgressData) : void
      {
         var _loc4_:IQPItemRenderer = null;
         var _loc5_:IQPItemOrConditionIcon = null;
         super.initData(param1);
         var _loc2_:String = Values.EMPTY_STR;
         var _loc3_:int = 0;
         for each(_loc4_ in items)
         {
            _loc4_.alpha = ALPHA_HIDE;
            if(_loc2_ == QUEST_PROGRESS_BASE.MAIN_ORDER_TYPE && _loc4_.orderType == QUEST_PROGRESS_BASE.ADD_ORDER_TYPE)
            {
               this._separatorPositionAfterTaskIndex = _loc3_ - 1;
            }
            _loc2_ = _loc4_.orderType;
            _loc3_++;
         }
         for each(_loc5_ in orItems)
         {
            _loc5_.alpha = ALPHA_HIDE;
            _loc5_.y = OR_ITEM_STATIC_Y_POS;
         }
         this.flag.setData(param1.questIndexStr,param1.questIcon);
         this.flag.alpha = ALPHA_HIDE;
         this.separator.alpha = ALPHA_HIDE;
         this.lock.setLockedItemsCount(items.length - this._separatorPositionAfterTaskIndex - 1);
         this.lock.resetShownContent();
         this.showContent(this._isUseAnim && !this._isContentShown);
      }
      
      override protected function reset() : void
      {
         super.reset();
         this.resetShownContent();
      }
      
      override protected function onPopulate() : void
      {
         super.onPopulate();
         this.flag.addEventListener(QuestProgressComponentEvent.SHOW,this.onFlagVisibilityChangeHandler);
         this.flag.addEventListener(QuestProgressComponentEvent.HIDE,this.onFlagVisibilityChangeHandler);
         this.initFramesScript();
      }
      
      override protected function getRendererLinkage() : String
      {
         return QUEST_PROGRESS_BASE.QP_VIEW_RENDERER_TOP;
      }
      
      override protected function getRendererOrLinkage() : String
      {
         return QUEST_PROGRESS_BASE.QP_OR_CONDITION_ICON_TOP;
      }
      
      override protected function doLayout() : void
      {
         var _loc2_:int = 0;
         var _loc3_:IQPItemRenderer = null;
         if(!this._isAllowLayoutContent)
         {
            return;
         }
         this._flagWidth = this.flag.getFlagWidth();
         var _loc1_:int = Boolean(items) ? int(items.length) : int(Values.ZERO);
         this._positions.recalculate(_loc1_,this._flagWidth,this._separatorPositionAfterTaskIndex);
         this.flag.x = this._positions.flagToX;
         this.separator.x = this._positions.separatorToX;
         this.lock.x = this._positions.lockToX;
         if(items)
         {
            _loc2_ = 0;
            for each(_loc3_ in items)
            {
               if(_loc3_.visible)
               {
                  _loc3_.x = this._positions.itemToX(_loc2_);
                  _loc2_++;
               }
            }
            this.layoutOrItems();
         }
      }
      
      override protected function getViewType() : String
      {
         return QUEST_PROGRESS_BASE.VIEW_TYPE_TOP;
      }
      
      override protected function onDispose() : void
      {
         this.clearViewTween();
         this.clearTween();
         this._hideViewCompleteCallback = null;
         this._positions.dispose();
         this._positions = null;
         this._frameHelper.dispose();
         this._frameHelper = null;
         this.shadow = null;
         this.separator = null;
         this.flag.removeEventListener(QuestProgressComponentEvent.SHOW,this.onFlagVisibilityChangeHandler);
         this.flag.removeEventListener(QuestProgressComponentEvent.HIDE,this.onFlagVisibilityChangeHandler);
         this.flag.dispose();
         this.flag = null;
         this.lock.dispose();
         this.lock = null;
         super.onDispose();
      }
      
      override protected function isHidden(param1:IQPInitData) : Boolean
      {
         return param1 != null && param1.isHiddenInBattleHud;
      }
      
      override protected function updateVisibility() : void
      {
         var _loc1_:IQPItemRenderer = null;
         var _loc2_:IQPItemOrConditionIcon = null;
         this.shadow.visible = this._isQPVisibleBySettings;
         this.lock.visible = this._isQPVisibleBySettings && hasLockedItems();
         this.updateSeparatorVisibility();
         for each(_loc1_ in items)
         {
            _loc1_.visible = this._isQPVisibleBySettings;
         }
         for each(_loc2_ in orItems)
         {
            _loc2_.visible = this._isQPVisibleBySettings;
         }
         this.updateFlagVisibility();
         super.updateVisibility();
      }
      
      public function as_setFlagVisible(param1:Boolean) : void
      {
         if(this._flagVisibilityBySettings == param1)
         {
            return;
         }
         this._flagVisibilityBySettings = param1;
         this.updateFlagVisibility();
      }
      
      public function as_setVisible(param1:Boolean) : void
      {
         if(this._isQPVisibleBySettings == param1)
         {
            return;
         }
         this._isQPVisibleBySettings = param1;
         this.updateVisibility();
      }
      
      public function as_showContentAnimation() : void
      {
         this.showContent(true);
      }
      
      public function resetFirstShowByTimer() : void
      {
         this._isAllowShowContentByTimer = false;
         this._isContentShown = false;
         this.resetShownContent();
      }
      
      public function setYPosition(param1:int) : void
      {
         this._y = param1;
         if(!this._isViewYAnimInProgress)
         {
            this.y = this._y;
         }
      }
      
      public function showByPrebattleTimer(param1:Boolean) : void
      {
         this._isAllowShowContentByTimer = true;
         if(!isInitCompleted)
         {
            return;
         }
         this.showContent(param1);
      }
      
      public function unlock() : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc1_:Boolean = hasLockedItems() && this._isQPVisibleBySettings;
         if(!_loc1_)
         {
            _loc2_ = Boolean(items) ? int(items.length) : int(0);
            _loc3_ = 0;
            while(_loc3_ < _loc2_)
            {
               if(_loc3_ > this._separatorPositionAfterTaskIndex)
               {
                  items[_loc3_].unlock();
               }
               _loc3_++;
            }
            if(this.lock.visible)
            {
               this.lock.hide();
            }
         }
      }
      
      private function updateSeparatorVisibility() : void
      {
         this.separator.visible = this._separatorPositionAfterTaskIndex != Values.DEFAULT_INT && this._isQPVisibleBySettings;
      }
      
      private function updateFlagVisibility() : void
      {
         this.flag.visible = this._flagVisibilityBySettings && this._isQPVisibleBySettings;
      }
      
      private function resetShownContent() : void
      {
         var _loc1_:IQPItemRenderer = null;
         var _loc2_:IQPItemOrConditionIcon = null;
         this.clearTween();
         this.clearViewTween();
         gotoAndStop(FRAME_LABEL_INIT);
         for each(_loc1_ in items)
         {
            _loc1_.alpha = ALPHA_HIDE;
            _loc1_.x = Values.ZERO;
         }
         for each(_loc2_ in orItems)
         {
            _loc2_.alpha = ALPHA_HIDE;
            _loc2_.x = Values.ZERO;
         }
         this.flag.x = START_FLAG_X;
         this.flag.alpha = ALPHA_HIDE;
         this.separator.alpha = ALPHA_HIDE;
         this.lock.resetShownContent();
         this._isAllowLayoutContent = false;
      }
      
      private function showContent(param1:Boolean) : void
      {
         var _loc3_:int = 0;
         var _loc4_:Tween = null;
         var _loc5_:int = 0;
         var _loc6_:IQPItemOrConditionIcon = null;
         this._isContentShown = true;
         this._isUseAnim = param1;
         if(!this._isAllowShowContentByTimer)
         {
            return;
         }
         var _loc2_:IQPItemRenderer = null;
         this.updateSeparatorVisibility();
         if(param1 && this.visible && this._isQPVisibleBySettings)
         {
            gotoAndPlay(FRAME_LABEL_SHOW);
            this.playSnd(BATTLE_SOUND.SOUND_TYPE_QUEST_PROGRESS_TOP_SHOW);
            this.flag.alpha = ALPHA_HIDE;
            this.flag.x = 0;
            this.separator.x = 0;
            this.separator.alpha = ALPHA_HIDE;
            this.lock.resetShownContent();
            if(items)
            {
               this._flagWidth = this.flag.getFlagWidth();
               _loc3_ = Boolean(items) ? int(items.length) : int(Values.ZERO);
               this._positions.recalculate(_loc3_,this._flagWidth,this._separatorPositionAfterTaskIndex);
               this.flag.x = -this._flagWidth >> 1;
               this._flagTween = new Tween(FADE_IN_DURATION,this.flag,{
                  "x":this._positions.flagToX,
                  "alpha":ALPHA_SHOW
               },{
                  "paused":false,
                  "ease":Quartic.easeOut,
                  "delay":0,
                  "onComplete":this.onFlagShowAnimCompleted
               });
               this._flagTween.fastTransform = false;
               if(this.lock.visible)
               {
                  this.lock.x = this._positions.lockToX;
                  this.lock.showContentAnimation();
               }
               this.separator.x = -this.separator.width >> 1;
               if(this.separator.visible)
               {
                  this._separatorTween = new Tween(FADE_IN_DURATION,this.separator,{
                     "x":this._positions.separatorToX,
                     "alpha":ALPHA_SHOW
                  },{
                     "paused":false,
                     "ease":Quartic.easeOut,
                     "delay":0,
                     "onComplete":null
                  });
                  this._separatorTween.fastTransform = false;
               }
               _loc4_ = null;
               this._itemsTween = new Vector.<Tween>();
               _loc5_ = 0;
               for each(_loc2_ in items)
               {
                  if(_loc2_.visible)
                  {
                     _loc2_.x = Values.ZERO;
                     _loc4_ = new Tween(FADE_IN_DURATION,_loc2_,{
                        "x":this._positions.itemToX(_loc5_),
                        "alpha":ALPHA_SHOW
                     },{
                        "paused":false,
                        "ease":Quartic.easeOut,
                        "delay":0,
                        "onComplete":null
                     });
                     _loc4_.fastTransform = false;
                     this._itemsTween.push(_loc4_);
                     _loc5_++;
                  }
               }
            }
         }
         else
         {
            gotoAndStop(FRAME_LABEL_SHOWN);
            this.flag.alpha = ALPHA_SHOW;
            this.separator.alpha = ALPHA_SHOW;
            this.lock.showContent();
            for each(_loc2_ in items)
            {
               _loc2_.alpha = ALPHA_SHOW;
            }
            for each(_loc6_ in orItems)
            {
               _loc6_.alpha = ALPHA_SHOW;
            }
         }
      }
      
      private function layoutOrItems() : void
      {
         var _loc1_:IQPItemOrConditionIcon = null;
         if(orItems)
         {
            for each(_loc1_ in orItems)
            {
               _loc1_.visible = _loc1_.item.visible && _loc1_.previousItem.visible;
               if(_loc1_.visible)
               {
                  _loc1_.x = _loc1_.item.x + _loc1_.previousItem.x - _loc1_.width >> 1;
               }
            }
         }
      }
      
      private function onFlagShowAnimCompleted() : void
      {
         var _loc1_:Tween = null;
         var _loc2_:IQPItemOrConditionIcon = null;
         if(orItems)
         {
            this.layoutOrItems();
            this._orItemsTween = new Vector.<Tween>();
            _loc1_ = null;
            for each(_loc2_ in orItems)
            {
               _loc2_.visible = _loc2_.item.visible && _loc2_.previousItem.visible;
               if(_loc2_.visible)
               {
                  _loc1_ = new Tween(FADE_IN_DURATION,_loc2_,{"alpha":ALPHA_SHOW},{
                     "paused":false,
                     "ease":Quartic.easeOut,
                     "delay":0,
                     "onComplete":null
                  });
                  _loc1_.fastTransform = false;
                  this._orItemsTween.push(_loc1_);
               }
            }
         }
      }
      
      private function initFramesScript() : void
      {
         var _loc3_:FrameLabel = null;
         this._frameHelper = new FrameHelper(this);
         var _loc1_:Array = this.currentLabels;
         var _loc2_:int = _loc1_.length;
         var _loc4_:int = 0;
         while(_loc4_ < _loc2_)
         {
            _loc3_ = _loc1_[_loc4_];
            if(_loc3_.name == FRAME_LABEL_SHOWN)
            {
               this._frameHelper.addScriptToFrame(_loc3_.frame,this.onContentShown);
            }
            _loc4_++;
         }
      }
      
      private function onContentShown() : void
      {
         this._isAllowLayoutContent = true;
         stop();
         invalidateLayout();
      }
      
      private function clearViewTween() : void
      {
         if(this._viewTween)
         {
            this._viewTween.dispose();
            this._viewTween = null;
         }
      }
      
      private function clearTween() : void
      {
         if(this._flagTween)
         {
            this._flagTween.dispose();
            this._flagTween = null;
         }
         if(this._separatorTween)
         {
            this._separatorTween.dispose();
            this._separatorTween = null;
         }
         this.lock.resetTween();
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         if(this._itemsTween)
         {
            _loc1_ = this._itemsTween.length;
            _loc2_ = 0;
            while(_loc2_ < _loc1_)
            {
               this._itemsTween[_loc2_].dispose();
               _loc2_++;
            }
            this._itemsTween.splice(0,_loc1_);
            this._itemsTween = null;
         }
         if(this._orItemsTween)
         {
            _loc1_ = this._orItemsTween.length;
            _loc2_ = 0;
            while(_loc2_ < _loc1_)
            {
               this._orItemsTween[_loc2_].dispose();
               _loc2_++;
            }
            this._orItemsTween.splice(0,_loc1_);
            this._orItemsTween = null;
         }
      }
      
      private function onViewHideCompleted() : void
      {
         this.finalizeShowHideAnim(this._hideViewCompleteCallback);
      }
      
      private function finalizeShowHideAnim(param1:Function) : void
      {
         this._isViewYAnimInProgress = false;
         if(param1 != null)
         {
            param1();
         }
         this.setYPosition(this._y);
      }
      
      override public function get isQPVisibleBySettings() : Boolean
      {
         return this._isQPVisibleBySettings;
      }
      
      private function onFlagVisibilityChangeHandler(param1:QuestProgressComponentEvent) : void
      {
         if(isInitCompleted)
         {
            invalidateLayout();
         }
      }
   }
}
