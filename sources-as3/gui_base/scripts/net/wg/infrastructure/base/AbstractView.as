package net.wg.infrastructure.base
{
   import flash.display.DisplayObject;
   import flash.display.DisplayObjectContainer;
   import flash.display.InteractiveObject;
   import flash.display.Loader;
   import flash.utils.getQualifiedClassName;
   import net.wg.data.constants.Errors;
   import net.wg.data.constants.Values;
   import net.wg.data.daapi.LoadViewVO;
   import net.wg.infrastructure.base.meta.IAbstractViewMeta;
   import net.wg.infrastructure.base.meta.impl.AbstractViewMeta;
   import net.wg.infrastructure.events.TutorialEvent;
   import net.wg.infrastructure.exceptions.InfrastructureException;
   import net.wg.infrastructure.exceptions.LifecycleException;
   import net.wg.infrastructure.interfaces.IManagedContent;
   import net.wg.infrastructure.interfaces.IView;
   import net.wg.utils.IUtils;
   import org.idmedia.as3commons.util.StringUtils;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.core.UIComponent;
   import scaleform.clik.events.FocusHandlerEvent;
   import scaleform.clik.events.InputEvent;
   import scaleform.clik.managers.InputDelegate;
   
   [Event(name="onAfterDispose",type="net.wg.infrastructure.events.LifeCycleEvent")]
   [Event(name="onBeforeDispose",type="net.wg.infrastructure.events.LifeCycleEvent")]
   [Event(name="onAfterPopulate",type="net.wg.infrastructure.events.LifeCycleEvent")]
   [Event(name="onBeforePopulate",type="net.wg.infrastructure.events.LifeCycleEvent")]
   public class AbstractView extends AbstractViewMeta implements IView, IAbstractViewMeta
   {
      
      private static const SET_MODAL_FOCUS_MESSAGE:String = "Last focused element is not on display list! Use setfocus before removing element ";
      
      private static const SET_FOCUS_ASSERT_MESSAGE:String = "focus must be set to object in display list only.";
      
      private static const INVALID_MODAL_FOCUS:String = "invalidModalFocus";
      
      protected static const SHOW_VIEW_PROP_FORBIDDEN:int = 0;
      
      protected static const SHOW_VIEW_PROP_AFTER_POPULATE:int = 1;
      
      protected static const SHOW_VIEW_PROP_AFTER_BG_READY:int = 2;
       
      
      private var _config:LoadViewVO = null;
      
      private var _waitingFocusToInitialization:Boolean = false;
      
      private var _firstModalFocusUpdating:Boolean = true;
      
      private var _loader:Loader = null;
      
      private var _lastFocusedElement:InteractiveObject = null;
      
      public function AbstractView()
      {
         visible = false;
         super();
         addEventListener(FocusHandlerEvent.FOCUS_IN,this.onFocusInHandler);
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         if(this.allowHandleInput())
         {
            addEventListener(InputEvent.INPUT,handleInput,false,0,true);
         }
         initSize();
      }
      
      override protected function draw() : void
      {
         var _loc1_:InteractiveObject = null;
         super.draw();
         if(constraints && isInvalid(InvalidationType.SIZE))
         {
            constraints.update(_width,_height);
         }
         if(isInvalid(INVALID_MODAL_FOCUS) && this.hasFocus)
         {
            _loc1_ = this.getManualFocus();
            if(this._firstModalFocusUpdating)
            {
               this._firstModalFocusUpdating = false;
               this.onInitModalFocus(_loc1_);
            }
            this.onSetModalFocus(_loc1_);
            if(this.getManualFocus() == null && !this._waitingFocusToInitialization)
            {
               this.setFocus(this);
            }
         }
      }
      
      override protected function onPopulate() : void
      {
         super.onPopulate();
         App.utils.scheduler.scheduleOnNextFrame(this.nextFrameAfterPopulateHandler);
      }
      
      override protected function onBeforeDispose() : void
      {
         InputDelegate.getInstance().checkAndCleanUpCurrentEvent(this);
         this.setLastFocusedElement(null);
         removeEventListener(FocusHandlerEvent.FOCUS_IN,this.onFocusInHandler);
         var _loc1_:IUtils = App.utils;
         App.toolTipMgr.hide();
         App.contextMenuMgr.hide();
         _loc1_.scheduler.cancelTask(this.setFocus);
         _loc1_.scheduler.cancelTask(this.nextFrameAfterPopulateHandler);
         removeEventListener(InputEvent.INPUT,handleInput);
         removeEventListener(TutorialEvent.VIEW_READY_FOR_TUTORIAL,this.onViewReadyForTutorialHandler);
         super.onBeforeDispose();
      }
      
      override protected function onDispose() : void
      {
         if(!this._config.cached)
         {
            if(!this._loader)
            {
               this.assert(false,"loader in " + getQualifiedClassName(this) + "(" + this._config.alias + " alias)");
            }
            App.utils.scheduler.scheduleOnNextFrame(this._loader.unloadAndStop);
            this._loader = null;
         }
         this._config.dispose();
         this._config = null;
         super.onDispose();
      }
      
      public function getFocusIndex() : Number
      {
         return App.containerMgr.getFocusPriority(this._config.configVO.layer);
      }
      
      public function getSubContainers() : Array
      {
         return [];
      }
      
      public final function leaveModalFocus() : void
      {
         cancelValidation(INVALID_MODAL_FOCUS);
         this.onLeaveModalFocus();
      }
      
      public function playHideTween(param1:DisplayObject, param2:Function = null) : Boolean
      {
         return false;
      }
      
      public function playShowTween(param1:DisplayObject, param2:Function = null) : Boolean
      {
         return false;
      }
      
      public final function setModalFocus() : void
      {
         invalidate(INVALID_MODAL_FOCUS);
      }
      
      public function setViewSize(param1:Number, param2:Number) : void
      {
         _originalWidth = param1;
         _originalHeight = param2;
         setActualSize(param1,param2);
         setActualScale(1,1);
      }
      
      public function unregisterComponent(param1:String) : void
      {
         this.assertLifeCycle();
         unregisterFlashComponentS(param1);
      }
      
      public function updateStage(param1:Number, param2:Number) : void
      {
      }
      
      protected function getViewContainer() : DisplayObjectContainer
      {
         return this;
      }
      
      protected function onInitModalFocus(param1:InteractiveObject) : void
      {
      }
      
      protected function onSetModalFocus(param1:InteractiveObject) : void
      {
         var _loc2_:String = null;
         if(this._lastFocusedElement != null && (param1 == this._lastFocusedElement || param1 == null))
         {
            _loc2_ = SET_MODAL_FOCUS_MESSAGE + this._lastFocusedElement;
            App.utils.asserter.assertNotNull(this._lastFocusedElement.parent,_loc2_,InfrastructureException);
            this.setFocus(this._lastFocusedElement);
         }
         else
         {
            this.setLastFocusedElement(param1);
         }
      }
      
      protected function onLeaveModalFocus() : void
      {
         var _loc1_:InteractiveObject = this.getManualFocus();
         if(_loc1_ != null)
         {
            this.setLastFocusedElement(_loc1_);
         }
      }
      
      protected final function setFocus(param1:InteractiveObject) : void
      {
         this.assertNotNull(param1,"element");
         this.assert(param1.stage != null,SET_FOCUS_ASSERT_MESSAGE);
         App.utils.scheduler.cancelTask(this.setFocus);
         this._waitingFocusToInitialization = false;
         if(this.hasFocus)
         {
            if(param1 is UIComponent && !UIComponent(param1).initialized)
            {
               App.utils.scheduler.scheduleOnNextFrame(this.setFocus,param1);
               this._waitingFocusToInitialization = true;
            }
            else
            {
               App.utils.focusHandler.setFocus(param1);
            }
         }
         this.setLastFocusedElement(param1);
         this.onSetFocus(param1);
      }
      
      protected function onSetFocus(param1:InteractiveObject) : void
      {
      }
      
      protected function nextFrameAfterPopulateHandler() : void
      {
         if(this.canAutoShowView())
         {
            visible = true;
         }
      }
      
      protected function allowHandleInput() : Boolean
      {
         return true;
      }
      
      protected final function assert(param1:Boolean, param2:String = "failed assert", param3:Class = null) : void
      {
         if(App.instance)
         {
            App.utils.asserter.assert(param1,param2,param3);
         }
      }
      
      protected final function assertLifeCycle() : void
      {
         this.assert(!disposed,Errors.MTHD_CORRUPT_INVOKE,LifecycleException);
      }
      
      protected final function assertNotNull(param1:Object, param2:String = "object", param3:Class = null) : void
      {
         if(App.instance)
         {
            App.utils.asserter.assertNotNull(param1,param2 + Errors.CANT_NULL,param3);
         }
      }
      
      protected final function assertNull(param1:Object, param2:String = "object", param3:Class = null) : void
      {
         if(App.instance)
         {
            App.utils.asserter.assertNull(param1,param2 + Errors.MUST_NULL,param3);
         }
      }
      
      private function canAutoShowView() : Boolean
      {
         return this.autoShowViewProperty == SHOW_VIEW_PROP_AFTER_POPULATE;
      }
      
      private function getManualFocus() : InteractiveObject
      {
         var _loc2_:InteractiveObject = null;
         var _loc1_:InteractiveObject = App.utils.focusHandler.getFocus(0);
         if(_loc1_ != null && _loc1_.stage != null)
         {
            _loc2_ = _loc1_;
            if(this._lastFocusedElement == _loc2_)
            {
               return _loc1_;
            }
            while(_loc2_ != null)
            {
               if(_loc2_ == this.getViewContainer())
               {
                  return _loc1_;
               }
               _loc2_ = _loc2_.parent;
            }
         }
         return null;
      }
      
      private function setLastFocusedElement(param1:InteractiveObject) : void
      {
         if(this._lastFocusedElement == param1)
         {
            return;
         }
         if(this._lastFocusedElement != null)
         {
            this._lastFocusedElement.removeEventListener(FocusHandlerEvent.FOCUS_OUT,this.onLastFocusedElementFocusOutHandler);
         }
         this._lastFocusedElement = param1;
         if(this._lastFocusedElement != null)
         {
            this._lastFocusedElement.addEventListener(FocusHandlerEvent.FOCUS_OUT,this.onLastFocusedElementFocusOutHandler);
         }
      }
      
      override public final function get hasFocus() : Boolean
      {
         return App.utils.focusHandler.hasModalFocus(this);
      }
      
      public function get loader() : Loader
      {
         return this._loader;
      }
      
      public function set loader(param1:Loader) : void
      {
         this._loader = param1;
      }
      
      public function get isModal() : Boolean
      {
         return false;
      }
      
      public function get modalAlpha() : Number
      {
         return Values.DEFAULT_ALPHA;
      }
      
      public function get sourceView() : IView
      {
         return this;
      }
      
      public function get containerContent() : IManagedContent
      {
         return this;
      }
      
      public function get as_config() : LoadViewVO
      {
         return this._config;
      }
      
      public function set as_config(param1:LoadViewVO) : void
      {
         this._config = param1;
         if(StringUtils.isNotEmpty(param1.viewTutorialId))
         {
            addEventListener(TutorialEvent.VIEW_READY_FOR_TUTORIAL,this.onViewReadyForTutorialHandler);
            App.tutorialMgr.setViewForTutorialId(this,param1.viewTutorialId);
         }
      }
      
      public function get tutorialId() : String
      {
         return this._config.viewTutorialId;
      }
      
      public function set tutorialId(param1:String) : void
      {
         this._config.viewTutorialId = param1;
      }
      
      public function get isResizable() : Boolean
      {
         return this._config.configVO.isResizable;
      }
      
      protected function get autoShowViewProperty() : int
      {
         return SHOW_VIEW_PROP_AFTER_POPULATE;
      }
      
      protected function get lastFocusedElement() : InteractiveObject
      {
         return this._lastFocusedElement;
      }
      
      private function onFocusInHandler(param1:FocusHandlerEvent) : void
      {
         onFocusInS(this._config.alias);
      }
      
      private function onLastFocusedElementFocusOutHandler(param1:FocusHandlerEvent) : void
      {
         var _loc5_:String = null;
         var _loc2_:InteractiveObject = this.getManualFocus();
         var _loc3_:Boolean = false;
         var _loc4_:InteractiveObject = App.utils.focusHandler.getFocus(0);
         if(_loc4_ != null)
         {
            _loc3_ = _loc4_.stage == null;
         }
         if(this.hasFocus && !_loc3_)
         {
            _loc5_ = "modal-focused view \'" + this + "\' has lost a component focus!";
            this.assert(_loc2_ != null,_loc5_,InfrastructureException);
         }
         this.setLastFocusedElement(_loc2_);
      }
      
      private function onViewReadyForTutorialHandler(param1:TutorialEvent) : void
      {
         param1.stopImmediatePropagation();
         App.tutorialMgr.onComponentCheckComplete(this._config.alias,param1,this._config.viewTutorialId);
      }
   }
}
