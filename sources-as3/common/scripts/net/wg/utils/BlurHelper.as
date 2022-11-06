package net.wg.utils
{
   import flash.display.DisplayObject;
   import flash.filters.BitmapFilter;
   import flash.filters.BlurFilter;
   import net.wg.data.constants.Errors;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class BlurHelper implements IDisposable
   {
      
      public static const DEFAULT_BLUR_XY:int = 20;
      
      public static const DEFAULT_ANIM_STEP_TIME:int = 20;
      
      public static const DEFAULT_ANIM_REPEAT_COUNT:int = 10;
       
      
      private var _blurAnimValue:Number = 0;
      
      private var _blurXY:int = 20;
      
      private var _animStepTime:int = 20;
      
      private var _animRepeatCount:int = 10;
      
      private var _blurStep:Number = 0;
      
      private var _scheduler:IScheduler;
      
      private var _quality:int = 2;
      
      private var _inProgress:Boolean = false;
      
      private var _blurFilter:BlurFilter;
      
      public function BlurHelper(param1:int = 10, param2:int = 20, param3:int = 20, param4:int = 2)
      {
         this._scheduler = App.utils.scheduler;
         super();
         this._blurXY = param2;
         this._animStepTime = param3;
         this._animRepeatCount = param1;
         this._quality = param4;
         this._blurStep = this._blurXY / this._animRepeatCount;
         this._blurFilter = new BlurFilter(param2,param2,param4);
      }
      
      public function blurElements(param1:Vector.<DisplayObject>, param2:Boolean = true) : void
      {
         var _loc3_:DisplayObject = null;
         if(!param2)
         {
            for each(_loc3_ in param1)
            {
               App.utils.commons.setBlur(_loc3_,this._blurXY,this._blurXY,this._quality);
            }
         }
         else if(param1 && param1.length > 0)
         {
            if(this._inProgress)
            {
               this.cancelScheduled();
            }
            this.runRepeatableTask(0,param1,this.animateBlur);
         }
         else
         {
            DebugUtils.LOG_WARNING("elements" + Errors.CANT_EMPTY);
         }
      }
      
      public function cancelScheduled() : void
      {
         this._scheduler.cancelTask(this.animateBlur);
         this._scheduler.cancelTask(this.animateUnblur);
         this._inProgress = false;
      }
      
      public function dispose() : void
      {
         this.cancelScheduled();
         this._blurFilter = null;
         this._scheduler = null;
      }
      
      public function isDisposed() : Boolean
      {
         return false;
      }
      
      public function unblurElements(param1:Vector.<DisplayObject>, param2:Boolean = true) : void
      {
         var _loc3_:DisplayObject = null;
         if(!param2)
         {
            for each(_loc3_ in param1)
            {
               _loc3_.filters = [];
            }
         }
         else if(param1 && param1.length > 0)
         {
            if(this._inProgress)
            {
               this.cancelScheduled();
            }
            this.runRepeatableTask(this._blurXY,param1,this.animateUnblur);
         }
         else
         {
            DebugUtils.LOG_WARNING("elements" + Errors.CANT_EMPTY);
         }
      }
      
      private function runRepeatableTask(param1:int, param2:Vector.<DisplayObject>, param3:Function) : void
      {
         this._blurAnimValue = param1;
         this._scheduler.scheduleRepeatableTask(param3,this._animStepTime,this._animRepeatCount,param2);
         this._inProgress = true;
      }
      
      private function animateBlur(param1:Vector.<DisplayObject>) : void
      {
         var _loc2_:int = 0;
         var _loc3_:BlurFilter = null;
         var _loc4_:DisplayObject = null;
         var _loc5_:BitmapFilter = null;
         this._blurAnimValue += this._blurStep;
         this._blurFilter.quality = this._quality;
         for each(_loc4_ in param1)
         {
            _loc2_ = this._blurAnimValue;
            if(_loc4_.filters)
            {
               for each(_loc5_ in _loc4_.filters)
               {
                  _loc3_ = _loc5_ as BlurFilter;
                  if(_loc3_)
                  {
                     _loc2_ = Math.max(_loc3_.blurX,this._blurAnimValue);
                     break;
                  }
               }
            }
            this._blurFilter.blurX = _loc2_;
            this._blurFilter.blurY = _loc2_;
            _loc4_.filters = [this._blurFilter];
         }
      }
      
      private function animateUnblur(param1:Vector.<DisplayObject>) : void
      {
         var _loc2_:DisplayObject = null;
         this._blurAnimValue -= this._blurStep;
         this._blurFilter.blurX = this._blurAnimValue;
         this._blurFilter.blurY = this._blurAnimValue;
         this._blurFilter.quality = this._quality;
         for each(_loc2_ in param1)
         {
            _loc2_.filters = [this._blurFilter];
         }
      }
   }
}
