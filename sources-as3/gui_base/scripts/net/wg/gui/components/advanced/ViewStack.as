package net.wg.gui.components.advanced
{
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import net.wg.data.constants.generated.EVENT_LOG_CONSTANTS;
   import net.wg.gui.events.ViewStackContentEvent;
   import net.wg.gui.events.ViewStackEvent;
   import net.wg.gui.interfaces.IGroupedControl;
   import net.wg.infrastructure.base.UIComponentEx;
   import net.wg.infrastructure.events.LifeCycleEvent;
   import net.wg.infrastructure.exceptions.ArgumentException;
   import net.wg.infrastructure.exceptions.InfrastructureException;
   import net.wg.infrastructure.interfaces.ITutorialCustomComponent;
   import net.wg.infrastructure.interfaces.IViewStackContent;
   import net.wg.infrastructure.interfaces.entity.IDAAPIEntity;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   import net.wg.utils.IAssertable;
   import org.idmedia.as3commons.util.StringUtils;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.events.IndexEvent;
   
   public class ViewStack extends UIComponentEx implements ITutorialCustomComponent
   {
       
      
      [Inspectable(defaultValue="false")]
      public var cache:Boolean = false;
      
      public var rescaleContainer:Boolean = true;
      
      public var cachedViews:Object;
      
      private var _container:Sprite;
      
      private var _targetGroup:IGroupedControl = null;
      
      private var _currentView:IViewStackContent;
      
      private var _currentViewId:String;
      
      private var _setViewId:String;
      
      public function ViewStack()
      {
         App.tutorialMgr.addListenersToCustomTutorialComponent(this);
         super();
         this.cachedViews = {};
         this._container = new Sprite();
         this._container.name = "container";
         this._container.mouseEnabled = false;
         this.addChild(this._container);
      }
      
      override public function isReadyForTutorialByDefault() : Boolean
      {
         return false;
      }
      
      override public function toString() : String
      {
         return "[WG ViewStack " + name + "]";
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         mouseEnabled = false;
         tabEnabled = false;
      }
      
      override protected function draw() : void
      {
         var _loc1_:int = 0;
         if(this.rescaleContainer && isInvalid(InvalidationType.SIZE))
         {
            _loc1_ = 5;
            this._container.width = this._container.height = _loc1_;
            setSize(_width,_height);
            this._container.scaleX = 1 / scaleX;
            this._container.scaleY = 1 / scaleY;
         }
      }
      
      override protected function onDispose() : void
      {
         var _loc1_:IViewStackContent = null;
         var _loc2_:IDisposable = null;
         var _loc3_:int = 0;
         App.tutorialMgr.removeListenersFromCustomTutorialComponent(this);
         if(this._targetGroup != null)
         {
            this._targetGroup.removeEventListener(IndexEvent.INDEX_CHANGE,this.onChangeViewHandler);
            this._targetGroup = null;
         }
         for each(_loc1_ in this.cachedViews)
         {
            _loc1_.removeEventListener(LifeCycleEvent.ON_AFTER_DISPOSE,this.onDisposeSubViewHandler);
            if(!(_loc1_ is IDAAPIEntity))
            {
               _loc1_.dispose();
               this.clearSubView(_loc1_);
            }
         }
         App.utils.data.cleanupDynamicObject(this.cachedViews);
         this.cachedViews = null;
         _loc3_ = this._container.numChildren - 1;
         while(_loc3_ >= 0)
         {
            _loc2_ = IDisposable(this._container.getChildAt(_loc3_));
            if(!(_loc2_ is IDAAPIEntity))
            {
               _loc2_.dispose();
            }
            _loc3_--;
         }
         removeChild(this._container);
         this._container = null;
         this._currentView = null;
         super.onDispose();
      }
      
      public function generatedUnstoppableEvents() : Boolean
      {
         return true;
      }
      
      public function getTutorialDescriptionName() : String
      {
         return name + ":" + this._setViewId;
      }
      
      public function needPreventInnerEvents() : Boolean
      {
         return false;
      }
      
      public function show(param1:String, param2:String) : IViewStackContent
      {
         this._setViewId = param1;
         var _loc3_:IViewStackContent = this.createView(param1,param2);
         this.setCurrentView(_loc3_,param1,true);
         if(_loc3_ != null)
         {
            if(_loc3_.canShowAutomatically())
            {
               _loc3_.visible = true;
            }
         }
         App.tutorialMgr.dispatchEventForCustomComponent(this);
         invalidate();
         return _loc3_;
      }
      
      private function assertTargetGroup(param1:String) : void
      {
         if(!App.utils)
         {
            return;
         }
         var _loc2_:String = "component with instance \'" + param1 + "\'";
         var _loc3_:IAssertable = App.utils.asserter;
         _loc3_.assert(parent.hasOwnProperty(param1),"container \'" + parent + "\' has no " + _loc2_,ArgumentException);
         _loc3_.assert(parent[param1] is IGroupedControl,"container \'" + parent + "\'  must implements IGroupController interface");
      }
      
      private function changeView() : void
      {
         var _loc1_:Object = null;
         var _loc2_:String = null;
         var _loc3_:String = null;
         var _loc4_:String = null;
         if(this._targetGroup && this._targetGroup.selectedItem != null)
         {
            _loc1_ = this._targetGroup.data;
            _loc2_ = null;
            if(_loc1_ != null)
            {
               if(_loc1_.hasOwnProperty("viewId"))
               {
                  _loc2_ = _loc1_.viewId;
               }
               if(_loc1_.hasOwnProperty("linkage") && _loc1_.linkage != null)
               {
                  if(_loc2_ == null || StringUtils.isEmpty(_loc2_))
                  {
                     _loc2_ = _loc1_.linkage;
                     _loc3_ = "renderers data for View stack must have a viewId property!";
                     DebugUtils.LOG_WARNING(_loc3_);
                  }
                  this.show(_loc2_,_loc1_.linkage);
               }
               else
               {
                  _loc4_ = "renderers data for View stack must have a linkage property!";
                  DebugUtils.LOG_WARNING(_loc4_);
               }
            }
         }
      }
      
      private function setCurrentView(param1:IViewStackContent, param2:String, param3:Boolean) : void
      {
         if(this._currentView != null)
         {
            if(this.cache && this.cachedViews[this._currentViewId] == this._currentView)
            {
               if(param1 != null && param2 != null)
               {
                  this._currentView.visible = false;
                  this._currentView.dispatchEvent(new ViewStackContentEvent(ViewStackContentEvent.VIEW_HIDE));
               }
               this.callLogEvent(this._currentView,EVENT_LOG_CONSTANTS.EVENT_TYPE_VIEWSTAK_ITEM_HIDE);
            }
            else
            {
               this._container.removeChild(DisplayObject(this._currentView));
               if(param3)
               {
                  this.callLogEvent(this._currentView,EVENT_LOG_CONSTANTS.EVENT_TYPE_VIEWSTAK_ITEM_HIDE);
                  if(!(param1 is IDAAPIEntity))
                  {
                     IDisposable(this._currentView).dispose();
                  }
                  else
                  {
                     this.clearSubView(this._currentView);
                  }
               }
               this._currentView = null;
            }
         }
         this._currentView = param1;
         if(this._currentView != null)
         {
            this.callLogEvent(this._currentView,EVENT_LOG_CONSTANTS.EVENT_TYPE_VIEWSTAK_ITEM_SHOW);
            this._currentView.addEventListener(LifeCycleEvent.ON_AFTER_DISPOSE,this.onDisposeSubViewHandler);
         }
         this._currentViewId = param2;
         if(this._currentView && this._currentViewId)
         {
            dispatchEvent(new ViewStackEvent(ViewStackEvent.VIEW_CHANGED,this._currentView,this._currentViewId));
         }
      }
      
      private function createView(param1:String, param2:String) : IViewStackContent
      {
         var _loc3_:IViewStackContent = null;
         if(this.cachedViews[param1] != null)
         {
            _loc3_ = this.cachedViews[param1];
         }
         else
         {
            _loc3_ = App.utils.classFactory.getComponent(param2,IViewStackContent);
            _loc3_.visible = false;
            _loc3_.addEventListener(LifeCycleEvent.ON_AFTER_DISPOSE,this.onDisposeSubViewHandler);
            this._container.addChild(DisplayObject(_loc3_));
            _loc3_.validateNow();
            dispatchEvent(new ViewStackEvent(ViewStackEvent.NEED_UPDATE,_loc3_,param1));
            if(this.cache)
            {
               this.cachedViews[param1] = _loc3_;
            }
         }
         return _loc3_;
      }
      
      private function clearSubView(param1:IViewStackContent) : void
      {
         var _loc4_:* = null;
         var _loc5_:String = null;
         param1.removeEventListener(LifeCycleEvent.ON_AFTER_DISPOSE,this.onDisposeSubViewHandler);
         var _loc2_:Boolean = !this.cache || !this.cachedViews;
         var _loc3_:DisplayObject = DisplayObject(param1);
         if(this._container && this._container.contains(_loc3_))
         {
            this._container.removeChild(_loc3_);
         }
         if(this._currentView == param1)
         {
            this.setCurrentView(null,null,false);
            _loc2_ = true;
         }
         for(_loc4_ in this.cachedViews)
         {
            if(this.cachedViews[_loc4_] == param1)
            {
               delete this.cachedViews[_loc4_];
               _loc2_ = true;
               break;
            }
         }
         _loc5_ = "View \' " + param1.name + "\'is disposed, but was not removed from viewStack \'" + name + "\'!";
         App.utils.asserter.assert(_loc2_,_loc5_,InfrastructureException);
      }
      
      private function callLogEvent(param1:IViewStackContent, param2:String) : void
      {
         App.eventLogManager.logUIElementViewStack(DisplayObject(param1),param2,0);
      }
      
      [Inspectable(defaultValue="")]
      public function get targetGroup() : String
      {
         return Boolean(this._targetGroup) ? this._targetGroup.name : null;
      }
      
      public function set targetGroup(param1:String) : void
      {
         if(param1)
         {
            this.assertTargetGroup(param1);
            this.groupRef = IGroupedControl(parent[param1]);
         }
      }
      
      public function get groupRef() : IGroupedControl
      {
         return this._targetGroup;
      }
      
      public function set groupRef(param1:IGroupedControl) : void
      {
         if(this._targetGroup != param1)
         {
            if(this._targetGroup != null)
            {
               this._targetGroup.removeEventListener(IndexEvent.INDEX_CHANGE,this.onChangeViewHandler);
            }
            this._targetGroup = param1;
            if(this._targetGroup != null)
            {
               this._targetGroup.addEventListener(IndexEvent.INDEX_CHANGE,this.onChangeViewHandler);
               this.changeView();
            }
         }
      }
      
      public function get currentViewId() : String
      {
         return this._currentViewId;
      }
      
      public function get currentView() : IViewStackContent
      {
         return this._currentView;
      }
      
      private function onChangeViewHandler(param1:IndexEvent) : void
      {
         this.changeView();
      }
      
      private function onDisposeSubViewHandler(param1:LifeCycleEvent) : void
      {
         var _loc2_:IViewStackContent = IViewStackContent(param1.target);
         this.clearSubView(_loc2_);
      }
   }
}
