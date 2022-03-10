package net.wg.infrastructure.managers.utils.animation.impl
{
   import flash.display.DisplayObject;
   import flash.display.DisplayObjectContainer;
   import flash.display.Sprite;
   import flash.geom.Point;
   import net.wg.data.constants.Errors;
   import net.wg.infrastructure.interfaces.IAnimation;
   import net.wg.utils.IAssertable;
   
   public class TweenWrapper extends Sprite
   {
       
      
      private var _container:DisplayObjectContainer = null;
      
      private var _target:DisplayObject = null;
      
      private var startIndex:int = 0;
      
      private var startPoint:Point = null;
      
      private var chainOfAnimations:Vector.<LinkedObjects>;
      
      public function TweenWrapper(param1:DisplayObjectContainer, param2:DisplayObject)
      {
         this.chainOfAnimations = new Vector.<LinkedObjects>(0);
         super();
         var _loc3_:String = "Container" + Errors.CANT_NULL;
         var _loc4_:String = "Target" + Errors.CANT_NULL;
         var _loc5_:IAssertable = getAsserter();
         _loc5_.assertNotNull(param1,_loc3_);
         _loc5_.assertNotNull(param2,_loc4_);
         this._container = param1;
         this.startIndex = this._container.getChildIndex(param2);
         this.startPoint = new Point(param2.x,param2.y);
         x = param2.x;
         y = param2.y;
         this._target = param2;
         this._target.x = 0;
         this._target.y = 0;
         this._container.addChildAt(this,this.startIndex);
         addChild(param2);
      }
      
      private static function getAsserter() : IAssertable
      {
         return App.utils.asserter;
      }
      
      public function changeVisibilityFromTarget() : void
      {
         visible = this._target.visible;
         alpha = this._target.alpha;
         this._target.alpha = 1;
         this._target.visible = true;
      }
      
      public function addAnimationByClassName(param1:String) : IAnimation
      {
         var _loc2_:IAnimation = null;
         var _loc4_:DisplayObject = null;
         var _loc3_:int = this.findElementIndexByClassName(param1);
         if(_loc3_ < 0)
         {
            _loc2_ = IAnimation(App.utils.classFactory.getComponent(param1,IAnimation));
            _loc4_ = getChildAt(0);
            this.chainOfAnimations.unshift(new LinkedObjects(_loc2_,param1));
            addChild(DisplayObject(_loc2_));
            _loc2_.getTarget().addChild(_loc4_);
         }
         else
         {
            _loc2_ = this.chainOfAnimations[_loc3_].element;
         }
         return _loc2_;
      }
      
      public function removeAnimationByClassName(param1:String) : void
      {
         var _loc4_:DisplayObjectContainer = null;
         var _loc5_:IAnimation = null;
         var _loc6_:DisplayObject = null;
         var _loc2_:String = "No element with such index!";
         var _loc3_:int = this.findElementIndexByClassName(param1);
         getAsserter().assert(_loc3_ >= 0,_loc2_);
         if(_loc3_ >= 0)
         {
            _loc4_ = null;
            if(this.chainOfAnimations.length > 1 && _loc3_ != 0)
            {
               _loc4_ = this.chainOfAnimations[_loc3_ - 1].element.getTarget();
            }
            else
            {
               _loc4_ = this;
            }
            _loc5_ = this.chainOfAnimations[_loc3_].element;
            _loc6_ = _loc5_.getTarget().getChildAt(0);
            this.chainOfAnimations.splice(_loc3_,1);
            _loc4_.removeChild(DisplayObject(_loc5_));
            _loc4_.addChild(_loc6_);
         }
      }
      
      public function dispose() : void
      {
         while(this.chainOfAnimations.length > 0)
         {
            this.chainOfAnimations.pop().dispose();
         }
         this.chainOfAnimations = null;
         this._container.addChildAt(this._target,this.startIndex);
         this._target.x = this.startPoint.x;
         this._target.y = this.startPoint.y;
         this._target.alpha = alpha;
         this._target.visible = visible;
         this._container.removeChild(this);
         this._container = null;
         this._target = null;
      }
      
      private function findElementIndexByClassName(param1:String) : int
      {
         var _loc4_:LinkedObjects = null;
         var _loc2_:int = -1;
         var _loc3_:int = 0;
         while(_loc3_ < this.chainOfAnimations.length)
         {
            _loc4_ = this.chainOfAnimations[_loc3_];
            if(_loc4_.elementClassName == param1)
            {
               _loc2_ = _loc3_;
               break;
            }
            _loc3_++;
         }
         return _loc2_;
      }
   }
}

import net.wg.infrastructure.interfaces.IAnimation;
import net.wg.infrastructure.interfaces.entity.IDisposable;

class LinkedObjects implements IDisposable
{
    
   
   private var _element:IAnimation = null;
   
   private var _elementClassName:String = null;
   
   private var _disposed:Boolean = false;
   
   function LinkedObjects(param1:IAnimation, param2:String)
   {
      super();
      this._element = param1;
      this._elementClassName = param2;
   }
   
   public function get element() : IAnimation
   {
      return this._element;
   }
   
   public function set element(param1:IAnimation) : void
   {
      this._element = param1;
   }
   
   public function get elementClassName() : String
   {
      return this._elementClassName;
   }
   
   public function set elementClassName(param1:String) : void
   {
      this._elementClassName = param1;
   }
   
   public final function dispose() : void
   {
      this._disposed = true;
      this._element = null;
      this._elementClassName = null;
   }
   
   public function isDisposed() : Boolean
   {
      return this._disposed;
   }
}
