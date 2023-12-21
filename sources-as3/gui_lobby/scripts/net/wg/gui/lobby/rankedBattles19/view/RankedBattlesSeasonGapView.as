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
      
      private static const STATS_LABEL_Y_OFFSET:int = 