package net.wg.gui.lobby.sessionStats
{
   import flash.display.InteractiveObject;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import net.wg.data.constants.Linkages;
   import net.wg.data.constants.generated.TEXT_ALIGN;
   import net.wg.gui.components.common.containers.TiledLayout;
   import net.wg.gui.components.containers.GroupEx;
   import net.wg.gui.components.containers.VerticalGroupLayout;
   import net.wg.gui.components.controls.ScrollingListEx;
   import net.wg.gui.interfaces.ISoundButtonEx;
   import net.wg.gui.lobby.components.IResizableContent;
   import net.wg.gui.lobby.sessionStats.data.SessionBattleStatsViewVO;
   import net.wg.gui.lobby.sessionStats.data.SessionStatsOverviewVO;
   import net.wg.gui.lobby.sessionStats.events.SessionStatsPopoverResizeEvent;
   import net.wg.infrastructure.base.meta.impl.SessionBattleStatsViewMeta;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.events.ButtonEvent;
   
   public class SessionBattleStatsView extends SessionBattleStatsViewMeta implements IResizableContent
   {
      
      public static const TILE_COLS:int = 