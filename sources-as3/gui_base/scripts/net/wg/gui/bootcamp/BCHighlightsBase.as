package net.wg.gui.bootcamp
{
   import flash.display.DisplayObject;
   import flash.display.DisplayObjectContainer;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.events.IEventDispatcher;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import flash.utils.Dictionary;
   import net.wg.data.constants.Values;
   import net.wg.data.constants.generated.LAYER_NAMES;
   import net.wg.gui.bootcamp.controls.BCHighlightRendererBase;
   import net.wg.gui.components.controls.SoundButtonEx;
   import net.wg.gui.components.controls.scroller.ScrollerBase;
   import net.wg.gui.components.windows.Window;
   import net.wg.gui.interfaces.IHighlighted;
   import net.wg.infrastructure.base.BaseViewWrapper;
   import net.wg.infrastructure.base.meta.IBCHighlightsMeta;
   import net.wg.infrastructure.base.meta.impl.BCHighlightsMeta;
   import net.wg.infrastructure.events.LifeCycleEvent;
   import net.wg.infrastructure.events.LoaderEvent;
   import net.wg.infrastructure.events.TutorialEvent;
   import net.wg.infrastructure.interfaces.ISimpleManagedContainer;
   import net.wg.infrastructure.interfaces.ITutorialCustomComponent;
   import net.wg.infrastructure.interfaces.IView;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   import net.wg.infrastructure.managers.IContainerManager;
   import scaleform.clik.controls.Button;
   import scaleform.clik.controls.ButtonBar;
   import scaleform.clik.controls.CoreList;
   import scaleform.clik.controls.DropdownMenu;
   import scaleform.clik.interfaces.IListItemRenderer;
   import scaleform.clik.utils.Padding;
   
   public class BCHighlightsBase extends BCHighlightsMeta implements IBCHighlightsMeta
   {
      
      private static const BC_LOBBY_HINT_UI:String = "BCLobbyHintUI";
      
      private static const MAX_SEARCH_FRAMES:int = 5;
      
      private static const EQUAL_DELIMITER:String = "=";
      
      private static const CONTEXT_SEARCH_DELIMITER:String = ":";
      
      private static const DROPDOWN_REF_NAME:String = "_dropdownRef";
      
      private static const DOT_DELIMITER:String = ".";
       
      
      private var _highlightsData:Dictionary;
      
      private var _foundComponents:Dictionary;
      
      private var _componentToId:Dictionary;
      
      private var _hintsMap:Dictionary;
      
      private var _viewsCache:Dictionary;
      
      private var _currentComponentSearching:String;
      
      private var _iterationTime:int = 0;
      
      private var _readyForTutorialDispatcher:EventDispatcher;
      
      public function BCHighlightsBase()
      {
         this._highlightsData = new Dictionary(true);
         this._foundComponents = new Dictionary(true);
         this._componentToId = new Dictionary(true);
         this._hintsMap = new Dictionary(true);
         this._viewsCache = new Dictionary(true);
         super();
      }
      
      public static function seekView(param1:String) : DisplayObjectContainer
      {
         var _loc4_:ISimpleManagedContainer = null;
         var _loc5_:* = null;
         var _loc6_:uint = 0;
         var _loc7_:uint = 0;
         var _loc8_:DisplayObject = null;
         var _loc9_:IView = null;
         var _loc2_:IContainerManager = App.containerMgr;
         var _loc3_:Array = LAYER_NAMES.LAYER_ORDER;
         for(_loc5_ in _loc3_)
         {
            _loc4_ = _loc2_.getContainer(Number(_loc5_));
            if(_loc4_)
            {
               _loc6_ = _loc4_.numChildren;
               _loc7_ = 0;
               while(_loc7_ < _loc6_)
               {
                  _loc8_ = _loc4_.getChildAt(_loc7_);
                  _loc9_ = null;
                  if(_loc8_ is IView)
                  {
                     _loc9_ = IView(_loc8_);
                  }
                  else if(_loc8_ is Window)
                  {
                     _loc9_ = Window(_loc8_).sourceView;
                  }
                  else if(_loc8_ is BaseViewWrapper)
                  {
                     _loc9_ = BaseViewWrapper(_loc8_).sourceView;
                  }
                  if(_loc9_ && _loc9_.as_config.alias == param1)
                  {
                     return DisplayObjectContainer(_loc9_);
                  }
                  _loc7_++;
               }
            }
         }
         DebugUtils.LOG_WARNING("View name = " + param1 + " was not found!");
         return null;
      }
      
      override public function updateStage(param1:Number, param2:Number) : void
      {
         var _loc3_:* = null;
         for(_loc3_ in this._foundComponents)
         {
            this.updateComponentPosition(this._foundComponents[_loc3_],_loc3_);
         }
      }
      
      override protected function onDispose() : void
      {
         var _loc1_:* = null;
         var _loc2_:* = null;
         var _loc3_:EventDispatcher = null;
         for(_loc1_ in this._foundComponents)
         {
            this.as_removeHighlight(_loc1_);
         }
         for(_loc2_ in this._viewsCache)
         {
            _loc3_ = this._viewsCache[_loc2_];
            _loc3_.removeEventListener(LifeCycleEvent.ON_DISPOSE,this.onViewOnDisposeHandler);
         }
         App.utils.data.cleanupDynamicObject(this._highlightsData);
         this._highlightsData = null;
         App.utils.data.cleanupDynamicObject(this._foundComponents);
         this._foundComponents = null;
         App.utils.data.cleanupDynamicObject(this._componentToId);
         this._componentToId = null;
         App.utils.data.cleanupDynamicObject(this._viewsCache);
         this._viewsCache = null;
         this._currentComponentSearching = null;
         App.utils.data.cleanupDynamicObject(this._hintsMap);
         this._hintsMap = null;
         this.disposeReadyForTutorialDispatcher();
         this.removeLoaderListener();
         super.onDispose();
      }
      
      public function addHintToComponent(param1:String, param2:DisplayObject, param3:HighlightData) : void
      {
         var _loc4_:String = null;
         if(param3.customHint)
         {
            _loc4_ = param3.customHint;
         }
         else
         {
            _loc4_ = BC_LOBBY_HINT_UI;
         }
         var _loc5_:BCHighlightRendererBase = App.utils.classFactory.getComponent(_loc4_,BCHighlightRendererBase);
         this._hintsMap[param1] = _loc5_;
         this._componentToId[param2] = param1;
         if(param2 is IHighlighted)
         {
            (param2 as IHighlighted).highlight = true;
         }
         this.updateComponentPosition(param2,param1);
         if(param3.customHint)
         {
            _loc5_.addEventListener(Event.COMPLETE,this.onHintRendrererCompleteHandler);
         }
         param2.addEventListener(MouseEvent.CLICK,this.onComponentClickHandler);
         if(param2 is IDisposable)
         {
            param2.addEventListener(LifeCycleEvent.ON_DISPOSE,this.onComponentOnDisposeHandler);
         }
         else
         {
            param2.addEventListener(Event.REMOVED_FROM_STAGE,this.onComponentRemovedFromStageHandler);
         }
         param2.addEventListener(Event.RENDER,this.onComponentRenderHandler);
      }
      
      public function as_addHighlight(param1:String) : void
      {
         this._iterationTime = 0;
         this.highlightRoutine(param1);
      }
      
      public function as_removeHighlight(param1:String) : void
      {
         if(this._currentComponentSearching == param1)
         {
            this.disposeReadyForTutorialDispatcher();
            this.removeLoaderListener();
            this._currentComponentSearching = null;
         }
         if(!this._foundComponents[param1])
         {
            return;
         }
         var _loc2_:MovieClip = this._hintsMap[param1];
         if(_loc2_)
         {
            _loc2_.removeEventListener(Event.COMPLETE,this.onHintRendrererCompleteHandler);
            if(_loc2_.parent)
            {
               _loc2_.parent.removeChild(_loc2_);
            }
         }
         delete this._hintsMap[param1];
         var _loc3_:DisplayObject = this._foundComponents[param1];
         _loc3_.removeEventListener(Event.REMOVED_FROM_STAGE,this.onComponentRemovedFromStageHandler);
         _loc3_.removeEventListener(LifeCycleEvent.ON_DISPOSE,this.onComponentOnDisposeHandler);
         _loc3_.removeEventListener(MouseEvent.CLICK,this.onComponentClickHandler);
         _loc3_.removeEventListener(Event.RENDER,this.onComponentRenderHandler);
         if(_loc3_ is IHighlighted)
         {
            IHighlighted(_loc3_).highlight = false;
         }
         delete this._componentToId[this._foundComponents[param1]];
         delete this._foundComponents[param1];
      }
      
      public function as_setDescriptors(param1:Object) : void
      {
         var _loc2_:* = null;
         var _loc3_:Object = null;
         var _loc4_:HighlightData = null;
         for(_loc2_ in param1)
         {
            _loc3_ = param1[_loc2_];
            if(this._highlightsData[_loc2_])
            {
               _loc4_ = this._highlightsData[_loc2_];
               _loc4_.update(_loc3_);
            }
            else
            {
               _loc4_ = new HighlightData(_loc3_);
               this._highlightsData[_loc2_] = _loc4_;
            }
         }
      }
      
      protected function disposeReadyForTutorialDispatcher() : void
      {
         if(this._readyForTutorialDispatcher)
         {
            this._readyForTutorialDispatcher.removeEventListener(TutorialEvent.VIEW_READY_FOR_TUTORIAL,this.onComponentViewReadyForTutorialHandler);
            this._readyForTutorialDispatcher.removeEventListener(Event.ENTER_FRAME,this.onComponentEnterFrameHandler);
            this._readyForTutorialDispatcher = null;
         }
      }
      
      protected function getContextRenderer(param1:DisplayObject, param2:String, param3:Object) : DisplayObject
      {
         var _loc4_:DisplayObject = null;
         var _loc5_:DisplayObjectContainer = null;
         var _loc7_:CoreList = null;
         var _loc8_:uint = 0;
         var _loc9_:IListItemRenderer = null;
         var _loc10_:Object = null;
         var _loc11_:ScrollerBase = null;
         var _loc12_:SoundButtonEx = null;
         var _loc13_:ButtonBar = null;
         var _loc14_:Button = null;
         if(param1 is DropdownMenu)
         {
            param1 = param1[DROPDOWN_REF_NAME];
         }
         var _loc6_:int = 0;
         if(param1 is CoreList)
         {
            _loc7_ = CoreList(param1);
            _loc8_ = 0;
            _loc5_ = _loc7_.container as DisplayObjectContainer;
            if(_loc5_)
            {
               _loc6_ = _loc5_.numChildren;
               while(_loc8_ < _loc6_)
               {
                  _loc4_ = _loc5_.getChildAt(_loc8_);
                  if(_loc4_ is IListItemRenderer)
                  {
                     _loc9_ = IListItemRenderer(_loc4_);
                     _loc10_ = _loc9_.getData();
                     if(this.checkForParamMatch(_loc10_,param2,param3))
                     {
                        return DisplayObject(_loc9_);
                     }
                  }
                  _loc8_++;
               }
            }
         }
         if(param1 is ScrollerBase)
         {
            _loc11_ = ScrollerBase(param1);
            _loc8_ = 0;
            _loc5_ = _loc11_.viewPort as DisplayObjectContainer;
            if(_loc5_)
            {
               _loc6_ = _loc5_.numChildren;
               while(_loc8_ < _loc6_)
               {
                  _loc4_ = _loc5_.getChildAt(_loc8_);
                  if(_loc4_ is SoundButtonEx)
                  {
                     _loc12_ = SoundButtonEx(_loc4_);
                     _loc10_ = _loc12_.data;
                     if(this.checkForParamMatch(_loc10_,param2,param3))
                     {
                        return DisplayObject(_loc12_);
                     }
                  }
                  _loc8_++;
               }
            }
         }
         if(param1 is ButtonBar)
         {
            _loc13_ = ButtonBar(param1);
            _loc5_ = _loc13_.container as DisplayObjectContainer;
            if(_loc5_)
            {
               _loc6_ = _loc5_.numChildren;
               while(_loc8_ < _loc6_)
               {
                  _loc4_ = _loc5_.getChildAt(_loc8_);
                  if(_loc4_ is Button)
                  {
                     _loc14_ = Button(_loc4_);
                     if(this.checkForParamMatch(_loc14_.data,param2,param3))
                     {
                        return DisplayObject(_loc14_);
                     }
                  }
                  _loc8_++;
               }
            }
         }
         return null;
      }
      
      protected function checkForParamMatch(param1:Object, param2:String, param3:Object) : Boolean
      {
         return param1 && param1[param2] == param3;
      }
      
      private function highlightRoutine(param1:String) : void
      {
         var _loc3_:DisplayObjectContainer = null;
         var _loc5_:IEventDispatcher = null;
         if(this._foundComponents[param1])
         {
            return;
         }
         var _loc2_:HighlightData = this._highlightsData[param1];
         _loc2_.componentId = param1;
         if(this._viewsCache[_loc2_.viewAlias])
         {
            _loc3_ = this._viewsCache[_loc2_.viewAlias];
         }
         else
         {
            _loc3_ = seekView(_loc2_.viewAlias);
            if(_loc3_)
            {
               this._viewsCache[_loc2_.viewAlias] = _loc3_;
               _loc3_.addEventListener(LifeCycleEvent.ON_DISPOSE,this.onViewOnDisposeHandler);
            }
         }
         if(!_loc3_)
         {
            this._currentComponentSearching = param1;
            _loc5_ = App.instance.loaderMgr;
            _loc5_.addEventListener(LoaderEvent.VIEW_LOADED,this.onLoaderViewLoadedHandler);
            return;
         }
         var _loc4_:DisplayObject = this.seekComponentInView(_loc2_.path,_loc3_,_loc2_);
         if(!_loc4_)
         {
            this._currentComponentSearching = param1;
            return;
         }
         this._foundComponents[param1] = _loc4_;
         this.addHintToComponent(param1,_loc4_,_loc2_);
      }
      
      private function updateComponentPosition(param1:Object, param2:String) : void
      {
         var _loc3_:HighlightData = this._highlightsData[param2];
         if(!_loc3_)
         {
            return;
         }
         var _loc4_:DisplayObjectContainer = this._viewsCache[_loc3_.viewAlias];
         var _loc5_:Rectangle = this.getComponentBounds(param1,_loc4_);
         var _loc6_:BCHighlightRendererBase = this._hintsMap[param2];
         var _loc7_:Padding = _loc3_.padding;
         if(_loc7_)
         {
            _loc5_.width += _loc7_.right - _loc7_.left >> 0;
            _loc5_.height += _loc7_.bottom - _loc7_.top >> 0;
            _loc5_.x += _loc7_.left;
            _loc5_.y += _loc7_.top;
         }
         _loc6_.x = _loc5_.x >> 0;
         _loc6_.y = _loc5_.y >> 0;
         _loc6_.setProperties(_loc5_.width,_loc5_.height,!_loc3_.hideBorder);
         if(_loc4_ && _loc6_.parent == null)
         {
            _loc4_.addChild(_loc6_);
         }
      }
      
      private function getComponentBounds(param1:Object, param2:DisplayObject) : Rectangle
      {
         if(param1.hitArea)
         {
            return param1.hitArea.getRect(param2);
         }
         return param1.getRect(param2);
      }
      
      private function seekComponentInView(param1:String, param2:DisplayObjectContainer, param3:HighlightData) : DisplayObject
      {
         var _loc8_:DisplayObject = null;
         var _loc4_:Array = param1.split(DOT_DELIMITER);
         var _loc5_:DisplayObjectContainer = param2;
         var _loc6_:uint = _loc4_.length;
         var _loc7_:uint = 0;
         while(_loc7_ < _loc6_)
         {
            if(_loc5_)
            {
               _loc8_ = this.getComponentChild(_loc5_,_loc4_[_loc7_],param3);
               if(!_loc8_)
               {
                  return null;
               }
               _loc5_ = _loc8_ as DisplayObjectContainer;
            }
            _loc7_++;
         }
         return _loc5_;
      }
      
      private function getComponentChild(param1:DisplayObjectContainer, param2:String, param3:HighlightData) : DisplayObject
      {
         var _loc5_:DisplayObject = null;
         var _loc6_:DisplayObjectContainer = null;
         var _loc7_:int = 0;
         var _loc8_:String = null;
         var _loc9_:String = null;
         var _loc10_:DisplayObject = null;
         var _loc11_:String = null;
         var _loc4_:int = param2.indexOf(CONTEXT_SEARCH_DELIMITER);
         if(_loc4_ == -1)
         {
            _loc5_ = param1.getChildByName(param2) as DisplayObject;
            if(_loc5_ == null)
            {
               _loc5_ = param1[param2];
            }
            if(_loc5_ == null)
            {
               if(this._iterationTime > MAX_SEARCH_FRAMES)
               {
                  return null;
               }
               if(param1 is ITutorialCustomComponent)
               {
                  this.disposeReadyForTutorialDispatcher();
                  this._readyForTutorialDispatcher = EventDispatcher(param1);
                  this._readyForTutorialDispatcher.addEventListener(TutorialEvent.VIEW_READY_FOR_TUTORIAL,this.onComponentViewReadyForTutorialHandler);
               }
               else
               {
                  this.disposeReadyForTutorialDispatcher();
                  this._readyForTutorialDispatcher = EventDispatcher(param1);
                  this._readyForTutorialDispatcher.addEventListener(Event.ENTER_FRAME,this.onComponentEnterFrameHandler);
               }
            }
            return _loc5_;
         }
         if(_loc4_ != 0)
         {
            _loc11_ = param2.substr(0,_loc4_);
            _loc6_ = param1.getChildByName(_loc11_) as DisplayObjectContainer;
         }
         else
         {
            _loc6_ = param1;
         }
         _loc7_ = param2.indexOf(EQUAL_DELIMITER);
         _loc8_ = param2.substr(_loc4_ + 1,_loc7_ - _loc4_ - 1);
         _loc9_ = param2.substr(_loc7_ + 1,param2.length - _loc7_ - 1);
         _loc10_ = this.getContextRenderer(_loc6_,_loc8_,param3[_loc9_]);
         if(!_loc10_)
         {
            this.disposeReadyForTutorialDispatcher();
            this._readyForTutorialDispatcher = EventDispatcher(_loc6_);
            _loc6_.addEventListener(TutorialEvent.VIEW_READY_FOR_TUTORIAL,this.onComponentViewReadyForTutorialHandler);
         }
         return _loc10_;
      }
      
      private function restartHighlightRoutine() : void
      {
         this._iterationTime += 1;
         this.highlightRoutine(this._currentComponentSearching);
      }
      
      private function removeLoaderListener() : void
      {
         var _loc1_:IEventDispatcher = App.instance.loaderMgr;
         _loc1_.removeEventListener(LoaderEvent.VIEW_LOADED,this.onLoaderViewLoadedHandler);
      }
      
      private function onLoaderViewLoadedHandler(param1:LoaderEvent) : void
      {
         var _loc4_:HighlightData = null;
         var _loc2_:IView = param1.view;
         var _loc3_:String = _loc2_.as_config.alias;
         this._viewsCache[_loc3_] = _loc2_;
         this.removeLoaderListener();
         _loc2_.addEventListener(LifeCycleEvent.ON_DISPOSE,this.onViewOnDisposeHandler);
         if(this._currentComponentSearching)
         {
            _loc4_ = this._highlightsData[this._currentComponentSearching];
            if(_loc4_.viewAlias == _loc3_)
            {
               this.highlightRoutine(this._currentComponentSearching);
            }
         }
      }
      
      private function onViewOnDisposeHandler(param1:LifeCycleEvent) : void
      {
         delete this._viewsCache[param1.target.as_config.alias];
         param1.target.removeEventListener(LifeCycleEvent.ON_DISPOSE,this.onViewOnDisposeHandler);
      }
      
      private function onHintRendrererCompleteHandler(param1:Event) : void
      {
         var _loc3_:* = null;
         var _loc2_:String = Values.EMPTY_STR;
         for(_loc3_ in this._hintsMap)
         {
            if(this._hintsMap[_loc3_] === param1.target)
            {
               _loc2_ = _loc3_;
               break;
            }
         }
         if(_loc2_)
         {
            onHighlightAnimationCompleteS(_loc2_);
            this.as_removeHighlight(_loc2_);
         }
      }
      
      private function onComponentRenderHandler(param1:Event) : void
      {
         var _loc2_:Object = param1.target;
         this.updateComponentPosition(_loc2_,this._componentToId[_loc2_]);
      }
      
      private function onComponentClickHandler(param1:MouseEvent) : void
      {
         var _loc2_:String = this._componentToId[param1.target];
         if(_loc2_)
         {
            onComponentTriggeredS(_loc2_);
         }
      }
      
      private function onComponentRemovedFromStageHandler(param1:Event) : void
      {
         this.as_removeHighlight(this._componentToId[param1.target]);
      }
      
      private function onComponentOnDisposeHandler(param1:Event) : void
      {
         this.as_removeHighlight(this._componentToId[param1.target]);
      }
      
      private function onComponentViewReadyForTutorialHandler(param1:Event) : void
      {
         this.disposeReadyForTutorialDispatcher();
         this.restartHighlightRoutine();
      }
      
      private function onComponentEnterFrameHandler(param1:Event) : void
      {
         this.disposeReadyForTutorialDispatcher();
         this.restartHighlightRoutine();
      }
   }
}

import net.wg.data.daapi.base.DAAPIDataClass;
import scaleform.clik.utils.Padding;

class HighlightData extends DAAPIDataClass
{
   
   private static const PADDING_NAME:String = "padding";
    
   
   public var viewAlias:String = "";
   
   public var path:String = "";
   
   public var padding:Padding = null;
   
   public var componentId:String = "";
   
   public var customHint:String = "";
   
   public var hideBorder:Boolean;
   
   public var compareValue:Object = null;
   
   public var asInt:int = -1;
   
   public var bool:Boolean = false;
   
   public var indexId:int = -1;
   
   public var slotIndex:int = -1;
   
   public var skillId:String = "";
   
   public var TankIndex:String = "";
   
   public var ButtonID:String = "";
   
   function HighlightData(param1:Object)
   {
      super(param1);
   }
   
   override protected function onDataWrite(param1:String, param2:Object) : Boolean
   {
      if(param1 == PADDING_NAME)
      {
         this.padding = new Padding(int(param2.top),int(param2.right),int(param2.bottom),int(param2.left));
         return false;
      }
      return super.onDataWrite(param1,param2);
   }
   
   override protected function onDispose() : void
   {
      this.padding = null;
      super.onDispose();
   }
   
   public function update(param1:Object) : void
   {
      fromHash(param1);
   }
}
