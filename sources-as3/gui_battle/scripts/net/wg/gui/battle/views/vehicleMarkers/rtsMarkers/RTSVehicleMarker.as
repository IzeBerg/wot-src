package net.wg.gui.battle.views.vehicleMarkers.rtsMarkers
{
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import net.wg.gui.battle.commander.views.common.HoverIcon;
   import net.wg.gui.battle.views.vehicleMarkers.VMAtlasItemName;
   import net.wg.gui.battle.views.vehicleMarkers.VehicleMarker;
   import net.wg.gui.battle.views.vehicleMarkers.VehicleMarkersConstants;
   import net.wg.gui.battle.views.vehicleMarkers.events.RTSMarkerEvent;
   
   public class RTSVehicleMarker extends VehicleMarker implements IRTSSelectableMarker
   {
      
      protected static const VM_HOVER_POSTFIX:String = "_hover";
      
      protected static const VM_SELECTED_POSTFIX:String = "_selected";
      
      protected static const HOVER_BRACKETS_RANGE:Object = {
         "lightTank":22,
         "mediumTank":22,
         "heavyTank":26,
         "SPG":22,
         "AT-SPG":22
      };
       
      
      public var hitMC:MovieClip = null;
      
      public var hover:HoverIcon = null;
      
      public var vehicleConditionMarkerUI:MovieClip = null;
      
      protected var _vehicleID:Number = 0;
      
      protected var _focused:Boolean = false;
      
      protected var _selected:Boolean = false;
      
      protected var _isBot:Boolean = false;
      
      public function RTSVehicleMarker()
      {
         super();
         _vmManager.addVehicleMarker(this);
         this.hover.visible = false;
      }
      
      override public function setVehicleInfo(param1:String, param2:String, param3:String, param4:int, param5:String, param6:String, param7:String, param8:String, param9:int, param10:String, param11:Boolean, param12:int, param13:String) : void
      {
         super.setVehicleInfo(param1,param2,param3,param4,param5,param6,param7,param8,param9,param10,param11,param12,param13);
         this.hover.type = entityType == VehicleMarkersConstants.ENTITY_TYPE_ALLY ? HoverIcon.BRACKETS_OUT : HoverIcon.BRACKETS_IN;
         this.hover.range = HOVER_BRACKETS_RANGE[param1];
      }
      
      private function onMouseOutHandler(param1:MouseEvent) : void
      {
         dispatchEvent(new RTSMarkerEvent(RTSMarkerEvent.MARKER_MOUSE_OUT,this.vehicleID));
      }
      
      private function onMouseOverHandler(param1:MouseEvent) : void
      {
         dispatchEvent(new RTSMarkerEvent(RTSMarkerEvent.MARKER_MOUSE_OVER,this.vehicleID));
      }
      
      override protected function onDispose() : void
      {
         this.hitMC.removeEventListener(MouseEvent.MOUSE_OVER,this.onMouseOverHandler);
         this.hitMC.removeEventListener(MouseEvent.MOUSE_OUT,this.onMouseOutHandler);
         this.hitMC = null;
         this.hover.dispose();
         this.hover = null;
         this.vehicleConditionMarkerUI = null;
         super.onDispose();
      }
      
      override protected function getIsPartVisible(param1:String) : Boolean
      {
         var _loc2_:Boolean = super.getIsPartVisible(param1);
         if(param1 == P_NAME_LBL && this._isBot)
         {
            _loc2_ = false;
         }
         return _loc2_;
      }
      
      override protected function makeColorSchemeName() : void
      {
         var _loc1_:String = "";
         if(!_vehicleDestroyed)
         {
            if(this._selected)
            {
               _loc1_ = VM_SELECTED_POSTFIX;
            }
            else if(this._focused)
            {
               _loc1_ = VM_HOVER_POSTFIX;
            }
         }
         _markerSchemeName = (!!_vehicleDestroyed ? VM_DEAD_PREFIX : VM_PREFIX) + entityName + _loc1_;
         _stunSchemeName = VM_STUN_PREFIX + entityName + VM_STUN_POSTFIX;
      }
      
      override protected function setMarkerState(param1:String) : void
      {
         var _loc2_:Boolean = false;
         super.setMarkerState(param1);
         _loc2_ = !_vehicleDestroyed;
         this.hover.isAlive = _loc2_;
         this.removeEventListener(MouseEvent.ROLL_OVER,this.onMouseOverHandler);
         this.removeEventListener(MouseEvent.ROLL_OUT,this.onMouseOutHandler);
         mouseChildren = false;
         if(_loc2_)
         {
            hitArea = this.hitMC;
            mouseEnabled = true;
            this.addEventListener(MouseEvent.ROLL_OVER,this.onMouseOverHandler);
            this.addEventListener(MouseEvent.ROLL_OUT,this.onMouseOutHandler);
         }
         else
         {
            hitArea = null;
            mouseEnabled = false;
         }
      }
      
      override protected function setVehicleType() : void
      {
         var _loc1_:String = null;
         if(isObserver)
         {
            marker.vehicleTypeIcon.transform.colorTransform = _vmManager.getTransform(_markerSchemeName);
         }
         if(_vehicleDestroyedAlready)
         {
            return;
         }
         if(_model.speaking && !_vehicleDestroyed)
         {
            _loc1_ = "commander_" + VMAtlasItemName.SPEAKING_ICON;
         }
         else
         {
            _loc1_ = VMAtlasItemName.getVehicleTypeIconName(_model.entityName,_model.vClass,_model.hunt);
            _loc1_ = "commander_" + _loc1_;
            if(_vehicleDestroyed)
            {
               _loc1_ += "_dead";
            }
         }
         _vmManager.drawWithCenterAlign(_loc1_,marker.vehicleTypeIcon.graphics,true,false,0,V_TYPE_ICON_Y);
         this.hover.attach(marker);
      }
      
      override protected function layoutParts(param1:Vector.<Boolean>) : void
      {
         super.layoutParts(param1);
         this.hover.attach(marker);
      }
      
      public function updateFocusedSelected(param1:Boolean, param2:Boolean) : void
      {
         if(this._focused != param1 || this._selected != param2)
         {
            this._focused = this.hover.hovered = param1;
            this._selected = this.hover.selected = param2;
            this.makeColorSchemeName();
         }
      }
      
      public function updateRTSInfo(param1:Number, param2:Boolean) : void
      {
         this._vehicleID = param1;
         this._isBot = param2;
      }
      
      public function get vehicleID() : Number
      {
         return this._vehicleID;
      }
   }
}
