package net.wg.gui.lobby.rankedBattles19.view
{
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import net.wg.data.constants.UniversalBtnStylesConst;
   import net.wg.data.constants.generated.RANKEDBATTLES_ALIASES;
   import net.wg.data.constants.generated.TEXT_MANAGER_STYLES;
   import net.wg.gui.components.controls.Image;
   import net.wg.gui.lobby.rankedBattles19.components.stats.RankedBattleStats;
   import net.wg.gui.lobby.rankedBattles19.constants.LeagueIconConsts;
   import net.wg.gui.lobby.rankedBattles19.constants.StatsConsts;
   import net.wg.gui.lobby.rankedBattles19.data.RankedBattlesStatsVO;
   import net.wg.gui.lobby.rankedBattles19.data.SeasonGapViewVO;
   import net.wg.infrastructure.base.meta.IRankedBattlesSeasonGapViewMeta;
   import net.wg.infrastructure.base.meta.impl.RankedBattlesSeasonGapViewMeta;
   import net.wg.infrastructure.interfaces.IUniversalBtn;
   import net.wg.infrastructure.managers.ITooltipMgr;
   import net.wg.utils.IStageSizeDependComponent;
   import net.wg.utils.ITextManager;
   import net.wg.utils.StageSizeBoundaries;
   import org.idmedia.as3commons.util.StringUtils;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.controls.Button;
   import scaleform.clik.events.ButtonEvent;
   
   public class RankedBattlesSeasonGapView extends RankedBattlesSeasonGapViewMeta implements IRankedBattlesSeasonGapViewMeta, IStageSizeDependComponent
   {
      
      private static const STATS_LABEL_Y_OFFSET:int = -6;
      
      private static const LEAGUE_DISABLED_ALPHA:Number = 0.6;
      
      private static const DIVISION_DISABLED_ALPHA:Number = 0.8;
      
      private static const STATS_H_OFFSET_BIG:int = 300;
      
      private static const STATS_H_OFFSET_SMALL:int = 250;
      
      private static const BG_HEIGHT_SMALL:int = 120;
      
      private static const BG_HEIGHT_BIG:int = 160;
      
      private static const SPRINTER_IMG_WIDTH:int = 32;
      
      private static const DESCR_TF_V_OFFSET_BIG:int = 47;
      
      private static const LEAGUE_IMG_V_OFFSET_BIG:int = 76;
      
      private static const DIVISION_IMG_V_OFFSET_BIG:int = -47;
      
      private static const STATS_V_OFFSET_BIG:int = 15;
      
      private static const RATING_BTN_V_OFFSET_BIG:int = 144;
      
      private static const SPRINTER_IMG_V_OFFSET_BIG:int = 20;
      
      private static const SPRINTER_IMG_H_OFFSET_BIG:int = -14;
      
      private static const DESCR_TF_V_OFFSET_SMALL:int = 35;
      
      private static const LEAGUE_IMG_V_OFFSET_SMALL:int = 63;
      
      private static const DIVISION_IMG_V_OFFSET_SMALL:int = -18;
      
      private static const STATS_V_OFFSET_SMALL:int = 10;
      
      private static const RATING_BTN_V_OFFSET_SMALL:int = 126;
      
      private static const SPRINTER_IMG_V_OFFSET_SMALL:int = 14;
      
      private static const SPRINTER_IMG_H_OFFSET_SMALL:int = -10;
      
      private static const TOP_BLOCK_Y_OFFSETS:Object = {};
      
      private static const CENTER_BLOCK_Y_OFFSETS:Object = {};
      
      {
         TOP_BLOCK_Y_OFFSETS[RankedBattlesViewHelper.SIZE_HUGE] = -200;
         TOP_BLOCK_Y_OFFSETS[RankedBattlesViewHelper.SIZE_BIG] = -165;
         TOP_BLOCK_Y_OFFSETS[RankedBattlesViewHelper.SIZE_SMALL] = -130;
         CENTER_BLOCK_Y_OFFSETS[RankedBattlesViewHelper.SIZE_HUGE] = -60;
         CENTER_BLOCK_Y_OFFSETS[RankedBattlesViewHelper.SIZE_BIG] = -70;
         CENTER_BLOCK_Y_OFFSETS[RankedBattlesViewHelper.SIZE_SMALL] = -40;
      }
      
      public var titleTf:TextField = null;
      
      public var descrTf:TextField = null;
      
      public var sprinterImage:Image = null;
      
      public var leagueMc:MovieClip = null;
      
      public var divisionImage:Image = null;
      
      public var statsEfficiency:RankedBattleStats = null;
      
      public var statsRating:RankedBattleStats = null;
      
      public var ratingBtn:IUniversalBtn = null;
      
      public var bg:Sprite = null;
      
      private var _data:SeasonGapViewVO = null;
      
      private var _prevBoundariesHeight:int = 0;
      
      private var _isSmall:Boolean = false;
      
      private var _textMgr:ITextManager = null;
      
      private var _tooltipMgr:ITooltipMgr = null;
      
      private var _viewHelper:RankedBattlesViewHelper = null;
      
      private var _viewSizeId:String = "small";
      
      public function RankedBattlesSeasonGapView()
      {
         super();
         this._textMgr = App.textMgr;
         this._tooltipMgr = App.toolTipMgr;
         this._viewHelper = RankedBattlesViewHelper.getInstance();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.statsEfficiency.valueStyleBig = TEXT_MANAGER_STYLES.GRAND_TITLE;
         this.statsEfficiency.valueStyleSmall = TEXT_MANAGER_STYLES.SUPER_PROMO_TITLE;
         this.statsEfficiency.iconSizeBig = StatsConsts.ICON_SIZE_84;
         this.statsEfficiency.iconSizeSmall = StatsConsts.ICON_SIZE_64;
         this.statsEfficiency.labelYOffset = STATS_LABEL_Y_OFFSET;
         this.statsRating.valueStyleBig = TEXT_MANAGER_STYLES.GRAND_TITLE;
         this.statsRating.valueStyleSmall = TEXT_MANAGER_STYLES.SUPER_PROMO_TITLE;
         this.statsRating.iconSizeBig = StatsConsts.ICON_SIZE_84;
         this.statsRating.iconSizeSmall = StatsConsts.ICON_SIZE_64;
         this.statsRating.labelYOffset = STATS_LABEL_Y_OFFSET;
         App.utils.universalBtnStyles.setStyle(this.ratingBtn,UniversalBtnStylesConst.STYLE_HEAVY_GREEN);
         this.leagueMc.visible = false;
         this.divisionImage.visible = false;
         this.divisionImage.addEventListener(Event.CHANGE,this.onMainImageChangeHandler);
         this.ratingBtn.addEventListener(ButtonEvent.CLICK,this.onRatingBtnClickHandler);
         this.sprinterImage.addEventListener(MouseEvent.ROLL_OVER,this.onSprinterImageRollOverHandler);
         this.sprinterImage.addEventListener(MouseEvent.ROLL_OUT,this.onSprinterImageRollOutHandler);
         this.sprinterImage.visible = false;
         App.stageSizeMgr.register(this);
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
      
      override protected function onDispose() : void
      {
         this.statsEfficiency.dispose();
         this.statsEfficiency = null;
         this.statsRating.dispose();
         this.statsRating = null;
         this.divisionImage.filters = null;
         this.divisionImage.removeEventListener(Event.CHANGE,this.onMainImageChangeHandler);
         this.divisionImage.dispose();
         this.divisionImage = null;
         this.ratingBtn.removeEventListener(ButtonEvent.CLICK,this.onRatingBtnClickHandler);
         this.ratingBtn.dispose();
         this.ratingBtn = null;
         this.sprinterImage.removeEventListener(MouseEvent.ROLL_OVER,this.onSprinterImageRollOverHandler);
         this.sprinterImage.removeEventListener(MouseEvent.ROLL_OUT,this.onSprinterImageRollOutHandler);
         this.sprinterImage.dispose();
         this.sprinterImage = null;
         this.titleTf = null;
         this.descrTf = null;
         this.leagueMc = null;
         this.bg = null;
         this._data = null;
         this._textMgr = null;
         this._tooltipMgr = null;
         this._viewHelper = null;
         super.onDispose();
      }
      
      override protected function setData(param1:SeasonGapViewVO) : void
      {
         if(param1 != null && this._data != param1)
         {
            this._data = param1;
            invalidateData();
         }
      }
      
      override protected function setEfficiencyData(param1:RankedBattlesStatsVO) : void
      {
         this.statsEfficiency.setData(param1);
      }
      
      override protected function setRatingData(param1:RankedBattlesStatsVO) : void
      {
         this.statsRating.setData(param1);
      }
      
      public function setStateSizeBoundaries(param1:int, param2:int) : void
      {
         this._viewSizeId = this._viewHelper.getSizeId(param1,param2);
         if(this._prevBoundariesHeight != param2)
         {
            this._prevBoundariesHeight = param2;
            this._isSmall = param2 < StageSizeBoundaries.HEIGHT_900;
            if(this._isSmall)
            {
               this.statsEfficiency.minimize();
               this.statsRating.minimize();
            }
            else
            {
               this.statsEfficiency.maximize();
               this.statsRating.maximize();
            }
            invalidateData();
         }
      }
      
      private function updateData() : void
      {
         var _loc1_:int = 0;
         if(this._data.state == RANKEDBATTLES_ALIASES.SEASON_GAP_VIEW_LEAGUE_STATE)
         {
            _loc1_ = !!this._isSmall ? int(LeagueIconConsts.SMALL_FRAME_OFFSET) : int(LeagueIconConsts.BIG_FRAME_OFFSET);
            this.leagueMc.gotoAndStop(this._data.leagueID + _loc1_);
            if(this._data.disabled)
            {
               this.leagueMc.alpha = LEAGUE_DISABLED_ALPHA;
            }
            else
            {
               this.leagueMc.alpha = 1;
            }
            this.leagueMc.visible = true;
            this.divisionImage.visible = false;
         }
         else
         {
            this.divisionImage.source = !!this._isSmall ? this._data.divisionImgSmall : this._data.divisionImgBig;
            if(this._data.disabled)
            {
               App.utils.commons.setSaturation(this.divisionImage,0);
               this.divisionImage.alpha = DIVISION_DISABLED_ALPHA;
            }
            else
            {
               this.divisionImage.filters = null;
               this.divisionImage.alpha = 1;
            }
            this.leagueMc.visible = false;
            this.divisionImage.visible = true;
         }
         this.ratingBtn.visible = this._data.btnVisible;
         if(this._data.btnVisible)
         {
            Button(this.ratingBtn).label = this._data.btnLabel;
         }
         this.titleTf.htmlText = !!this._isSmall ? this._textMgr.getTextStyleById(TEXT_MANAGER_STYLES.SUPER_PROMO_TITLE,this._data.title) : this._textMgr.getTextStyleById(TEXT_MANAGER_STYLES.GRAND_TITLE,this._data.title);
         this.descrTf.htmlText = !!this._isSmall ? this._textMgr.getTextStyleById(TEXT_MANAGER_STYLES.MAIN_TEXT,this._data.descr) : this._textMgr.getTextStyleById(TEXT_MANAGER_STYLES.MAIN_BIG_TEXT,this._data.descr);
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
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         this.titleTf.x = _width - this.titleTf.width >> 1;
         this.descrTf.x = _width - this.descrTf.width >> 1;
         this.bg.x = _width - this.bg.width >> 1;
         this.ratingBtn.x = _width - this.ratingBtn.width >> 1;
         if(this.sprinterImage.visible)
         {
            this.sprinterImage.x = (_width - this.titleTf.textWidth >> 1) - SPRINTER_IMG_WIDTH;
            this.sprinterImage.x += !!this._isSmall ? SPRINTER_IMG_H_OFFSET_SMALL : SPRINTER_IMG_H_OFFSET_BIG;
         }
         if(this._data.state == RANKEDBATTLES_ALIASES.SEASON_GAP_VIEW_LEAGUE_STATE)
         {
            _loc1_ = _width >> 1;
            this.leagueMc.x = _loc1_;
            _loc2_ = 0;
         }
         else
         {
            _loc1_ = _width - this.divisionImage.width >> 1;
            this.divisionImage.x = _loc1_;
            _loc2_ = this.divisionImage.width >> 1;
         }
         if(this._isSmall)
         {
            this.statsEfficiency.x = _loc1_ + _loc2_ - STATS_H_OFFSET_SMALL;
            this.statsRating.x = _loc1_ + _loc2_ + STATS_H_OFFSET_SMALL;
         }
         else
         {
            this.statsEfficiency.x = _loc1_ + _loc2_ - STATS_H_OFFSET_BIG;
            this.statsRating.x = _loc1_ + _loc2_ + STATS_H_OFFSET_BIG;
         }
      }
      
      private function updateLayoutVertical() : void
      {
         var _loc1_:Sprite = null;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         if(this._data.state == RANKEDBATTLES_ALIASES.SEASON_GAP_VIEW_LEAGUE_STATE)
         {
            _loc1_ = this.leagueMc;
            _loc2_ = LEAGUE_IMG_V_OFFSET_BIG;
            _loc3_ = LEAGUE_IMG_V_OFFSET_SMALL;
         }
         else
         {
            _loc1_ = this.divisionImage;
            _loc2_ = DIVISION_IMG_V_OFFSET_BIG;
            _loc3_ = DIVISION_IMG_V_OFFSET_SMALL;
         }
         this.bg.y = (height >> 1) + CENTER_BLOCK_Y_OFFSETS[this._viewSizeId];
         this.titleTf.y = this.bg.y + TOP_BLOCK_Y_OFFSETS[this._viewSizeId];
         if(this._isSmall)
         {
            this.descrTf.y = this.titleTf.y + DESCR_TF_V_OFFSET_SMALL;
            this.bg.height = BG_HEIGHT_SMALL;
            _loc1_.y = this.bg.y + _loc3_;
            this.statsEfficiency.y = this.statsRating.y = this.bg.y + STATS_V_OFFSET_SMALL;
            this.ratingBtn.y = this.bg.y + this.bg.height + RATING_BTN_V_OFFSET_SMALL;
         }
         else
         {
            this.descrTf.y = this.titleTf.y + DESCR_TF_V_OFFSET_BIG;
            this.bg.height = BG_HEIGHT_BIG;
            _loc1_.y = this.bg.y + _loc2_;
            this.statsEfficiency.y = this.statsRating.y = this.bg.y + STATS_V_OFFSET_BIG;
            this.ratingBtn.y = this.bg.y + this.bg.height + RATING_BTN_V_OFFSET_BIG;
         }
         if(this.sprinterImage.visible)
         {
            this.sprinterImage.y = this.titleTf.y + (!!this._isSmall ? SPRINTER_IMG_V_OFFSET_SMALL : SPRINTER_IMG_V_OFFSET_BIG);
         }
      }
      
      private function onMainImageChangeHandler(param1:Event) : void
      {
         invalidateLayout();
      }
      
      private function onRatingBtnClickHandler(param1:Event) : void
      {
         onBtnClickS();
      }
      
      private function onSprinterImageRollOverHandler(param1:Event) : void
      {
         this._tooltipMgr.showComplex(TOOLTIPS.RANKEDBATTLESVIEW_SPRINTER);
      }
      
      private function onSprinterImageRollOutHandler(param1:Event) : void
      {
         this._tooltipMgr.hide();
      }
   }
}
