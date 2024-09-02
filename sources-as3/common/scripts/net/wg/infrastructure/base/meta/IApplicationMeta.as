package net.wg.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;
   import net.wg.infrastructure.interfaces.ICursorManager;
   import net.wg.infrastructure.managers.IColorSchemeManager;
   import net.wg.infrastructure.managers.IContainerManager;
   import net.wg.infrastructure.managers.IContextMenuManager;
   import net.wg.infrastructure.managers.IEventLogManager;
   import net.wg.infrastructure.managers.IGraphicsOptimizationManager;
   import net.wg.infrastructure.managers.IImageManager;
   import net.wg.infrastructure.managers.IPopoverManager;
   import net.wg.infrastructure.managers.ISoundManager;
   import net.wg.infrastructure.managers.ITooltipMgr;
   import net.wg.infrastructure.managers.ITutorialManager;
   import net.wg.infrastructure.managers.IUILoggerManager;
   import net.wg.infrastructure.managers.IVoiceChatManager;
   import net.wg.utils.ITextManager;
   import net.wg.utils.ITweenManager;
   
   public interface IApplicationMeta extends IEventDispatcher
   {
       
      
      function setLoaderMgrS(param1:ILoaderManagerMeta) : void;
      
      function setGlobalVarsMgrS(param1:IGlobalVarsMgrMeta) : void;
      
      function setSoundMgrS(param1:ISoundManager) : void;
      
      function setCursorMgrS(param1:ICursorManager) : void;
      
      function setContainerMgrS(param1:IContainerManager) : void;
      
      function setContextMenuMgrS(param1:IContextMenuManager) : void;
      
      function setPopoverMgrS(param1:IPopoverManager) : void;
      
      function setColorSchemeMgrS(param1:IColorSchemeManager) : void;
      
      function setEventLogMgrS(param1:IEventLogManager) : void;
      
      function setTooltipMgrS(param1:ITooltipMgr) : void;
      
      function setVoiceChatMgrS(param1:IVoiceChatManager) : void;
      
      function setUtilsMgrS(param1:IUtilsManagerMeta) : void;
      
      function setTweenMgrS(param1:ITweenManager) : void;
      
      function setGameInputMgrS(param1:IGameInputManagerMeta) : void;
      
      function setCacheMgrS(param1:ICacheManagerMeta) : void;
      
      function setTextMgrS(param1:ITextManager) : void;
      
      function setTutorialMgrS(param1:ITutorialManager) : void;
      
      function setImageManagerS(param1:IImageManager) : void;
      
      function setGraphicsOptimizationManagerS(param1:IGraphicsOptimizationManager) : void;
      
      function setUILoggerMgrS(param1:IUILoggerManager) : void;
      
      function handleGlobalKeyEventS(param1:String) : void;
      
      function onAsInitializationCompletedS() : void;
      
      function as_isDAAPIInited() : Boolean;
      
      function as_populate() : void;
      
      function as_dispose() : void;
      
      function as_registerManagers() : void;
      
      function as_loadLibraries(param1:Array) : void;
      
      function as_updateStage(param1:Number, param2:Number, param3:Number) : void;
      
      function as_blurBackgroundViews(param1:int, param2:Number, param3:Number) : void;
      
      function as_unblurBackgroundViews() : void;
      
      function as_setMouseEventsEnabled(param1:Boolean) : void;
   }
}
