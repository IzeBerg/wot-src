package net.wg.gui.battle.views.destroyTimers.components.notifiers
{
   import net.wg.utils.IDateTime;
   
   public class NormalTimerNotifier extends TimerNotifier
   {
       
      
      private var _dateTime:IDateTime;
      
      private var _prevSeconds:int = -1;
      
      public function NormalTimerNotifier()
      {
         this._dateTime = App.utils.dateTime;
         super();
      }
      
      override public function setData(param1:int, param2:int) : void
      {
         super.setData(param1,param2);
         var _loc3_:int = Math.ceil(param1 / 1000);
         if(this._prevSeconds != _loc3_)
         {
            this._prevSeconds = _loc3_;
            drawTime(this._dateTime.formatSecondsToString(_loc3_));
         }
      }
      
      override protected function onDispose() : void
      {
         this._dateTime = null;
         super.onDispose();
      }
   }
}
