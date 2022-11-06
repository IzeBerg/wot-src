package net.wg.gui.battle.tutorial.views.tutorial.utils.tween
{
   import flash.display.DisplayObject;
   import net.wg.gui.battle.components.interfaces.ICoolDownCompleteHandler;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class TutorialTweener implements IDisposable
   {
      
      private static var _flowFactory:TweenFlowFactory;
      
      private static var ANIMATE_STEP_TIME:Number = 20;
      
      private static const EASE_FUNCTION:String = "ease";
       
      
      private var _totalTicks:int;
      
      private var _currentTick:int;
      
      private var _id:int = 0;
      
      private var _context:DisplayObject;
      
      private var _coolDownHandler:ICoolDownCompleteHandler;
      
      private var _tweenHandler:ITutorialTweenerHandler;
      
      private var _params:Vector.<TweenParams>;
      
      private var _tweenFlow:Vector.<Number>;
      
      private var _fixedStep:Number;
      
      private var _isExternalLinkToInstance:Boolean = true;
      
      private var _disposed:Boolean = false;
      
      public function TutorialTweener(param1:Boolean)
      {
         super();
         _flowFactory = TweenFlowFactory.getInstance();
         this._params = new Vector.<TweenParams>();
         this._isExternalLinkToInstance = param1;
      }
      
      public static function get tweener() : TutorialTweener
      {
         return new TutorialTweener(false);
      }
      
      public static function clearCache() : void
      {
         if(_flowFactory)
         {
            _flowFactory.dispose();
            _flowFactory = null;
         }
      }
      
      public function tween(param1:DisplayObject, param2:Number, param3:Object, param4:ITutorialTweenerHandler, param5:int = 0) : void
      {
         var _loc6_:* = null;
         var _loc7_:Function = null;
         this._currentTick = 0;
         this._params.splice(0,this._params.length);
         this._context = param1;
         this._tweenHandler = param4;
         this._totalTicks = param2 / ANIMATE_STEP_TIME + 1;
         this._id = param5;
         for(_loc6_ in param3)
         {
            if(_loc6_ == EASE_FUNCTION)
            {
               _loc7_ = param3[_loc6_] as Function;
               if(_loc7_ != null)
               {
                  this._tweenFlow = _flowFactory.getFlow(_loc7_,this._totalTicks);
               }
            }
            else if(!isNaN(param3[_loc6_]) && _loc6_ in param1)
            {
               this._params.push(new TweenParams(_loc6_,param1[_loc6_],param3[_loc6_]));
            }
         }
         this._fixedStep = Boolean(this._tweenFlow) ? Number(0) : Number(1 / this._totalTicks);
         App.utils.scheduler.cancelTask(this.run);
         this.start();
      }
      
      public function start() : void
      {
         App.utils.scheduler.scheduleRepeatableTask(this.run,ANIMATE_STEP_TIME,this._totalTicks);
      }
      
      private function run() : void
      {
         var _loc1_:TweenParams = null;
         ++this._currentTick;
         if(this._currentTick == this._totalTicks)
         {
            for each(_loc1_ in this._params)
            {
               this._context[_loc1_.name] = _loc1_.endValue;
            }
            this._tweenHandler.onTweenComplete(this._id);
            if(!this._isExternalLinkToInstance)
            {
               this.dispose();
            }
         }
         else
         {
            this.changePosition(this._currentTick);
         }
      }
      
      private function changePosition(param1:int) : void
      {
         var _loc2_:TweenParams = null;
         var _loc3_:Number = NaN;
         for each(_loc2_ in this._params)
         {
            _loc3_ = Boolean(this._fixedStep) ? Number(this._fixedStep * param1) : Number(this._tweenFlow[param1 - 1]);
            this._context[_loc2_.name] = _loc2_.startValue + _loc2_.distance * _loc3_;
         }
      }
      
      public final function dispose() : void
      {
         this._disposed = true;
         this._params.length = 0;
         if(this._tweenFlow)
         {
            this._tweenFlow.length = 0;
         }
         App.utils.scheduler.cancelTask(this.run);
         this._context = null;
         this._coolDownHandler = null;
         this._tweenHandler = null;
         this._params = null;
         this._tweenFlow = null;
      }
      
      public function isDisposed() : Boolean
      {
         return this._disposed;
      }
   }
}

class TweenParams
{
    
   
   private var _name:String;
   
   private var _startValue:Number;
   
   private var _endValue:Number;
   
   private var _distance:Number;
   
   function TweenParams(param1:String, param2:Number, param3:Number)
   {
      super();
      this._name = param1;
      this._startValue = param2;
      this._endValue = param3;
      this._distance = param3 - this._startValue;
   }
   
   public function get name() : String
   {
      return this._name;
   }
   
   public function get startValue() : Number
   {
      return this._startValue;
   }
   
   public function get endValue() : Number
   {
      return this._endValue;
   }
   
   public function get distance() : Number
   {
      return this._distance;
   }
}
