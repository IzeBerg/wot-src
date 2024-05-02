package net.wg.gui.lobby.rankedBattles19.view.stats
{
   import net.wg.infrastructure.base.UIComponentEx;
   import scaleform.clik.constants.InvalidationType;
   
   public class StatsBlock extends UIComponentEx
   {
      
      private static const STATE_BIG:String = "state_big";
      
      private static const STATE_SMALL:String = "state_small";
       
      
      private var _state:String = "state_big";
      
      public function StatsBlock()
      {
         super();
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(InvalidationType.STATE))
         {
            if(this._state == STATE_SMALL)
            {
               this.minimizeElements();
            }
            else
            {
               this.maximizeElements();
            }
         }
      }
      
      public final function maximize() : void
      {
         if(this._state != STATE_BIG)
         {
            this._state = STATE_BIG;
            invalidateState();
         }
      }
      
      public final function minimize() : void
      {
         if(this._state != STATE_SMALL)
         {
            this._state = STATE_SMALL;
            invalidateState();
         }
      }
      
      protected function minimizeElements() : void
      {
      }
      
      protected function maximizeElements() : void
      {
      }
   }
}
