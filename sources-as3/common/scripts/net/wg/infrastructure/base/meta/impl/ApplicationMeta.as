package net.wg.infrastructure.base.meta.impl
{
   import net.wg.data.constants.Errors;
   import net.wg.infrastructure.base.meta.ICacheManagerMeta;
   import net.wg.infrastructure.base.meta.IGameInputManagerMeta;
   import net.wg.infrastructure.base.meta.IGlobalVarsMgrMeta;
   import net.wg.infrastructure.base.meta.ILoaderManagerMeta;
   import net.wg.infrastructure.base.meta.IUtilsManagerMeta;
   import net.wg.infrastructure.exceptions.AbstractException;
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
   import scaleform.clik.core.UIComponent;
   
   public class ApplicationMeta extends UIComponent
   {
       
      
      public var setLoaderMgr:Function;
      
      public var setGlobalVarsMgr:Function;
      
      public var setSoundMgr:Function;
      
      public var setCursorMgr:Function;
      
      public var setContainerMgr:Function;
      
      public var setContextMenuMgr:Function;
      
      public var setPopoverMgr:Function;
      
      public var setColorSchemeMgr:Function;
      
      public var setEventLogMgr:Function;
      
      public var setTooltipMgr:Function;
      
      public var setVoiceChatMgr:Function;
      
      public var setUtilsMgr:Function;
      
      public var setTweenMgr:Function;
      
      public var setGameInputMgr:Function;
      
      public var setCacheMgr:Function;
      
      public var setTextMgr:Function;
      
      public var setTutorialMgr:Function;
      
      public var setImageManager:Function;
      
      public var setGraphicsOptimizationManager:Function;
      
      public var setUILoggerMgr:Function;
      
      public var handleGlobalKeyEvent:Function;
      
      public var onAsInitializationCompleted:Function;
      
      private var _vectorString:Vector.<String>;
      
      public function ApplicationMeta()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         if(this._vectorString)
         {
            this._vectorString.splice(0,this._vectorString.length);
            this._vectorString = null;
         }
         super.onDispose();
      }
      
      public function setLoaderMgrS(param1:ILoaderManagerMeta) : void
      {
         App.utils.asserter.assertNotNull(this.setLoaderMgr,"setLoaderMgr" + Errors.CANT_NULL);
         this.setLoaderMgr(param1);
      }
      
      public function setGlobalVarsMgrS(param1:IGlobalVarsMgrMeta) : void
      {
         App.utils.asserter.assertNotNull(this.setGlobalVarsMgr,"setGlobalVarsMgr" + Errors.CANT_NULL);
         this.setGlobalVarsMgr(param1);
      }
      
      public function setSoundMgrS(param1:ISoundManager) : void
      {
         App.utils.asserter.assertNotNull(this.setSoundMgr,"setSoundMgr" + Errors.CANT_NULL);
         this.setSoundMgr(param1);
      }
      
      public function setCursorMgrS(param1:ICursorManager) : void
      {
         App.utils.asserter.assertNotNull(this.setCursorMgr,"setCursorMgr" + Errors.CANT_NULL);
         this.setCursorMgr(param1);
      }
      
      public function setContainerMgrS(param1:IContainerManager) : void
      {
         App.utils.asserter.assertNotNull(this.setContainerMgr,"setContainerMgr" + Errors.CANT_NULL);
         this.setContainerMgr(param1);
      }
      
      public function setContextMenuMgrS(param1:IContextMenuManager) : void
      {
         App.utils.asserter.assertNotNull(this.setContextMenuMgr,"setContextMenuMgr" + Errors.CANT_NULL);
         this.setContextMenuMgr(param1);
      }
      
      public function setPopoverMgrS(param1:IPopoverManager) : void
      {
         App.utils.asserter.assertNotNull(this.setPopoverMgr,"setPopoverMgr" + Errors.CANT_NULL);
         this.setPopoverMgr(param1);
      }
      
      public function setColorSchemeMgrS(param1:IColorSchemeManager) : void
      {
         App.utils.asserter.assertNotNull(this.setColorSchemeMgr,"setColorSchemeMgr" + Errors.CANT_NULL);
         this.setColorSchemeMgr(param1);
      }
      
      public function setEventLogMgrS(param1:IEventLogManager) : void
      {
         App.utils.asserter.assertNotNull(this.setEventLogMgr,"setEventLogMgr" + Errors.CANT_NULL);
         this.setEventLogMgr(param1);
      }
      
      public function setTooltipMgrS(param1:ITooltipMgr) : void
      {
         App.utils.asserter.assertNotNull(this.setTooltipMgr,"setTooltipMgr" + Errors.CANT_NULL);
         this.setTooltipMgr(param1);
      }
      
      public function setVoiceChatMgrS(param1:IVoiceChatManager) : void
      {
         App.utils.asserter.assertNotNull(this.setVoiceChatMgr,"setVoiceChatMgr" + Errors.CANT_NULL);
         this.setVoiceChatMgr(param1);
      }
      
      public function setUtilsMgrS(param1:IUtilsManagerMeta) : void
      {
         App.utils.asserter.assertNotNull(this.setUtilsMgr,"setUtilsMgr" + Errors.CANT_NULL);
         this.setUtilsMgr(param1);
      }
      
      public function setTweenMgrS(param1:ITweenManager) : void
      {
         App.utils.asserter.assertNotNull(this.setTweenMgr,"setTweenMgr" + Errors.CANT_NULL);
         this.setTweenMgr(param1);
      }
      
      public function setGameInputMgrS(param1:IGameInputManagerMeta) : void
      {
         App.utils.asserter.assertNotNull(this.setGameInputMgr,"setGameInputMgr" + Errors.CANT_NULL);
         this.setGameInputMgr(param1);
      }
      
      public function setCacheMgrS(param1:ICacheManagerMeta) : void
      {
         App.utils.asserter.assertNotNull(this.setCacheMgr,"setCacheMgr" + Errors.CANT_NULL);
         this.setCacheMgr(param1);
      }
      
      public function setTextMgrS(param1:ITextManager) : void
      {
         App.utils.asserter.assertNotNull(this.setTextMgr,"setTextMgr" + Errors.CANT_NULL);
         this.setTextMgr(param1);
      }
      
      public function setTutorialMgrS(param1:ITutorialManager) : void
      {
         App.utils.asserter.assertNotNull(this.setTutorialMgr,"setTutorialMgr" + Errors.CANT_NULL);
         this.setTutorialMgr(param1);
      }
      
      public function setImageManagerS(param1:IImageManager) : void
      {
         App.utils.asserter.assertNotNull(this.setImageManager,"setImageManager" + Errors.CANT_NULL);
         this.setImageManager(param1);
      }
      
      public function setGraphicsOptimizationManagerS(param1:IGraphicsOptimizationManager) : void
      {
         App.utils.asserter.assertNotNull(this.setGraphicsOptimizationManager,"setGraphicsOptimizationManager" + Errors.CANT_NULL);
         this.setGraphicsOptimizationManager(param1);
      }
      
      public function setUILoggerMgrS(param1:IUILoggerManager) : void
      {
         App.utils.asserter.assertNotNull(this.setUILoggerMgr,"setUILoggerMgr" + Errors.CANT_NULL);
         this.setUILoggerMgr(param1);
      }
      
      public function handleGlobalKeyEventS(param1:String) : void
      {
         App.utils.asserter.assertNotNull(this.handleGlobalKeyEvent,"handleGlobalKeyEvent" + Errors.CANT_NULL);
         this.handleGlobalKeyEvent(param1);
      }
      
      public function onAsInitializationCompletedS() : void
      {
         App.utils.asserter.assertNotNull(this.onAsInitializationCompleted,"onAsInitializationCompleted" + Errors.CANT_NULL);
         this.onAsInitializationCompleted();
      }
      
      public final function as_loadLibraries(param1:Array) : void
      {
         var _loc2_:Vector.<String> = this._vectorString;
         this._vectorString = new Vector.<String>(0);
         var _loc3_:uint = param1.length;
         var _loc4_:int = 0;
         while(_loc4_ < _loc3_)
         {
            this._vectorString[_loc4_] = param1[_loc4_];
            _loc4_++;
         }
         this.loadLibraries(this._vectorString);
         if(_loc2_)
         {
            _loc2_.splice(0,_loc2_.length);
         }
      }
      
      protected function loadLibraries(param1:Vector.<String>) : void
      {
         var _loc2_:String = "as_loadLibraries" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
   }
}
