package net.wg.white_tiger.gui.battle.views.vehicleMarkers.statusMarkers
{
   import flash.display.Sprite;
   import net.wg.gui.battle.views.vehicleMarkers.statusMarkers.VehicleAnimatedStatusBaseMarker;
   import net.wg.white_tiger.gui.battle.views.shared.TimerAnimHelper;
   import net.wg.white_tiger.gui.battle.views.shared.interfaces.ITimerAnimation;
   
   public class VehicleBombMarker extends VehicleAnimatedStatusBaseMarker implements ITimerAnimation
   {
      
      private static const DEFAULT_PLAYBACK_SPEED:Number = 1;
      
      private static const PROGRESS_BAR_COLOR:uint = 9753343;
      
      private static const PROGRESS_BAR_WIDTH:uint = 62;
      
      private static const PROGRESS_BAR_HEIGHT:uint = 3;
       
      
      public var progressBar:Sprite = null;
      
      private var _animHelper:TimerAnimHelper = null;
      
      private var _timeTotal:Number = 0;
      
      public function VehicleBombMarker()
      {
         super();
         this._animHelper = new TimerAnimHelper(this);
      }
      
      override public function hideEffectTimer(param1:Boolean = false) : void
      {
         visible = false;
      }
      
      override public function isVisible() : Boolean
      {
         return this.visible;
      }
      
      override public function resetMarkerStates() : void
      {
         this._animHelper.setTime(0,this._timeTotal,DEFAULT_PLAYBACK_SPEED);
         visible = false;
      }
      
      override public function setVisibility(param1:Boolean) : void
      {
         this.visible = param1;
      }
      
      override public function setupFrameEvents() : void
      {
      }
      
      override public function updateEffectTimer(param1:Number, param2:Boolean, param3:Boolean = false) : void
      {
         if(param3)
         {
            this._timeTotal = param1;
         }
         this._animHelper.setTime(param1,this._timeTotal,DEFAULT_PLAYBACK_SPEED);
         visible = param2;
      }
      
      override protected function onDispose() : void
      {
         this._animHelper.dispose();
         this._animHelper = null;
         this.progressBar = null;
      }
      
      public function updateProgress(param1:Number, param2:int) : void
      {
         this.progressBar.graphics.clear();
         if(param1 > 0)
         {
            this.progressBar.graphics.beginFill(PROGRESS_BAR_COLOR);
            this.progressBar.graphics.drawRect(0,0,PROGRESS_BAR_WIDTH * param1,PROGRESS_BAR_HEIGHT);
            this.progressBar.graphics.endFill();
         }
         else
         {
            visible = false;
         }
      }
   }
}
