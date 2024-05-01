package net.wg.gui.lobby.sessionStats
{
   import net.wg.data.constants.generated.SESSION_STATS_CONSTANTS;
   import net.wg.gui.components.popovers.PopOver;
   import net.wg.gui.events.ViewStackEvent;
   import net.wg.gui.lobby.components.ResizableViewStack;
   import net.wg.gui.lobby.sessionStats.data.SessionStatsPopoverVO;
   import net.wg.gui.lobby.sessionStats.events.SessionStatsPopoverResizeEvent;
   import net.wg.gui.lobby.sessionStats.helpers.SessionStatsHelper;
   import net.wg.gui.lobby.sessionStats.interfaces.ISeassonResizableContent;
   import net.wg.infrastructure.base.BaseDAAPIComponent;
   import net.wg.infrastructure.base.meta.ISessionStatsPopoverMeta;
   import net.wg.infrastructure.base.meta.impl.SessionStatsPopoverMeta;
   import net.wg.infrastructure.interfaces.IWrapper;
   import net.wg.utils.IStageSizeDependComponent;
   import scaleform.clik.constants.InvalidationType;
   
   public class SessionStatsPopover extends SessionStatsPopoverMeta implements ISessionStatsPopoverMeta, IStageSizeDependComponent
   {
       
      
      public var viewStack:ResizableViewStack = null;
      
      private var _currentView:ISeassonResizableContent = null;
      
      private var _currentLinkage:String = "";
      
      private var _data:SessionStatsPopoverVO = null;
      
      private var _isExpanded:Boolean = false;
      
      public function SessionStatsPopover()
      {
         super();
      }
      
      override public function set wrapper(param1:IWrapper) : void
      {
         super.wrapper = param1;
         PopOver(param1).isCloseBtnVisible = true;
      }
      
      public function setStateSizeBoundaries(param1:int, param2:int) : void
      {
         invalidateSize();
      }
      
      override protected function draw() : void
      {
         var _loc1_:Number = NaN;
         var _loc2_:Number = NaN;
         var _loc3_:int = 0;
         if(this._data && isInvalid(InvalidationType.DATA))
         {
            if(this._data.linkage != this._currentLinkage)
            {
               this._currentLinkage = this._data.linkage;
               this._currentView = ISeassonResizableContent(this.viewStack.show(this._currentLinkage,this._currentLinkage));
               invalidateSize();
            }
         }
         if(isInvalid(InvalidationType.SIZE))
         {
            _loc1_ = SessionStatsHelper.TOTAL_WIDTH;
            _loc2_ = SessionStatsHelper.getExpandedHeight(this.isSettings() || this._isExpanded);
            if(this._currentView != null)
            {
               if(!this.isSettings())
               {
                  _loc3_ = this._currentView.contentHeight();
                  _loc2_ = Math.min(_loc3_,_loc2_);
               }
               this._currentView.setViewSize(_loc1_,_loc2_);
            }
            setViewSize(_loc1_,_loc2_);
         }
         super.draw();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.viewStack.cache = true;
         this.viewStack.addEventListener(SessionStatsPopoverResizeEvent.EXPANDED,this.onContentExpandedHandler);
         this.viewStack.addEventListener(SessionStatsPopoverResizeEvent.RESIZED,this.onContentResizedHandler);
         this.viewStack.addEventListener(ViewStackEvent.VIEW_CHANGED,this.onViewStackViewChangedHandler);
         App.stageSizeMgr.register(this);
      }
      
      override protected function onDispose() : void
      {
         App.stageSizeMgr.unregister(this);
         this.viewStack.removeEventListener(SessionStatsPopoverResizeEvent.EXPANDED,this.onContentExpandedHandler);
         this.viewStack.removeEventListener(SessionStatsPopoverResizeEvent.RESIZED,this.onContentResizedHandler);
         this.viewStack.removeEventListener(ViewStackEvent.VIEW_CHANGED,this.onViewStackViewChangedHandler);
         this.viewStack.dispose();
         this.viewStack = null;
         this._currentView = null;
         this._data = null;
         super.onDispose();
      }
      
      override protected function setData(param1:SessionStatsPopoverVO) : void
      {
         this._data = param1;
         invalidateData();
      }
      
      private function onContentExpandedHandler(param1:SessionStatsPopoverResizeEvent) : void
      {
         if(this._isExpanded == param1.isExpanded)
         {
            return;
         }
         this._isExpanded = param1.isExpanded;
         invalidateSize();
         validateNow();
      }
      
      private function onContentResizedHandler(param1:SessionStatsPopoverResizeEvent) : void
      {
         invalidateSize();
      }
      
      private function onViewStackViewChangedHandler(param1:ViewStackEvent) : void
      {
         if(!isFlashComponentRegisteredS(this._data.alias))
         {
            registerFlashComponentS(BaseDAAPIComponent(param1.view),this._data.alias);
         }
         invalidateSize();
      }
      
      private function isSettings() : Boolean
      {
         return this._currentLinkage == SESSION_STATS_CONSTANTS.SESSION_STATS_SETTINGS_VIEW_LINKAGE;
      }
   }
}
