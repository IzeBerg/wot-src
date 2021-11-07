package net.wg.app
{
   import flash.display.DisplayObjectContainer;
   import flash.display.Stage;
   import lesta.unbound2.proxy.UbPlayerProxy;
   import net.wg.infrastructure.base.meta.IApplicationMeta;
   import net.wg.infrastructure.interfaces.ICursorManager;
   import net.wg.infrastructure.managers.IAtlasManager;
   import net.wg.infrastructure.managers.ICacheManager;
   import net.wg.infrastructure.managers.IColorSchemeManager;
   import net.wg.infrastructure.managers.IContainerManager;
   import net.wg.infrastructure.managers.IContextMenuManager;
   import net.wg.infrastructure.managers.IEnvironmentManager;
   import net.wg.infrastructure.managers.IEventLogManager;
   import net.wg.infrastructure.managers.IGlobalVarsManager;
   import net.wg.infrastructure.managers.IGraphicsOptimizationManager;
   import net.wg.infrastructure.managers.IImageManager;
   import net.wg.infrastructure.managers.ILoaderManager;
   import net.wg.infrastructure.managers.IPopoverManager;
   import net.wg.infrastructure.managers.ISoundManager;
   import net.wg.infrastructure.managers.IStageSizeManager;
   import net.wg.infrastructure.managers.ITooltipMgr;
   import net.wg.infrastructure.managers.ITutorialManager;
   import net.wg.infrastructure.managers.IUILoggerManager;
   import net.wg.infrastructure.managers.IVoiceChatManager;
   import net.wg.infrastructure.managers.IWaitingView;
   import net.wg.utils.IGameInputManager;
   import net.wg.utils.ITextManager;
   import net.wg.utils.ITweenManager;
   import net.wg.utils.IUtils;
   
   public interface IApplication extends IApplicationMeta
   {
       
      
      function setUbPlayerProxy(param1:UbPlayerProxy) : void;
      
      function get appWidth() : Number;
      
      function get appHeight() : Number;
      
      function get appScale() : Number;
      
      function get stage() : Stage;
      
      function get systemMessages() : DisplayObjectContainer;
      
      function get globalVarsMgr() : IGlobalVarsManager;
      
      function get soundMgr() : ISoundManager;
      
      function get toolTipMgr() : ITooltipMgr;
      
      function get uiLoggerManager() : IUILoggerManager;
      
      function get waiting() : IWaitingView;
      
      function get environment() : IEnvironmentManager;
      
      function get cursor() : ICursorManager;
      
      function get containerMgr() : IContainerManager;
      
      function get textMgr() : ITextManager;
      
      function get contextMenuMgr() : IContextMenuManager;
      
      function get popoverMgr() : IPopoverManager;
      
      function get colorSchemeMgr() : IColorSchemeManager;
      
      function get voiceChatMgr() : IVoiceChatManager;
      
      function get gameInputMgr() : IGameInputManager;
      
      function get eventLogManager() : IEventLogManager;
      
      function get loaderMgr() : ILoaderManager;
      
      function get cacheMgr() : ICacheManager;
      
      function get tutorialMgr() : ITutorialManager;
      
      function get atlasMgr() : IAtlasManager;
      
      function get imageMgr() : IImageManager;
      
      function get utils() : IUtils;
      
      function get tweenMgr() : ITweenManager;
      
      function get graphicsOptimizationMgr() : IGraphicsOptimizationManager;
      
      function get stageSizeMgr() : IStageSizeManager;
   }
}
