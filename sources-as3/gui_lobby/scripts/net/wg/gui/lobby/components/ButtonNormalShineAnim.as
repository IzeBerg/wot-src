package net.wg.gui.lobby.components
{
   import flash.display.FrameLabel;
   import flash.display.MovieClip;
   import net.wg.gui.lobby.components.events.ShineEvent;
   import net.wg.gui.utils.FrameHelper;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   import net.wg.utils.IScheduler;
   
   public class ButtonNormalShineAnim extends MovieClip implements IDisposable
   {
      
      private static const SHINE_FRAME:String = "shine";
      
      private static const SHINE_FRAME_FINISHED:String = "shineFinished";
      
      public static const SHINE_LINKAGE:String = "ButtonNormalShineAnimUI";
      
      public static const LOOP_DELAY:int = 3000;
       
      
      private var _frameHelper:FrameHelper = null;
      
      private var _repeat:Boolean = false;
      
      private var _scheduler:IScheduler;
      
      private var _disposed:Boolean = false;
      
      public function ButtonNormalShineAnim()
      {
         this._scheduler = App.utils.scheduler;
         super();
         this._frameHelper = new FrameHelper(this);
         var _loc1_:Array = currentLabels;
         var _loc2_:int = _loc1_.length;
         var _loc3_:FrameLabel = null;
         var _loc4_:uint = 0;
         while(_loc4_ < _loc2_)
         {
            _loc3_ = _loc1_[_loc4_];
            if(_loc3_.name == SHINE_FRAME_FINISHED)
            {
               this._frameHelper.addScriptToFrame(_loc3_.frame,this.onAnimFinished);
            }
            _loc4_++;
         }
         mouseEnabled = false;
         mouseChildren = false;
      }
      
      public final function dispose() : void
      {
         stop();
         this.stopRepeat();
         this._repeat = false;
         this._frameHelper.dispose();
         this._frameHelper = null;
         this._disposed = true;
      }
      
      public function isDisposed() : Boolean
      {
         return this._disposed;
      }
      
      public function shine(param1:Boolean, param2:int) : void
      {
         this.stopRepeat();
         this._repeat = param1;
         if(param2 > 0)
         {
            this._scheduler.scheduleTask(this.doShine,param2);
         }
         else
         {
            this.doShine();
         }
      }
      
      private function stopRepeat() : void
      {
         this._scheduler.cancelTask(this.doShine);
      }
      
      private function onAnimFinished() : void
      {
         stop();
         if(this._repeat)
         {
            dispatchEvent(new ShineEvent(ShineEvent.ON_ANIM_LOOP_FINISHED));
            this._scheduler.scheduleTask(this.doShine,LOOP_DELAY);
         }
         else
         {
            dispatchEvent(new ShineEvent(ShineEvent.ON_ANIM_COMPLETED));
         }
      }
      
      private function doShine() : void
      {
         this.gotoAndPlay(SHINE_FRAME);
      }
   }
}
