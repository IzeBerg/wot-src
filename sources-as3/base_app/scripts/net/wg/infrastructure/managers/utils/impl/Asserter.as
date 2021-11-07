package net.wg.infrastructure.managers.utils.impl
{
   import flash.display.FrameLabel;
   import flash.display.MovieClip;
   import net.wg.infrastructure.exceptions.AssertionException;
   import net.wg.utils.IAssertable;
   import scaleform.gfx.Extensions;
   
   public final class Asserter implements IAssertable
   {
       
      
      private var assertProcessing:Function = null;
      
      private var _errorLoggingEnabled:Boolean = true;
      
      public function Asserter()
      {
         super();
         this.assertProcessing = this.startingAssertProcessing;
      }
      
      public final function assert(param1:Boolean, param2:String, param3:Class = null) : void
      {
         this.assertProcessing(param1,param2,param3);
      }
      
      public final function assertNotNull(param1:Object, param2:String, param3:Class = null) : void
      {
         this.assert(param1 != null,param2);
      }
      
      public final function assertNull(param1:Object, param2:String, param3:Class = null) : void
      {
         this.assert(param1 == null,param2);
      }
      
      public function assertFrameExists(param1:String, param2:MovieClip, param3:Class = null) : void
      {
         var _loc7_:FrameLabel = null;
         var _loc8_:int = 0;
         this.assertNotNull(param2,"Target MovieClip instance is null");
         var _loc4_:Array = param2.currentLabels;
         var _loc5_:Vector.<String> = new Vector.<String>(0);
         var _loc6_:int = _loc4_.length;
         _loc8_ = 0;
         while(_loc8_ < _loc6_)
         {
            _loc7_ = _loc4_[_loc8_];
            _loc5_.push(_loc7_.name);
            _loc8_++;
         }
         this.assert(_loc5_.indexOf(param1) > -1,"Unknown frame \"" + param1 + "\" in " + param2.name,param3);
      }
      
      public final function enableErrorLogging(param1:Boolean) : void
      {
         this._errorLoggingEnabled = param1;
      }
      
      private function throwException(param1:String, param2:Class = null) : void
      {
         var _loc3_:Error = null;
         if(param2 == null)
         {
            _loc3_ = new AssertionException(param1);
         }
         else
         {
            _loc3_ = new param2() as Error;
            this.assertNotNull(_loc3_,"ex argument must be Error object class");
         }
         _loc3_.message = param1;
         if(!Extensions.isGFxPlayer && Extensions.isScaleform && this._errorLoggingEnabled)
         {
            DebugUtils.LOG_ERROR(param1);
            DebugUtils.LOG_ERROR(_loc3_.getStackTrace());
         }
         throw _loc3_;
      }
      
      private function startingAssertProcessing(param1:Boolean, param2:String, param3:Class) : void
      {
         var _loc4_:Function = Object(App.globalVarsMgr).isDevelopment;
         if(_loc4_ != null)
         {
            if(_loc4_())
            {
               this.assertProcessing = this.debugAssertProcessing;
            }
            else
            {
               this.assertProcessing = this.releaseAssertProcessing;
            }
            this.assertProcessing(param1,param2,param3);
         }
         else if(!param1)
         {
            this.throwException(param2,param3);
         }
      }
      
      private function debugAssertProcessing(param1:Boolean, param2:String, param3:Class) : void
      {
         if(!param1)
         {
            this.throwException(param2,param3);
         }
      }
      
      private function releaseAssertProcessing(param1:Boolean, param2:String, param3:Class) : void
      {
         if(!param1 && !Extensions.isGFxPlayer && Extensions.isScaleform && this._errorLoggingEnabled)
         {
            DebugUtils.LOG_ERROR(param2);
         }
      }
   }
}
