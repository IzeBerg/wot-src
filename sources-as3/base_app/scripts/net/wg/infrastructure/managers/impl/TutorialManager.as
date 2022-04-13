package net.wg.infrastructure.managers.impl
{
   import flash.display.DisplayObject;
   import flash.display.DisplayObjectContainer;
   import flash.events.Event;
   import flash.utils.Dictionary;
   import net.wg.data.TutorialBuilderVO;
   import net.wg.data.TutorialComponentData;
   import net.wg.data.TutorialComponentRect;
   import net.wg.data.constants.Errors;
   import net.wg.data.constants.Values;
   import net.wg.data.vo.TutorialComponentPathVO;
   import net.wg.data.vo.TutorialCriteriaVo;
   import net.wg.data.vo.TutorialUnboundViewVO;
   import net.wg.infrastructure.base.meta.impl.TutorialManagerMeta;
   import net.wg.infrastructure.events.LifeCycleEvent;
   import net.wg.infrastructure.events.TutorialEvent;
   import net.wg.infrastructure.interfaces.IContainerWrapper;
   import net.wg.infrastructure.interfaces.ICustomObjectFinder;
   import net.wg.infrastructure.interfaces.ITriggerWatcher;
   import net.wg.infrastructure.interfaces.ITutorialBuilder;
   import net.wg.infrastructure.interfaces.ITutorialCustomComponent;
   import net.wg.infrastructure.interfaces.IView;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   import net.wg.infrastructure.managers.ITutorialManager;
   import net.wg.infrastructure.managers.impl.tutorial.BuilderTypeMapping;
   import net.wg.infrastructure.managers.impl.tutorial.BuildersMap;
   import net.wg.infrastructure.managers.impl.tutorial.TriggerEvent;
   import net.wg.infrastructure.managers.impl.tutorial.TriggerWatcherFactory;
   import org.idmedia.as3commons.util.StringUtils;
   
   public class TutorialManager extends TutorialManagerMeta implements ITutorialManager
   {
      
      private static const FULL_MATCH:int = 2;
      
      private static const PARTIAL_MATCH:int = 1;
      
      private static const MISMATCH:int = 0;
      
      private static const LINKAGE_REG_EXP:RegExp = new RegExp(/:[^\?\.]*[\.\?]/g);
      
      private static const CRITERIA_REG_EXP:RegExp = new RegExp(/\?%[^%]*%/);
      
      private static const PARAMS_REG_EXP:RegExp = new RegExp(/\?.*$/);
       
      
      private var _descriptions:Object;
      
      private var _ignoredInTutorialComponents:Vector.<DisplayObject>;
      
      private var _tutorialLinkages:Vector.<String>;
      
      private var _aliasToPathsList:Object;
      
      private var _fullPathToVO:Object;
      
      private var _idToVO:Object;
      
      private var _idToView:Dictionary;
      
      private var _componentToVO:Dictionary;
      
      private var _criteriaHash:Object;
      
      private var _shownIds:Vector.<String>;
      
      private var _compIdToWatchers:Object;
      
      private var _isSystemEnabled:Object;
      
      private var _customObjectFinder:ICustomObjectFinder;
      
      private var _buildersMap:BuildersMap;
      
      private var _unboudViewsForRegister:Dictionary;
      
      private var _unboundComponents:Dictionary;
      
      public function TutorialManager(param1:ICustomObjectFinder)
      {
         this._ignoredInTutorialComponents = new Vector.<DisplayObject>();
         this._tutorialLinkages = new Vector.<String>();
         this._aliasToPathsList = {};
         this._fullPathToVO = {};
         this._idToVO = {};
         this._idToView = new Dictionary();
         this._componentToVO = new Dictionary(true);
         this._criteriaHash = {};
         this._shownIds = new Vector.<String>();
         this._compIdToWatchers = {};
         this._buildersMap = new BuildersMap();
         this._unboudViewsForRegister = new Dictionary();
         this._unboundComponents = new Dictionary();
         super();
         this._customObjectFinder = param1;
      }
      
      private static function createPathFromRoot(param1:DisplayObject) : String
      {
         var _loc3_:DisplayObject = null;
         var _loc2_:String = "";
         if(param1)
         {
            _loc3_ = App.stage.root;
            _loc2_ = param1.name;
            param1 = param1.parent;
            while(param1 && param1 != _loc3_)
            {
               _loc2_ = param1.name + "." + _loc2_;
               param1 = param1.parent;
            }
         }
         else
         {
            App.utils.asserter.assert(false,"dObj must be not null");
         }
         return _loc2_;
      }
      
      private static function updateExternalHintComponent(param1:DisplayObject, param2:TutorialComponentRect) : void
      {
         param1.x = param2.x / App.appScale;
         param1.y = param2.y / App.appScale;
         param1.width = param2.width / App.appScale;
         param1.height = param2.height / App.appScale;
      }
      
      private static function getTutorialHintZoneName(param1:String) : String
      {
         return param1 + "_HintArea";
      }
      
      override protected function onDispose() : void
      {
         var _loc1_:* = null;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:* = null;
         var _loc5_:* = null;
         var _loc6_:IDisposable = null;
         var _loc7_:DisplayObject = null;
         var _loc8_:Vector.<String> = null;
         var _loc9_:TutorialComponentPathVO = null;
         App.utils.data.cleanupDynamicObject(this._descriptions);
         for(_loc1_ in this._criteriaHash)
         {
            this._criteriaHash[_loc1_].dispose();
            delete this._criteriaHash[_loc1_];
         }
         this._criteriaHash = null;
         this._descriptions = null;
         _loc2_ = this._ignoredInTutorialComponents.length;
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            _loc7_ = this._ignoredInTutorialComponents[_loc3_];
            this.removeListenersFromNotTutorialObject(_loc7_);
            _loc3_++;
         }
         this._ignoredInTutorialComponents.splice(0,_loc2_);
         this._tutorialLinkages.splice(0,this._tutorialLinkages.length);
         for(_loc4_ in this._aliasToPathsList)
         {
            _loc8_ = this._aliasToPathsList[_loc4_];
            _loc8_.splice(0,_loc8_.length);
         }
         App.utils.data.cleanupDynamicObject(this._aliasToPathsList);
         this._aliasToPathsList = null;
         for(_loc5_ in this._fullPathToVO)
         {
            _loc9_ = this._fullPathToVO[_loc5_];
            _loc9_.dispose();
         }
         App.utils.data.cleanupDynamicObject(this._fullPathToVO);
         App.utils.data.cleanupDynamicObject(this._idToVO);
         App.utils.data.cleanupDynamicObject(this._componentToVO);
         App.utils.data.cleanupDynamicObject(this._isSystemEnabled);
         App.utils.data.cleanupDynamicObject(this._compIdToWatchers);
         for each(_loc6_ in this._unboudViewsForRegister)
         {
            _loc6_.dispose();
         }
         App.utils.data.cleanupDynamicObject(this._unboudViewsForRegister);
         App.utils.data.cleanupDynamicObject(this._unboundComponents);
         this._componentToVO = null;
         this._fullPathToVO = null;
         this._idToVO = null;
         this._ignoredInTutorialComponents = null;
         this._tutorialLinkages = null;
         this._isSystemEnabled = null;
         this._compIdToWatchers = null;
         this._unboudViewsForRegister = null;
         this._unboundComponents = null;
         this._shownIds.splice(0,this._shownIds.length);
         this._shownIds = null;
         this._customObjectFinder = null;
         this._buildersMap.dispose();
         super.onDispose();
      }
      
      override protected function setTriggers(param1:String, param2:Array) : void
      {
         var _loc3_:Vector.<ITriggerWatcher> = this._compIdToWatchers[param1];
         if(_loc3_ && _loc3_.length > 0)
         {
            this.cleanupTriggerWatchers(_loc3_);
         }
         if(param2 && param2.length > 0)
         {
            this._compIdToWatchers[param1] = this.createTriggerWatchers(param1,param2);
         }
         else
         {
            delete this._compIdToWatchers[param1];
         }
      }
      
      public function addListenersToCustomTutorialComponent(param1:ITutorialCustomComponent) : void
      {
         param1.addEventListener(TutorialEvent.VIEW_READY_FOR_TUTORIAL,this.onViewReadyForTutorialHandler);
      }
      
      public function as_getComponentGlobalBounds(param1:String, param2:String) : Object
      {
         var _loc3_:String = this.makeFullPath(param1,param2);
         var _loc4_:DisplayObject = this._unboundComponents[this.makeFullPath(param1,param2)];
         if(_loc4_)
         {
            return _loc4_.getBounds(App.stage);
         }
         if(this._fullPathToVO[_loc3_])
         {
            _loc4_ = this._fullPathToVO[_loc3_].foundComponent;
            return _loc4_.getBounds(App.stage);
         }
         assert(false,"Component " + _loc3_ + " has not been registered in TutorialManager.");
         return null;
      }
      
      public function as_getComponentPath(param1:String, param2:String) : String
      {
         if(param2 == Values.EMPTY_STR)
         {
            return createPathFromRoot(this._idToView[param1].getChildAt(0));
         }
         var _loc3_:String = this.makeFullPath(param1,param2);
         if(this._fullPathToVO[param2])
         {
            return createPathFromRoot(this._fullPathToVO[_loc3_].foundComponent);
         }
         return createPathFromRoot(this._unboundComponents[this.makeFullPath(param1,param2)]);
      }
      
      public function as_hideEffect(param1:String, param2:String, param3:String, param4:String) : void
      {
         var _loc6_:int = 0;
         var _loc7_:String = null;
         var _loc5_:TutorialComponentPathVO = this._idToVO[param2];
         if(_loc5_)
         {
            _loc6_ = this._shownIds.indexOf(param2);
            if(_loc6_ != -1)
            {
               this._shownIds.splice(_loc6_,1);
            }
            _loc7_ = Values.EMPTY_STR;
            if(StringUtils.isNotEmpty(param3))
            {
               _loc7_ = BuilderTypeMapping.getLnk(param3,param4);
            }
            this.stopEffects(param1,Boolean(_loc5_.foundComponent) ? this._componentToVO[_loc5_.foundComponent].id : param2,_loc7_);
         }
      }
      
      public function as_setComponentViewCriteria(param1:String, param2:String) : void
      {
         var _loc3_:TutorialComponentPathVO = this._idToVO[param1];
         if(_loc3_)
         {
            _loc3_.viewTutorialId = param2;
         }
      }
      
      public function as_setConditions(param1:Object) : void
      {
      }
      
      public function as_setCriteria(param1:String, param2:String) : void
      {
         var _loc3_:TutorialCriteriaVo = null;
         if(this._criteriaHash.hasOwnProperty(param1))
         {
            _loc3_ = this._criteriaHash[param1];
            if(_loc3_.criteriaValue != param2)
            {
               _loc3_.criteriaValue = param2;
               if(_loc3_.vo.foundComponent != null)
               {
                  this.as_hideEffect(_loc3_.viewTutorialId,_loc3_.vo.id,Values.EMPTY_STR,Values.EMPTY_STR);
                  _loc3_.vo.foundComponent = null;
               }
               if(_loc3_.tutorialEvent.ev_target != null && _loc3_.tutorialEvent.ev_target.stage == null)
               {
                  return;
               }
               this.onComponentCheckComplete(_loc3_.parentViewAlias,_loc3_.tutorialEvent,_loc3_.viewTutorialId);
            }
         }
         else
         {
            this._criteriaHash[param1] = new TutorialCriteriaVo({"criteriaValue":param2});
         }
      }
      
      public function as_setDescriptions(param1:Object) : void
      {
         var _loc2_:* = null;
         this._descriptions = param1;
         for(_loc2_ in param1)
         {
            this._aliasToPathsList[_loc2_] = this.generateData(_loc2_,param1[_loc2_]);
         }
      }
      
      public function as_setSystemEnabled(param1:Boolean) : void
      {
         this._isSystemEnabled = param1;
      }
      
      public function dispatchEventForCustomComponent(param1:ITutorialCustomComponent) : void
      {
         var _loc2_:TutorialEvent = null;
         if(this._isSystemEnabled)
         {
            _loc2_ = new TutorialEvent(TutorialEvent.VIEW_READY_FOR_TUTORIAL);
            _loc2_.addPathPoint(DisplayObject(param1),param1.getTutorialDescriptionName());
            _loc2_.unstoppable = param1.generatedUnstoppableEvents();
            param1.dispatchEvent(_loc2_);
         }
      }
      
      public function onBotNetComponentVarChanged(param1:String = "", param2:String = "", param3:String = "", param4:Object = null) : void
      {
         onUbTrackedVarChangedS(param1,param2,param3,param4);
      }
      
      public function onComponentCheckComplete(param1:String, param2:TutorialEvent, param3:String) : void
      {
         var _loc10_:DisplayObject = null;
         var _loc12_:String = null;
         var _loc13_:Array = null;
         var _loc14_:Vector.<String> = null;
         var _loc15_:Vector.<DisplayObject> = null;
         var _loc16_:int = 0;
         var _loc17_:String = null;
         var _loc18_:TutorialComponentPathVO = null;
         var _loc19_:Array = null;
         var _loc20_:Boolean = false;
         var _loc21_:int = 0;
         var _loc22_:String = null;
         var _loc23_:String = null;
         var _loc24_:TutorialCriteriaVo = null;
         var _loc4_:Vector.<String> = this._aliasToPathsList[param1];
         if(!_loc4_)
         {
            this.clearTutorialEvent(param2);
            return;
         }
         var _loc5_:TutorialEvent = TutorialEvent(param2.clone());
         var _loc6_:Vector.<String> = param2.pathPointNames;
         var _loc7_:String = _loc6_.join(".*");
         var _loc8_:RegExp = new RegExp(_loc7_);
         var _loc9_:int = _loc4_.length;
         var _loc11_:int = 0;
         while(_loc11_ < _loc9_)
         {
            _loc12_ = _loc4_[_loc11_];
            if(_loc12_.match(_loc8_) != null)
            {
               if(_loc12_.indexOf(":") != -1 == (_loc7_.indexOf(":") != -1))
               {
                  _loc13_ = _loc12_.split(".");
                  _loc14_ = new Vector.<String>(_loc13_.length);
                  _loc15_ = new Vector.<DisplayObject>(_loc13_.length);
                  _loc16_ = this.checkForFullMatching(_loc13_,_loc14_,_loc15_,param2);
                  _loc17_ = this.makeFullPath(param1,_loc12_);
                  _loc18_ = this._fullPathToVO[_loc17_];
                  assert(_loc18_ != null,"TutorialComponentPathVO is not found for path - " + _loc17_);
                  if(StringUtils.isNotEmpty(_loc18_.viewTutorialId) && _loc18_.viewTutorialId != param3)
                  {
                     return;
                  }
                  if(_loc16_ == FULL_MATCH)
                  {
                     _loc10_ = DisplayObject(param2.pathPointObjects[param2.pathPointObjects.length - 1]);
                     this.processFoundComponent(_loc10_,_loc18_,param3);
                  }
                  else if(_loc16_ == PARTIAL_MATCH)
                  {
                     _loc17_ = this.makeFullPath(param1,_loc12_);
                     _loc18_ = this._fullPathToVO[_loc17_];
                     if(_loc18_.foundComponent == null)
                     {
                        _loc19_ = _loc12_.match(CRITERIA_REG_EXP);
                        _loc20_ = true;
                        if(_loc19_ != null)
                        {
                           _loc21_ = 0;
                           while(_loc21_ < _loc19_.length)
                           {
                              _loc22_ = this.cutSubstitution(_loc19_[_loc21_]);
                              _loc23_ = null;
                              if(this._criteriaHash.hasOwnProperty(_loc22_))
                              {
                                 _loc24_ = this._criteriaHash[_loc22_];
                                 _loc23_ = _loc24_.criteriaValue;
                                 this.updatePathWithCriteria(_loc13_,_loc22_,_loc23_);
                              }
                              this._criteriaHash[_loc22_] = new TutorialCriteriaVo({
                                 "viewTutorialId":param3,
                                 "criteriaValue":_loc23_,
                                 "parentViewAlias":param1,
                                 "tutorialEvent":_loc5_,
                                 "vo":_loc18_
                              });
                              if(!_loc23_)
                              {
                                 _loc20_ = false;
                              }
                              _loc21_++;
                           }
                        }
                        if(_loc20_)
                        {
                           _loc10_ = this.checkPartialMatch(_loc13_,_loc14_,_loc15_);
                        }
                        else
                        {
                           _loc10_ = null;
                        }
                        _loc13_.splice(0,_loc13_.length);
                        _loc14_.splice(0,_loc14_.length);
                        _loc15_.splice(0,_loc15_.length);
                        this.processFoundComponent(_loc10_,_loc18_,param3);
                     }
                  }
               }
            }
            _loc11_++;
         }
         this.clearTutorialEvent(param2);
      }
      
      public function onComponentCreatedByLinkage(param1:DisplayObject, param2:String) : void
      {
         if(!this.isTutorialLinkage(param2))
         {
            this._ignoredInTutorialComponents.push(DisplayObject(param1));
            param1.addEventListener(TutorialEvent.VIEW_READY_FOR_TUTORIAL,this.viewReadyForTutorialHandler);
            param1.addEventListener(LifeCycleEvent.ON_DISPOSE,this.objectDisposeHandler);
         }
      }
      
      public function onEffectComplete(param1:DisplayObject, param2:String) : void
      {
         var _loc3_:String = TutorialComponentPathVO(this._componentToVO[param1]).id;
         onEffectCompletedS(_loc3_,param2);
      }
      
      public function registerUnboundBotNetComponent(param1:String, param2:String, param3:DisplayObject) : void
      {
         this._unboundComponents[this.makeFullPath(param1,param2)] = param3;
         onComponentFoundS(param2,param1);
      }
      
      public function registerUnboundComponent(param1:String, param2:String, param3:DisplayObject) : void
      {
         var _loc7_:TutorialUnboundViewVO = null;
         var _loc4_:String = this.makeFullPath(param1,param2);
         var _loc5_:TutorialComponentPathVO = this._fullPathToVO[_loc4_];
         if(_loc5_ && (_loc5_.foundComponent || this._unboundComponents[_loc4_]))
         {
            assert(false,"registerUnboundComponent: Component already registered. componentID = " + param2);
         }
         var _loc6_:Boolean = this._unboudViewsForRegister[param1] != null;
         if(_loc6_)
         {
            _loc7_ = this._unboudViewsForRegister[param1];
            _loc7_.componentPaths.push(_loc4_);
         }
         this._unboundComponents[_loc4_] = param3;
         param3.addEventListener(Event.REMOVED_FROM_STAGE,this.onUnboundComponentRemovedHandler);
         if(_loc5_ && !_loc6_ && this._idToView[param1])
         {
            _loc5_.foundComponent = param3;
            this.processFoundComponent(param3,_loc5_,param1);
         }
      }
      
      public function registerUnboundView(param1:String, param2:DisplayObject) : void
      {
         var _loc3_:TutorialUnboundViewVO = null;
         if(!this._idToView[param1])
         {
            _loc3_ = new TutorialUnboundViewVO();
            _loc3_.addView(param1,param2);
            this._unboudViewsForRegister[param1] = _loc3_;
            param2.addEventListener(Event.ADDED_TO_STAGE,this.unboundViewAddedHandler);
         }
         else
         {
            assert(false,"registerUnboundView: View already registered. viewTutorialId = " + param1);
         }
      }
      
      public function removeListenersFromCustomTutorialComponent(param1:ITutorialCustomComponent) : void
      {
         param1.removeEventListener(TutorialEvent.VIEW_READY_FOR_TUTORIAL,this.onViewReadyForTutorialHandler);
      }
      
      public function setViewForTutorialId(param1:IView, param2:String) : void
      {
         this._idToView[param2] = param1;
         param1.addEventListener(LifeCycleEvent.ON_DISPOSE,this.onViewOnDisposeHandler);
      }
      
      public function setupEffectBuilder(param1:IView, param2:String, param3:TutorialBuilderVO, param4:DisplayObject) : void
      {
         var _loc5_:ITutorialBuilder = null;
         var _loc6_:String = null;
         var _loc7_:String = null;
         var _loc8_:String = null;
         if(param1 != null)
         {
            _loc6_ = param1.as_config.viewTutorialId;
            _loc7_ = param4 != null ? this._componentToVO[param4].id : Values.EMPTY_STR;
            _loc8_ = BuilderTypeMapping.getLnk(param2,param3.builder);
            _loc5_ = this._buildersMap.getBuilder(_loc6_,_loc7_,_loc8_);
            if(_loc5_ == null)
            {
               _loc5_ = App.utils.classFactory.getObject(_loc8_) as ITutorialBuilder;
               if(_loc5_ != null)
               {
                  _loc5_.setView(param1);
                  if(param4 != null)
                  {
                     _loc5_.component = param4;
                  }
                  this._buildersMap.addBuilder(_loc5_,_loc6_,_loc7_,_loc8_);
               }
               else
               {
                  assert(false,"Can\'t create builder: " + _loc8_);
               }
            }
            _loc5_.updateData(param3.data);
         }
      }
      
      public function unregisterUnboundBotNetComponent(param1:String = "", param2:String = "") : void
      {
         var _loc3_:String = this.makeFullPath(param1,param2);
         if(this._unboundComponents[_loc3_])
         {
            delete this._unboundComponents[_loc3_];
            onComponentDisposedS(param2);
         }
         else
         {
            assert(false,"unregisterUnboundBotNetComponent: Component doesn\'t exist. botNetID = " + param2);
         }
      }
      
      public function unregisterUnboundComponent(param1:String, param2:String) : void
      {
         var _loc5_:TutorialUnboundViewVO = null;
         var _loc6_:Vector.<String> = null;
         var _loc7_:DisplayObject = null;
         var _loc3_:String = this.makeFullPath(param1,param2);
         var _loc4_:TutorialComponentPathVO = this._fullPathToVO[_loc3_];
         if(_loc4_)
         {
            _loc5_ = this._unboudViewsForRegister[param1];
            _loc6_ = _loc5_.componentPaths;
            _loc6_.splice(_loc6_.indexOf(_loc3_),1);
            _loc7_ = _loc4_.foundComponent;
            if(_loc7_)
            {
               _loc7_.removeEventListener(Event.REMOVED_FROM_STAGE,this.onUnboundComponentRemovedHandler);
               _loc4_.foundComponent = null;
               delete this._unboundComponents[_loc3_];
               this.unregisterComponent(_loc7_);
            }
         }
         else
         {
            assert(false,"unregisterUnboundComponent: Componennt doesn\'t exist. componentID = " + param2);
         }
      }
      
      public function unregisterUnboundView(param1:String) : void
      {
         if(this._idToView[param1])
         {
            this._buildersMap.removeBuildersForView(param1);
            delete this._idToView[param1];
         }
      }
      
      override protected function updateExternalComponent(param1:String, param2:String, param3:TutorialComponentData) : void
      {
         var _loc5_:ITutorialBuilder = null;
         var _loc6_:Dictionary = null;
         var _loc4_:TutorialComponentPathVO = this._idToVO[param1];
         if(_loc4_ && _loc4_.foundComponent)
         {
            updateExternalHintComponent(_loc4_.foundComponent,param3.rect);
            _loc6_ = this._buildersMap.getComponentBuildersDict(param2,param1);
            for each(_loc5_ in _loc6_)
            {
               _loc5_.externalUpdate();
            }
         }
      }
      
      public function as_disposeExternalComponent(param1:String, param2:String) : void
      {
         DebugUtils.LOG_DEBUG("as_disposeExternalComponent",param1,param2);
         var _loc3_:TutorialComponentPathVO = this._idToVO[param1];
         this.unregisterExternalComponent(_loc3_);
      }
      
      override protected function externalComponentFound(param1:String, param2:String, param3:TutorialComponentData) : void
      {
         var _loc5_:IContainerWrapper = null;
         var _loc6_:DisplayObject = null;
         DebugUtils.LOG_DEBUG("as_externalComponentFound",param1,param2);
         var _loc4_:TutorialComponentPathVO = this._idToVO[param1];
         if(_loc4_ && !_loc4_.foundComponent)
         {
            _loc5_ = IContainerWrapper(this._idToView[param2]);
            App.utils.asserter.assertNotNull(_loc5_,"view id " + param2 + Errors.WASNT_FOUND);
            _loc6_ = _loc5_.getTutorialHintZone(getTutorialHintZoneName(param1));
            updateExternalHintComponent(_loc6_,param3.rect);
            _loc6_.addEventListener(LifeCycleEvent.ON_BEFORE_DISPOSE,this.onExternalComponentDisposedHandler);
            _loc4_.foundComponent = _loc6_;
            this._componentToVO[_loc6_] = _loc4_;
         }
      }
      
      private function onExternalComponentDisposedHandler(param1:LifeCycleEvent) : void
      {
         var _loc3_:TutorialComponentPathVO = null;
         var _loc2_:DisplayObject = param1.target as DisplayObject;
         if(_loc2_ != null)
         {
            _loc2_.removeEventListener(LifeCycleEvent.ON_BEFORE_DISPOSE,this.onExternalComponentDisposedHandler);
            _loc3_ = this._componentToVO[_loc2_];
            this.unregisterExternalComponent(_loc3_);
         }
      }
      
      private function unregisterExternalComponent(param1:TutorialComponentPathVO) : void
      {
         var _loc2_:IContainerWrapper = null;
         var _loc3_:Vector.<ITriggerWatcher> = null;
         if(param1 && param1.foundComponent)
         {
            _loc2_ = IContainerWrapper(this._idToView[param1.viewTutorialId]);
            if(_loc2_ != null)
            {
               _loc2_.removeTutorialHintZone(getTutorialHintZoneName(param1.id));
            }
            this.clearCriteriaHash(CriteriaUtils.componentPathVoPredicate(param1));
            _loc3_ = this._compIdToWatchers[param1.id];
            if(_loc3_ && _loc3_.length > 0)
            {
               this.cleanupTriggerWatchers(_loc3_);
               this._compIdToWatchers[param1.id] = null;
            }
            this._buildersMap.removeBuildersForComponent(param1.viewName,param1.id);
            delete this._componentToVO[param1.foundComponent];
            param1.foundComponent = null;
         }
      }
      
      override protected function showEffect(param1:String, param2:String, param3:String, param4:TutorialBuilderVO) : void
      {
         var _loc6_:TutorialComponentPathVO = null;
         var _loc7_:DisplayObject = null;
         var _loc5_:IView = this._idToView[param1];
         App.utils.asserter.assertNotNull(_loc5_,"view id " + param1 + Errors.WASNT_FOUND);
         if(StringUtils.isNotEmpty(param2))
         {
            _loc6_ = this._idToVO[param2];
            if(_loc6_)
            {
               _loc7_ = _loc6_.foundComponent;
               if(_loc7_)
               {
                  this.setupEffectBuilder(_loc5_,param3,param4,_loc7_);
               }
            }
         }
         else
         {
            this.setupEffectBuilder(_loc5_,param3,param4,null);
         }
      }
      
      private function stopEffects(param1:String, param2:String, param3:String = null) : void
      {
         var _loc4_:ITutorialBuilder = null;
         var _loc5_:Dictionary = null;
         if(param3)
         {
            _loc4_ = this._buildersMap.getBuilder(param1,param2,param3);
            if(_loc4_)
            {
               _loc4_.stopEffect();
            }
         }
         else
         {
            _loc5_ = this._buildersMap.getComponentBuildersDict(param1,param2);
            for each(_loc4_ in _loc5_)
            {
               _loc4_.stopEffect();
            }
         }
      }
      
      private function cleanupTriggerWatchers(param1:Vector.<ITriggerWatcher>) : void
      {
         var _loc2_:ITriggerWatcher = null;
         for each(_loc2_ in param1)
         {
            _loc2_.removeEventListener(TriggerEvent.TRIGGER_ACTIVATED,this.onTriggerActivatedHandler);
            _loc2_.dispose();
         }
         param1.splice(0,param1.length);
      }
      
      private function createTriggerWatchers(param1:String, param2:Array) : Vector.<ITriggerWatcher>
      {
         var _loc3_:String = null;
         var _loc4_:ITriggerWatcher = null;
         var _loc6_:TutorialComponentPathVO = null;
         var _loc5_:Vector.<ITriggerWatcher> = new Vector.<ITriggerWatcher>();
         for each(_loc3_ in param2)
         {
            _loc4_ = TriggerWatcherFactory.createWatcher(param1,_loc3_);
            _loc4_.addEventListener(TriggerEvent.TRIGGER_ACTIVATED,this.onTriggerActivatedHandler);
            _loc6_ = this._idToVO[param1];
            if(_loc6_ && _loc6_.foundComponent)
            {
               _loc4_.start(_loc6_.foundComponent);
               _loc5_.push(_loc4_);
            }
         }
         return _loc5_;
      }
      
      private function updatePathWithCriteria(param1:Array, param2:String, param3:String) : void
      {
         param2 = "%" + param2 + "%";
         var _loc4_:int = 0;
         while(_loc4_ < param1.length)
         {
            if(param1[_loc4_].indexOf(param2) != -1)
            {
               param1[_loc4_] = param1[_loc4_].replace(param2,param3);
               return;
            }
            _loc4_++;
         }
      }
      
      private function processFoundComponent(param1:DisplayObject, param2:TutorialComponentPathVO, param3:String) : void
      {
         var _loc4_:Array = null;
         if(param1)
         {
            param2.foundComponent = param1;
            param1.addEventListener(LifeCycleEvent.ON_BEFORE_DISPOSE,this.onComponentDisposedHandler,false,0,false);
            this._componentToVO[param1] = param2;
            _loc4_ = onComponentFoundS(param2.id,param3);
            if(_loc4_ != null)
            {
               as_setTriggers(param2.id,_loc4_);
            }
         }
      }
      
      private function cutSubstitution(param1:String) : String
      {
         return param1.slice(2,param1.length - 1);
      }
      
      private function checkPartialMatch(param1:Array, param2:Vector.<String>, param3:Vector.<DisplayObject>) : DisplayObject
      {
         var _loc4_:int = 0;
         var _loc6_:String = null;
         var _loc8_:DisplayObjectContainer = null;
         var _loc10_:Boolean = false;
         var _loc11_:Object = null;
         var _loc12_:DisplayObject = null;
         var _loc5_:int = 0;
         var _loc7_:int = param1.length;
         do
         {
            _loc10_ = false;
            _loc4_ = 0;
            while(_loc4_ < _loc7_)
            {
               _loc6_ = param1[_loc4_ + _loc5_];
               _loc11_ = this.parseParamString(_loc6_);
               if(_loc11_ != null)
               {
                  _loc12_ = this._customObjectFinder.getObjectByParams(param3[_loc4_ + _loc5_],_loc11_);
                  if(_loc12_ != null)
                  {
                     _loc10_ = true;
                     param1[_loc4_ + _loc5_] = param2[_loc4_ + _loc5_];
                     _loc5_++;
                     param3.splice(_loc4_ + _loc5_,0,_loc12_);
                     param1.splice(_loc4_ + _loc5_,0,_loc12_.name);
                     param2.splice(_loc4_ + _loc5_,0,_loc12_.name);
                  }
               }
               _loc4_++;
            }
         }
         while(_loc10_);
         
         _loc7_ = param2.length;
         _loc4_ = 0;
         while(_loc4_ < _loc7_)
         {
            _loc6_ = param2[_loc4_];
            if(this.isNULLString(_loc6_))
            {
               _loc8_ = param3[_loc4_ - 1] as DisplayObjectContainer;
               if(_loc8_)
               {
                  _loc12_ = _loc8_.getChildByName(param1[_loc4_]);
                  if(_loc12_)
                  {
                     param2[_loc4_] = param1[_loc4_];
                     param3[_loc4_] = _loc12_;
                  }
               }
            }
            _loc4_++;
         }
         var _loc9_:Boolean = true;
         _loc7_ = param2.length;
         _loc4_ = 0;
         while(_loc4_ < _loc7_)
         {
            if(param2[_loc4_] != param1[_loc4_])
            {
               _loc9_ = false;
               break;
            }
            _loc4_++;
         }
         if(_loc9_ && !this._customObjectFinder.validateObjectPath(param3))
         {
            _loc9_ = false;
         }
         if(_loc9_)
         {
            _loc12_ = param3[param3.length - 1] as DisplayObject;
            if(_loc12_)
            {
               return _loc12_;
            }
         }
         return null;
      }
      
      private function isNULLString(param1:String) : Boolean
      {
         return param1 == null || param1 == "null";
      }
      
      private function parseParamString(param1:String) : Object
      {
         var _loc3_:Object = null;
         var _loc4_:String = null;
         var _loc5_:Array = null;
         var _loc6_:int = 0;
         var _loc7_:Array = null;
         var _loc2_:int = param1.search(PARAMS_REG_EXP);
         if(_loc2_ != -1)
         {
            _loc3_ = {};
            _loc4_ = param1.slice(_loc2_ + 1,param1.length);
            _loc5_ = _loc4_.split("&");
            _loc6_ = 0;
            while(_loc6_ < _loc5_.length)
            {
               _loc7_ = _loc5_[_loc6_].split("=");
               _loc3_[_loc7_[0]] = _loc7_[1];
               _loc6_++;
            }
            return _loc3_;
         }
         return null;
      }
      
      private function checkForFullMatching(param1:Array, param2:Vector.<String>, param3:Vector.<DisplayObject>, param4:TutorialEvent) : int
      {
         var _loc6_:int = 0;
         var _loc9_:String = null;
         var _loc10_:int = 0;
         var _loc11_:int = 0;
         var _loc12_:int = 0;
         var _loc13_:String = null;
         var _loc14_:DisplayObject = null;
         var _loc15_:String = null;
         var _loc5_:int = param4.pathPointNames.length;
         _loc6_ = 0;
         while(_loc6_ < _loc5_)
         {
            _loc9_ = param4.pathPointNames[_loc6_];
            _loc10_ = param1.indexOf(_loc9_);
            if(_loc10_ != -1)
            {
               param2[_loc10_] = _loc9_;
               param3[_loc10_] = param4.pathPointObjects[_loc6_];
            }
            else
            {
               _loc11_ = param1.length;
               _loc12_ = 0;
               while(_loc12_ < _loc11_)
               {
                  _loc13_ = param1[_loc12_];
                  if(_loc13_.match(new RegExp(_loc9_ + "?.*")))
                  {
                     param2[_loc12_] = _loc9_;
                     param3[_loc12_] = param4.pathPointObjects[_loc6_];
                     break;
                  }
                  _loc12_++;
               }
            }
            _loc6_++;
         }
         _loc5_ = param2.length - 1;
         var _loc7_:Boolean = false;
         while(this.isNULLString(param2[_loc5_]))
         {
            if(param1[_loc5_].indexOf("?") != -1)
            {
               return MISMATCH;
            }
            _loc5_--;
            _loc7_ = true;
         }
         if(_loc7_)
         {
            if(param1[_loc5_].indexOf("?") == -1)
            {
               return MISMATCH;
            }
         }
         _loc6_ = _loc5_;
         while(_loc6_ > -1)
         {
            if(this.isNULLString(param2[_loc6_]))
            {
               _loc14_ = DisplayObject(param3[_loc6_ + 1]);
               param3[_loc6_] = _loc14_.parent;
               param2[_loc6_] = _loc14_.parent.name;
            }
            _loc6_--;
         }
         _loc5_ = param1.length;
         var _loc8_:Boolean = false;
         _loc6_ = 0;
         while(_loc6_ < _loc5_)
         {
            _loc15_ = param1[_loc6_];
            if(_loc15_ != param2[_loc6_] && !this.isNULLString(param2[_loc6_]))
            {
               if(_loc15_.indexOf("?") == -1)
               {
                  return MISMATCH;
               }
               _loc8_ = true;
            }
            _loc6_++;
         }
         if(_loc8_)
         {
            return PARTIAL_MATCH;
         }
         return FULL_MATCH;
      }
      
      private function isTutorialLinkage(param1:String) : Boolean
      {
         return this._tutorialLinkages.indexOf(param1) != -1;
      }
      
      private function removeListenersFromNotTutorialObject(param1:DisplayObject) : void
      {
         param1.removeEventListener(TutorialEvent.VIEW_READY_FOR_TUTORIAL,this.viewReadyForTutorialHandler);
         param1.removeEventListener(LifeCycleEvent.ON_DISPOSE,this.objectDisposeHandler);
      }
      
      private function generateData(param1:String, param2:Array) : Vector.<String>
      {
         var _loc4_:Object = null;
         var _loc5_:TutorialComponentPathVO = null;
         var _loc6_:Array = null;
         var _loc7_:uint = 0;
         var _loc8_:int = 0;
         var _loc9_:String = null;
         var _loc3_:Vector.<String> = new Vector.<String>();
         for each(_loc4_ in param2)
         {
            _loc5_ = new TutorialComponentPathVO(_loc4_);
            _loc3_.push(_loc5_.path);
            LINKAGE_REG_EXP.lastIndex = 0;
            _loc6_ = _loc5_.path.match(LINKAGE_REG_EXP);
            if(_loc6_)
            {
               _loc7_ = _loc6_.length;
               _loc8_ = 0;
               while(_loc8_ < _loc7_)
               {
                  _loc9_ = _loc6_[_loc8_];
                  this._tutorialLinkages.push(_loc9_.substring(1,_loc9_.length - 1));
                  _loc8_++;
               }
            }
            this._fullPathToVO[this.makeFullPath(param1,_loc5_.path)] = _loc5_;
            this._idToVO[_loc5_.id] = _loc5_;
         }
         return _loc3_;
      }
      
      private function makeFullPath(param1:String, param2:String) : String
      {
         return param1 + "." + param2;
      }
      
      private function unregisterComponent(param1:DisplayObject) : void
      {
         var _loc2_:TutorialComponentPathVO = this._componentToVO[param1];
         var _loc3_:Vector.<ITriggerWatcher> = this._compIdToWatchers[_loc2_.id];
         if(_loc3_ && _loc3_.length > 0)
         {
            this.cleanupTriggerWatchers(_loc3_);
            this._compIdToWatchers[_loc2_.id] = null;
         }
         if(_loc2_)
         {
            this.clearCriteriaHash(CriteriaUtils.componentPathVoPredicate(_loc2_));
            _loc2_.foundComponent = null;
            delete this._componentToVO[param1];
            onComponentDisposedS(_loc2_.id);
            this._buildersMap.removeBuildersForComponent(_loc2_.viewName,_loc2_.id);
         }
      }
      
      public function get isSystemEnabled() : Object
      {
         return this._isSystemEnabled;
      }
      
      private function clearCriteriaHash(param1:Function) : void
      {
         var _loc3_:* = null;
         var _loc4_:* = undefined;
         var _loc2_:Array = [];
         for(_loc3_ in this._criteriaHash)
         {
            if(param1(this._criteriaHash[_loc3_]))
            {
               _loc2_.push(_loc3_);
            }
         }
         for each(_loc4_ in _loc2_)
         {
            this._criteriaHash[_loc4_].dispose();
            delete this._criteriaHash[_loc4_];
         }
      }
      
      private function onViewOnDisposeHandler(param1:Event) : void
      {
         var _loc2_:IView = IView(param1.currentTarget);
         _loc2_.removeEventListener(LifeCycleEvent.ON_DISPOSE,this.onViewOnDisposeHandler);
         var _loc3_:String = _loc2_.as_config.viewTutorialId;
         this.clearCriteriaHash(CriteriaUtils.viewIdPredicate(_loc3_));
         this._buildersMap.removeBuildersForView(_loc3_);
         delete this._idToView[_loc3_];
      }
      
      private function unboundViewAddedHandler(param1:Event) : void
      {
         var _loc4_:Boolean = false;
         var _loc5_:* = null;
         var _loc6_:TutorialUnboundViewVO = null;
         var _loc7_:String = null;
         var _loc8_:TutorialComponentPathVO = null;
         var _loc2_:DisplayObject = DisplayObject(param1.currentTarget);
         _loc2_.removeEventListener(Event.ADDED_TO_STAGE,this.unboundViewAddedHandler);
         var _loc3_:IView = _loc2_.parent as IView;
         if(_loc3_)
         {
            _loc4_ = false;
            for(_loc5_ in this._unboudViewsForRegister)
            {
               _loc6_ = this._unboudViewsForRegister[_loc5_];
               if(_loc6_.viewContent == _loc2_)
               {
                  _loc4_ = true;
                  this._idToView[_loc5_] = _loc3_;
                  _loc3_.as_config.viewTutorialId = _loc5_;
                  for each(_loc7_ in _loc6_.componentPaths)
                  {
                     _loc8_ = this._fullPathToVO[_loc7_];
                     if(_loc8_)
                     {
                        _loc8_.foundComponent = this._unboundComponents[_loc7_];
                        this.processFoundComponent(_loc8_.foundComponent,_loc8_,_loc5_);
                     }
                     else
                     {
                        assert(false,"Unregistered view = " + _loc5_);
                     }
                  }
                  _loc6_.dispose();
                  delete this._unboudViewsForRegister[_loc5_];
                  break;
               }
            }
            assert(_loc4_,"Cann\'t register unbound content in tutorial system. Content name = " + _loc2_.name);
         }
         else
         {
            assert(false,"View container must be USSWrapper");
         }
      }
      
      private function onUnboundComponentRemovedHandler(param1:Event) : void
      {
         var _loc4_:* = null;
         var _loc2_:DisplayObject = DisplayObject(param1.target);
         _loc2_.removeEventListener(Event.REMOVED_FROM_STAGE,this.onUnboundComponentRemovedHandler);
         var _loc3_:TutorialComponentPathVO = this._componentToVO[_loc2_];
         if(_loc3_)
         {
            this.unregisterComponent(_loc2_);
         }
         for(_loc4_ in this._unboundComponents)
         {
            if(this._unboundComponents[_loc4_] == _loc2_)
            {
               delete this._unboundComponents[_loc4_];
               break;
            }
         }
      }
      
      private function onTriggerActivatedHandler(param1:TriggerEvent) : void
      {
         var _loc2_:ITriggerWatcher = param1.target as ITriggerWatcher;
         if(_loc2_)
         {
            onTriggerActivatedS(_loc2_.componentId,_loc2_.type,param1.componentState);
         }
      }
      
      private function onComponentDisposedHandler(param1:LifeCycleEvent) : void
      {
         var _loc2_:DisplayObject = param1.target as DisplayObject;
         if(_loc2_ && _loc2_ == param1.currentTarget)
         {
            _loc2_.removeEventListener(LifeCycleEvent.ON_BEFORE_DISPOSE,this.onComponentDisposedHandler);
            this.unregisterComponent(DisplayObject(param1.target));
         }
      }
      
      private function clearTutorialEvent(param1:TutorialEvent) : void
      {
         param1.pathPointNames.splice(0,param1.pathPointNames.length);
         param1.pathPointObjects.splice(0,param1.pathPointObjects.length);
         param1.pathPointNames = null;
         param1.pathPointObjects = null;
      }
      
      private function viewReadyForTutorialHandler(param1:TutorialEvent) : void
      {
         param1.stopPropagation();
      }
      
      private function objectDisposeHandler(param1:LifeCycleEvent) : void
      {
         this.removeListenersFromNotTutorialObject(DisplayObject(param1.target));
         this._ignoredInTutorialComponents.splice(this._ignoredInTutorialComponents.indexOf(DisplayObject(param1.target)),1);
      }
      
      private function onViewReadyForTutorialHandler(param1:TutorialEvent) : void
      {
         var _loc3_:ITutorialCustomComponent = null;
         var _loc2_:ITutorialCustomComponent = ITutorialCustomComponent(param1.currentTarget);
         if(param1.target != param1.currentTarget)
         {
            param1.addPathPoint(DisplayObject(_loc2_),_loc2_.getTutorialDescriptionName());
            if(_loc2_.needPreventInnerEvents())
            {
               _loc3_ = param1.target as ITutorialCustomComponent;
               if(_loc3_ != null && _loc3_.generatedUnstoppableEvents())
               {
                  return;
               }
               param1.stopImmediatePropagation();
            }
         }
      }
   }
}

import net.wg.data.vo.TutorialComponentPathVO;
import net.wg.data.vo.TutorialCriteriaVo;

class CriteriaUtils
{
    
   
   function CriteriaUtils()
   {
      super();
   }
   
   public static function viewIdPredicate(param1:String) : Function
   {
      var id:String = param1;
      return function(param1:TutorialCriteriaVo):Boolean
      {
         return param1.viewTutorialId == id;
      };
   }
   
   public static function componentPathVoPredicate(param1:TutorialComponentPathVO) : Function
   {
      var cmpVo:TutorialComponentPathVO = param1;
      return function(param1:TutorialCriteriaVo):Boolean
      {
         return param1.vo == cmpVo;
      };
   }
}
