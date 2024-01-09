package net.wg.gui.lobby.rankedBattles19.view
{
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import flash.text.TextFormat;
   import net.wg.data.constants.Fonts;
   import net.wg.data.constants.generated.TEXT_MANAGER_STYLES;
   import net.wg.data.constants.generated.TOOLTIPS_CONSTANTS;
   import net.wg.gui.components.controls.Image;
   import net.wg.gui.lobby.rankedBattles19.components.BonusBattles;
   import net.wg.gui.lobby.rankedBattles19.components.RankedBattlesPageHeaderHelper;
   import net.wg.gui.lobby.rankedBattles19.components.stats.RankedBattleStats;
   import net.wg.gui.lobby.rankedBattles19.constants.LeagueIconConsts;
   import net.wg.gui.lobby.rankedBattles19.constants.StatsConsts;
   import net.wg.gui.lobby.rankedBattles19.data.LeaguesStatsBlockVO;
   import net.wg.gui.lobby.rankedBattles19.data.LeaguesViewVO;
   import net.wg.gui.lobby.rankedBattles19.data.RankedBattlesStatsDeltaVO;
   import net.wg.gui.lobby.rankedBattles19.data.RankedBattlesStatsInfoVO;
   import net.wg.gui.lobby.rankedBattles19.view.stats.LeaguesStatsBlock;
   import net.wg.infrastructure.base.meta.IRankedBattlesLeaguesViewMeta;
   import net.wg.infrastructure.base.meta.impl.RankedBattlesLeaguesViewMeta;
   import net.wg.infrastructure.managers.ITooltipMgr;
   import net.wg.utils.IStageSizeDependComponent;
   import net.wg.utils.ITextManager;
   import net.wg.utils.StageSizeBoundaries;
   import org.idmedia.as3commons.util.StringUtils;
   import scaleform.clik.constants.InvalidationType;
   
   public class RankedBattlesLeaguesView extends RankedBattlesLeaguesViewMeta implements IRankedBattlesLeaguesViewMeta, IStageSizeDependComponent
   {
      
      private static const SPRINTER_IMG_WIDTH:int = 32;
      
      private static const STATS_H_OFFSET_BIG:int = 300;
      
      private static const STATS_H_OFFSET_SMALL:int = 250;
      
      private static const BG_V_OFFSET_SMALL:int = -55;
      
      private static const BG_V_OFFSET_BIG:int = -75;
      
      private static const BG_HEIGHT_SMALL:int = 120;
      
      private static const BG_HEIGHT_BIG:int = 160;
      
      private static const DESCR_TF_WIDTH_SMALL:int = 500;
      
      private static const DESCR_TF_WIDTH_BIG:int = 600;
      
      private static const DESCR_TF_V_OFFSET_BIG:int = 48;
      
      private static const LEAGUE_ICON_V_OFFSET_BIG:int = 76;
      
      private static const STATS_V_OFFSET_BIG:int = -56;
      
      private static const BONUS_BATTLES_V_OFFSET_BIG:int = 220;
      
      private static const TOP_V_OFFSET_BIG:int = 136;
      
      private static const SPRINTER_IMG_V_OFFSET_BIG:int = 20;
      
      private static const SPRINTER_IMG_H_OFFSET_BIG:int = -14;
      
      private static const DESCR_TF_V_OFFSET_SMALL:int = 35;
      
      private static const LEAGUE_ICON_V_OFFSET_SMALL:int = 63;
      
      private static const STATS_V_OFFSET_SMALL:int = -45;
      
      private static const BONUS_BATTLES_V_OFFSET_SMALL:int = 160;
      
      private static const TOP_V_OFFSET_SMALL:int = 110;
      
      private static const SPRINTER_IMG_V_OFFSET_SMALL:int = 14;
      
      private static const SPRINTER_IMG_H_OFFSET_SMALL:int = -10;
      
      private static const STATS_PADDING_WEIGHT:Number = 0.05;
      
      private static const STATS_PADDING_BOTTOM_MIN:int = 25;
      
      private static const TOP_LIGHT_MC_V_OFFSET:int = 8;
      
      private static const TOP_LIGHT_MC_FRAME_BIG:int = 1;
      
      private static const TOP_LIGHT_MC_FRAME_SMALL:int = 2;
      
      private static const TOP_FORMATS:Object = {};
      
      {
         TOP_FORMATS[RankedBattlesPageHeaderHelper.SIZE_HUGE] = new TextFormat(Fonts.TITLE_FONT,36,16689972);
         TOP_FORMATS[RankedBattlesPageHeaderHelper.SIZE_BIG] = new TextFormat(Fonts.TITLE_FONT,36,16689972);
         TOP_FORMATS[RankedBattlesPageHeaderHelper.SIZE_SMALL] = new TextFormat(Fonts.TITLE_FONT,28,16689972);
      }
      
      public var titleTf:TextField = null;
      
      public var descrTf:TextField = null;
      
      public var sprinterImage:Image = null;
      
      public var leagueIcon:MovieClip = null;
      
      public var statsDelta:RankedBattleStats = null;
      
      public var statsInfo:RankedBattleStats = null;
      
      public var bonusBattles:BonusBattles = null;
      
      public var topMc:MovieClip = null;
      
      public var topLightMc:MovieClip = null;
      
      public var statsBlock:LeaguesStatsBlock = null;
      
      public var bg:Sprite = null;
      
      private var _data:LeaguesViewVO = null;
      
      private var _textMgr:ITextManager = null;
      
      private var _prevBoundariesHeight:int = 0;
      
      private var _isSmall:Boolean = false;
      
      private var _topTf:TextField = null;
      
      private var _tooltipMgr:ITooltipMgr = null;
      
      private var _viewHelper:RankedBattlesViewHelper = null;
      
      private var _viewSizeId:String = "small";
      
      public function RankedBattlesLeaguesView()
      {
         super();
         this._textMgr = App.textMgr;
         this._tooltipMgr = App.toolTipMgr;
         this._viewHelper = RankedBattlesViewHelper.getInstance();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.statsDelta.addEventListener(MouseEvent.ROLL_OVER,this.onStatsDeltaRollOverHandler);
         this.statsDelta.addEventListener(MouseEvent.ROLL_OUT,this.onRollOutHandler);
         this.statsDelta.valueStyleBig = TEXT_MANAGER_STYLES.GRAND_TITLE;
         this.statsDelta.valueStyleSmall = TEXT_MANAGER_STYLES.SUPER_PROMO_TITLE;
         this.statsDelta.iconSizeBig = StatsConsts.ICON_SIZE_84;
         this.statsDelta.iconSizeSmall = StatsConsts.ICON_SIZE_64;
         this.statsInfo.addEventListener(MouseEvent.ROLL_OVER,this.onStatsInfoRollOverHandler);
         this.statsInfo.addEventListener(MouseEvent.ROLL_OUT,this.onRollOutHandler);
         this.statsInfo.valueStyleBig = TEXT_MANAGER_STYLES.GRAND_TITLE;
         this.statsInfo.valueStyleSmall = TEXT_MANAGER_STYLES.SUPER_PROMO_TITLE;
         this.statsInfo.iconSizeBig = StatsConsts.ICON_SIZE_84;
         this.statsInfo.iconSizeSmall = StatsConsts.ICON_SIZE_64;
         this.sprinterImage.addEventListener(MouseEvent.ROLL_OVER,this.onSprinterImageRollOverHandler);
         this.sprinterImage.addEventListener(MouseEvent.ROLL_OUT,this.onRollOutHandler);
         this.sprinterImage.visible = false;
         this.topLightMc.visible = false;
         this._topTf = this.topMc.topTf;
         App.stageSizeMgr.register(this);
      }
      
      override protected function onDispose() : void
      {
         this.statsBlock.dispose();
         this.statsBlock = null;
         this.statsDelta.removeEventListener(MouseEvent.ROLL_OVER,this.onStatsDeltaRollOverHandler);
         this.statsDelta.removeEventListener(MouseEvent.ROLL_OUT,this.onRollOutHandler);
         this.statsDelta.dispose();
         this.statsDelta = null;
         this.statsInfo.removeEventListener(MouseEvent.ROLL_OVER,this.onStatsInfoRollOverHandler);
         this.statsInfo.removeEventListener(MouseEvent.ROLL_OUT,this.onRollOutHandler);
         this.statsInfo.dispose();
         this.statsInfo = null;
         this.sprinterImage.removeEventListener(MouseEvent.ROLL_OVER,this.onSprinterImageRollOverHandler);
         this.sprinterImage.removeEventListener(MouseEvent.ROLL_OUT,this.onRollOutHandler);
         this.sprinterImage.dispose();
         this.sprinterImage = null;
         this.bonusBattles.dispose();
         this.bonusBattles = null;
         this.titleTf = null;
         this.descrTf = null;
         this.leagueIcon = null;
         this.topLightMc = null;
         this.topMc = null;
         this.bg = null;
         this._topTf = null;
         this._data = null;
         this._textMgr = null;
         this._tooltipMgr = null;
         this._viewHelper = null;
         super.onDispose();
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(this._data != null)
         {
            if(isInvalid(InvalidationType.DATA))
            {
               this.updateData();
               if(_baseDisposed)
               {
                  return;
               }
               invalidateLayout();
            }
            if(isInvalid(InvalidationType.LAYOUT) || isInvalid(INV_VIEW_PADDING))
            {
               this.updateLayoutVertical();
               this.updateLayoutHorizontal();
            }
         }
      }
      
      override protected function setData(param1:LeaguesViewVO) : void
      {
         if(param1 != null && this._data != param1)
         {
            this._data = LeaguesViewVO(param1);
            invalidateData();
         }
      }
      
      override protected function setStatsData(param1:LeaguesStatsBlockVO) : void
      {
         this.statsBlock.setData(param1);
      }
      
      override protected function setEfficiencyData(param1:RankedBattlesStatsDeltaVO) : void
      {
         this.statsDelta.setData(param1);
      }
      
      override protected function setRatingData(param1:RankedBattlesStatsInfoVO) : void
      {
         this.statsInfo.setData(param1);
      }
      
      public function as_setBonusBattlesLabel(param1:String) : void
      {
         this.bonusBattles.visible = StringUtils.isNotEmpty(param1);
         if(this.bonusBattles.visible)
         {
            this.bonusBattles.setText(param1);
         }
      }
      
      public function setStateSizeBoundaries(param1:int, param2:int) : void
      {
         this._viewSizeId = this._viewHelper.getSizeId(param1,param2);
         this._topTf.defaultTextFormat = TOP_FORMATS[this._viewSizeId];
         if(this._prevBoundariesHeight != param2)
         {
            this._prevBoundariesHeight = param2;
            this._isSmall = param2 < StageSizeBoundaries.HEIGHT_900;
            if(this._isSmall)
            {
               this.statsDelta.minimize();
               this.statsInfo.minimize();
               this.statsBlock.minimize();
            }
            else
            {
               this.statsDelta.maximize();
               this.statsInfo.maximize();
               this.statsBlock.maximize();
            }
            invalidateData();
         }
      }
      
      private function updateData() : void
      {
         var _loc1_:int = !!this._isSmall ? int(LeagueIconConsts.SMALL_FRAME_OFFSET) : int(LeagueIconConsts.BIG_FRAME_OFFSET);
         this.leagueIcon.gotoAndStop(this._data.league + _loc1_);
         if(this._isSmall)
         {
            this.titleTf.htmlText = this._textMgr.getTextStyleById(TEXT_MANAGER_STYLES.SUPER_PROMO_TITLE,this._data.title);
            this.descrTf.htmlText = this._textMgr.getTextStyleById(TEXT_MANAGER_STYLES.MAIN_TEXT,this._data.descr);
            this.descrTf.width = DESCR_TF_WIDTH_SMALL;
         }
         else
         {
            this.titleTf.htmlText = this._textMgr.getTextStyleById(TEXT_MANAGER_STYLES.GRAND_TITLE,this._data.title);
            this.descrTf.htmlText = this._textMgr.getTextStyleById(TEXT_MANAGER_STYLES.MAIN_BIG_TEXT,this._data.descr);
            this.descrTf.width = DESCR_TF_WIDTH_BIG;
         }
         this.topMc.visible = this.topLightMc.visible = StringUtils.isNotEmpty(this._data.topText);
         if(this.topMc.visible)
         {
            this._topTf.text = this._data.topText;
            this.topLightMc.gotoAndStop(!!this._isSmall ? TOP_LIGHT_MC_FRAME_SMALL : TOP_LIGHT_MC_FRAME_BIG);
         }
         if(StringUtils.isNotEmpty(this._data.sprinterImg))
         {
            this.sprinterImage.visible = true;
            this.sprinterImage.source = this._data.sprinterImg;
         }
         else
         {
            this.sprinterImage.visible = false;
         }
      }
      
      private function updateLayoutHorizontal() : void
      {
         var _loc1_:int = width >> 1;
         this.titleTf.x = width - this.titleTf.width >> 1;
         this.descrTf.x = width - this.descrTf.width >> 1;
         this.leagueIcon.x = _loc1_;
         this.statsBlock.x = _loc1_;
         this.bg.x = width - this.bg.width >> 1;
         this.bonusBattles.x = _loc1_;
         this.topMc.x = width - this.topMc.width >> 1;
         this.topLightMc.x = _loc1_;
         if(this.sprinterImage.visible)
         {
            this.sprinterImage.x = (_width - this.titleTf.textWidth >> 1) - SPRINTER_IMG_WIDTH;
            this.sprinterImage.x += !!this._isSmall ? SPRINTER_IMG_H_OFFSET_SMALL : SPRINTER_IMG_H_OFFSET_BIG;
         }
         if(this._isSmall)
         {
            this.statsDelta.x = this.leagueIcon.x - STATS_H_OFFSET_SMALL;
            this.statsInfo.x = this.leagueIcon.x + STATS_H_OFFSET_SMALL;
         }
         else
         {
            this.statsDelta.x = this.leagueIcon.x - STATS_H_OFFSET_BIG;
            this.statsInfo.x = this.leagueIcon.x + STATS_H_OFFSET_BIG;
         }
      }
      
      private function updateLayoutVertical() : void
      {
         var _loc1_:int = height - viewPadding.top - this.statsBlock.height;
         this.statsBlock.y = height - this.statsBlock.height - Math.max(_loc1_ * STATS_PADDING_WEIGHT,STATS_PADDING_BOTTOM_MIN);
         this.bg.y = (height >> 1) + this._viewHelper.getLeaguesCenterBlockYOffset(this._viewSizeId);
         this.titleTf.y = this.bg.y + this._viewHelper.getLeaguesTopBlockYOffset(this._viewSizeId);
         if(this._isSmall)
         {
            this.descrTf.y = this.titleTf.y + DESCR_TF_V_OFFSET_SMALL;
            this.leagueIcon.y = this.bg.y + LEAGUE_ICON_V_OFFSET_SMALL;
            this.statsDelta.y = this.statsInfo.y = this.leagueIcon.y + STATS_V_OFFSET_SMALL;
            this.topMc.y = this.leagueIcon.y + TOP_V_OFFSET_SMALL;
            this.bonusBattles.y = this.leagueIcon.y + BONUS_BATTLES_V_OFFSET_SMALL;
            this.bg.y = this.leagueIcon.y + BG_V_OFFSET_SMALL;
            this.bg.height = BG_HEIGHT_SMALL;
         }
         else
         {
            this.descrTf.y = this.titleTf.y + DESCR_TF_V_OFFSET_BIG;
            this.leagueIcon.y = this.bg.y + LEAGUE_ICON_V_OFFSET_BIG;
            this.statsDelta.y = this.statsInfo.y = this.leagueIcon.y + STATS_V_OFFSET_BIG;
            this.topMc.y = this.leagueIcon.y + TOP_V_OFFSET_BIG;
            this.bonusBattles.y = this.leagueIcon.y + BONUS_BATTLES_V_OFFSET_BIG;
            this.bg.y = this.leagueIcon.y + BG_V_OFFSET_BIG;
            this.bg.height = BG_HEIGHT_BIG;
         }
         this.topLightMc.y = this.leagueIcon.y + TOP_LIGHT_MC_V_OFFSET;
         if(this.sprinterImage.visible)
         {
            this.sprinterImage.y = this.titleTf.y + (!!this._isSmall ? SPRINTER_IMG_V_OFFSET_SMALL : SPRINTER_IMG_V_OFFSET_BIG);
         }
      }
      
      private function onRollOutHandler(param1:MouseEvent) : void
      {
         this._tooltipMgr.hide();
      }
      
      private function onStatsDeltaRollOverHandler(param1:MouseEvent) : void
      {
         this._tooltipMgr.showSpecial(TOOLTIPS_CONSTANTS.RANKED_BATTLES_EFFICIENCY,null);
      }
      
      private function onStatsInfoRollOverHandler(param1:MouseEvent) : void
      {
         this._tooltipMgr.showSpecial(TOOLTIPS_CONSTANTS.RANKED_BATTLES_POSITION,null);
      }
      
      private function onSprinterImageRollOverHandler(param1:MouseEvent) : void
      {
         this._tooltipMgr.showComplex(TOOLTIPS.RANKEDBATTLESVIEW_SPRINTER);
      }
   }
}
