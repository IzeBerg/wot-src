package net.wg.gui.battle.halloween.minimap
{
   import flash.events.Event;
   import net.wg.data.constants.InvalidationType;
   import net.wg.gui.battle.views.minimap.components.entries.personal.ViewPointMinimapEntry;
   
   public class HWViewPointMinimapEntry extends ViewPointMinimapEntry
   {
      
      private static const INVALID_BUFF_STATE:int = InvalidationType.SYSTEM_FLAGS_BORDER << 2;
       
      
      public var buffBG:HWBuffCircle = null;
      
      private var _showBuff:Boolean = false;
      
      public function HWViewPointMinimapEntry()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         removeEventListener(Event.ENTER_FRAME,this.onEnterFrameHandler);
         this.buffBG.stop();
         this.buffBG.dispose();
         this.buffBG = null;
         super.onDispose();
      }
      
      public function setBuff(param1:Boolean) : void
      {
         if(this._showBuff != param1)
         {
            this._showBuff = param1;
            invalidate(INVALID_BUFF_STATE);
         }
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(INVALID_BUFF_STATE))
         {
            this.buffBG.visible = this._showBuff;
            if(this._showBuff)
            {
               addEventListener(Event.ENTER_FRAME,this.onEnterFrameHandler);
               this.buffBG.gotoAndPlay(1);
            }
            else
            {
               removeEventListener(Event.ENTER_FRAME,this.onEnterFrameHandler);
               this.buffBG.stop();
            }
         }
      }
      
      private function onEnterFrameHandler(param1:Event) : void
      {
         this.buffBG.rotation = -rotation;
      }
   }
}
