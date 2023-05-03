package net.wg.gui.battle.views.perksPanel.components
{
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import net.wg.data.constants.BaseTooltips;
   import net.wg.data.constants.InvalidationType;
   import net.wg.data.constants.Time;
   import net.wg.data.constants.Values;
   import net.wg.data.managers.impl.TooltipProps;
   import net.wg.gui.battle.components.BattleUIComponent;
   import net.wg.gui.battle.views.perksPanel.data.PerkItemVO;
   import net.wg.gui.battle.views.perksPanel.events.PerkItemEvent;
   import net.wg.gui.bootcamp.containers.AnimatedLoaderTextContainer;
   import net.wg.gui.utils.FrameHelper;
   import net.wg.infrastructure.managers.ITooltipMgr;
   import scaleform.clik.motion.Tween;
   
   public class PerkItem extends BattleUIComponent
   {
      
      private static const PROGRESS_TOTAL_FRAMES:int = 164;
      
      private static const SHOW_FRAME:String = "show";
      
      private static const PROGRESS_DIS_FRAME:String = "progressDis";
      
      private static const EVENT_DIS_FRAME:String = "eventDis";
      
      private static const END_FRAME:String = "Last";
      
      private static const TOOLTIP_DELAY:int = 400;
      
      public static const INVALIDATE_STATE:uint = 1 << 17;
       
      
      public var progress:MovieClip = null;
      
      public var iconContainer:AnimatedLoaderTextContainer = null;
      
      public var iconBackContainer:AnimatedLoaderTextContainer = null;
      
      private var _progressValue:int = -1;
      
      private var _frameHelper:FrameHelper = null;
      
      private var _progressTween:Tween = null;
      
      private var _perkName:String = "";
      
      private var _duration:Number = -1;
      
      private var _lifeTime:Number = -1;
      
      private var _state:int = -1;
      
      private var _tooltipMgr:ITooltipMgr;
      
      public function PerkItem()
      {
         this._tooltipMgr = App.toolTipMgr;
         super();
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         this._frameHelper = new FrameHelper(this);
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         addEventListener(MouseEvent.ROLL_OVER,this.onRollOverHandler);
         addEventListener(MouseEvent.ROLL_OUT,this.onRollOutHandler);
         this.iconContainer.mouseChildren = this.iconContainer.mouseEnabled = false;
         hitArea = this.iconBackContainer;
      }
      
      override protected function draw() : void
      {
         if(isInvalid(InvalidationType.DATA))
         {
            this.updateProgress();
         }
         if(isInvalid(INVALIDATE_STATE))
         {
            switch(this._state)
            {
               case PerkItemVO.STATE_ACTIVE:
                  this.show();
                  break;
               case PerkItemVO.STATE_INACTIVE:
                  this.hide();
            }
         }
      }
      
      override protected function onDispose() : void
      {
         if(this._progressTween)
         {
            this._progressTween.dispose();
            this._progressTween = null;
         }
         this._frameHelper.dispose();
         this._frameHelper = null;
         this.iconContainer.dispose();
         this.iconContainer = null;
         this.iconBackContainer.dispose();
         this.iconBackContainer = null;
         this.progress = null;
         removeEventListener(MouseEvent.ROLL_OVER,this.onRollOverHandler);
         removeEventListener(MouseEvent.ROLL_OUT,this.onRollOutHandler);
         this._tooltipMgr.hide();
         this._tooltipMgr = null;
         super.onDispose();
      }
      
      public function update(param1:int, param2:Number, param3:Number) : void
      {
         if(this._duration != param2 || this._lifeTime != param3)
         {
            this._duration = param2;
            this._lifeTime = param3;
            invalidateData();
         }
         this.state = param1;
      }
      
      private function hide() : void
      {
         var _loc1_:String = this._lifeTime != Values.DEFAULT_INT ? PROGRESS_DIS_FRAME : EVENT_DIS_FRAME;
         var _loc2_:int = this._frameHelper.getFrameByLabel(_loc1_ + END_FRAME);
         this._frameHelper.addScriptToFrame(_loc2_,this.onHideAnimComplete);
         gotoAndPlay(_loc1_);
      }
      
      private function show() : void
      {
         var _loc1_:int = this._frameHelper.getFrameByLabel(SHOW_FRAME + END_FRAME);
         this._frameHelper.addScriptToFrame(_loc1_,this.onShowAnimComplete);
         gotoAndPlay(SHOW_FRAME);
      }
      
      private function updateProgress() : void
      {
         var _loc1_:int = 0;
         if(this._lifeTime != Values.DEFAULT_INT)
         {
            _loc1_ = this._lifeTime * Time.MILLISECOND_IN_SECOND;
            if(this._progressTween)
            {
               this._progressTween.paused = true;
               this._progressTween.dispose();
            }
            this.progressValue = 1 + Math.round(PROGRESS_TOTAL_FRAMES * (this._duration - this._lifeTime) / this._duration) >> 0;
            this._progressTween = new Tween(_loc1_,this,{"progressValue":PROGRESS_TOTAL_FRAMES},{"onComplete":this.onProgressTweenComplete});
         }
      }
      
      private function onProgressTweenComplete() : void
      {
         this.progress.gotoAndStop(PROGRESS_TOTAL_FRAMES);
      }
      
      private function onShowAnimComplete() : void
      {
         this._frameHelper.removeScriptFromFrame(this._frameHelper.getFrameByLabel(END_FRAME));
         gotoAndStop(this._frameHelper.getFrameByLabel(END_FRAME));
         dispatchEvent(new PerkItemEvent(PerkItemEvent.SHOW_ANIM_COMPLETE,true,true));
      }
      
      private function onHideAnimComplete() : void
      {
         this._tooltipMgr.hide();
         var _loc1_:String = this._lifeTime != -1 ? PROGRESS_DIS_FRAME : EVENT_DIS_FRAME;
         gotoAndStop(this._frameHelper.getFrameByLabel(_loc1_ + END_FRAME));
         if(_baseDisposed)
         {
            return;
         }
         this._frameHelper.removeScriptFromFrame(this._frameHelper.getFrameByLabel(_loc1_ + END_FRAME));
         dispatchEvent(new PerkItemEvent(PerkItemEvent.HIDE_ANIM_COMPLETE,true,true));
      }
      
      public function get perkName() : String
      {
         return this._perkName;
      }
      
      public function set perkName(param1:String) : void
      {
         if(this._perkName == param1)
         {
            return;
         }
         this._perkName = param1;
         this.iconContainer.source = this.iconBackContainer.source = RES_ICONS.getPerkIcon(this._perkName);
      }
      
      public function get progressValue() : int
      {
         return this._progressValue;
      }
      
      public function set progressValue(param1:int) : void
      {
         if(this._progressValue == param1)
         {
            return;
         }
         this._progressValue = param1;
         this.progress.gotoAndStop(this._progressValue);
      }
      
      public function set state(param1:int) : void
      {
         if(this._state == param1)
         {
            return;
         }
         this._state = param1;
         invalidate(INVALIDATE_STATE);
      }
      
      private function onRollOverHandler(param1:MouseEvent) : void
      {
         var _loc2_:String = this._tooltipMgr.getNewFormatter().addHeader(CREW_PERKS.getPerkName(this._perkName),true).addBody(CREW_PERKS.gePerkHudDescription(this._perkName),true).make();
         this._tooltipMgr.showComplex(_loc2_,new TooltipProps(BaseTooltips.TYPE_INFO,0,0,0,Values.DEFAULT_INT,0,TOOLTIP_DELAY));
      }
      
      private function onRollOutHandler(param1:MouseEvent) : void
      {
         this._tooltipMgr.hide();
      }
   }
}
