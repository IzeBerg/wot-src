package net.wg.app.impl
{
   import flash.display.DisplayObject;
   import flash.display.DisplayObjectContainer;
   import flash.events.Event;
   import flash.net.registerClassAlias;
   import net.wg.app.iml.base.AbstractApplication;
   import net.wg.data.constants.generated.ATLAS_CONSTANTS;
   import net.wg.data.constants.generated.LAYER_NAMES;
   import net.wg.gui.components.containers.CursorManagedContainer;
   import net.wg.gui.components.containers.HiddenServiceManagedContainer;
   import net.wg.gui.components.containers.MainViewContainer;
   import net.wg.gui.components.containers.ManagedContainer;
   import net.wg.gui.components.containers.SimpleManagedContainer;
   import net.wg.gui.components.containers.WaitingManagedContainer;
   import net.wg.gui.components.controls.VO.ActionPriceVO;
   import net.wg.gui.components.questProgress.data.QPProgressVO;
   import net.wg.gui.components.questProgress.data.metrics.QPMetricsLimiterVO;
   import net.wg.gui.components.questProgress.data.metrics.QPMetricsRangeVO;
   import net.wg.gui.components.questProgress.data.metrics.QPMetricsSimpleVO;
   import net.wg.gui.components.questProgress.data.metrics.QPMetricsSimpleValueVO;
   import net.wg.gui.components.questProgress.data.metrics.QPMetricsTimerVO;
   import net.wg.gui.components.questProgress.data.metrics.QPMetricsVehicleVO;
   import net.wg.gui.lobby.components.data.SkillsVO;
   import net.wg.gui.lobby.components.maintenance.data.ModuleVO;
   import net.wg.gui.lobby.fortifications.data.base.BuildingBaseVO;
   import net.wg.gui.lobby.hangar.crew.TankmanRoleVO;
   import net.wg.gui.lobby.hangar.crew.TankmanVO;
   import net.wg.gui.lobby.hangar.crew.TankmenResponseVO;
   import net.wg.infrastructure.interfaces.ICursorManager;
   import net.wg.infrastructure.managers.GlobalVarsManager;
   import net.wg.infrastructure.managers.ICacheManager;
   import net.wg.infrastructure.managers.IColorSchemeManager;
   import net.wg.infrastructure.managers.IContainerManager;
   import net.wg.infrastructure.managers.IContextMenuManager;
   import net.wg.infrastructure.managers.IEnvironmentManager;
   import net.wg.infrastructure.managers.IEventLogManager;
   import net.wg.infrastructure.managers.IGlobalVarsManager;
   import net.wg.infrastructure.managers.IImageManager;
   import net.wg.infrastructure.managers.ILoaderManager;
   import net.wg.infrastructure.managers.IPopoverManager;
   import net.wg.infrastructure.managers.ISoundManager;
   import net.wg.infrastructure.managers.IStageSizeManager;
   import net.wg.infrastructure.managers.ITooltipMgr;
   import net.wg.infrastructure.managers.ITutorialManager;
   import net.wg.infrastructure.managers.IUILoggerManager;
   import net.wg.infrastructure.managers.IVoiceChatManager;
   import net.wg.infrastructure.managers.counter.CounterManager;
   import net.wg.infrastructure.managers.impl.AtlasManager;
   import net.wg.infrastructure.managers.impl.CacheManager;
   import net.wg.infrastructure.managers.impl.ClassManager;
   import net.wg.infrastructure.managers.impl.ColorSchemeManagerLobby;
   import net.wg.infrastructure.managers.impl.ContainerManagerLobby;
   import net.wg.infrastructure.managers.impl.ContextMenuManager;
   import net.wg.infrastructure.managers.impl.ElementBlurAdapter;
   import net.wg.infrastructure.managers.impl.EnvironmentManager;
   import net.wg.infrastructure.managers.impl.EventLogManager;
   import net.wg.infrastructure.managers.impl.GameInputManager;
   import net.wg.infrastructure.managers.impl.ImageManager;
   import net.wg.infrastructure.managers.impl.LoaderManager;
   import net.wg.infrastructure.managers.impl.PopoverManagerLobby;
   import net.wg.infrastructure.managers.impl.SoundManager;
   import net.wg.infrastructure.managers.impl.StageSizeManager;
   import net.wg.infrastructure.managers.impl.TextManager;
   import net.wg.infrastructure.managers.impl.ToolTipManagerLobby;
   import net.wg.infrastructure.managers.impl.TutorialManager;
   import net.wg.infrastructure.managers.impl.UILoggerManager;
   import net.wg.infrastructure.managers.impl.VoiceChatManagerLobby;
   import net.wg.infrastructure.managers.impl.cursor.CursorManager;
   import net.wg.infrastructure.managers.impl.tutorial.CustomObjectFinderLobby;
   import net.wg.infrastructure.managers.pool.PoolManager;
   import net.wg.infrastructure.managers.utils.impl.AnimBuilder;
   import net.wg.infrastructure.managers.utils.impl.Asserter;
   import net.wg.infrastructure.managers.utils.impl.ClassFactory;
   import net.wg.infrastructure.managers.utils.impl.CommonsLobby;
   import net.wg.infrastructure.managers.utils.impl.DataUtils;
   import net.wg.infrastructure.managers.utils.impl.DateTimeLobby;
   import net.wg.infrastructure.managers.utils.impl.FocusHandlerEx;
   import net.wg.infrastructure.managers.utils.impl.HelpLayoutManager;
   import net.wg.infrastructure.managers.utils.impl.IME;
   import net.wg.infrastructure.managers.utils.impl.Icons;
   import net.wg.infrastructure.managers.utils.impl.LocaleLobby;
   import net.wg.infrastructure.managers.utils.impl.Nations;
   import net.wg.infrastructure.managers.utils.impl.PopupManager;
   import net.wg.infrastructure.managers.utils.impl.Scheduler;
   import net.wg.infrastructure.managers.utils.impl.StyleSheetManager;
   import net.wg.infrastructure.managers.utils.impl.TweenAnimator;
   import net.wg.infrastructure.managers.utils.impl.TweenManager;
   import net.wg.infrastructure.managers.utils.impl.UniversalBtnStyles;
   import net.wg.infrastructure.managers.utils.impl.Utils;
   import net.wg.infrastructure.managers.utils.impl.VOManager;
   import net.wg.infrastructure.managers.utils.impl.ViewRestrictions;
   import net.wg.infrastructure.managers.utils.impl.WGJSON;
   import net.wg.utils.IGameInputManager;
   import net.wg.utils.ITextManager;
   import net.wg.utils.ITweenManager;
   import net.wg.utils.IUtils;
   import scaleform.clik.core.CLIK;
   import scaleform.gfx.Extensions;
   
   [SWF(frameRate="50",backgroundColor="#000000",width="1024",height="768")]
   public final class LobbyApp extends AbstractApplication
   {
      
      public static const APP_REG_CMD:String = "registerApplication";
       
      
      private var _serviceLayout:ManagedContainer;
      
      private var _hiddenServiceLayout:HiddenServiceManagedContainer;
      
      private var _markers:ManagedContainer;
      
      private var _views:MainViewContainer;
      
      private var _windows:ManagedContainer;
      
      private var _fullscreenWindows:ManagedContainer;
      
      private var _dialogs:ManagedContainer;
      
      private var _toolTips:SimpleManagedContainer;
      
      private var _cursorCtnr:CursorManagedContainer;
      
      private var _waiting:ManagedContainer;
      
      private var _overlay:ManagedContainer;
      
      private var _systemMessages:SimpleManagedContainer;
      
      public function LobbyApp()
      {
         super();
         Extensions.enabled = true;
         Extensions.noInvisibleAdvance = true;
         CLIK.disableNullFocusMoves = true;
      }
      
      override protected function registerAliases() : void
      {
         super.registerAliases();
         registerClassAlias("net.wg.gui.components.controls.VO.ActionPriceVO",ActionPriceVO);
         registerClassAlias("net.wg.gui.lobby.components.maintenance.data.ModuleVO",ModuleVO);
         registerClassAlias("net.wg.gui.lobby.hangar.crew.TankmanVO",TankmanVO);
         registerClassAlias("net.wg.gui.lobby.hangar.crew.TankmenResponseVO",TankmenResponseVO);
         registerClassAlias("net.wg.gui.lobby.hangar.crew.TankmanRoleVO",TankmanRoleVO);
         registerClassAlias("net.wg.gui.lobby.components.data.SkillsVO",SkillsVO);
         registerClassAlias("net.wg.gui.lobby.fortifications.data.base.BuildingBaseVO",BuildingBaseVO);
         registerClassAlias("net.wg.gui.battle.views.questProgress.data.QPProgressVO",QPProgressVO);
         registerClassAlias("net.wg.gui.battle.views.questProgress.data.metrics.QPMetricsRangeVO",QPMetricsRangeVO);
         registerClassAlias("net.wg.gui.battle.views.questProgress.data.metrics.QPMetricsSimpleValueVO",QPMetricsSimpleValueVO);
         registerClassAlias("net.wg.gui.battle.views.questProgress.data.metrics.QPMetricsSimpleVO",QPMetricsSimpleVO);
         registerClassAlias("net.wg.gui.battle.views.questProgress.data.metrics.QPMetricsTimerVO",QPMetricsTimerVO);
         registerClassAlias("net.wg.gui.battle.views.questProgress.data.metrics.QPMetricsVehicleVO",QPMetricsVehicleVO);
         registerClassAlias("net.wg.gui.battle.views.questProgress.data.metrics.QPMetricsLimiterVO",QPMetricsLimiterVO);
      }
      
      override protected function getNewUtils() : IUtils
      {
         var _loc1_:IUtils = new Utils(new Asserter(),new Scheduler(),new LocaleLobby(),new WGJSON(),new HelpLayoutManager(),new ClassFactory(),new PopupManager(),new CommonsLobby(),new FocusHandlerEx(),new IME(new SimpleManagedContainer(LAYER_NAMES.IME)),new VOManager(),new Icons(),new StyleSheetManager(),new TweenAnimator(),new AnimBuilder(),new DateTimeLobby(),new PoolManager(),new DataUtils(),new CounterManager(),new ViewRestrictions(),new UniversalBtnStyles(),new AtlasManager(),new ElementBlurAdapter());
         _loc1_.setNations(new Nations(_loc1_));
         _loc1_.universalBtnStyles.setClassFactory(_loc1_.classFactory);
         return _loc1_;
      }
      
      override protected function getNewTweenManager() : ITweenManager
      {
         return new TweenManager();
      }
      
      override protected function createContainers() : void
      {
         this._serviceLayout = new ManagedContainer(LAYER_NAMES.SERVICE_LAYOUT);
         this._hiddenServiceLayout = new HiddenServiceManagedContainer(LAYER_NAMES.HIDDEN_SERVICE_LAYOUT);
         this._views = new MainViewContainer(LAYER_NAMES.VIEWS);
         this._windows = new ManagedContainer(LAYER_NAMES.WINDOWS);
         this._fullscreenWindows = new ManagedContainer(LAYER_NAMES.FULLSCREEN_WINDOWS);
         this._systemMessages = new SimpleManagedContainer(LAYER_NAMES.SYSTEM_MESSAGES);
         this._dialogs = new ManagedContainer(LAYER_NAMES.DIALOGS);
         this._toolTips = new SimpleManagedContainer(LAYER_NAMES.TOOL_TIPS);
         this._toolTips.updateMouseHandling(false);
         this._cursorCtnr = new CursorManagedContainer(LAYER_NAMES.CURSOR);
         this._waiting = new WaitingManagedContainer(LAYER_NAMES.WAITING);
         this._overlay = new ManagedContainer(LAYER_NAMES.OVERLAY);
         this._markers = new ManagedContainer(LAYER_NAMES.MARKER);
         super.createContainers();
      }
      
      override protected function initializeAtlasManager() : void
      {
         atlasMgr.registerAtlas(ATLAS_CONSTANTS.QUESTS_PROGRESS);
      }
      
      override protected function disposeContainers() : void
      {
         super.disposeContainers();
         this._views.dispose();
         this._views = null;
         this._markers.dispose();
         this._markers = null;
         this._fullscreenWindows.dispose();
         this._fullscreenWindows = null;
         this._windows.dispose();
         this._windows = null;
         this._dialogs.dispose();
         this._dialogs = null;
         this._systemMessages = null;
         this._toolTips = null;
         this._overlay.dispose();
         this._overlay = null;
         this._serviceLayout.dispose();
         this._serviceLayout = null;
         this._cursorCtnr.dispose();
         this._cursorCtnr = null;
         this._waiting.dispose();
         this._waiting = null;
      }
      
      override protected function getContainers() : Vector.<DisplayObject>
      {
         var _loc1_:DisplayObject = null;
         if(!containers)
         {
            _loc1_ = DisplayObject(utils.IME.getContainer());
            containers = new <DisplayObject>[this._hiddenServiceLayout,this._markers,this._views,this._windows,this._fullscreenWindows,this._systemMessages,this._dialogs,this._overlay,_loc1_,this._serviceLayout,this._toolTips,this._cursorCtnr,this._waiting];
         }
         return containers;
      }
      
      override protected function getNewEnvironment() : IEnvironmentManager
      {
         return EnvironmentManager.getInstance();
      }
      
      override protected function getNewSoundManager() : ISoundManager
      {
         return new SoundManager();
      }
      
      override protected function getNewCursorManager() : ICursorManager
      {
         return new CursorManager();
      }
      
      override protected function getNewTooltipManager() : ITooltipMgr
      {
         return new ToolTipManagerLobby(this._toolTips);
      }
      
      override protected function getNewContainerManager() : IContainerManager
      {
         return new ContainerManagerLobby();
      }
      
      override protected function getNewColorSchemeManager() : IColorSchemeManager
      {
         return new ColorSchemeManagerLobby();
      }
      
      override protected function getNewContextMenuManager() : IContextMenuManager
      {
         return new ContextMenuManager();
      }
      
      override protected function getNewPopoverManager() : IPopoverManager
      {
         return new PopoverManagerLobby(stage);
      }
      
      override protected function getNewClassManager() : Object
      {
         return new ClassManager();
      }
      
      override protected function getNewVoiceChatManager() : IVoiceChatManager
      {
         return new VoiceChatManagerLobby();
      }
      
      override protected function getNewGameInputManager() : IGameInputManager
      {
         return new GameInputManager();
      }
      
      override protected function getEventLogManager() : IEventLogManager
      {
         return new EventLogManager();
      }
      
      override protected function getGlobalVarsManager() : IGlobalVarsManager
      {
         return new GlobalVarsManager();
      }
      
      override protected function getNewLoaderManager() : ILoaderManager
      {
         return new LoaderManager();
      }
      
      override protected function getNewTextManager() : ITextManager
      {
         return new TextManager();
      }
      
      override protected function getNewCacheManager() : ICacheManager
      {
         return new CacheManager();
      }
      
      override protected function getNewTutorialManager() : ITutorialManager
      {
         return new TutorialManager(new CustomObjectFinderLobby());
      }
      
      override protected function getNewUILoggerManager() : IUILoggerManager
      {
         return new UILoggerManager();
      }
      
      override protected function getNewImageManagerManager() : IImageManager
      {
         return new ImageManager();
      }
      
      override protected function getNewStageSizeManager() : IStageSizeManager
      {
         return new StageSizeManager();
      }
      
      override protected function onPopUpManagerInit() : void
      {
         super.onPopUpManagerInit();
         addChildAt(utils.popupMgr.popupCanvas,this.getTooltipsLayerIndex());
      }
      
      override protected function getRegCmdName() : String
      {
         return APP_REG_CMD;
      }
      
      public function as_traceObject(param1:*) : void
      {
         DebugUtils.LOG_DEBUG("traceObject",param1);
      }
      
      private function getTooltipsLayerIndex() : Number
      {
         return getChildIndex(this._toolTips);
      }
      
      override public function get systemMessages() : DisplayObjectContainer
      {
         return this._systemMessages;
      }
      
      override protected function initStage(param1:Event = null) : void
      {
         if(gameInputMgr)
         {
            gameInputMgr.initStage(this.stage);
         }
         super.initStage(param1);
      }
   }
}
