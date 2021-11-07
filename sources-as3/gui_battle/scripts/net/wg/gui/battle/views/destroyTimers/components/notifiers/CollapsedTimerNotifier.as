package net.wg.gui.battle.views.destroyTimers.components.notifiers
{
   public class CollapsedTimerNotifier extends TimerNotifier
   {
       
      
      private var _prevDeciseconds:int = -1;
      
      public function CollapsedTimerNotifier()
      {
         super();
      }
      
      override public function setData(param1:int, param2:int) : void
      {
         super.setData(param1,param2);
         var _loc3_:int = param1 / 100;
         if(this._prevDeciseconds != _loc3_)
         {
            this._prevDeciseconds = _loc3_;
            drawTime(Number(_loc3_ / 10).toFixed(1));
         }
      }
   }
}
