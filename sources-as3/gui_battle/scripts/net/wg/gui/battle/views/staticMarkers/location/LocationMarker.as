package net.wg.gui.battle.views.staticMarkers.location
{
   import flash.display.MovieClip;
   import net.wg.gui.battle.components.BattleUIComponent;
   import net.wg.gui.battle.views.actionMarkers.ActionMarkerStates;
   import net.wg.gui.battle.views.vehicleMarkers.VehicleMarkersManager;
   import net.wg.gui.battle.views.vehicleMarkers.events.VehicleMarkersManagerEvent;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class LocationMarker extends BattleUIComponent implements IDisposable
   {
       
      
      public var marker:LocationActionMarker = null;
      
      public var greenPoint:MovieClip = null;
      
      private var _firstActiveState:Boolean = true;
      
      private var _isStickyAndOutOfScreen:Boolean = false;
      
      private var _lastActiveState:int = -1;
      
      private var _vmManager:VehicleMarkersManager = null;
      
      private var _wasReplied:Boolean = false;
      
      private var _alwaysShowCreatorName:Boolean = false;
      
      public function LocationMarker()
      {
         super();
         this._vmManager = VehicleMarkersManager.getInstance();
         this._vmManager.addEventListener(VehicleMarkersManagerEvent.SHOW_EX_INFO,this.onShowExInfoHandler);
      }
      
      override protected function onDispose() : void
      {
         this._vmManager.removeEventListener(VehicleMarkersManagerEvent.SHOW_EX_INFO,this.onShowExInfoHandler);
         this._vmManager = null;
         this.marker.highlightAnimation.stop();
         this.marker.highlightAnimation = null;
         this.marker.hoverShadow = null;
         this.marker.dispose();
         this.marker = null;
         this.greenPoint = null;
         super.onDispose();
      }
      
      public function activateHover(param1:Boolean) : void
      {
         this.marker.hoverShadow.visible = param1;
         this.marker.setCreatorNameVisible(this._alwaysShowCreatorName);
      }
      
      public function alwaysShowCreatorName(param1:Boolean) : void
      {
         this.marker.setCreatorNameVisible(param1);
         this._alwaysShowCreatorName = param1;
         this.marker.setTextLabelEnabled(!param1);
      }
      
      public function setActiveState(param1:int) : void
      {
         if(!this._wasReplied)
         {
            this._wasReplied = param1 == ActionMarkerStates.REPLIED_ME || param1 == ActionMarkerStates.REPLIED_ALLY;
         }
         this.marker.highlightAnimation.visible = !this._wasReplied;
         if(this._firstActiveState)
         {
            this.marker.highlightAnimation.play();
            this._firstActiveState = false;
         }
         if(this._isStickyAndOutOfScreen)
         {
            this.marker.setActiveState(ActionMarkerStates.STATE_INT_TO_STRING_STICKY_OUT[param1]);
         }
         else
         {
            this.marker.setActiveState(ActionMarkerStates.STATE_INT_TO_STRING[param1]);
         }
         this._lastActiveState = param1;
         this.onShowExInfoHandler(null);
      }
      
      public function setCreator(param1:String) : void
      {
         this.marker.setCreatorNameText(param1);
      }
      
      public function setIsStickyAndOutOfScreen(param1:Boolean) : void
      {
         this._isStickyAndOutOfScreen = param1;
         this.setActiveState(this._lastActiveState);
         this.marker.locationLineElement.visible = !param1;
         this.greenPoint.visible = !param1;
      }
      
      public function setMarkerReplied(param1:Boolean) : void
      {
         this.marker.setMarkerReplied(param1);
      }
      
      public function setReplyCount(param1:int) : void
      {
         this.marker.setReplyCount(param1);
      }
      
      public function triggerClickAnimation() : void
      {
         this.marker.triggerClickAnimation();
      }
      
      private function onShowExInfoHandler(param1:VehicleMarkersManagerEvent) : void
      {
         var _loc2_:Boolean = this._vmManager.showExInfo && this._lastActiveState == ActionMarkerStates.PING_CREATE_STATE;
         this.marker.setCreatorNameVisible(this._alwaysShowCreatorName || _loc2_);
      }
   }
}
