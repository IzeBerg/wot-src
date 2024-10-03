package net.wg.app.impl
{
   import flash.display.DisplayObject;
   import flash.display.DisplayObjectContainer;
   import flash.net.registerClassAlias;
   import net.wg.app.iml.base.AbstractApplication;
   import net.wg.data.VO.daapi.DAAPIVehicleInfoVO;
   import net.wg.data.VO.daapi.DAAPIVehicleStatsVO;
   import net.wg.data.VO.daapi.DAAPIVehicleUserTagsVO;
   import net.wg.data.constants.generated.ATLAS_CONSTANTS;
   import net.wg.data.constants.generated.LAYER_NAMES;
   import net.wg.gui.battle.comp7.VO.daapi.Comp7DAAPIVehicleInfoVO;
   import net.wg.gui.battle.epicRandom.VO.daapi.EpicRandomDAAPIVehicleInfoVO;
   import net.wg.gui.battle.eventBattle.VO.DAAPIHunterVehicleInfoVO;
   import net.wg.gui.battle.ranked.VO.daapi.RankedDAAPIVehicleInfoVO;
   import net.wg.gui.components.containers.CursorManagedContainer;
   import net.wg.gui.components.containers.HiddenServiceManagedContainer;
   import net.wg.gui.components.containers.MainViewContainer;
   import net.wg.gui.components.containers.ManagedContainer;
   import net.wg.gui.components.containers.SimpleManagedContainer;
   import net.wg.gui.components.containers.TooltipContainer;
   import net.wg.gui.components.controls.VO.BadgeVisualVO;
   import net.wg.gui.components.questProgress.data.QPProgressVO;
   import net.wg.gui.components.questProgress.data.metrics.QPMetricsLimiterVO;
   import net.wg.gui.components.questProgress.data.metrics.QPMetricsRangeVO;
   import net.wg.gui.components.questProgress.data.metrics.QPMetricsSimpleVO;
   import net.wg.gui.components.questProgress.data.metrics.QPMetricsSimpleValueVO;
   import net.wg.gui.components.questProgress.data.metrics.QPMetricsTimerVO;
   import net.wg.gui.components.questProgress.data.metrics.QPMetricsVehicleVO;
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
   import net.wg.infrastructure.managers.impl.ClassManager;
   import net.wg.infrastructure.managers.impl.ColorSchemeManagerBattle;
   import net.wg.infrastructure.managers.impl.CommonsBattle;
   import net.wg.infrastructure.managers.impl.ContainerManagerBattle;
   import net.wg.infrastructure.managers.impl.ContextMenuManager;
   import net.wg.infrastructure.managers.impl.ElementBlurAdapter;
   import net.wg.infrastructure.managers.impl.EnvironmentManager;
   import net.wg.infrastructure.managers.impl.ImageManager;
   import net.wg.infrastructure.managers.impl.LoaderManager;
   import net.wg.infrastructure.managers.impl.MockEventLogManager;
   import net.wg.infrastructure.managers.impl.PopoverManagerBattle;
   import net.wg.infrastructure.managers.impl.SoundManager;
   import net.wg.infrastructure.managers.impl.StageSizeManager;
   import net.wg.infrastructure.managers.impl.TextManager;
   import net.wg.infrastructure.managers.impl.ToolTipManagerBattle;
   import net.wg.infrastructure.managers.impl.TutorialManagerBattle;
   import net.wg.infrastructure.managers.impl.UILoggerManager;
   import net.wg.infrastructure.managers.impl.VoiceChatManagerBattle;
   import net.wg.infrastructure.managers.impl.cursor.CursorManager;
   import net.wg.infrastructure.managers.impl.tutorial.CustomObjectFinderBase;
   import net.wg.infrastructure.managers.pool.PoolManager;
   import net.wg.infrastructure.managers.utils.impl.Asserter;
   import net.wg.infrastructure.managers.utils.impl.ClassFactory;
   import net.wg.infrastructure.managers.utils.impl.DataUtils;
   import net.wg.infrastructure.managers.utils.impl.DateTimeBattle;
   import net.wg.infrastructure.managers.utils.impl.FocusHandlerEx;
   import net.wg.infrastructure.managers.utils.impl.IME;
   import net.wg.infrastructure.managers.utils.impl.LocaleBase;
   import net.wg.infrastructure.managers.utils.impl.PopupManager;
   import net.wg.infrastructure.managers.utils.impl.Scheduler;
   import net.wg.infrastructure.managers.utils.impl.StyleSheetManager;
   import net.wg.infrastructure.managers.utils.impl.TweenAnimator;
   import net.wg.infrastructure.managers.utils.impl.TweenManager;
   import net.wg.infrastructure.managers.utils.impl.UniversalBtnStyles;
   import net.wg.infrastructure.managers.utils.impl.Utils;
   import net.wg.infrastructure.managers.utils.impl.ViewRestrictions;
   import net.wg.infrastructure.managers.utils.impl.WGJSON;
   import net.wg.utils.IGameInputManager;
   import net.wg.utils.ITextManager;
   import net.wg.utils.ITweenManager;
   import net.wg.utils.IUtils;
   import scaleform.clik.core.CLIK;
   import scaleform.gfx.Extensions;
   
   [SWF(frameRate="50",backgroundColor="#00000000",width="1024",height="768")]
   public final class BattleApp extends AbstractApplication
   {
      
      public static const BATTLE_REG_CMD:String = "registerBattleTest";
       
      
      private var _views:MainViewContainer;
      
      private var _windows:ManagedContainer;
      
      private var _fullscreenWindows:ManagedContainer;
      
      private var _dialogs:ManagedContainer;
      
      private var _toolTips:SimpleManagedContainer;
      
      private var _systemMessages:SimpleManagedContainer;
      
      private var _cursorCtnr:CursorManagedContainer;
      
      private var _serviceLayout:ManagedContainer;
      
      private var _hiddenServiceLayout:HiddenServiceManagedContainer;
      
      private var _overlay:ManagedContainer;
      
      public function BattleApp()
      {
         super();
         Extensions.enabled = true;
         Extensions.noInvisibleAdvance = true;
         CLIK.disableNullFocusMoves = true;
      }
      
      override protected function registerAliases() : void
      {
         super.registerAliases();
         registerClassAlias("net.wg.data.VO.daapi.DAAPIVehicleStatsVO",DAAPIVehicleStatsVO);
         registerClassAlias("net.wg.data.VO.daapi.DAAPIVehicleUserTagsVO",DAAPIVehicleUserTagsVO);
         registerClassAlias("net.wg.data.VO.daapi.DAAPIVehicleInfoVO",DAAPIVehicleInfoVO);
         registerClassAlias("net.wg.gui.battle.ranked.VO.daapi.RankedDAAPIVehicleInfoVO",RankedDAAPIVehicleInfoVO);
         registerClassAlias("net.wg.gui.battle.epicRandom.VO.daapi.EpicRandomDAAPIVehicleInfoVO",EpicRandomDAAPIVehicleInfoVO);
         registerClassAlias("net.wg.gui.battle.eventBattle.VO.DAAPIHunterVehicleInfoVO",DAAPIHunterVehicleInfoVO);
         registerClassAlias("net.wg.gui.battle.views.questProgress.data.QPProgressVO",QPProgressVO);
         registerClassAlias("net.wg.gui.battle.views.questProgress.data.metrics.QPMetricsRangeVO",QPMetricsRangeVO);
         registerClassAlias("net.wg.gui.battle.views.questProgress.data.metrics.QPMetricsSimpleValueVO",QPMetricsSimpleValueVO);
         registerClassAlias("net.wg.gui.battle.views.questProgress.data.metrics.QPMetricsSimpleVO",QPMetricsSimpleVO);
         registerClassAlias("net.wg.gui.battle.views.questProgress.data.metrics.QPMetricsTimerVO",QPMetricsTimerVO);
         registerClassAlias("net.wg.gui.battle.views.questProgress.data.metrics.QPMetricsVehicleVO",QPMetricsVehicleVO);
         registerClassAlias("net.wg.gui.battle.views.questProgress.data.metrics.QPMetricsLimiterVO",QPMetricsLimiterVO);
         registerClassAlias("net.wg.gui.components.controls.VO.BadgeVisualVO",BadgeVisualVO);
         registerClassAlias("net.wg.gui.battle.comp7.VO.daapi.Comp7DAAPIVehicleInfoVO",Comp7DAAPIVehicleInfoVO);
      }
      
      override protected function onPopUpManagerInit() : void
      {
         super.onPopUpManagerInit();
         addChildAt(utils.popupMgr.popupCanvas,this.getTooltipsLayerIndex());
      }
      
      override protected function getNewUtils() : IUtils
      {
         var _loc1_:IUtils = new Utils(new Asserter(),new Scheduler(),new LocaleBase(),new WGJSON(),null,new ClassFactory(),new PopupManager(),new CommonsBattle(),new FocusHandlerEx(),new IME(new SimpleManagedContainer(LAYER_NAMES.IME)),null,null,new StyleSheetManager(),new TweenAnimator(),null,new DateTimeBattle(),new PoolManager(),new DataUtils(),new CounterManager(),new ViewRestrictions(),new UniversalBtnStyles(),new AtlasManager(),new ElementBlurAdapter());
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
         this._toolTips = new TooltipContainer(LAYER_NAMES.TOOL_TIPS);
         this._cursorCtnr = new CursorManagedContainer(LAYER_NAMES.CURSOR);
         this._overlay = new ManagedContainer(LAYER_NAMES.OVERLAY);
         super.createContainers();
      }
      
      override protected function disposeContainers() : void
      {
         super.disposeContainers();
         this._views.dispose();
         this._views = null;
         this._dialogs.dispose();
         this._dialogs = null;
         this._fullscreenWindows.dispose();
         this._fullscreenWindows = null;
         this._windows.dispose();
         this._windows = null;
         this._cursorCtnr.dispose();
         this._cursorCtnr = null;
         this._serviceLayout.dispose();
         this._serviceLayout = null;
         this._overlay.dispose();
         this._overlay = null;
         this._systemMessages = null;
         this._toolTips = null;
      }
      
      override protected function getContainers() : Vector.<DisplayObject>
      {
         var _loc1_:DisplayObject = null;
         if(!containers)
         {
            _loc1_ = DisplayObject(utils.IME.getContainer());
            containers = new <DisplayObject>[this._hiddenServiceLayout,this._views,this._windows,this._fullscreenWindows,this._systemMessages,this._dialogs,this._overlay,_loc1_,this._serviceLayout,this._toolTips,this._cursorCtnr];
         }
         return containers;
      }
      
      override protected function getRegCmdName() : String
      {
         return BATTLE_REG_CMD;
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
         return new ToolTipManagerBattle(this._toolTips);
      }
      
      override protected function getNewContainerManager() : IContainerManager
      {
         return new ContainerManagerBattle();
      }
      
      override protected function getNewColorSchemeManager() : IColorSchemeManager
      {
         return new ColorSchemeManagerBattle();
      }
      
      override protected function getNewContextMenuManager() : IContextMenuManager
      {
         return new ContextMenuManager();
      }
      
      override protected function getNewPopoverManager() : IPopoverManager
      {
         return new PopoverManagerBattle(stage);
      }
      
      override protected function getNewTutorialManager() : ITutorialManager
      {
         return new TutorialManagerBattle(new CustomObjectFinderBase());
      }
      
      override protected function getNewUILoggerManager() : IUILoggerManager
      {
         return new UILoggerManager();
      }
      
      override protected function getNewClassManager() : Object
      {
         return new ClassManager();
      }
      
      override protected function getNewVoiceChatManager() : IVoiceChatManager
      {
         return new VoiceChatManagerBattle();
      }
      
      override protected function getNewGameInputManager() : IGameInputManager
      {
         return null;
      }
      
      override protected function getEventLogManager() : IEventLogManager
      {
         return new MockEventLogManager();
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
         return null;
      }
      
      override protected function getNewImageManagerManager() : IImageManager
      {
         return new ImageManager();
      }
      
      override protected function getNewStageSizeManager() : IStageSizeManager
      {
         return new StageSizeManager();
      }
      
      override protected function initializeAtlasManager() : void
      {
         atlasMgr.registerAtlas(ATLAS_CONSTANTS.BATTLE_ATLAS);
         atlasMgr.registerAtlas(ATLAS_CONSTANTS.QUESTS_PROGRESS);
      }
      
      override protected function onAfterAppConfiguring() : void
      {
         DebugUtils.LOG_DEBUG("BattleApp configure finished");
         super.onAfterAppConfiguring();
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
   }
}
