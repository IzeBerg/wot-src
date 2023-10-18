package net.wg.gui.battle.views.staticMarkers.interestPoint
{
   import flash.display.MovieClip;
   import flash.text.TextField;
   import net.wg.data.constants.InvalidationType;
   import net.wg.data.constants.Time;
   import net.wg.data.constants.Values;
   import net.wg.data.constants.generated.POI_CONSTS;
   import net.wg.gui.battle.components.poi.components.PoiWithProgressStateCircle;
   import net.wg.gui.battle.views.vehicleMarkers.IMarkerManagerHandler;
   import net.wg.gui.battle.views.vehicleMarkers.VMAtlasItemName;
   import net.wg.gui.battle.views.vehicleMarkers.VehicleMarkersManager;
   import net.wg.gui.battle.views.vehicleMarkers.events.VehicleMarkersManagerEvent;
   import org.idmedia.as3commons.util.StringUtils;
   import scaleform.gfx.TextFieldEx;
   
   public class MarkerPoiProgressCircle extends PoiWithProgressStateCircle implements IMarkerManagerHandler
   {
      
      private static const INV_TIMER:uint = InvalidationType.SYSTEM_FLAGS_BORDER << 2;
      
      private static const ZERO_STR:String = "0";
      
      private static const COLON_STR:String = ":";
       
      
      public var smallIcon:MovieClip = null;
      
      public var label:TextField = null;
      
      private var _vmManager:VehicleMarkersManager = null;
      
      private var _isManagerReady:Boolean = false;
      
      private var _durationSeconds:int;
      
      public function MarkerPoiProgressCircle()
      {
         super();
         this.label.visible = false;
         TextFieldEx.setNoTranslate(this.label,true);
      }
      
      override public function setStatusID(param1:int) : void
      {
         super.setStatusID(param1);
         invalidate(INV_TIMER);
      }
      
      override public function updateProgress(param1:Number) : void
      {
         if(statusID == POI_CONSTS.POI_STATUS_ACTIVE)
         {
            return;
         }
         super.updateProgress(param1);
      }
      
      override protected function afterProgressUpdate() : void
      {
         super.afterProgressUpdate();
         invalidate(INV_TIMER);
      }
      
      override protected function initialize() : void
      {
         this._vmManager = VehicleMarkersManager.getInstance();
         this._vmManager.addEventListener(VehicleMarkersManagerEvent.UPDATE_COLORS,this.onUpdateColorsHandler);
         this._isManagerReady = this._vmManager.isAtlasInited;
         if(!this._isManagerReady)
         {
            this._vmManager.addReadyHandler(this);
         }
         else
         {
            this.updateColorBlind();
         }
         super.initialize();
      }
      
      override protected function onDispose() : void
      {
         this._vmManager.removeEventListener(VehicleMarkersManagerEvent.UPDATE_COLORS,this.onUpdateColorsHandler);
         this._vmManager = null;
         this.label = null;
         this.smallIcon = null;
         super.onDispose();
      }
      
      override protected function drawIconType() : void
      {
         var _loc1_:String = null;
         super.drawIconType();
         if(this._isManagerReady)
         {
            _loc1_ = VMAtlasItemName.getPOIMarkerIconByType(iconType);
            this._vmManager.drawWithCenterAlign(_loc1_,icon.graphics,true,true);
            _loc1_ = VMAtlasItemName.getPOIMarkerIconByType(iconType,true);
            this._vmManager.drawWithCenterAlign(_loc1_,this.smallIcon.graphics,true,true);
            this.updateIconsVisibility();
         }
      }
      
      override protected function draw() : void
      {
         var _loc1_:Boolean = false;
         var _loc2_:String = null;
         super.draw();
         if(isInvalid(INV_TIMER))
         {
            _loc1_ = false;
            if(statusID == POI_CONSTS.POI_STATUS_COOLDOWN)
            {
               _loc2_ = this.getTimeoutStr();
               _loc1_ = !StringUtils.isEmpty(_loc2_);
               if(_loc1_)
               {
                  this.label.text = _loc2_;
               }
            }
            this.label.visible = _loc1_;
         }
      }
      
      override protected function drawBackIcon() : void
      {
         super.drawBackIcon();
         if(this._isManagerReady)
         {
            this._vmManager.drawWithCenterAlign(VMAtlasItemName.POI_MARKER_BACK_ICON,highlight.graphics,true,true);
         }
      }
      
      override protected function updateColorBlind() : void
      {
         setColorBlindMode(this._vmManager.isColorBlind);
      }
      
      override protected function applyStateAndProgress() : void
      {
         super.applyStateAndProgress();
         this.updateIconsVisibility();
      }
      
      public function managerReadyHandler() : void
      {
         this._isManagerReady = true;
         this.updateColorBlind();
         this.drawBackIcon();
         this.drawIconType();
      }
      
      public function setDuration(param1:int) : void
      {
         if(this._durationSeconds != param1)
         {
            this._durationSeconds = param1;
            invalidate(INV_TIMER);
         }
      }
      
      private function updateIconsVisibility() : void
      {
         var _loc1_:Boolean = statusID == POI_CONSTS.POI_STATUS_COOLDOWN;
         this.smallIcon.visible = _loc1_;
         icon.visible = !_loc1_;
         highlight.visible = !_loc1_;
      }
      
      private function getTimeoutStr() : String
      {
         var _loc1_:int = progress * this._durationSeconds;
         var _loc2_:int = this._durationSeconds - _loc1_;
         if(_loc2_ <= 0)
         {
            return Values.EMPTY_STR;
         }
         var _loc3_:int = Math.floor(_loc2_ / Time.SECONDS_IN_MINUTE);
         _loc2_ = Math.floor(_loc2_ % Time.SECONDS_IN_MINUTE);
         return (_loc3_ < 10 ? ZERO_STR + _loc3_ : _loc3_) + COLON_STR + (_loc2_ < 10 ? ZERO_STR + _loc2_ : _loc2_);
      }
      
      private function onUpdateColorsHandler(param1:VehicleMarkersManagerEvent) : void
      {
         this.updateColorBlind();
      }
   }
}
