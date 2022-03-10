package net.wg.data.vo
{
   import flash.display.DisplayObject;
   import flash.events.EventDispatcher;
   import net.wg.data.constants.Errors;
   import net.wg.infrastructure.interfaces.ITweenHandler;
   import net.wg.infrastructure.interfaces.ITweenPropertiesVO;
   import net.wg.utils.IAssertable;
   
   public class TweenPropertiesVO extends EventDispatcher implements ITweenPropertiesVO
   {
      
      private static const POSITION:String = "position";
      
      private static const DURATION:String = "duration";
      
      private static const GLOBAL_DELAY:String = "globalDelay";
      
      private static const LOCAL_DELAY:String = "localDelay";
      
      private static const TARGET:String = "target";
      
      private static const ACTION_AFTER_REMOVE_FROM_STAGE:String = "actionAfterRemoveFromStage";
      
      private static const LOOP:String = "loop";
      
      private static const PAUSED:String = "paused";
      
      private static const HANDLER:String = "handler";
      
      private static const X:String = "x";
      
      private static const Y:String = "y";
      
      private static const SCALE_X:String = "scaleX";
      
      private static const SCALE_Y:String = "scaleY";
      
      private static const ROTATION:String = "rotation";
      
      private static const ALPHA:String = "alpha";
       
      
      public var x:Number = NaN;
      
      public var y:Number = NaN;
      
      public var scaleX:Number = NaN;
      
      public var scaleY:Number = NaN;
      
      public var alpha:Number = NaN;
      
      public var rotation:Number = NaN;
      
      private var _duration:int = 0;
      
      private var _globalDelay:int = 0;
      
      private var _localDelay:int = 0;
      
      private var _position:int = 0;
      
      private var _target:DisplayObject = null;
      
      private var _actionAfterRemoveFromStage:String = "notToProcess";
      
      private var _loop:Boolean = false;
      
      private var _paused:Boolean = true;
      
      private var _handler:ITweenHandler = null;
      
      private var _idx:int = -1;
      
      private var localDelayIsSet:Boolean = false;
      
      private var _disposed:Boolean = false;
      
      public function TweenPropertiesVO(param1:Object)
      {
         super();
         var _loc2_:IAssertable = App.utils.asserter;
         _loc2_.assertNotNull(param1,"Hash" + Errors.CANT_NULL);
         this.fromHash(param1);
      }
      
      public function fromHash(param1:Object) : void
      {
         if(POSITION in param1)
         {
            this.setPosition(param1[POSITION]);
         }
         if(DURATION in param1)
         {
            this.setDuration(param1[DURATION]);
         }
         if(GLOBAL_DELAY in param1)
         {
            this.setGlobalDelay(param1[GLOBAL_DELAY]);
         }
         if(LOCAL_DELAY in param1)
         {
            this.setLocalDelay(param1[LOCAL_DELAY]);
         }
         if(TARGET in param1)
         {
            this.setTarget(param1[TARGET]);
         }
         if(ACTION_AFTER_REMOVE_FROM_STAGE in param1)
         {
            this.setActionAfterRemoveFromStage(param1[ACTION_AFTER_REMOVE_FROM_STAGE]);
         }
         if(LOOP in param1)
         {
            this.setLoop(param1[LOOP]);
         }
         if(PAUSED in param1)
         {
            this.setPaused(param1[PAUSED]);
         }
         if(HANDLER in param1)
         {
            this.setHandler(param1[HANDLER]);
         }
         if(X in param1)
         {
            this.setX(param1[X]);
         }
         if(Y in param1)
         {
            this.setY(param1[Y]);
         }
         if(SCALE_X in param1)
         {
            this.setScaleX(param1[SCALE_X]);
         }
         if(SCALE_Y in param1)
         {
            this.setScaleY(param1[SCALE_Y]);
         }
         if(ROTATION in param1)
         {
            this.setRotation(param1[ROTATION]);
         }
         if(ALPHA in param1)
         {
            this.setAlpha(param1[ALPHA]);
         }
      }
      
      public function getPosition() : int
      {
         return this._position;
      }
      
      public function setPosition(param1:int) : void
      {
         this._position = param1;
      }
      
      public function getDuration() : int
      {
         return this._duration;
      }
      
      public function setDuration(param1:int) : void
      {
         var _loc2_:IAssertable = App.utils.asserter;
         _loc2_.assert(param1 > 0,"Duration in Tween will be more than 0.");
         this._duration = param1;
      }
      
      public function getGlobalDelay() : int
      {
         return this._globalDelay;
      }
      
      public function setGlobalDelay(param1:int) : void
      {
         if(!this.localDelayIsSet)
         {
            this.setLocalDelay(param1);
         }
         this._globalDelay = param1;
      }
      
      public function getLocalDelay() : int
      {
         return this._localDelay;
      }
      
      public function setLocalDelay(param1:int) : void
      {
         this.localDelayIsSet = true;
         this._localDelay = param1;
      }
      
      public function getTarget() : DisplayObject
      {
         return this._target;
      }
      
      public function setTarget(param1:DisplayObject) : void
      {
         App.utils.asserter.assertNotNull(param1,"target " + Errors.CANT_NULL);
         this._target = param1;
      }
      
      public function getActionAfterRemoveFromStage() : String
      {
         return this._actionAfterRemoveFromStage;
      }
      
      public function setActionAfterRemoveFromStage(param1:String) : void
      {
         this._actionAfterRemoveFromStage = param1;
      }
      
      public function getLoop() : Boolean
      {
         return this._loop;
      }
      
      public function setLoop(param1:Boolean) : void
      {
         this._loop = param1;
      }
      
      public function getPaused() : Boolean
      {
         return this._paused;
      }
      
      public function setPaused(param1:Boolean) : void
      {
         this._paused = param1;
      }
      
      public function getHandler() : ITweenHandler
      {
         return this._handler;
      }
      
      public function setHandler(param1:ITweenHandler) : void
      {
         this._handler = param1;
      }
      
      public function getX() : Number
      {
         return this.x;
      }
      
      public function setX(param1:Number) : void
      {
         this.x = param1;
      }
      
      public function getY() : Number
      {
         return this.y;
      }
      
      public function setY(param1:Number) : void
      {
         this.y = param1;
      }
      
      public function getScaleX() : Number
      {
         return this.scaleX;
      }
      
      public function setScaleX(param1:Number) : void
      {
         this.scaleX = param1;
      }
      
      public function getScaleY() : Number
      {
         return this.scaleY;
      }
      
      public function setScaleY(param1:Number) : void
      {
         this.scaleY = param1;
      }
      
      public function getAlpha() : Number
      {
         return this.alpha;
      }
      
      public function setAlpha(param1:Number) : void
      {
         this.alpha = param1 * 100;
      }
      
      public function getRotation() : Number
      {
         return this.rotation;
      }
      
      public function setRotation(param1:Number) : void
      {
         this.rotation = param1 * Math.PI / 180;
      }
      
      public function dispose() : void
      {
         this._disposed = true;
         this._target = null;
      }
      
      public function setTweenIdx(param1:int) : void
      {
         this._idx = param1;
      }
      
      public function getTweenIdx() : int
      {
         return this._idx;
      }
      
      public function isDisposed() : Boolean
      {
         return this._disposed;
      }
   }
}
