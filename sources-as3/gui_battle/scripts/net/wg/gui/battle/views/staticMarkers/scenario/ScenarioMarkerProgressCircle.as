package net.wg.gui.battle.views.staticMarkers.scenario
{
   import flash.display.MovieClip;
   import net.wg.data.constants.InvalidationType;
   import net.wg.gui.battle.components.BaseProgressCircle;
   import net.wg.gui.battle.views.vehicleMarkers.IMarkerManagerHandler;
   import net.wg.gui.battle.views.vehicleMarkers.VMAtlasItemName;
   import net.wg.gui.battle.views.vehicleMarkers.VehicleMarkersManager;
   import net.wg.gui.battle.views.vehicleMarkers.events.VehicleMarkersManagerEvent;
   
   public class ScenarioMarkerProgressCircle extends BaseProgressCircle implements IMarkerManagerHandler
   {
      
      private static const PRECISION:Number = 0.005;
      
      private static const INV_FRAME:uint = InvalidationType.SYSTEM_FLAGS_BORDER << 1;
      
      private static const EMPTY_LAST_FRAME:int = 181;
      
      private static const NORMAL_STATE:String = "normal";
       
      
      public var icon:MovieClip = null;
      
      public var highlight:MovieClip = null;
      
      private var _progress:Number = 0;
      
      private var _vmManager:VehicleMarkersManager = null;
      
      private var _isManagerReady:Boolean = false;
      
      public function ScenarioMarkerProgressCircle()
      {
         super();
      }
      
      override public function updateProgress(param1:Number) : void
      {
         if(Math.abs(this._progress - param1) >= PRECISION)
         {
            this._progress = param1;
            currentProgressFrame = this._progress * SEMI_LAST_FRAME >> 0;
            invalidate(INV_FRAME);
         }
      }
      
      override protected function initialize() : void
      {
         this._vmManager = VehicleMarkersManager.getInstance();
         this._vmManager.addEventListener(VehicleMarkersManagerEvent.UPDATE_COLORS,this.onUpdateColorsHandler);
         this.updateColorBlind();
         this._isManagerReady = this._vmManager.isAtlasInited;
         if(this._isManagerReady)
         {
            this.drawIconType();
            this.drawBackIcon();
         }
         else
         {
            this._vmManager.addReadyHandler(this);
         }
         currentProgressFrame = EMPTY_LAST_FRAME;
         invalidate(INV_FRAME);
         super.initialize();
      }
      
      override protected function draw() : void
      {
         var _loc1_:String = null;
         super.draw();
         if(isInvalid(InvalidationType.STATE))
         {
            _loc1_ = !!colorblindMode ? COLORBLIND_STATE : NORMAL_STATE;
            if(state != _loc1_)
            {
               state = _loc1_;
            }
            invalidate(INV_FRAME);
         }
         if(isInvalid(INV_FRAME))
         {
            if(currentFrameLabel != state)
            {
               gotoAndStop(state);
            }
            if(progressCircle.currentFrame != curFrame)
            {
               progressCircle.gotoAndStop(curFrame);
            }
         }
      }
      
      override protected function onDispose() : void
      {
         this._vmManager.removeEventListener(VehicleMarkersManagerEvent.UPDATE_COLORS,this.onUpdateColorsHandler);
         this._vmManager = null;
         this.icon = null;
         this.highlight = null;
         super.onDispose();
      }
      
      public function managerReadyHandler() : void
      {
         this._isManagerReady = true;
         this.drawIconType();
         this.drawBackIcon();
      }
      
      private function setColorBlindMode(param1:Boolean) : void
      {
         if(colorblindMode != param1)
         {
            colorblindMode = param1;
            invalidateState();
         }
      }
      
      private function updateColorBlind() : void
      {
         this.setColorBlindMode(this._vmManager.isColorBlind);
      }
      
      private function drawIconType() : void
      {
         if(this._isManagerReady)
         {
            this._vmManager.drawWithCenterAlign(VMAtlasItemName.SCENARIO_MARKER_ICON,this.icon.graphics,true,true);
         }
      }
      
      private function drawBackIcon() : void
      {
         if(this._isManagerReady)
         {
            this._vmManager.drawWithCenterAlign(VMAtlasItemName.POI_MARKER_BACK_ICON,this.highlight.graphics,true,true);
         }
      }
      
      private function onUpdateColorsHandler(param1:VehicleMarkersManagerEvent) : void
      {
         this.updateColorBlind();
      }
   }
}
