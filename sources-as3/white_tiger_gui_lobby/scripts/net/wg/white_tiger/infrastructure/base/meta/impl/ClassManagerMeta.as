package net.wg.white_tiger.infrastructure.base.meta.impl
{
   import net.wg.white_tiger.data.constants.generated.WHITE_TIGER_BATTLES_CONSTS;
   import net.wg.white_tiger.gui.lobby.battleQueue.BattleQueue;
   import net.wg.white_tiger.gui.lobby.battleQueue.components.QuickStartBossContent;
   import net.wg.white_tiger.gui.lobby.battleQueue.components.QuickStartContentBase;
   import net.wg.white_tiger.gui.lobby.battleQueue.components.QuickStartHunterContent;
   import net.wg.white_tiger.gui.lobby.battleQueue.components.QuickStartPanel;
   import net.wg.white_tiger.gui.lobby.battleQueue.components.QuickStartVehicleList;
   import net.wg.white_tiger.gui.lobby.battleQueue.components.QuickStartVehicleRenderer;
   import net.wg.white_tiger.gui.lobby.battleQueue.data.BossQuickStartPanelVO;
   import net.wg.white_tiger.gui.lobby.battleQueue.data.HunterQuickStartPanelVO;
   import net.wg.white_tiger.gui.lobby.battleQueue.data.QuickStartPanelHunterInfoVO;
   import net.wg.white_tiger.gui.lobby.battleQueue.data.QuickStartPanelVO;
   import net.wg.white_tiger.gui.lobby.battleQueue.events.QuickStartEvent;
   import net.wg.white_tiger.gui.lobby.window.WTEventPrimeTime;
   
   public class ClassManagerMeta
   {
      
      public static const NET_WG_WHITE_TIGER_DATA_CONSTANTS_GENERATED_WHITE_TIGER_BATTLES_CONSTS:Class = WHITE_TIGER_BATTLES_CONSTS;
      
      public static const NET_WG_WHITE_TIGER_GUI_LOBBY_BATTLEQUEUE_BATTLEQUEUE:Class = BattleQueue;
      
      public static const NET_WG_WHITE_TIGER_GUI_LOBBY_BATTLEQUEUE_COMPONENTS_QUICKSTARTBOSSCONTENT:Class = QuickStartBossContent;
      
      public static const NET_WG_WHITE_TIGER_GUI_LOBBY_BATTLEQUEUE_COMPONENTS_QUICKSTARTCONTENTBASE:Class = QuickStartContentBase;
      
      public static const NET_WG_WHITE_TIGER_GUI_LOBBY_BATTLEQUEUE_COMPONENTS_QUICKSTARTHUNTERCONTENT:Class = QuickStartHunterContent;
      
      public static const NET_WG_WHITE_TIGER_GUI_LOBBY_BATTLEQUEUE_COMPONENTS_QUICKSTARTPANEL:Class = QuickStartPanel;
      
      public static const NET_WG_WHITE_TIGER_GUI_LOBBY_BATTLEQUEUE_COMPONENTS_QUICKSTARTVEHICLELIST:Class = QuickStartVehicleList;
      
      public static const NET_WG_WHITE_TIGER_GUI_LOBBY_BATTLEQUEUE_COMPONENTS_QUICKSTARTVEHICLERENDERER:Class = QuickStartVehicleRenderer;
      
      public static const NET_WG_WHITE_TIGER_GUI_LOBBY_BATTLEQUEUE_DATA_BOSSQUICKSTARTPANELVO:Class = BossQuickStartPanelVO;
      
      public static const NET_WG_WHITE_TIGER_GUI_LOBBY_BATTLEQUEUE_DATA_HUNTERQUICKSTARTPANELVO:Class = HunterQuickStartPanelVO;
      
      public static const NET_WG_WHITE_TIGER_GUI_LOBBY_BATTLEQUEUE_DATA_QUICKSTARTPANELHUNTERINFOVO:Class = QuickStartPanelHunterInfoVO;
      
      public static const NET_WG_WHITE_TIGER_GUI_LOBBY_BATTLEQUEUE_DATA_QUICKSTARTPANELVO:Class = QuickStartPanelVO;
      
      public static const NET_WG_WHITE_TIGER_GUI_LOBBY_BATTLEQUEUE_EVENTS_QUICKSTARTEVENT:Class = QuickStartEvent;
      
      public static const NET_WG_WHITE_TIGER_GUI_LOBBY_WINDOW_WTEVENTPRIMETIME:Class = WTEventPrimeTime;
       
      
      public function ClassManagerMeta()
      {
         super();
      }
   }
}
