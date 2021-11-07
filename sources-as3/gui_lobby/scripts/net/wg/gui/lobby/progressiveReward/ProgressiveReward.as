package net.wg.gui.lobby.progressiveReward
{
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import net.wg.data.constants.BaseTooltips;
   import net.wg.data.constants.Linkages;
   import net.wg.data.constants.generated.PROGRESSIVEREWARD_CONSTANTS;
   import net.wg.data.managers.impl.TooltipProps;
   import net.wg.gui.interfaces.ISoundButtonEx;
   import net.wg.gui.lobby.hangar.seniorityAwards.SeniorityAwardsEntryPoint;
   import net.wg.gui.lobby.progressiveReward.data.ProgressiveRewardStepVO;
   import net.wg.gui.lobby.progressiveReward.data.ProgressiveRewardVO;
   import net.wg.gui.lobby.progressiveReward.events.ProgressiveRewardEvent;
   import net.wg.infrastructure.base.UIComponentEx;
   import net.wg.infrastructure.managers.ITooltipMgr;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.events.ButtonEvent;
   
   public class ProgressiveReward extends UIComponentEx
   {
      
      private static const REWARD_PROGRESS_Y_OFFSET:int = 37;
      
      private static const BASE_REWARD_Y:int = 0;
      
      private static const H_ALIGNED_WIDTH:int = 503;
      
      private static const H_ALIGNED_DESC_WIDTH:int = 310;
      
      private static const V_ALIGNED_DESC_WIDTH:int = 270;
      
      private static const H_ALIGNED_REWARD_X_OFFSET:int = -20;
      
      private static const SENIORITY_AWARDS_OFFSET_Y:int = -35;
       
      
      public var titleTF:TextField = null;
      
      public var linkBtn:ISoundButtonEx = null;
      
      public var descTF:TextField = null;
      
      public var bgMc:MovieClip = null;
      
      public var rewardMc:MovieClip = null;
      
      public var lockMc:MovieClip = null;
      
      public var rewardsProgress:ProgressiveRewardProgress = null;
      
      private var _seniorityAwards:SeniorityAwardsEntryPoint = null;
      
      private var _progressiveData:ProgressiveRewardVO = null;
      
      private var _rewardTooltipProps:TooltipProps;
      
      private var _tooltipMgr:ITooltipMgr = null;
      
      public function ProgressiveReward()
      {
         this._rewardTooltipProps = new TooltipProps(BaseTooltips.TYPE_INFO,0,0,0,-1,0,350);
         super();
      }
      
      override protected function onDispose() : void
      {
         this.rewardsProgress.removeEventListener(Event.RESIZE,this.onRewardsProgressResizeHandler);
         this.linkBtn.removeEventListener(ButtonEvent.CLICK,this.onLinkBtnClickHandler);
         this.rewardMc.removeEventListener(MouseEvent.ROLL_OVER,this.onRewardMcRollOverHandler);
         this.rewardMc.removeEventListener(MouseEvent.ROLL_OUT,this.onRewardMcRollOutHandler);
         this.rewardMc.removeEventListener(MouseEvent.CLICK,this.onRewardMcClickHandler);
         this.bgMc = null;
         this.titleTF = null;
         this.descTF = null;
         this.rewardMc = null;
         this.lockMc = null;
         this.linkBtn.dispose();
         this.linkBtn = null;
         this.rewardsProgress.dispose();
         this.rewardsProgress = null;
         this._progressiveData = null;
         this._tooltipMgr = null;
         this._rewardTooltipProps = null;
         if(this._seniorityAwards)
         {
            this._seniorityAwards.dispose();
            this._seniorityAwards = null;
         }
         super.onDispose();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this._tooltipMgr = App.toolTipMgr;
         this.rewardsProgress.addEventListener(Event.RESIZE,this.onRewardsProgressResizeHandler);
         this.linkBtn.addEventListener(ButtonEvent.CLICK,this.onLinkBtnClickHandler);
         this.lockMc.mouseEnabled = false;
         this.lockMc.mouseChildren = false;
         this.rewardsProgress.mouseChildren = false;
         this.rewardsProgress.mouseEnabled = false;
         this.rewardMc.buttonMode = true;
         this.rewardMc.mouseChildren = false;
         this.rewardMc.addEventListener(MouseEvent.ROLL_OVER,this.onRewardMcRollOverHandler);
         this.rewardMc.addEventListener(MouseEvent.ROLL_OUT,this.onRewardMcRollOutHandler);
         this.rewardMc.addEventListener(MouseEvent.CLICK,this.onRewardMcClickHandler);
      }
      
      override protected function draw() : void
      {
         var _loc1_:Boolean = false;
         super.draw();
         if(this._progressiveData)
         {
            if(isInvalid(InvalidationType.DATA))
            {
               this.bgMc.visible = this._progressiveData.showBg;
               _loc1_ = this._progressiveData.seniorityAwards != null;
               if(!_loc1_ && this._progressiveData.isEnabled)
               {
                  this.createSteps();
                  this.linkBtn.tooltip = this._progressiveData.btnTooltip;
               }
               this.rewardMc.visible = this.rewardsProgress.visible = !_loc1_ && this._progressiveData.isEnabled;
               this.linkBtn.visible = this._progressiveData.showLinkBtn;
               this.rewardMc.mouseEnabled = this._progressiveData.showLinkBtn;
               this.titleTF.htmlText = this._progressiveData.titleText;
               App.utils.commons.updateTextFieldSize(this.titleTF,true,false);
               this.descTF.htmlText = this._progressiveData.descText;
               invalidateSize();
            }
            if(isInvalid(InvalidationType.SIZE))
            {
               this.updatePositions();
            }
         }
      }
      
      public function setData(param1:ProgressiveRewardVO) : void
      {
         this._progressiveData = param1;
         if(param1.seniorityAwards && !this._seniorityAwards)
         {
            this._seniorityAwards = App.utils.classFactory.getComponent(Linkages.SENIORITY_AWARDS_WIDGET_BLOCK,SeniorityAwardsEntryPoint);
            addChild(this._seniorityAwards);
         }
         if(this._seniorityAwards)
         {
            this._seniorityAwards.setDataVO(param1.seniorityAwards);
         }
         invalidateData();
      }
      
      private function updatePositions() : void
      {
         var _loc1_:Boolean = this._progressiveData.widgetAlign == PROGRESSIVEREWARD_CONSTANTS.WIDGET_LAYOUT_V;
         this.linkBtn.x = this.titleTF.x + this.titleTF.width | 0;
         this.descTF.width = !!_loc1_ ? Number(V_ALIGNED_DESC_WIDTH) : Number(H_ALIGNED_DESC_WIDTH);
         App.utils.commons.updateTextFieldSize(this.descTF,false);
         if(_loc1_)
         {
            this.rewardMc.x = this.descTF.x + V_ALIGNED_DESC_WIDTH - this.rewardMc.width >> 1;
            this.rewardMc.y = this.descTF.y + this.descTF.height | 0;
         }
         else
         {
            if(this._progressiveData.showBg)
            {
               this.bgMc.x = H_ALIGNED_WIDTH - this.bgMc.width | 0;
               this.rewardMc.x = H_ALIGNED_WIDTH - this.rewardMc.width + H_ALIGNED_REWARD_X_OFFSET | 0;
            }
            else
            {
               this.rewardMc.x = this.descTF.x + H_ALIGNED_DESC_WIDTH | 0;
            }
            this.rewardMc.y = BASE_REWARD_Y;
         }
         if(this._progressiveData.seniorityAwards)
         {
            this._seniorityAwards.y = this.descTF.y + this.descTF.textHeight + SENIORITY_AWARDS_OFFSET_Y;
         }
         else
         {
            this.lockMc.x = this.rewardMc.x + (this.rewardMc.width - this.lockMc.width >> 1) | 0;
            this.lockMc.y = this.rewardMc.y + (this.rewardMc.height - this.lockMc.height >> 1) | 0;
            this.rewardsProgress.x = this.rewardMc.x + (this.rewardMc.width - this.rewardsProgress.actualWidth >> 1) | 0;
            this.rewardsProgress.y = this.rewardMc.y + this.rewardMc.height - this.rewardsProgress.actualHeight + REWARD_PROGRESS_Y_OFFSET | 0;
         }
         dispatchEvent(new Event(Event.RESIZE,true,true));
      }
      
      private function createSteps() : void
      {
         var _loc4_:String = null;
         var _loc1_:Vector.<ProgressiveRewardStepVO> = this._progressiveData.getSteps();
         var _loc2_:ProgressiveRewardStepVO = _loc1_[this._progressiveData.stepIdx];
         var _loc3_:String = _loc2_.rewardType;
         App.utils.asserter.assertFrameExists(_loc3_,this.rewardMc);
         this.rewardMc.gotoAndStop(_loc3_);
         if(!this._progressiveData.seniorityAwards)
         {
            _loc4_ = _loc2_.stepState;
            App.utils.asserter.assertFrameExists(_loc4_,this.lockMc);
            this.lockMc.gotoAndStop(_loc4_);
         }
         this.rewardsProgress.update(this._progressiveData);
      }
      
      private function handleWidgetClick() : void
      {
         dispatchEvent(new ProgressiveRewardEvent(ProgressiveRewardEvent.LINK_BTN_CLICK));
      }
      
      private function onRewardMcClickHandler(param1:MouseEvent) : void
      {
         this.handleWidgetClick();
      }
      
      private function onRewardMcRollOutHandler(param1:MouseEvent) : void
      {
         this._tooltipMgr.hide();
      }
      
      private function onRewardMcRollOverHandler(param1:MouseEvent) : void
      {
         this._tooltipMgr.showComplex(this._progressiveData.rewardTooltip,this._rewardTooltipProps);
      }
      
      private function onLinkBtnClickHandler(param1:ButtonEvent) : void
      {
         this.handleWidgetClick();
      }
      
      private function onRewardsProgressResizeHandler(param1:Event) : void
      {
         invalidateSize();
      }
   }
}
