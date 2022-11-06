package net.wg.infrastructure.managers.impl
{
   import flash.events.Event;
   import flash.geom.Rectangle;
   import flash.utils.Dictionary;
   import net.wg.infrastructure.base.meta.IGraphicsOptimizationManagerMeta;
   import net.wg.infrastructure.base.meta.impl.GraphicsOptimizationManagerMeta;
   import net.wg.infrastructure.events.LifeCycleEvent;
   import net.wg.infrastructure.interfaces.IGraphicsOptimizationComponent;
   import net.wg.infrastructure.managers.IGraphicsOptimizationManager;
   import scaleform.clik.events.ComponentEvent;
   
   public class GraphicsOptimizationManager extends GraphicsOptimizationManagerMeta implements IGraphicsOptimizationManager, IGraphicsOptimizationManagerMeta
   {
       
      
      private var _componentsInWork:Dictionary;
      
      private var _componentsInListen:Dictionary;
      
      private var _lastScaleFactor:Number = 0;
      
      private var _isEnabled:Boolean = true;
      
      public function GraphicsOptimizationManager()
      {
         super();
         this._componentsInWork = new Dictionary();
         this._componentsInListen = new Dictionary();
      }
      
      public function as_invalidateRectangles() : void
      {
         var _loc1_:* = undefined;
         var _loc2_:String = null;
         if(!this._isEnabled)
         {
            return;
         }
         for(_loc1_ in this._componentsInListen)
         {
            _loc2_ = _loc1_.getAliasS();
            if(isOptimizationAvailableS(_loc2_))
            {
               if(isOptimizationEnabledS(_loc2_))
               {
                  this.registerComponent(_loc1_);
               }
            }
            else
            {
               this.unregister(_loc1_);
            }
         }
         for(_loc1_ in this._componentsInWork)
         {
            _loc2_ = _loc1_.getAliasS();
            if(isOptimizationAvailableS(_loc2_))
            {
               if(isOptimizationEnabledS(_loc2_))
               {
                  this.registerComponent(_loc1_);
               }
               else
               {
                  this.unregister(_loc1_);
                  this.listenComponent(_loc1_);
               }
            }
            else
            {
               this.unregister(_loc1_);
            }
         }
      }
      
      public function as_switchOptimizationEnabled(param1:Boolean) : void
      {
         this._isEnabled = param1;
      }
      
      public function register(param1:IGraphicsOptimizationComponent) : void
      {
         var _loc2_:String = param1.getAliasS();
         if(isOptimizationAvailableS(_loc2_))
         {
            if(isOptimizationEnabledS(_loc2_))
            {
               this.registerComponent(param1);
            }
            else
            {
               this.listenComponent(param1);
            }
         }
      }
      
      public function switchEnabled(param1:Boolean) : void
      {
         this._isEnabled = param1;
         switchOptimizationEnabledS(param1);
      }
      
      public function unregister(param1:IGraphicsOptimizationComponent) : void
      {
         var _loc3_:Object = null;
         if(!this._componentsInWork[param1] && !this._componentsInListen[param1])
         {
            return;
         }
         param1.removeEventListener(LifeCycleEvent.ON_BEFORE_DISPOSE,this.onBeforeComponentDisposeHandler);
         param1.removeEventListener(LifeCycleEvent.ON_GRAPHICS_RECTANGLES_UPDATE,this.onGraphicsRectanglesUpdateHandler);
         param1.removeEventListener(ComponentEvent.SHOW,this.onGraphicsRectanglesUpdateHandler);
         param1.removeEventListener(ComponentEvent.HIDE,this.onGraphicsRectanglesUpdateHandler);
         var _loc2_:Array = this._componentsInWork[param1];
         if(_loc2_)
         {
            for each(_loc3_ in _loc2_)
            {
               if(_loc3_.id > 0)
               {
                  unregisterOptimizationAreaS(_loc3_.id);
               }
            }
            _loc2_.length = 0;
         }
         delete this._componentsInWork[param1];
         delete this._componentsInListen[param1];
      }
      
      public function updateStage(param1:Number, param2:Number) : void
      {
         var _loc4_:* = undefined;
         var _loc3_:Boolean = this._lastScaleFactor != App.appScale;
         for(_loc4_ in this._componentsInWork)
         {
            this.updateComponentReactangle(_loc4_,_loc3_);
         }
         this._lastScaleFactor = App.appScale;
      }
      
      private function registerComponent(param1:IGraphicsOptimizationComponent) : void
      {
         var _loc2_:Number = NaN;
         var _loc3_:Array = null;
         var _loc4_:Rectangle = null;
         delete this._componentsInListen[param1];
         if(!this._componentsInWork[param1])
         {
            param1.addEventListener(LifeCycleEvent.ON_BEFORE_DISPOSE,this.onBeforeComponentDisposeHandler);
            param1.addEventListener(LifeCycleEvent.ON_GRAPHICS_RECTANGLES_UPDATE,this.onGraphicsRectanglesUpdateHandler);
            param1.addEventListener(ComponentEvent.SHOW,this.onGraphicsRectanglesUpdateHandler);
            param1.addEventListener(ComponentEvent.HIDE,this.onGraphicsRectanglesUpdateHandler);
            _loc2_ = App.appScale;
            _loc3_ = this._componentsInWork[param1] = [];
            for each(_loc4_ in param1.getRectangles())
            {
               this.validateRect(_loc4_);
               _loc3_.push({
                  "id":(Boolean(_loc4_) ? registerOptimizationAreaS(_loc4_.x * _loc2_,_loc4_.y * _loc2_,_loc4_.width * _loc2_,_loc4_.height * _loc2_) : -1),
                  "rect":_loc4_
               });
            }
         }
      }
      
      private function validateRect(param1:Rectangle) : Rectangle
      {
         if(param1 == null)
         {
            return null;
         }
         var _loc2_:Number = App.appWidth;
         var _loc3_:Number = App.appHeight;
         if(param1.x < 0)
         {
            param1.width += param1.x;
            param1.x = 0;
         }
         if(param1.x + param1.width > _loc2_)
         {
            param1.width = _loc2_ - param1.x;
         }
         if(param1.y < 0)
         {
            param1.height += param1.y;
            param1.y = 0;
         }
         if(param1.y + param1.height > _loc3_)
         {
            param1.height = _loc3_ - param1.y;
         }
         if(param1.width < 0)
         {
            param1.width = 0;
         }
         if(param1.height < 0)
         {
            param1.height = 0;
         }
         return param1;
      }
      
      private function listenComponent(param1:IGraphicsOptimizationComponent) : void
      {
         if(!this._componentsInListen[param1])
         {
            param1.addEventListener(LifeCycleEvent.ON_BEFORE_DISPOSE,this.onBeforeComponentDisposeHandler);
            this._componentsInListen[param1] = true;
         }
      }
      
      private function updateComponentReactangle(param1:IGraphicsOptimizationComponent, param2:Boolean = false) : void
      {
         var _loc10_:Rectangle = null;
         var _loc11_:Rectangle = null;
         var _loc3_:Array = this._componentsInWork[param1];
         var _loc4_:Vector.<Rectangle> = param1.getRectangles();
         var _loc5_:int = Boolean(_loc4_) ? int(_loc4_.length) : int(0);
         var _loc6_:int = Boolean(_loc3_) ? int(_loc3_.length) : int(0);
         var _loc7_:int = Math.max(_loc5_,_loc6_);
         var _loc8_:Number = App.appScale;
         var _loc9_:int = 0;
         while(_loc9_ < _loc7_)
         {
            _loc10_ = _loc9_ < _loc6_ ? _loc3_[_loc9_].rect : null;
            _loc11_ = _loc9_ < _loc5_ ? this.validateRect(_loc4_[_loc9_]) : null;
            if(!(_loc11_ == null && _loc10_ == null && !param2))
            {
               if(_loc10_ == null && _loc11_ != null)
               {
                  _loc3_[_loc9_] = {
                     "id":registerOptimizationAreaS(_loc11_.x * _loc8_,_loc11_.y * _loc8_,_loc11_.width * _loc8_,_loc11_.height * _loc8_),
                     "rect":_loc11_
                  };
               }
               else if(_loc10_ != null && _loc11_ == null && _loc3_[_loc9_].id > 0)
               {
                  unregisterOptimizationAreaS(_loc3_[_loc9_].id);
                  _loc3_[_loc9_].id = -1;
                  _loc3_[_loc9_].rect = _loc11_;
               }
               else if((param2 || !_loc10_.equals(_loc11_)) && _loc11_ != null)
               {
                  updateOptimizationAreaS(_loc3_[_loc9_].id,_loc11_.x * _loc8_,_loc11_.y * _loc8_,_loc11_.width * _loc8_,_loc11_.height * _loc8_);
                  _loc3_[_loc9_].rect = _loc11_;
               }
            }
            _loc9_++;
         }
      }
      
      private function onBeforeComponentDisposeHandler(param1:LifeCycleEvent) : void
      {
         this.unregister(IGraphicsOptimizationComponent(param1.currentTarget));
      }
      
      private function onGraphicsRectanglesUpdateHandler(param1:Event) : void
      {
         this.updateComponentReactangle(IGraphicsOptimizationComponent(param1.currentTarget));
      }
   }
}
