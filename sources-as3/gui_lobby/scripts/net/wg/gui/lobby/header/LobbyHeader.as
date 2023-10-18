package net.wg.gui.lobby.header
{
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import net.wg.data.Aliases;
   import net.wg.data.VO.UserVO;
   import net.wg.data.constants.BaseTooltips;
   import net.wg.data.constants.Errors;
   import net.wg.data.constants.Linkages;
   import net.wg.data.constants.Values;
   import net.wg.data.constants.generated.CURRENCIES_CONSTANTS;
   import net.wg.data.constants.generated.HANGAR_ALIASES;
   import net.wg.data.managers.impl.TooltipProps;
   import net.wg.gui.components.controls.FightButton;
   import net.wg.gui.components.controls.MainMenuButton;
   import net.wg.gui.components.controls.VO.BadgeVisualVO;
   import net.wg.gui.components.tooltips.ToolTipComplex;
   import net.wg.gui.interfaces.ISoundButtonEx;
   import net.wg.gui.lobby.header.events.HeaderEvents;
   import net.wg.gui.lobby.header.events.PersonalReservesWidgetEvent;
   import net.wg.gui.lobby.header.headerButtonBar.HeaderButton;
   import net.wg.gui.lobby.header.headerButtonBar.HeaderButtonBar;
   import net.wg.gui.lobby.header.headerButtonBar.HeaderButtonsHelper;
   import net.wg.gui.lobby.header.interfaces.ILobbyHeader;
   import net.wg.gui.lobby.header.mainMenuButtonBar.MainMenuButtonBar;
   import net.wg.gui.lobby.header.rankedBattles.SparkAnim;
   import net.wg.gui.lobby.header.vo.AccountDataVo;
   import net.wg.gui.lobby.header.vo.ExtendedSquadInfoVo;
   import net.wg.gui.lobby.header.vo.HBC_AccountDataVo;
   import net.wg.gui.lobby.header.vo.HBC_BattleTypeVo;
   import net.wg.gui.lobby.header.vo.HBC_FinanceVo;
   import net.wg.gui.lobby.header.vo.HBC_PremDataVo;
   import net.wg.gui.lobby.header.vo.HBC_PremShopVO;
   import net.wg.gui.lobby.header.vo.HBC_SettingsVo;
   import net.wg.gui.lobby.header.vo.HBC_SquadDataVo;
   import net.wg.gui.lobby.header.vo.HBC_WotPlusDataVO;
   import net.wg.gui.lobby.header.vo.HangarMenuTabItemVO;
   import net.wg.gui.lobby.header.vo.HeaderButtonVo;
   import net.wg.gui.tutorial.components.TutorialClip;
   import net.wg.infrastructure.base.meta.impl.LobbyHeaderMeta;
   import net.wg.infrastructure.events.LifeCycleEvent;
   import net.wg.infrastructure.interfaces.IDAAPIModule;
   import net.wg.infrastructure.managers.ITooltipMgr;
   import net.wg.utils.ICounterManager;
   import net.wg.utils.IScheduler;
   import net.wg.utils.IStageSizeDependComponent;
   import net.wg.utils.IUtils;
   import net.wg.utils.StageSizeBoundaries;
   import org.idmedia.as3commons.util.StringUtils;
   import scaleform.clik.constants.ConstrainMode;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.controls.Button;
   import scaleform.clik.data.DataProvider;
   import scaleform.clik.events.ButtonEvent;
   import scaleform.clik.interfaces.IDataProvider;
   import scaleform.clik.utils.Constraints;
   
   public class LobbyHeader extends LobbyHeaderMeta implements ILobbyHeader, IStageSizeDependComponent
   {
      
      public static const NARROW_SCREEN:String = 