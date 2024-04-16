package net.wg.gui.lobby.rankedBattles19.view.divisions
{
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.text.TextField;
   import net.wg.data.constants.generated.TEXT_MANAGER_STYLES;
   import net.wg.gui.lobby.rankedBattles19.components.BonusBattles;
   import net.wg.gui.lobby.rankedBattles19.components.divisionProgress.DivisionProgressBlock;
   import net.wg.gui.lobby.rankedBattles19.data.RankedBattlesDivisionProgressVO;
   import net.wg.gui.lobby.rankedBattles19.data.RankedBattlesStatsBlockVO;
   import net.wg.gui.lobby.rankedBattles19.view.stats.DivisionsStatsBlock;
   import net.wg.infrastructure.base.meta.IRankedBattlesDivisionProgressMeta;
   import net.wg.infrastructure.base.meta.impl.RankedBattlesDivisionProgressMeta;
   import net.wg.utils.IStageSizeDependComponent;
   import net.wg.utils.ITextManager;
   import net.wg.utils.StageSizeBoundaries;
   import org.idmedia.as3commons.util.StringUtils;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.utils.Padding;
   
   public class RankedBattlesDivisionProgress extends RankedBattlesDivisionProgressMeta implements IRankedBattlesDivisionProgressMeta, IStageSizeDependComponent
   {
      
      private static const BONUS_BLOCK_OFFSET:int = 40;
      
      private static const BG_V_OFFSET_SMALL:int = -62;
      
      private static const BG_V_OFFSET_BIG:int = -85;
      
      private static const MAX_BG_WIDTH:int = 1600;
      
      private static const BG_HEIGHT_SMALL:int = 120;
      
      private static const BG_HEIGHT_BIG:int = 160;
      
      private static const TITLE_Y_OFFSET_BIG:int = 72;
      
      private static const DESCR_TF_V_OFFSET_BIG:int = 18;
      
      private static const TITLE_Y_OFFSET_SMALL:int = 50;
      
      private static const DESCR_TF_V_OFFSET_SMALL:int = 6;
      
      private static const PROGRESS_OFFSET_SMALL:int = 20;
      
      private static const PROGRESS_OFFSET_BIG:int = 40;
      
      private static const STATS_PADDING_WEIGHT:Number = 0.2;
      
      private static const STATS_PADDING_BOTTOM_MIN:int = 25;
      
      private static const BONUS_BATTLES_IS_INVALID:String = "bonusBattlesIsInvalid";
       
      
      public var titleTf:TextField = null;
      
      public var descrTf:TextField = null;
      
      public var statsBlock:DivisionsStatsBlock = null;
      
      public var progressBlock:DivisionProgressBlock = null;
      
      public var bonusBattles:BonusBattles = null;
      
      public var bg:Sprite = null;
      
      private var _divisionStatusTitle:String = "";
      
      private var _divisionStatusDescription:String = "";
      
      private var _titleIsSmall:Boolean = false;
      
      private var _statsAreSmall:Boolean = false;
      
      private var _ranksAreSmall:Boolean = false;
      
      private var _bonusBattlesLabel:String = "";
      
      private var _bgOffset:int = 0;
      
      private var _textMgr:ITextManager = null;
      
      public function RankedBattlesDivisionProgress()
      {
         super();
      }
      
      override public function setSize(param1:Number, param2:Number) : void
      {
         super.setSize(param1,param2);
         this.progressBlock.width = param1;
      }
      
      override public function setSizePadding(param1:Padding, param2:Boolean) : void
      {
         super.setSizePadding(param1,param2);
         this.progressBlock.setSizePadding(param1);
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this._textMgr = App.textMgr;
         this.progressBlock.addEventListener(Event.RESIZE,this.onProgressBlockResizeHandler);
         App.stageSizeMgr.register(this);
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(BONUS_BATTLES_IS_INVALID))
         {
            this.bonusBattles.visible = StringUtils.isNotEmpty(this._bonusBattlesLabel);
            if(this.bonusBattles.visible)
            {
               this.bonusBattles.setText(this._bonusBattlesLabel);
            }
         }
         if(isInvalid(InvalidationType.SIZE,INV_VIEW_PADDING))
         {
            if(this._statsAreSmall)
            {
               this.statsBlock.minimize();
            }
            else
            {
               this.statsBlock.maximize();
            }
            this.updateLabels();
            this.updateLayoutHorizontal();
            this.updateLayoutVertical();
         }
      }
      
      override protected function onDispose() : void
      {
         this.statsBlock.dispose();
         this.statsBlock = null;
         this.progressBlock.removeEventListener(Event.RESIZE,this.onProgressBlockResizeHandler);
         this.progressBlock.dispose();
         this.progressBlock = null;
         this.bonusBattles.dispose();
         this.bonusBattles = null;
         this.titleTf = null;
         this.descrTf = null;
         this.bg = null;
         this._textMgr = null;
         super.onDispose();
      }
      
      override protected function setStatsData(param1:RankedBattlesStatsBlockVO) : void
      {
         this.statsBlock.setData(param1);
      }
      
      override protected function setRankedData(param1:RankedBattlesDivisionProgressVO) : void
      {
         this.progressBlock.setData(param1);
         invalidateSize();
      }
      
      public function as_setBonusBattlesLabel(param1:String) : void
      {
         this._bonusBattlesLabel = param1;
         invalidate(BONUS_BATTLES_IS_INVALID);
      }
      
      public function as_setDivisionStatus(param1:String, param2:String) : void
      {
         this._divisionStatusTitle = param1;
         this._divisionStatusDescription = param2;
         invalidateSize();
      }
      
      public function setStateSizeBoundaries(param1:int, param2:int) : void
      {
         this._statsAreSmall = param2 < StageSizeBoundaries.HEIGHT_900;
         this._titleIsSmall = param1 < StageSizeBoundaries.WIDTH_1366 || this._statsAreSmall;
         this._ranksAreSmall = param1 < StageSizeBoundaries.WIDTH_1920 || this._statsAreSmall;
         invalidateSize();
      }
      
      private function updateLayoutHorizontal() : void
      {
         var _loc1_:int = width >> 1;
         this.progressBlock.x = _loc1_;
         this.titleTf.x = width - this.titleTf.width >> 1;
         this.descrTf.x = width - this.descrTf.width >> 1;
         var _loc2_:int = width - 2 * viewPadding.left;
         this.bg.width = Math.min(_loc2_,MAX_BG_WIDTH);
         this.bg.x = width - this.bg.width >> 1;
         this.statsBlock.x = _loc1_;
         this.bonusBattles.x = _loc1_;
      }
      
      private function updateLayoutVertical() : void
      {
         if(this._ranksAreSmall)
         {
            this.bg.height = BG_HEIGHT_SMALL;
            this._bgOffset = BG_V_OFFSET_SMALL;
         }
         else
         {
            this.bg.height = BG_HEIGHT_BIG;
            this._bgOffset = BG_V_OFFSET_BIG;
         }
         var _loc1_:int = height - viewPadding.top - this.progressBlock.height - this.statsBlock.height;
         this.statsBlock.y = height - this.statsBlock.height - Math.max(_loc1_ * STATS_PADDING_WEIGHT,STATS_PADDING_BOTTOM_MIN) | 0;
         this.progressBlock.y = this.statsBlock.y >> 1;
         this.progressBlock.y -= !!this._statsAreSmall ? PROGRESS_OFFSET_SMALL : PROGRESS_OFFSET_BIG;
         this.bg.y = this.progressBlock.y + this._bgOffset;
         this.titleTf.y = this.bg.y - (!!this._titleIsSmall ? TITLE_Y_OFFSET_SMALL : TITLE_Y_OFFSET_BIG);
         this.descrTf.y = this.bg.y + this.bg.height + (!!this._titleIsSmall ? DESCR_TF_V_OFFSET_SMALL : DESCR_TF_V_OFFSET_BIG);
         this.bonusBattles.y = this.progressBlock.y + (this.progressBlock.height >> 1) + BONUS_BLOCK_OFFSET;
      }
      
      private function updateLabels() : void
      {
         if(this._titleIsSmall)
         {
            this.titleTf.htmlText = this._textMgr.getTextStyleById(TEXT_MANAGER_STYLES.SUPER_PROMO_TITLE,this._divisionStatusTitle);
            this.descrTf.htmlText = this._textMgr.getTextStyleById(TEXT_MANAGER_STYLES.MAIN_TEXT,this._divisionStatusDescription);
         }
         else
         {
            this.titleTf.htmlText = this._textMgr.getTextStyleById(TEXT_MANAGER_STYLES.GRAND_TITLE,this._divisionStatusTitle);
            this.descrTf.htmlText = this._textMgr.getTextStyleById(TEXT_MANAGER_STYLES.MAIN_BIG_TEXT,this._divisionStatusDescription);
         }
      }
      
      private function onProgressBlockResizeHandler(param1:Event) : void
      {
         invalidateSize();
      }
   }
}
