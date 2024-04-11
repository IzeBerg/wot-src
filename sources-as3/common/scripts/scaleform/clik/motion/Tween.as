package scaleform.clik.motion
{
   import flash.display.DisplayObject;
   import flash.display.Shape;
   import flash.events.Event;
   import flash.geom.Matrix;
   import flash.geom.Transform;
   import flash.utils.getTimer;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class Tween implements IDisposable
   {
      
      public static var propsDO:Object = {
         "x":true,
         "y":true,
         "rotation":true,
         "scaleX":true,
         "scaleY":true,
         "alpha":true
      };
      
      protected static var ticker:Shape = new Shape();
      
      protected static var workingMatrix:Matrix = new Matrix();
      
      protected static var firstTween:Tween;
      
      protected static var lastTime:uint = getTimer();
      
      protected static var degToRad:Number = 1 / 180 * Math.PI;
      
      protected static var isTickListening:Boolean = false;
       
      
      public var target:Object;
      
      public var duration:Number;
      
      public var ease:Function;
      
      public var easeParam:Object;
      
      public var onComplete:Function;
      
      public var onChange:Function;
      
      public var data:Object;
      
      public var nextTween:Tween;
      
      public var deltaScale:Number = 1;
      
      private var _disposed:Boolean = false;
      
      public var frameBased:Boolean = false;
      
      public var delay:Number = 0;
      
      public var loop:Boolean = false;
      
      public var fastTransform:Boolean = true;
      
      protected var invalid:Boolean;
      
      protected var next:Tween;
      
      protected var prev:Tween;
      
      protected var _position:Number = 0;
      
      protected var _paused:Boolean = true;
      
      protected var startMatrix:Matrix;
      
      protected var deltaMatrix:Matrix;
      
      protected var transform:Transform;
      
      protected var targetDO:DisplayObject;
      
      protected var firstProp:Prop;
      
      protected var props:Object;
      
      public function Tween(param1:Number, param2:Object = null, param3:Object = null, param4:Object = null)
      {
         super();
         this.duration = param1;
         this.target = param2;
         if(param2 is DisplayObject)
         {
            this.targetDO = DisplayObject(param2);
            this.transform = this.targetDO.transform;
         }
         this.props = param3;
         if(param4)
         {
            this.quickSet(param4);
         }
         if(param4 == null || param4.paused == null)
         {
            this.paused = false;
         }
      }
      
      public static function removeAllTweens() : void
      {
         firstTween = null;
      }
      
      protected static function removeTween(param1:Tween) : void
      {
         if(param1.prev)
         {
            param1.prev.next = param1.next;
         }
         if(param1.next)
         {
            param1.next.prev = param1.prev;
         }
         if(param1 == firstTween)
         {
            firstTween = param1.next;
         }
         if(!firstTween && isTickListening)
         {
            ticker.removeEventListener(Event.ENTER_FRAME,Tween.tick);
            isTickListening = false;
         }
         param1.prev = param1.next = null;
      }
      
      protected static function tick(param1:Event) : void
      {
         var _loc5_:Tween = null;
         var _loc2_:Number = getTimer();
         var _loc3_:Number = _loc2_ - lastTime;
         lastTime = _loc2_;
         var _loc4_:Tween = firstTween;
         while(_loc4_)
         {
            _loc5_ = _loc4_.next;
            _loc4_.updatePosition(!!_loc4_.frameBased ? Number(1) : Number(_loc3_));
            _loc4_ = _loc5_;
         }
      }
      
      public function dispose() : void
      {
         var _loc1_:* = null;
         this._disposed = true;
         this.paused = true;
         this.target = null;
         this.ease = null;
         for(_loc1_ in this.easeParam)
         {
            delete this.easeParam[_loc1_];
         }
         this.easeParam = null;
         for(_loc1_ in this.data)
         {
            delete this.data[_loc1_];
         }
         this.data = null;
         this.onComplete = null;
         this.onChange = null;
         this.nextTween = null;
         this.next = null;
         this.prev = null;
         this.startMatrix = null;
         this.deltaMatrix = null;
         this.transform = null;
         this.targetDO = null;
         if(this.firstProp)
         {
            this.firstProp.next = null;
            this.firstProp.prev = null;
            this.firstProp = null;
         }
         this.props = null;
      }
      
      public function reset() : void
      {
         this._position = 0;
      }
      
      public function quickSet(param1:Object) : void
      {
         var _loc2_:* = null;
         for(_loc2_ in param1)
         {
            this[_loc2_] = param1[_loc2_];
         }
      }
      
      public function get position() : Number
      {
         return this._position - this.delay;
      }
      
      public function set position(param1:Number) : void
      {
         this.updatePosition(param1 + this.delay - this._position);
      }
      
      public function get paused() : Boolean
      {
         return this._paused;
      }
      
      public function set paused(param1:Boolean) : void
      {
         if(param1 == this._paused)
         {
            return;
         }
         this._paused = param1;
         if(param1)
         {
            removeTween(this);
         }
         else
         {
            if(firstTween)
            {
               firstTween.prev = this;
               this.next = firstTween;
            }
            firstTween = this;
            if(!isTickListening)
            {
               ticker.addEventListener(Event.ENTER_FRAME,Tween.tick,false,0,true);
               lastTime = getTimer();
               isTickListening = true;
            }
            if(this._position >= this.delay + this.duration)
            {
               this._position = 0;
            }
         }
      }
      
      protected function constructProp(param1:String) : Prop
      {
         var _loc2_:Prop = new Prop();
         _loc2_.name = param1;
         _loc2_.prev = null;
         if(this.firstProp)
         {
            this.firstProp.prev = _loc2_;
         }
         _loc2_.next = this.firstProp;
         return this.firstProp = _loc2_;
      }
      
      protected function init() : void
      {
         var _loc2_:* = null;
         var _loc3_:Prop = null;
         var _loc1_:Boolean = false;
         for(_loc2_ in this.props)
         {
            if(this.fastTransform && this.transform && propsDO[_loc2_])
            {
               _loc1_ = true;
            }
            else
            {
               _loc3_ = this.constructProp(_loc2_);
               _loc3_.delta = this.props[_loc2_] - (_loc3_.start = this.target[_loc2_]);
            }
         }
         if(_loc1_)
         {
            this.startMatrix = new Matrix(this.targetDO.scaleX,this.targetDO.rotation * degToRad,this.targetDO.alpha,this.targetDO.scaleY,this.targetDO.x,this.targetDO.y);
            if(isNaN(this.startMatrix.a) || Infinity == this.startMatrix.a)
            {
               this.startMatrix.a = 1;
            }
            if(isNaN(this.startMatrix.b) || Infinity == this.startMatrix.b)
            {
               this.startMatrix.b = 0;
            }
            if(isNaN(this.startMatrix.c) || Infinity == this.startMatrix.c)
            {
               this.startMatrix.c = 0;
            }
            if(isNaN(this.startMatrix.d) || Infinity == this.startMatrix.d)
            {
               this.startMatrix.d = 1;
            }
            if(isNaN(this.startMatrix.tx) || Infinity == this.startMatrix.tx)
            {
               this.startMatrix.tx = 0;
            }
            if(isNaN(this.startMatrix.ty) || Infinity == this.startMatrix.ty)
            {
               this.startMatrix.ty = 0;
            }
            this.deltaMatrix = new Matrix(!!isNaN(this.props.scaleX) ? Number(0) : Number(this.props.scaleX - this.startMatrix.a),!!isNaN(this.props.rotation) ? Number(0) : Number((this.props.rotation - this.targetDO.rotation) * degToRad),!!isNaN(this.props.alpha) ? Number(0) : Number(this.props.alpha - this.startMatrix.c),!!isNaN(this.props.scaleY) ? Number(0) : Number(this.props.scaleY - this.startMatrix.d),!!isNaN(this.props.x) ? Number(0) : Number(this.props.x - this.startMatrix.tx),!!isNaN(this.props.y) ? Number(0) : Number(this.props.y - this.startMatrix.ty));
         }
         this.props = null;
      }
      
      protected function updatePosition(param1:Number) : void
      {
         var _loc5_:Number = NaN;
         var _loc6_:Number = NaN;
         var _loc7_:Number = NaN;
         if(this.target == null)
         {
            this.paused = true;
            return;
         }
         this._position += param1 * this.deltaScale;
         if(this._position <= this.delay)
         {
            return;
         }
         if(this.props)
         {
            this.init();
         }
         var _loc2_:Number = (this._position - this.delay) / this.duration;
         var _loc3_:Boolean = _loc2_ >= 1;
         if(_loc3_)
         {
            _loc2_ = 1;
            this._position = this.duration + this.delay;
         }
         if(this.ease != null)
         {
            _loc2_ = this.easeParam == null ? Number(this.ease(_loc2_,0,1,1)) : Number(this.ease(_loc2_,0,1,1,this.easeParam));
         }
         if(this.startMatrix)
         {
            _loc5_ = this.startMatrix.b + this.deltaMatrix.b * _loc2_;
            if(_loc5_)
            {
               _loc6_ = Math.cos(_loc5_);
               _loc7_ = Math.sin(_loc5_);
            }
            else
            {
               _loc6_ = 1;
               _loc7_ = 0;
            }
            workingMatrix.a = _loc6_ * this.startMatrix.a + this.deltaMatrix.a * _loc2_;
            workingMatrix.b = _loc7_;
            workingMatrix.c = -_loc7_;
            workingMatrix.d = _loc6_ * this.startMatrix.d + this.deltaMatrix.d * _loc2_;
            workingMatrix.tx = this.startMatrix.tx + this.deltaMatrix.tx * _loc2_;
            workingMatrix.ty = this.startMatrix.ty + this.deltaMatrix.ty * _loc2_;
            this.transform.matrix = workingMatrix;
            if(this.deltaMatrix.c)
            {
               this.targetDO.alpha = this.startMatrix.c + this.deltaMatrix.c * _loc2_;
            }
         }
         var _loc4_:Prop = this.firstProp;
         while(_loc4_)
         {
            this.target[_loc4_.name] = _loc4_.start + _loc4_.delta * _loc2_;
            _loc4_ = _loc4_.next;
         }
         if(this.onChange != null)
         {
            this.onChange(this);
         }
         if(_loc3_)
         {
            if(this.loop)
            {
               this.reset();
            }
            else
            {
               this.paused = true;
            }
            if(this.nextTween)
            {
               this.nextTween.paused = false;
            }
            if(this.onComplete != null)
            {
               this.onComplete(this);
            }
         }
      }
      
      public function isDisposed() : Boolean
      {
         return this._disposed;
      }
   }
}

final class Prop
{
    
   
   public var next:Prop;
   
   public var prev:Prop;
   
   public var name:String;
   
   public var start:Number;
   
   public var delta:Number;
   
   function Prop()
   {
      super();
   }
}
