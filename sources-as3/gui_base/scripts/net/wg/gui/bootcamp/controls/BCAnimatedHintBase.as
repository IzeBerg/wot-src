package net.wg.gui.bootcamp.controls
{
   import flash.display.MovieClip;
   import flash.events.Event;
   import net.wg.gui.bootcamp.containers.TipHintAnimation;
   
   public class BCAnimatedHintBase extends BCHighlightRendererBase
   {
      
      private static const APPEAR:String = "appear";
       
      
      public var animationMC:TipHintAnimation;
      
      public function BCAnimatedHintBase()
      {
         super();
         this.animationMC.addFrameScript(this.animationMC.totalFrames - 1,this.onAnimationComplete);
      }
      
      public function setLabel(param1:String) : void
      {
         this.animationMC.setLabel(param1);
      }
      
      public function playAnimation() : void
      {
         var _loc3_:MovieClip = null;
         this.animationMC.gotoAndPlay(APPEAR);
         var _loc1_:int = this.animationMC.numChildren;
         var _loc2_:int = 0;
         while(_loc2_ < _loc1_)
         {
            _loc3_ = this.animationMC.getChildAt(_loc2_) as MovieClip;
            if(_loc3_ && _loc3_.totalFrames > 1)
            {
               _loc3_.gotoAndPlay(APPEAR);
            }
            _loc2_++;
         }
      }
      
      override public function setProperties(param1:Number, param2:Number, param3:Boolean) : void
      {
      }
      
      override protected function onDispose() : void
      {
         this.animationMC.addFrameScript(this.animationMC.totalFrames - 1,null);
         this.animationMC.stop();
         this.animationMC.dispose();
         this.animationMC = null;
         super.onDispose();
      }
      
      private function onAnimationComplete() : void
      {
         this.animationMC.addFrameScript(this.animationMC.totalFrames - 1,null);
         this.animationMC.stop();
         dispatchEvent(new Event(Event.COMPLETE));
      }
   }
}
