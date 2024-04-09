package net.wg.gui.battle.pveBase.views.secondaryObjectives.components
{
   import flash.display.MovieClip;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class PveIconContainer extends MovieClip implements IDisposable
   {
      
      private static const ICON_WITHOUT_TIMER_LABEL:String = "iconWithoutTimer";
      
      private static const ICON_WITH_TIMER_LABEL:String = "iconWithTimer";
       
      
      public var iconWithoutTimer:PveIconBlock = null;
      
      public var iconWithTimer:PveIconBlock = null;
      
      private var _isTimerEnable:Boolean = false;
      
      private var _disposed:Boolean = false;
      
      public function PveIconContainer()
      {
         super();
      }
      
      public function setType(param1:String, param2:Boolean) : void
      {
         if(param2)
         {
            gotoAndStop(ICON_WITH_TIMER_LABEL);
            this.iconWithTimer.setIcon(param1);
         }
         else
         {
            gotoAndStop(ICON_WITHOUT_TIMER_LABEL);
            this.iconWithoutTimer.setIcon(param1);
         }
         this._isTimerEnable = param2;
      }
      
      public function setDone(param1:Boolean) : void
      {
         if(this._isTimerEnable)
         {
            this.iconWithTimer.setDone(param1);
         }
         else
         {
            this.iconWithoutTimer.setDone(param1);
         }
      }
      
      public function updateTime(param1:String, param2:Boolean) : void
      {
         if(this._isTimerEnable)
         {
            this.iconWithTimer.setTimer(param1,param2);
         }
      }
      
      public final function dispose() : void
      {
         this._disposed = true;
         if(this.iconWithoutTimer)
         {
            this.iconWithoutTimer.dispose();
            this.iconWithoutTimer = null;
         }
         if(this.iconWithTimer)
         {
            this.iconWithTimer.dispose();
            this.iconWithTimer = null;
         }
      }
      
      public function isDisposed() : Boolean
      {
         return this._disposed;
      }
   }
}
