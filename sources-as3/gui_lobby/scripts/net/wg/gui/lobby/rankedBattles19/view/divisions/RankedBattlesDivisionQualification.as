package net.wg.gui.lobby.rankedBattles19.view.divisions
{
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import net.wg.data.constants.generated.TEXT_MANAGER_STYLES;
   import net.wg.data.constants.generated.TOOLTIPS_CONSTANTS;
   import net.wg.gui.components.controls.Image;
   import net.wg.gui.lobby.rankedBattles19.components.stats.RankedBattleStats;
   import net.wg.gui.lobby.rankedBattles19.constants.StatsConsts;
   import net.wg.gui.lobby.rankedBattles19.data.RankedBattlesStatsVO;
   import net.wg.gui.lobby.rankedBattles19.view.RankedBattlesViewHelper;
   import net.wg.infrastructure.base.meta.IRankedBattlesDivisionQualificationMeta;
   import net.wg.infrastructure.base.meta.impl.RankedBattlesDivisionQualificationMeta;
   import net.wg.infrastructure.managers.ITooltipMgr;
   import net.wg.utils.IStageSizeDependComponent;
   import net.wg.utils.StageSizeBoundaries;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.motion.Tween;
   
   public class RankedBattlesDivisionQualification extends RankedBattlesDivisionQualificationMeta implements IRankedBattlesDivisionQualificationMeta, IStageSizeDependComponent
   {
      
      private static const STATS_H_OFFSET_BIG:int = 280;
      
      private static const STATS_H_OFFSET_SMALL:int = 220;
      
      private static const MAX_BG_WIDTH:int = 1600;
      
      private static const ICON_V_OFFSET_SMALL:int = -40;
      
      private static const ICON_V_OFFSET_BIG:int = -60;
      
      private static const BG_V_OFFSET_SMALL:int = -3;
      
      private static const BG_V_OFFSET_BIG:int = -5;
      
      private static const BG_HEIGHT_SMALL:int = 120;
      
      private static const BG_HEIGHT_BIG:int = 160;
      
      private static const STATS_V_OFFSET_BIG:int = 55;
      
      private static const STATS_V_OFFSET_SMALL:int = 20;
      
      private static const ICON_FADE_DURATION:int = 400;
      
      private static const ICON_FADE_DELAY:int = 0;
      
      private static const STATS_FADE_DURATION:int = 400;
      
      private static const STATS_FADE_DELAY:int = 200;
      
      private static const QUAL_COUNTER_FADE_DURATION:int = 400;
      
      private static const QUAL_COUNTER_FADE_DELAY:int = 400;
      
      private static const QUAL_DESCR_X_OFFSET:int = -12;
      
      private static const Y_OFFSETS:Object = {};
      
      private static const QUAL_COUNTER_Y_OFFSETS:Object = {};
      
      private static const QUAL_DESCR_Y_OFFSETS:Object = {};
      
      {
         Y_OFFSETS[RankedBattlesViewHelper.SIZE_HUGE] = -65;
         Y_OFFSETS[RankedBattlesViewHelper.SIZE_BIG] = -72;
         Y_OFFSETS[RankedBattlesViewHelper.SIZE_SMALL] = -51;
         QUAL_COUNTER_Y_OFFSETS[RankedBattlesViewHelper.SIZE_HUGE] = 135;
         QUAL_COUNTER_Y_OFFSETS[RankedBattlesViewHelper.SIZE_BIG] = 100;
         QUAL_COUNTER_Y_OFFSETS[RankedBattlesViewHelper.SIZE_SMALL] = 91;
         QUAL_DESCR_Y_OFFSETS[RankedBattlesViewHelper.SIZE_HUGE] = 15;
         QUAL_DESCR_Y_OFFSETS[RankedBattlesViewHelper.SIZE_BIG] = 5;
         QUAL_DESCR_Y_OFFSETS[RankedBattlesViewHelper.SIZE_SMALL] = 5;
      }
      
      public var rankIcon:Image = null;
      
      public var efficiencyStats:RankedBattleStats = null;
      
      public var stepsStats:RankedBattleStats = null;
      
      public var bg:Sprite = null;
      
      public var qualCounterTf:TextField = null;
      
      public var qualDescrTf:TextField = null;
      
      private var _iconContainer:Sprite = null;
      
      private var _statsContainer:Sprite = null;
      
      private var _qualCounterContainer:Sprite = null;
      
      private var _tweens:Vector.<Tween> = null;
      
      private var _smallImageSrc:String = "";
      
      private var _bigImageSrc:String = "";
      
      private var _progressTextSmall:String = "";
      
      private var _progressTextBig:String = "";
      
      private var _qualDescr:String = "";
      
      private var _isSmall:Boolean = false;
      
      private var _tooltipMgr:ITooltipMgr = null;
      
      private var _isCompleted:Boolean = false;
      
      private var _isFirstEnter:Boolean = false;
      
      private var _viewHelper:RankedBattlesViewHelper = null;
      
      private var _viewSizeId:String = "small";
      
      public function RankedBattlesDivisionQualification()
      {
         super();
         this._qualCounterContainer = new Sprite();
         this._iconContainer = new Sprite();
         this._statsContainer = new Sprite();
         addChild(this._qualCounterContainer);
         addChild(this._iconContainer);
         addChild(this._statsContainer);
         this._qualCounterContainer.addChild(this.qualCounterTf);
         this._qualCounterContainer.addChild(this.qualDescrTf);
         this._iconContainer.addChild(this.rankIcon);
         this._statsContainer.addChild(this.efficiencyStats);
         this._statsContainer.addChild(this.stepsStats);
         this._qualCounterContainer.alpha = 0;
         this._iconContainer.alpha = 0;
         this._statsContainer.alpha = 0;
         this._tweens = new Vector.<Tween>(0);
         this._viewHelper = RankedBattlesViewHelper.getInstance();
      }
      
      override protected function setQualificationEfficiencyData(param1:RankedBattlesStatsVO) : void
      {
         this.efficiencyStats.setData(param1);
      }
      
      override protected function setQualificationStepsData(param1:RankedBattlesStatsVO) : void
      {
         this.stepsStats.setData(param1);
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.efficiencyStats.addEventListener(MouseEvent.ROLL_OVER,this.onStatsDeltaRollOverHandler);
         this.efficiencyStats.addEventListener(MouseEvent.ROLL_OUT,this.onStatsDeltaRollOutHandler);
         this.efficiencyStats.valueStyleBig = TEXT_MANAGER_STYLES.GRAND_TITLE;
         this.efficiencyStats.valueStyleSmall = TEXT_MANAGER_STYLES.SUPER_PROMO_TITLE;
         this.efficiencyStats.iconSizeBig = StatsConsts.ICON_SIZE_84;
         this.efficiencyStats.iconSizeSmall = StatsConsts.ICON_SIZE_64;
         this.stepsStats.addEventListener(MouseEvent.ROLL_OVER,this.onStatsInfoRollOverHandler);
         this.stepsStats.addEventListener(MouseEvent.ROLL_OUT,this.onStatsInfoRollOutHandler);
         this.stepsStats.valueStyleBig = TEXT_MANAGER_STYLES.GRAND_TITLE;
         this.stepsStats.valueStyleSmall = TEXT_MANAGER_STYLES.SUPER_PROMO_TITLE;
         this.stepsStats.iconSizeBig = StatsConsts.ICON_SIZE_84;
         this.stepsStats.iconSizeSmall = StatsConsts.ICON_SIZE_64;
         this.rankIcon.addEventListener(Event.CHANGE,this.onRankIconChangeHandler);
         this.rankIcon.addEventListener(MouseEvent.ROLL_OVER,this.onRankRollOverHandler);
         this.rankIcon.addEventListener(MouseEvent.ROLL_OUT,this.onRankRollOutHandler);
         this._tooltipMgr = App.toolTipMgr;
         App.stageSizeMgr.register(this);
      }
      
      override protected function onDispose() : void
      {
         this.efficiencyStats.removeEventListener(MouseEvent.ROLL_OVER,this.onStatsDeltaRollOverHandler);
         this.efficiencyStats.removeEventListener(MouseEvent.ROLL_OUT,this.onStatsDeltaRollOutHandler);
         this.efficiencyStats.dispose();
         this.efficiencyStats = null;
         this.stepsStats.removeEventListener(MouseEvent.ROLL_OVER,this.onStatsInfoRollOverHandler);
         this.stepsStats.removeEventListener(MouseEvent.ROLL_OUT,this.onStatsInfoRollOutHandler);
         this.stepsStats.dispose();
         this.stepsStats = null;
         this.rankIcon.removeEventListener(Event.CHANGE,this.onRankIconChangeHandler);
         this.rankIcon.removeEventListener(MouseEvent.ROLL_OVER,this.onRankRollOverHandler);
         this.rankIcon.removeEventListener(MouseEvent.ROLL_OUT,this.onRankRollOutHandler);
         this.rankIcon.dispose();
         this.rankIcon.filters = null;
         this.rankIcon = null;
         this.qualCounterTf = null;
         this.qualDescrTf = null;
         this.bg = null;
         removeChild(this._qualCounterContainer);
         removeChild(this._iconContainer);
         removeChild(this._statsContainer);
         this._qualCounterContainer = null;
         this._iconContainer = null;
         this._statsContainer = null;
         this._tooltipMgr = null;
         this._viewHelper = null;
         this.clearTweens();
         this._tweens = null;
         super.onDispose();
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(InvalidationType.DATA))
         {
            if(this._isFirstEnter)
            {
               this._isFirstEnter = false;
               this._qualCounterContainer.alpha = 0;
               this._iconContainer.alpha = 0;
               this._statsContainer.alpha = 0;
               this.clearTweens();
               this._tweens.push(new Tween(ICON_FADE_DURATION,this._iconContainer,{"alpha":1},{
                  "paused":false,
                  "delay":ICON_FADE_DELAY
               }));
               this._tweens.push(new Tween(STATS_FADE_DURATION,this._statsContainer,{"alpha":1},{
                  "paused":false,
                  "delay":STATS_FADE_DELAY
               }));
               this._tweens.push(new Tween(QUAL_COUNTER_FADE_DURATION,this._qualCounterContainer,{"alpha":1},{
                  "paused":false,
                  "delay":QUAL_COUNTER_FADE_DELAY
               }));
            }
            else
            {
               this._qualCounterContainer.alpha = 1;
               this._iconContainer.alpha = 1;
               this._statsContainer.alpha = 1;
            }
            if(this._isCompleted)
            {
               App.utils.commons.setSaturation(this.rankIcon,0);
            }
            else
            {
               this.rankIcon.filters = null;
            }
            this.qualCounterTf.visible = !this._isCompleted;
            this.qualDescrTf.htmlText = this._qualDescr;
            invalidateLayout();
         }
         if(isInvalid(InvalidationType.LAYOUT) || isInvalid(InvalidationType.SIZE))
         {
            this.rankIcon.source = !!this._isSmall ? this._smallImageSrc : this._bigImageSrc;
            if(this.qualCounterTf.visible)
            {
               this.qualCounterTf.htmlText = !!this._isSmall ? this._progressTextSmall : this._progressTextBig;
            }
            this.updateLayoutHorizontal();
            this.updateLayoutVertical();
         }
      }
      
      public function as_setQualificationData(param1:String, param2:String, param3:Boolean) : void
      {
         this._smallImageSrc = param1;
         this._bigImageSrc = param2;
         this._isFirstEnter = param3;
         invalidateData();
      }
      
      public function as_setQualificationProgress(param1:String, param2:String, param3:Boolean, param4:String) : void
      {
         this._progressTextSmall = param1;
         this._progressTextBig = param2;
         this._isCompleted = param3;
         this._qualDescr = param4;
         invalidateData();
      }
      
      public function setStateSizeBoundaries(param1:int, param2:int) : void
      {
         this._viewSizeId = this._viewHelper.getSizeId(param1,param2);
         this._isSmall = param1 < StageSizeBoundaries.WIDTH_1920 || param2 < StageSizeBoundaries.HEIGHT_900;
         if(this._isSmall)
         {
            this.efficiencyStats.minimize();
            this.stepsStats.minimize();
         }
         else
         {
            this.efficiencyStats.maximize();
            this.stepsStats.maximize();
         }
         invalidateLayout();
      }
      
      private function clearTweens() : void
      {
         var _loc1_:Tween = null;
         for each(_loc1_ in this._tweens)
         {
            _loc1_.paused = true;
            _loc1_.dispose();
         }
         this._tweens.length = 0;
      }
      
      private function updateLayoutHorizontal() : void
      {
         this.rankIcon.x = width - this.rankIcon.width >> 1;
         var _loc1_:int = width - 2 * viewPadding.left;
         this.bg.width = Math.min(_loc1_,MAX_BG_WIDTH);
         this.bg.x = width - this.bg.width >> 1;
         if(this.qualCounterTf.visible)
         {
            this.qualCounterTf.x = this.rankIcon.x + (this.rankIcon.width - this.qualCounterTf.width >> 1);
         }
         this.qualDescrTf.x = this.rankIcon.x + (this.rankIcon.width - this.qualDescrTf.width >> 1);
         this.qualDescrTf.x += !!this._isCompleted ? QUAL_DESCR_X_OFFSET : 0;
         var _loc2_:int = width >> 1;
         if(this._isSmall)
         {
            this.efficiencyStats.x = _loc2_ - STATS_H_OFFSET_SMALL;
            this.stepsStats.x = _loc2_ + STATS_H_OFFSET_SMALL;
         }
         else
         {
            this.efficiencyStats.x = _loc2_ - STATS_H_OFFSET_BIG;
            this.stepsStats.x = _loc2_ + STATS_H_OFFSET_BIG;
         }
      }
      
      private function updateLayoutVertical() : void
      {
         this.rankIcon.y = (_height - this.rankIcon.height >> 1) + (!!this._isSmall ? ICON_V_OFFSET_SMALL : ICON_V_OFFSET_BIG) + Y_OFFSETS[this._viewSizeId];
         this.bg.height = !!this._isSmall ? Number(BG_HEIGHT_SMALL) : Number(BG_HEIGHT_BIG);
         this.bg.y = this.rankIcon.y + (this.rankIcon.height - this.bg.height >> 1);
         if(this.qualCounterTf.visible)
         {
            this.qualCounterTf.y = this.rankIcon.y + this.rankIcon.height + QUAL_COUNTER_Y_OFFSETS[this._viewSizeId];
            this.qualDescrTf.y = this.qualCounterTf.y + this.qualCounterTf.height + QUAL_DESCR_Y_OFFSETS[this._viewSizeId];
         }
         else
         {
            this.qualDescrTf.y = this.rankIcon.y + this.rankIcon.height + QUAL_COUNTER_Y_OFFSETS[this._viewSizeId];
         }
         if(this._isSmall)
         {
            this.bg.y += BG_V_OFFSET_SMALL;
            this.efficiencyStats.y = this.stepsStats.y = this.rankIcon.y + STATS_V_OFFSET_SMALL;
         }
         else
         {
            this.bg.y += BG_V_OFFSET_BIG;
            this.efficiencyStats.y = this.stepsStats.y = this.rankIcon.y + STATS_V_OFFSET_BIG;
         }
      }
      
      private function onRankIconChangeHandler(param1:Event) : void
      {
         invalidateLayout();
      }
      
      private function onStatsDeltaRollOverHandler(param1:MouseEvent) : void
      {
         this._tooltipMgr.showSpecial(TOOLTIPS_CONSTANTS.RANKED_BATTLES_EFFICIENCY,null);
      }
      
      private function onStatsDeltaRollOutHandler(param1:MouseEvent) : void
      {
         this._tooltipMgr.hide();
      }
      
      private function onStatsInfoRollOverHandler(param1:MouseEvent) : void
      {
         this._tooltipMgr.showSpecial(TOOLTIPS_CONSTANTS.RANKED_BATTLES_POSITION,null);
      }
      
      private function onStatsInfoRollOutHandler(param1:MouseEvent) : void
      {
         this._tooltipMgr.hide();
      }
      
      private function onRankRollOverHandler(param1:MouseEvent) : void
      {
         this._tooltipMgr.showSpecial(TOOLTIPS_CONSTANTS.RANKED_BATTLES_RANK,null,0);
      }
      
      private function onRankRollOutHandler(param1:MouseEvent) : void
      {
         this._tooltipMgr.hide();
      }
   }
}
