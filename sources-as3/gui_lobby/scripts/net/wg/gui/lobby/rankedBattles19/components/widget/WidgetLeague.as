package net.wg.gui.lobby.rankedBattles19.components.widget
{
   import flash.display.BlendMode;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.text.TextField;
   import net.wg.data.constants.generated.RANKEDBATTLES_ALIASES;
   import net.wg.data.constants.generated.RANKEDBATTLES_CONSTS;
   import net.wg.data.constants.generated.TEXT_MANAGER_STYLES;
   import net.wg.data.constants.generated.TOOLTIPS_CONSTANTS;
   import net.wg.gui.interfaces.IUpdatableComponent;
   import net.wg.gui.lobby.rankedBattles19.components.ImageContainer;
   import net.wg.gui.lobby.rankedBattles19.components.interfaces.IResizableRankedComponent;
   import net.wg.gui.lobby.rankedBattles19.components.stats.RankedBattleStats;
   import net.wg.gui.lobby.rankedBattles19.constants.StatsConsts;
   import net.wg.gui.lobby.rankedBattles19.data.WidgetLeagueVO;
   import net.wg.infrastructure.base.UIComponentEx;
   import net.wg.infrastructure.managers.ITooltipMgr;
   import scaleform.clik.constants.InvalidationType;
   
   public class WidgetLeague extends UIComponentEx implements IUpdatableComponent, IResizableRankedComponent
   {
      
      private static const STATS_VALUE_Y_OFFSET:int = -8;
      
      private static const IMAGE_SIZE_MEDIUM:String = "130x130";
      
      private static const IMAGE_SIZE_SMALL:String = "100x100";
      
      private static const SIZES_WIDTH:Object = {};
      
      private static const SIZES_HEIGHT:Object = {};
      
      private static const IMAGE_POSITIONS:Object = {};
      
      private static const STATS_POSITIONS_X_OFFSETS:Object = {};
      
      private static const BULLITS_X:Object = {};
      
      {
         SIZES_WIDTH[RANKEDBATTLES_ALIASES.WIDGET_MEDIUM] = RANKEDBATTLES_CONSTS.WIDGET_MEDIUM_WIDTH;
         SIZES_WIDTH[RANKEDBATTLES_ALIASES.WIDGET_SMALL] = RANKEDBATTLES_CONSTS.WIDGET_SMALL_WIDTH;
         SIZES_HEIGHT[RANKEDBATTLES_ALIASES.WIDGET_MEDIUM] = 130;
         SIZES_HEIGHT[RANKEDBATTLES_ALIASES.WIDGET_SMALL] = 100;
         IMAGE_POSITIONS[RANKEDBATTLES_ALIASES.WIDGET_MEDIUM] = new Point(-65,-65);
         IMAGE_POSITIONS[RANKEDBATTLES_ALIASES.WIDGET_SMALL] = new Point(-50,-60);
         STATS_POSITIONS_X_OFFSETS[RANKEDBATTLES_ALIASES.WIDGET_MEDIUM] = 136;
         STATS_POSITIONS_X_OFFSETS[RANKEDBATTLES_ALIASES.WIDGET_SMALL] = 96;
         BULLITS_X[RANKEDBATTLES_ALIASES.WIDGET_MEDIUM] = 80;
         BULLITS_X[RANKEDBATTLES_ALIASES.WIDGET_SMALL] = 60;
      }
      
      public var leagueMc:ImageContainer = null;
      
      public var leagueEffectMc:ImageContainer = null;
      
      public var statsDelta:RankedBattleStats = null;
      
      public var statsInfo:RankedBattleStats = null;
      
      public var infoTexts:MovieClip = null;
      
      public var leftBullit:Sprite = null;
      
      public var rightBullit:Sprite = null;
      
      private var _data:WidgetLeagueVO = null;
      
      private var _size:String = "medium";
      
      private var _titleTF:TextField = null;
      
      private var _descrTF:TextField = null;
      
      private var _tooltipMgr:ITooltipMgr;
      
      public function WidgetLeague()
      {
         this._tooltipMgr = App.toolTipMgr;
         super();
      }
      
      private static function getIcon(param1:String, param2:int) : String
      {
         var _loc3_:String = param1 == RANKEDBATTLES_ALIASES.WIDGET_MEDIUM ? IMAGE_SIZE_MEDIUM : IMAGE_SIZE_SMALL;
         return RES_ICONS.getLeagueIcon(_loc3_,String(param2));
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this._titleTF = this.infoTexts.title;
         this._descrTF = this.infoTexts.descr;
         this.leagueMc.buttonMode = this.leagueMc.useHandCursor = true;
         this.statsDelta.buttonMode = this.statsDelta.useHandCursor = true;
         this.statsDelta.iconBlendMode = BlendMode.ADD;
         this.statsDelta.addEventListener(MouseEvent.ROLL_OVER,this.onStatsDeltaRollOverHandler);
         this.statsDelta.addEventListener(MouseEvent.ROLL_OUT,this.onCmpRollOutHandler);
         this.statsDelta.valueYOffsetBig = STATS_VALUE_Y_OFFSET;
         this.statsDelta.valueStyleBig = TEXT_MANAGER_STYLES.PROMO_TITLE;
         this.statsDelta.iconSizeBig = StatsConsts.ICON_SIZE_42;
         this.leagueMc.addEventListener(MouseEvent.ROLL_OVER,this.onLeagueRollOverHandler);
         this.leagueMc.addEventListener(MouseEvent.ROLL_OUT,this.onCmpRollOutHandler);
         this.infoTexts.mouseEnabled = this.infoTexts.mouseChildren = false;
         this.leagueEffectMc.mouseEnabled = this.leagueEffectMc.mouseChildren = false;
      }
      
      override protected function draw() : void
      {
         var _loc1_:String = null;
         var _loc2_:Point = null;
         super.draw();
         if(this._data != null)
         {
            if(isInvalid(InvalidationType.DATA))
            {
               this._titleTF.htmlText = this._data.title;
               this._descrTF.htmlText = this._data.infoText;
               invalidateSize();
            }
            if(isInvalid(InvalidationType.SIZE))
            {
               _loc1_ = getIcon(this._size,this._data.league);
               this.leagueMc.setSource(_loc1_);
               this.leagueEffectMc.setSource(_loc1_);
               _loc2_ = IMAGE_POSITIONS[this._size];
               this.leagueMc.setImgPoint(_loc2_);
               this.leagueEffectMc.setImgPoint(_loc2_);
               this.statsDelta.x = -STATS_POSITIONS_X_OFFSETS[this._size];
               this.leftBullit.x = -BULLITS_X[this._size];
               this.rightBullit.x = BULLITS_X[this._size];
            }
         }
      }
      
      override protected function onDispose() : void
      {
         this.statsDelta.removeEventListener(MouseEvent.ROLL_OVER,this.onStatsDeltaRollOverHandler);
         this.statsDelta.removeEventListener(MouseEvent.ROLL_OUT,this.onCmpRollOutHandler);
         this.statsDelta.dispose();
         this.statsDelta = null;
         this.leagueMc.removeEventListener(MouseEvent.ROLL_OVER,this.onLeagueRollOverHandler);
         this.leagueMc.removeEventListener(MouseEvent.ROLL_OUT,this.onCmpRollOutHandler);
         this.leagueMc.dispose();
         this.leagueMc = null;
         this.leagueEffectMc.dispose();
         this.leagueEffectMc = null;
         this.infoTexts = null;
         this.leftBullit = null;
         this.rightBullit = null;
         this._data = null;
         this._titleTF = null;
         this._descrTF = null;
         this._tooltipMgr = null;
         super.onDispose();
      }
      
      public function update(param1:Object) : void
      {
         if(param1 != null && this._data != param1)
         {
            this._data = WidgetLeagueVO(param1);
            this.statsDelta.setData(this._data.efficiencyData);
            invalidateData();
         }
      }
      
      override public function get width() : Number
      {
         return SIZES_WIDTH[this._size];
      }
      
      override public function get height() : Number
      {
         return SIZES_HEIGHT[this._size];
      }
      
      public function get componentSize() : String
      {
         return this._size;
      }
      
      public function set componentSize(param1:String) : void
      {
         if(this._size != param1)
         {
            this._size = param1;
            invalidateSize();
         }
      }
      
      private function onLeagueRollOverHandler(param1:MouseEvent) : void
      {
         this._tooltipMgr.showSpecial(TOOLTIPS_CONSTANTS.RANKED_BATTLES_LEAGUE,null);
      }
      
      private function onStatsDeltaRollOverHandler(param1:MouseEvent) : void
      {
         this._tooltipMgr.showSpecial(TOOLTIPS_CONSTANTS.RANKED_BATTLES_EFFICIENCY,null);
      }
      
      private function onStatsInfoRollOverHandler(param1:MouseEvent) : void
      {
         this._tooltipMgr.showSpecial(TOOLTIPS_CONSTANTS.RANKED_BATTLES_POSITION,null);
      }
      
      private function onCmpRollOutHandler(param1:MouseEvent) : void
      {
         this._tooltipMgr.hide();
      }
   }
}
