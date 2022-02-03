package net.wg.infrastructure.managers.utils.animation.impl
{
   import flash.display.DisplayObject;
   import net.wg.data.TweenDataByType;
   import net.wg.data.constants.DelayTypes;
   import net.wg.data.constants.Linkages;
   import net.wg.data.constants.TweenTypes;
   import net.wg.infrastructure.interfaces.ISimpleTweenPropertiesVO;
   import net.wg.infrastructure.interfaces.ITween;
   import net.wg.infrastructure.interfaces.ITweenConstructionHandler;
   import net.wg.infrastructure.interfaces.ITweenTypesDuration;
   import net.wg.infrastructure.managers.ITweenManagerHelper;
   import net.wg.utils.IAssertable;
   import net.wg.utils.ICommons;
   import net.wg.utils.IDataUtils;
   import net.wg.utils.ITweenAnimator;
   import net.wg.utils.animation.ITweenConstruction;
   import org.idmedia.as3commons.util.Iterator;
   import org.idmedia.as3commons.util.Map;
   
   public class TweenConstruction implements ITweenConstruction
   {
      
      private static var identicalTypes:Vector.<TweenDataByType>;
      
      private static const GLOBAL_DELAY_IDX:int = 0;
      
      private static const LOCAL_DELAY_IDX:int = 1;
       
      
      private var tweenTypesMap:Map = null;
      
      private var pythonTweenCreators:Map = null;
      
      private var _target:DisplayObject = null;
      
      private var tweensData:Vector.<TweenLinkedObjects>;
      
      private var _tweenConstructionHandler:ITweenConstructionHandler = null;
      
      private var firstPlayingElement:TweenLinkedObjects = null;
      
      private var lastPlayingElement:TweenLinkedObjects = null;
      
      private var tweenWrapper:TweenWrapper = null;
      
      private var startStateTarget:Object;
      
      private var stateTargetAfterAnim:Object;
      
      private var _disposed:Boolean = false;
      
      public function TweenConstruction(param1:DisplayObject, param2:ITweenConstructionHandler)
      {
         this.tweensData = new Vector.<TweenLinkedObjects>(0);
         this.startStateTarget = {};
         this.stateTargetAfterAnim = {};
         super();
         var _loc3_:IDataUtils = App.utils.data;
         identicalTypes = new <TweenDataByType>[new TweenDataByType(TweenTypes.MOVE_TYPES,this.tweenMgrHelper.getMoveDuration()),new TweenDataByType(TweenTypes.FADE_TYPES,this.tweenMgrHelper.getFadeDuration()),new TweenDataByType(TweenTypes.GLOW_TYPES,this.tweenMgrHelper.getGlowDuration()),new TweenDataByType(TweenTypes.SHADOW_TYPES,this.tweenMgrHelper.getShadowDuration()),new TweenDataByType(TweenTypes.TURN_TYPES,this.tweenMgrHelper.getHalfTurnDuration())];
         this.tweenTypesMap = _loc3_.createMap([Linkages.GLOW_IN_ANIM,TweenTypes.GLOW_IN,Linkages.GLOW_OUT_ANIM,TweenTypes.GLOW_OUT,Linkages.SHADOW_IN_ANIM,TweenTypes.SHADOW_IN,Linkages.SHADOW_OUT_ANIM,TweenTypes.SHADOW_OUT]);
         var _loc4_:ITweenAnimator = this.getAnimator();
         this.pythonTweenCreators = _loc3_.createMap([TweenTypes.FADE_IN,_loc4_.addFadeInAnimEx,TweenTypes.FADE_OUT,_loc4_.addFadeOutAnimEx,TweenTypes.MOVE_DOWN,_loc4_.addMoveDownAnimEx,TweenTypes.MOVE_UP,_loc4_.addMoveUpAnimEx,TweenTypes.TURN_HALF,_loc4_.addHalfTurnAnimEx]);
         this._target = param1;
         this.createStartParams();
         this.tweenWrapper = new TweenWrapper(param1.parent,param1);
         this._tweenConstructionHandler = param2;
      }
      
      private static function getTweenSettingByType(param1:String) : ITweenTypesDuration
      {
         var _loc2_:int = 0;
         while(_loc2_ < identicalTypes.length)
         {
            if(identicalTypes[_loc2_].types.indexOf(param1))
            {
               return identicalTypes[_loc2_];
            }
            _loc2_++;
         }
         return null;
      }
      
      public function addFadeIn(param1:int, param2:String = "global") : ITweenConstruction
      {
         this.createPythonTween(TweenTypes.FADE_IN,param1,param2);
         return this;
      }
      
      public function addFadeOut(param1:int, param2:String = "global") : ITweenConstruction
      {
         this.createPythonTween(TweenTypes.FADE_OUT,param1,param2);
         return this;
      }
      
      public function addMoveUp(param1:int, param2:String = "global") : ITweenConstruction
      {
         this.createPythonTween(TweenTypes.MOVE_UP,param1,param2);
         return this;
      }
      
      public function addMoveDown(param1:int, param2:String = "global") : ITweenConstruction
      {
         this.createPythonTween(TweenTypes.MOVE_DOWN,param1,param2);
         return this;
      }
      
      public function addHalfTurn(param1:int, param2:String = "global") : ITweenConstruction
      {
         this.createPythonTween(TweenTypes.TURN_HALF,param1,param2);
         return this;
      }
      
      public function addTween(param1:ITween, param2:int, param3:String = "global") : ITweenConstruction
      {
         if(param1.memberData == null)
         {
            param1.memberData = {"type":TweenTypes.USER_TWEEN};
         }
         else
         {
            param1.memberData.type = TweenTypes.USER_TWEEN;
         }
         this.addInStack(new TweenLinkedObjects(param1,param2,param3));
         return this;
      }
      
      public function start() : void
      {
         var _loc1_:TweenLinkedObjects = null;
         var _loc2_:ITween = null;
         this.tweenWrapper.changeVisibilityFromTarget();
         for each(_loc1_ in this.tweensData)
         {
            _loc2_ = _loc1_.tween;
            _loc2_.resetAnimS();
            _loc2_.setPausedS(false);
         }
      }
      
      public function onComplete(param1:ITween) : void
      {
         var _loc3_:TweenLinkedObjects = null;
         var _loc2_:ISimpleTweenPropertiesVO = ISimpleTweenPropertiesVO(param1.props);
         if(this._tweenConstructionHandler != null)
         {
            this._tweenConstructionHandler.onComplete(_loc2_);
         }
         for each(_loc3_ in this.tweensData)
         {
            if(_loc3_ == this.lastPlayingElement && _loc3_.tween == param1)
            {
               if(this._tweenConstructionHandler != null)
               {
                  this._tweenConstructionHandler.constructionOnComplete(_loc2_);
               }
            }
         }
      }
      
      public function onStart(param1:ITween) : void
      {
         var _loc3_:TweenLinkedObjects = null;
         var _loc2_:ISimpleTweenPropertiesVO = ISimpleTweenPropertiesVO(param1.props);
         for each(_loc3_ in this.tweensData)
         {
            if(_loc3_ == this.firstPlayingElement && _loc3_.tween == param1)
            {
               if(this._tweenConstructionHandler != null)
               {
                  this._tweenConstructionHandler.constructionOnStart(_loc2_);
               }
               break;
            }
         }
         if(this._tweenConstructionHandler != null)
         {
            this._tweenConstructionHandler.onStart(_loc2_);
         }
      }
      
      public function dispose() : void
      {
         var _loc1_:TweenLinkedObjects = null;
         this._disposed = true;
         while(this.tweensData.length > 0)
         {
            _loc1_ = this.tweensData.pop();
            App.tweenMgr.disposeTweenS(_loc1_.tween);
            _loc1_.dispose();
         }
         this.tweensData = null;
         this.firstPlayingElement = null;
         this.lastPlayingElement = null;
         this.tweenWrapper.dispose();
         this.tweenWrapper = null;
         this._target = null;
         this._tweenConstructionHandler = null;
      }
      
      public function removeTween(param1:int) : void
      {
         var _loc8_:String = null;
         var _loc9_:Iterator = null;
         var _loc10_:Object = null;
         var _loc2_:String = "Not element with such index";
         var _loc3_:String = "Not element with such className";
         var _loc4_:TweenLinkedObjects = this.tweensData[param1];
         var _loc5_:IAssertable = this.getAsserter();
         var _loc6_:Boolean = param1 < this.tweensData.length && param1 >= 0;
         _loc5_.assert(_loc6_,_loc2_);
         var _loc7_:String = _loc4_.tween.memberData.type;
         if(this.findTweenDataByType(_loc7_).length == 1)
         {
            _loc8_ = null;
            _loc9_ = this.tweenTypesMap.entrySet().iterator();
            while(_loc9_.hasNext())
            {
               _loc10_ = _loc9_.next();
               if(_loc10_.getValue() == _loc7_)
               {
                  _loc8_ = _loc10_.getKey();
                  break;
               }
            }
            _loc5_.assertNotNull(_loc8_,_loc3_);
            this.tweenWrapper.removeAnimationByClassName(_loc8_);
         }
         App.tweenMgr.disposeTweenS(_loc4_.tween);
         this.tweensData[param1].dispose();
         this.tweensData.splice(param1,1);
         this.firstPlayingElement = this.findFirstPlayingElement();
         this.lastPlayingElement = this.findLastPlayingElement();
      }
      
      public function countTweens() : int
      {
         return this.tweensData.length;
      }
      
      public function getAllTweens() : Vector.<ISimpleTweenPropertiesVO>
      {
         var _loc1_:Vector.<ISimpleTweenPropertiesVO> = new Vector.<ISimpleTweenPropertiesVO>(0);
         var _loc2_:int = 0;
         while(_loc2_ < this.tweensData.length)
         {
            _loc1_.push(this.tweensData[_loc2_].tween.props);
            _loc2_++;
         }
         return _loc1_;
      }
      
      public function getTweenByIdx(param1:int) : ISimpleTweenPropertiesVO
      {
         var _loc2_:String = "Not element with such index!";
         this.getAsserter().assert(param1 < this.tweensData.length,_loc2_);
         return this.tweensData[param1].tween.props;
      }
      
      private function createStartParams() : void
      {
         var _loc2_:String = null;
         var _loc1_:Vector.<String> = new <String>["x","y","alpha","rotation","scaleX","scaleY"];
         for each(_loc2_ in _loc1_)
         {
            if(_loc2_ in this._target)
            {
               this.stateTargetAfterAnim[_loc2_] = this.startStateTarget[_loc2_] = this._target[_loc2_];
            }
         }
      }
      
      private function getAsserter() : IAssertable
      {
         return App.utils.asserter;
      }
      
      private function getAnimator() : ITweenAnimator
      {
         return App.utils.tweenAnimator;
      }
      
      private function getCommon() : ICommons
      {
         return App.utils.commons;
      }
      
      private function findTweenDataByType(param1:String) : Vector.<int>
      {
         var _loc2_:Vector.<int> = new Vector.<int>(0);
         var _loc3_:int = 0;
         while(_loc3_ < this.tweensData.length)
         {
            if(this.tweensData[_loc3_].tween.memberData.type == param1)
            {
               _loc2_.push(_loc3_);
            }
            _loc3_++;
         }
         return _loc2_;
      }
      
      private function createPythonTween(param1:String, param2:int, param3:String) : void
      {
         var _loc4_:ITween = null;
         this.setParamsToTarget(this.stateTargetAfterAnim);
         if(TweenTypes.MOVE_TYPES.indexOf(param1) >= 0)
         {
            _loc4_ = this.pythonTweenCreators.get(param1)(this.tweenWrapper,this.tweenWrapper.y);
         }
         else
         {
            _loc4_ = this.pythonTweenCreators.get(param1)(this.tweenWrapper);
         }
         var _loc5_:Object = TweenDataByType.getPropertyChanges(param1);
         if(_loc5_.propertyName in this.stateTargetAfterAnim)
         {
            if(_loc5_.type == TweenDataByType.TYPE_ADD)
            {
               this.stateTargetAfterAnim[_loc5_.propertyName] += _loc5_.value;
            }
            else if(_loc5_.type == TweenDataByType.TYPE_SET)
            {
               this.stateTargetAfterAnim[_loc5_.propertyName] = _loc5_.value;
            }
         }
         this.addInStack(new TweenLinkedObjects(_loc4_,param2,param3));
         this.setParamsToTarget(this.startStateTarget);
      }
      
      private function setParamsToTarget(param1:Object) : void
      {
         var _loc2_:* = null;
         for(_loc2_ in param1)
         {
            this.tweenWrapper[_loc2_] = param1[_loc2_];
         }
      }
      
      private function getDelays(param1:int, param2:String = "global") : Array
      {
         var _loc5_:TweenLinkedObjects = null;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         if(param2 == DelayTypes.GLOBAL)
         {
            _loc3_ = param1;
            _loc4_ = param1;
         }
         else if(param2 == DelayTypes.LOCAL)
         {
            _loc5_ = this.tweensData[this.tweensData.length - 1];
            _loc3_ = _loc5_.delay + _loc5_.tween.props.getDuration() + param1;
            _loc4_ = param1;
         }
         return [_loc3_,_loc4_];
      }
      
      private function addInStack(param1:TweenLinkedObjects) : void
      {
         var _loc2_:String = "Tweens with identical type will not be executed in at one time!";
         this.getAsserter().assert(this.tweensAreNotCrossedInTime(param1),_loc2_);
         var _loc3_:ITween = param1.tween;
         _loc3_.setHandler(this);
         var _loc4_:Array = this.getDelays(param1.delay,param1.type);
         _loc3_.setDelayS(_loc4_[GLOBAL_DELAY_IDX]);
         _loc3_.props.setGlobalDelay(_loc4_[GLOBAL_DELAY_IDX]);
         _loc3_.props.setLocalDelay(_loc4_[LOCAL_DELAY_IDX]);
         this.tweensData.push(param1);
         this.firstPlayingElement = this.findFirstPlayingElement();
         this.lastPlayingElement = this.findLastPlayingElement();
      }
      
      private function findFirstPlayingElement() : TweenLinkedObjects
      {
         var _loc3_:TweenLinkedObjects = null;
         var _loc1_:TweenLinkedObjects = null;
         if(this.tweensData.length > 0)
         {
            _loc1_ = this.tweensData[0];
         }
         var _loc2_:int = 1;
         while(_loc2_ < this.tweensData.length)
         {
            _loc3_ = this.tweensData[_loc2_];
            if(_loc3_.type == null)
            {
               if(_loc1_.tween.props.getGlobalDelay() > _loc3_.tween.props.getGlobalDelay())
               {
                  _loc1_ = _loc3_;
               }
            }
            _loc2_++;
         }
         return _loc1_;
      }
      
      private function findLastPlayingElement() : TweenLinkedObjects
      {
         var _loc3_:TweenLinkedObjects = null;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:TweenLinkedObjects = null;
         var _loc7_:int = 0;
         var _loc1_:TweenLinkedObjects = null;
         if(this.tweensData.length > 0)
         {
            _loc1_ = this.tweensData[0];
         }
         var _loc2_:int = 1;
         while(_loc2_ < this.tweensData.length)
         {
            _loc3_ = this.tweensData[_loc2_];
            if(_loc3_.type == null)
            {
               _loc4_ = _loc3_.tween.props.getGlobalDelay() + _loc3_.tween.props.getDuration();
               _loc5_ = _loc1_.tween.props.getGlobalDelay() + _loc1_.tween.props.getDuration();
               if(_loc5_ <= _loc4_)
               {
                  _loc1_ = _loc3_;
               }
            }
            else
            {
               _loc6_ = this.tweensData[_loc2_ - 1];
               _loc7_ = _loc6_.tween.props.getGlobalDelay() + _loc6_.tween.props.getDuration();
               if(_loc1_.tween.props.getGlobalDelay() <= _loc7_)
               {
                  _loc1_ = _loc3_;
               }
            }
            _loc2_++;
         }
         return _loc1_;
      }
      
      private function tweensAreNotCrossedInTime(param1:TweenLinkedObjects) : Boolean
      {
         var _loc4_:Object = null;
         var _loc5_:int = 0;
         var _loc6_:TweenLinkedObjects = null;
         var _loc7_:Boolean = false;
         var _loc2_:Vector.<String> = null;
         var _loc3_:int = 0;
         while(_loc3_ < identicalTypes.length)
         {
            _loc4_ = identicalTypes[_loc3_];
            if(_loc4_.types.indexOf(param1.tween.memberData.type) >= 0)
            {
               _loc2_ = _loc4_.types;
               _loc5_ = _loc4_.duration;
            }
            _loc3_++;
         }
         _loc3_ = 0;
         for(; _loc3_ < this.tweensData.length; _loc3_++)
         {
            _loc6_ = this.tweensData[_loc3_];
            if(_loc6_.type != null || param1.type != null)
            {
               if(_loc6_.tween.getTargetDisplayObject() != param1.tween.getTargetDisplayObject())
               {
                  continue;
               }
            }
            if(_loc2_.indexOf(_loc6_.tween.memberData.type) >= 0)
            {
               _loc7_ = Math.abs(_loc6_.delay - param1.delay) >= _loc5_;
               if(!_loc7_)
               {
                  return false;
               }
            }
         }
         return true;
      }
      
      private function get tweenMgrHelper() : ITweenManagerHelper
      {
         return App.tweenMgr.getTweenManagerHelper();
      }
      
      public function isDisposed() : Boolean
      {
         return this._disposed;
      }
   }
}
