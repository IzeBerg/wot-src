package
{
   import flash.display.DisplayObjectContainer;
   import flash.display.Stage;
   import net.wg.app.IApplication;
   import net.wg.data.constants.LobbyMetrics;
   import net.wg.infrastructure.base.meta.IGlobalVarsMgrMeta;
   import net.wg.infrastructure.interfaces.ICursorManager;
   import net.wg.infrastructure.managers.IAtlasManager;
   import net.wg.infrastructure.managers.ICacheManager;
   import net.wg.infrastructure.managers.IColorSchemeManager;
   import net.wg.infrastructure.managers.IContainerManager;
   import net.wg.infrastructure.managers.IContextMenuManager;
   import net.wg.infrastructure.managers.IEnvironmentManager;
   import net.wg.infrastructure.managers.IEventLogManager;
   import net.wg.infrastructure.managers.IGraphicsOptimizationManager;
   import net.wg.infrastructure.managers.IImageManager;
   import net.wg.infrastructure.managers.IPopoverManager;
   import net.wg.infrastructure.managers.ISoundManager;
   import net.wg.infrastructure.managers.IStageSizeManager;
   import net.wg.infrastructure.managers.ITooltipMgr;
   import net.wg.infrastructure.managers.ITutorialManager;
   import net.wg.infrastructure.managers.IUILoggerManager;
   import net.wg.infrastructure.managers.IVoiceChatManager;
   import net.wg.infrastructure.managers.IWaitingView;
   import net.wg.mock.MockApplication;
   import net.wg.utils.IGameInputManager;
   import net.wg.utils.ITextManager;
   import net.wg.utils.ITweenManager;
   import net.wg.utils.IUtils;
   import scaleform.gfx.Extensions;
   
   public class App
   {
      
      private static var ms_instance:IApplication;
       
      
      public function App()
      {
         super();
      }
      
      public static function get instance() : IApplication
      {
         if(ms_instance == null && (!Extensions.isScaleform || Extensions.isGFxPlayer))
         {
            ms_instance = new MockApplication();
         }
         return ms_instance;
      }
      
      public static function set instance(param1:IApplication) : void
      {
         if(ms_instance == null)
         {
            ms_instance = param1;
         }
         else
         {
            DebugUtils.LOG_ERROR("Application already set to App!");
         }
      }
      
      public static function get globalVarsMgr() : IGlobalVarsMgrMeta
      {
         return instance.globalVarsMgr;
      }
      
      public static function get soundMgr() : ISoundManager
      {
         return instance.soundMgr;
      }
      
      public static function get toolTipMgr() : ITooltipMgr
      {
         return instance.toolTipMgr;
      }
      
      public static function get container() : DisplayObjectContainer
      {
         return instance.toolTipMgr.getContainer();
      }
      
      public static function get waiting() : IWaitingView
      {
         return instance != null ? instance.waiting : null;
      }
      
      public static function get environment() : IEnvironmentManager
      {
         return instance.environment;
      }
      
      public static function get contextMenuMgr() : IContextMenuManager
      {
         return instance.contextMenuMgr;
      }
      
      public static function get popoverMgr() : IPopoverManager
      {
         return instance.popoverMgr;
      }
      
      public static function get colorSchemeMgr() : IColorSchemeManager
      {
         return instance.colorSchemeMgr;
      }
      
      public static function get textMgr() : ITextManager
      {
         return instance.textMgr;
      }
      
      public static function get voiceChatMgr() : IVoiceChatManager
      {
         return instance.voiceChatMgr;
      }
      
      public static function get utils() : IUtils
      {
         return instance.utils;
      }
      
      public static function get tweenMgr() : ITweenManager
      {
         return instance.tweenMgr;
      }
      
      public static function get cursor() : ICursorManager
      {
         return instance.cursor;
      }
      
      public static function get containerMgr() : IContainerManager
      {
         return instance.containerMgr;
      }
      
      public static function get gameInputMgr() : IGameInputManager
      {
         return instance.gameInputMgr;
      }
      
      public static function get eventLogManager() : IEventLogManager
      {
         return instance.eventLogManager;
      }
      
      public static function get imageMgr() : IImageManager
      {
         return instance.imageMgr;
      }
      
      public static function get cacheMgr() : ICacheManager
      {
         return instance.cacheMgr;
      }
      
      public static function get tutorialMgr() : ITutorialManager
      {
         return instance.tutorialMgr;
      }
      
      public static function get uiLoggerManager() : IUILoggerManager
      {
         return instance.uiLoggerManager;
      }
      
      public static function get atlasMgr() : IAtlasManager
      {
         return instance.atlasMgr;
      }
      
      public static function get graphicsOptimizationMgr() : IGraphicsOptimizationManager
      {
         return instance.graphicsOptimizationMgr;
      }
      
      public static function get stageSizeMgr() : IStageSizeManager
      {
         return instance.stageSizeMgr;
      }
      
      public static function get appWidth() : Number
      {
         return instance != null ? Number(instance.appWidth) : Number(LobbyMetrics.MIN_STAGE_WIDTH);
      }
      
      public static function get appHeight() : Number
      {
         return instance != null ? Number(instance.appHeight) : Number(LobbyMetrics.MIN_STAGE_HEIGHT);
      }
      
      public static function get appScale() : Number
      {
         return instance != null ? Number(instance.appScale) : Number(1);
      }
      
      public static function get stage() : Stage
      {
         return instance.stage;
      }
      
      public static function get systemMessages() : DisplayObjectContainer
      {
         return instance.systemMessages;
      }
   }
}
