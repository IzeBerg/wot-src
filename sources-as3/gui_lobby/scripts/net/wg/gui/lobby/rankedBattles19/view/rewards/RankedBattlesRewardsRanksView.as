package net.wg.gui.lobby.rankedBattles19.view.rewards
{
   import fl.motion.easing.Cubic;
   import flash.display.Sprite;
   import flash.events.Event;
   import net.wg.data.constants.Values;
   import net.wg.gui.lobby.rankedBattles19.components.divisionSelector.DivisionSelector;
   import net.wg.gui.lobby.rankedBattles19.data.DivisionVO;
   import net.wg.gui.lobby.rankedBattles19.data.RewardsRankRendererVO;
   import net.wg.gui.lobby.rankedBattles19.view.rewards.ranks.DivisionRewardsView;
   import net.wg.gui.lobby.rankedBattles19.view.rewards.ranks.QualificationRewardsView;
   import net.wg.infrastructure.base.meta.IRankedBattlesRewardsRanksMeta;
   import net.wg.infrastructure.base.meta.impl.RankedBattlesRewardsRanksMeta;
   import net.wg.utils.IStageSizeDependComponent;
   import net.wg.utils.StageSizeBoundaries;
   import org.idmedia.as3commons.util.StringUtils;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.events.IndexEvent;
   import scaleform.clik.motion.Tween;
   import scaleform.clik.utils.Padding;
   
   public class RankedBattlesRewardsRanksView extends RankedBattlesRewardsRanksMeta implements IRankedBattlesRewardsRanksMeta, IStageSizeDependComponent
   {
      
      private static const DIVISION_HEIGHT_ID_HIGH:String = "divisionHigh";
      
      private static const DIVISION_HEIGHT_ID_SHORT:String = "divisionShort";
      
      private static const DIVISION_SELECTOR_TOP_POSITION_SHORT:int = -52;
      
      private static const DIVISION_SELECTOR_TOP_POSITION_HIGH:int = -22;
      
      private static const SHOW_HIDE_TWEEN_DURATION:int = 400;
      
      private static const SHOW_HIDE_TWEEN_EASING_HIDE:Function = Cubic.easeOut;
      
      private static const SHOW_HIDE_TWEEN_EASING_SHOW:Function = Cubic.easeIn;
      
      private static const INV_DIVISIONS:String = "invalidateDivisions";
      
      private static const INV_REWARDS:String = "invalidateRewards";
      
      private static const INV_REWARD_REQUEST:String = "invRequest";
      
      private static const REWARDS_Y_OFFSET:int = 5;
       
      
      public var divisionSelector:DivisionSelector = null;
      
      public var qualificationRewards:QualificationRewardsView = null;
      
      public var divisionRewards:DivisionRewardsView = null;
      
      private var _cont:Sprite = null;
      
      private var _rewards:Vector.<RewardsRankRendererVO> = null;
      
      private var _isQualification:Boolean = false;
      
      private var _divisions:Vector.<DivisionVO> = null;
      
      private var _updateDivisionsImmediately:Boolean = false;
      
      private var _containerGlobalLeftShift:Number = 0;
      
      private var _divisionHeightID:String = "";
      
      private var _contentTween:Tween = null;
      
      private var _nextDataIndex:int = -1;
      
      public function RankedBattlesRewardsRanksView()
      {
         super();
         this._cont = new Sprite();
         addChild(this._cont);
         this._cont.addChild(this.qualificationRewards);
         this._cont.addChild(this.divisionRewards);
      }
      
      override public function setSizePadding(param1:Padding, param2:Boolean) : void
      {
         super.setSizePadding(param1,param2);
         this.divisionRewards.setSizePadding(param1);
         this.qualificationRewards.setSizePadding(param1);
      }
      
      override protected function onPopulate() : void
      {
         this.divisionRewards.addEventListener(Event.COMPLETE,this.onContainerCompleteHandler);
         this.divisionRewards.addEventListener(Event.CHANGE,this.onDivisionRewardsEventChangeHandler);
         this.qualificationRewards.addEventListener(Event.COMPLETE,this.onContainerCompleteHandler);
         this._cont.alpha = Values.ZERO;
         this.qualificationRewards.visible = false;
         this.divisionRewards.visible = false;
         this.divisionRewards.view = this;
         App.stageSizeMgr.register(this);
         this.divisionSelector.addEventListener(IndexEvent.INDEX_CHANGE,this.onDivisionSelectorIndexChangeHandler);
         super.onPopulate();
      }
      
      override protected function draw() : void
      {
         var _loc1_:Boolean = false;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         super.draw();
         if(this._divisions)
         {
            if(isInvalid(INV_DIVISIONS))
            {
               this.updateDivisionData();
               invalidateSize();
            }
            if(isInvalid(INV_REWARD_REQUEST))
            {
               this.requestData();
            }
         }
         if(this._rewards && isInvalid(INV_REWARDS))
         {
            if(this._isQualification)
            {
               this.qualificationRewards.setData(this._rewards);
            }
            else
            {
               this.divisionRewards.setData(this._rewards);
            }
            invalidateSize();
         }
         if(isInvalid(InvalidationType.SIZE,INV_VIEW_PADDING))
         {
            this._containerGlobalLeftShift = Boolean(viewPadding) ? Number(viewPadding.left >> 1) : Number(Values.ZERO);
            this.divisionSelector.x = (_width - this.divisionSelector.width >> 1) - this._containerGlobalLeftShift;
            _loc1_ = this._divisionHeightID == DIVISION_HEIGHT_ID_SHORT;
            this.divisionSelector.isShort = _loc1_;
            this.divisionSelector.y = !!_loc1_ ? Number(DIVISION_SELECTOR_TOP_POSITION_SHORT) : Number(DIVISION_SELECTOR_TOP_POSITION_HIGH);
            _loc2_ = this.divisionSelector.y + this.divisionSelector.height + REWARDS_Y_OFFSET;
            this.divisionRewards.y = this.qualificationRewards.y = _loc2_;
            _loc3_ = height - _loc2_;
            this.divisionRewards.setSize(width,_loc3_);
            this.qualificationRewards.setSize(width,_loc3_);
         }
      }
      
      override protected function onBeforeDispose() : void
      {
         this.clearContentTween();
         this.divisionSelector.removeEventListener(IndexEvent.INDEX_CHANGE,this.onDivisionSelectorIndexChangeHandler);
         this.divisionRewards.removeEventListener(Event.COMPLETE,this.onContainerCompleteHandler);
         this.divisionRewards.removeEventListener(Event.CHANGE,this.onDivisionRewardsEventChangeHandler);
         this.qualificationRewards.removeEventListener(Event.COMPLETE,this.onContainerCompleteHandler);
         super.onBeforeDispose();
      }
      
      override protected function onDispose() : void
      {
         this.divisionRewards.mask = null;
         this.divisionRewards.dispose();
         this.divisionRewards = null;
         this.divisionSelector.dispose();
         this.divisionSelector = null;
         this.qualificationRewards.dispose();
         this.qualificationRewards = null;
         this._rewards = null;
         this._divisions = null;
         removeChild(this._cont);
         this._cont = null;
         super.onDispose();
      }
      
      override protected function setRewards(param1:Vector.<RewardsRankRendererVO>, param2:Boolean) : void
      {
         this._rewards = param1;
         invalidate(INV_REWARDS);
      }
      
      override protected function setDivisionsData(param1:Vector.<DivisionVO>, param2:Boolean) : void
      {
         this._divisions = param1;
         this._updateDivisionsImmediately = param2;
         invalidate(INV_DIVISIONS);
         if(param2 || this._nextDataIndex == Values.DEFAULT_INT)
         {
            invalidate(INV_REWARD_REQUEST);
         }
      }
      
      public function setStateSizeBoundaries(param1:int, param2:int) : void
      {
         var _loc3_:String = param2 >= StageSizeBoundaries.HEIGHT_800 ? DIVISION_HEIGHT_ID_HIGH : DIVISION_HEIGHT_ID_SHORT;
         if(this._divisionHeightID != _loc3_)
         {
            this._divisionHeightID = _loc3_;
            invalidateSize();
         }
      }
      
      private function clearContentTween() : void
      {
         if(this._contentTween)
         {
            this._contentTween.paused = true;
            this._contentTween.dispose();
            this._contentTween = null;
         }
      }
      
      private function showHideContent(param1:Boolean) : void
      {
         this.clearContentTween();
         var _loc2_:Number = !!param1 ? Number(Values.DEFAULT_ALPHA) : Number(Values.ZERO);
         var _loc3_:Function = !!param1 ? SHOW_HIDE_TWEEN_EASING_SHOW : SHOW_HIDE_TWEEN_EASING_HIDE;
         if(this._cont.alpha != _loc2_)
         {
            this._contentTween = new Tween(SHOW_HIDE_TWEEN_DURATION,this._cont,{"alpha":_loc2_},{
               "paused":false,
               "ease":_loc3_,
               "onComplete":this.onContentAnimCompleted
            });
         }
         else
         {
            this.onContentAnimCompleted(null);
         }
      }
      
      private function onContentAnimCompleted(param1:Tween) : void
      {
         if(this._cont.alpha == Values.ZERO)
         {
            invalidate(INV_REWARD_REQUEST);
         }
      }
      
      private function updateDivisionData() : void
      {
         this.divisionSelector.setData(this._divisions,this._updateDivisionsImmediately,SHOW_HIDE_TWEEN_DURATION,SHOW_HIDE_TWEEN_EASING_SHOW,SHOW_HIDE_TWEEN_EASING_HIDE);
         var _loc1_:int = this._divisions.length;
         var _loc2_:int = 0;
         while(_loc2_ < _loc1_)
         {
            if(this._divisions[_loc2_].isCurrent)
            {
               this._isQualification = this._divisions[_loc2_].isQualification;
               this._nextDataIndex = _loc2_;
               break;
            }
            _loc2_++;
         }
      }
      
      private function requestData() : void
      {
         var _loc1_:String = !!this._isQualification ? this.qualificationRewards.rewardsIconSize : this.divisionRewards.rewardsIconSize;
         var _loc2_:int = !!this._isQualification ? int(this.qualificationRewards.rewardsCount) : int(this.divisionRewards.rewardsCount);
         if(StringUtils.isNotEmpty(_loc1_) && _loc2_ >= 0)
         {
            onRequestDataS(this._nextDataIndex,_loc1_,_loc2_);
         }
      }
      
      private function onContainerCompleteHandler(param1:Event) : void
      {
         this.showHideContent(true);
         this.qualificationRewards.visible = this._isQualification;
         this.divisionRewards.visible = !this._isQualification;
         if(this._nextDataIndex != Values.DEFAULT_INT)
         {
            this.divisionSelector.setSelectedIndex(this._nextDataIndex,false);
         }
      }
      
      private function onDivisionSelectorIndexChangeHandler(param1:IndexEvent) : void
      {
         this._nextDataIndex = param1.index;
         if(param1.lastIndex == Values.DEFAULT_INT)
         {
            return;
         }
         var _loc2_:DivisionVO = this._divisions[this._nextDataIndex];
         this._isQualification = _loc2_.isQualification;
         this.showHideContent(false);
      }
      
      private function onDivisionRewardsEventChangeHandler(param1:Event) : void
      {
         if(!this._isQualification)
         {
            invalidate(INV_REWARD_REQUEST);
         }
      }
   }
}
