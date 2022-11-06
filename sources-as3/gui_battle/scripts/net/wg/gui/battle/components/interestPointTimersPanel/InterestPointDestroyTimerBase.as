package net.wg.gui.battle.components.interestPointTimersPanel
{
   import net.wg.data.constants.InvalidationType;
   import net.wg.gui.battle.views.destroyTimers.DestroyTimer;
   
   public class InterestPointDestroyTimerBase extends DestroyTimer
   {
      
      private static const ICON_SPR_POSITION_VALIDATE:int = InvalidationType.SYSTEM_FLAGS_BORDER << 2;
       
      
      private var _iconSprOriginY:int = 0;
      
      public function InterestPointDestroyTimerBase()
      {
         super();
         this._iconSprOriginY = graphicsSpr.iconSpr.y;
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(ICON_SPR_POSITION_VALIDATE))
         {
            graphicsSpr.iconSpr.y = this._iconSprOriginY;
         }
      }
   }
}
