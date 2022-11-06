package net.wg.gui.lobby.settings.components
{
   import flash.events.Event;
   import net.wg.infrastructure.base.UIComponentEx;
   
   public class SoundVoiceWaves extends UIComponentEx
   {
       
      
      private var _step:Number = 0;
      
      private var _finishFrame:uint;
      
      public function SoundVoiceWaves()
      {
         super();
      }
      
      public function speak(param1:Boolean) : void
      {
         if(param1)
         {
            this._step = 1;
            this._finishFrame = this.totalFrames;
         }
         else
         {
            this._step = -1;
            this._finishFrame = 1;
         }
         if(hasEventListener(Event.ENTER_FRAME))
         {
            this.removeEventListener(Event.ENTER_FRAME,this.onEnterFrameHandler);
         }
         this.addEventListener(Event.ENTER_FRAME,this.onEnterFrameHandler);
      }
      
      private function onEnterFrameHandler(param1:Event) : void
      {
         this.gotoAndStop(this.currentFrame + this._step);
         if(this.currentFrame == this._finishFrame)
         {
            this.removeEventListener(Event.ENTER_FRAME,this.onEnterFrameHandler);
         }
      }
   }
}
