package net.wg.gui.components.common.lobbyVehicleMarkers
{
   import flash.display.MovieClip;
   import flash.text.TextField;
   import net.wg.infrastructure.base.UIComponentEx;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.core.UIComponent;
   
   public class PlatoonMarker extends UIComponentEx
   {
       
      
      public var vehicleTypeMarker:MovieClip;
      
      public var playerNameField:TextField;
      
      private var _model:PlatoonMarkerVO = null;
      
      private var _markerHash:Object = null;
      
      public function PlatoonMarker()
      {
         super();
      }
      
      override protected function initialize() : void
      {
         this._markerHash = UIComponent.generateLabelHash(this.vehicleTypeMarker);
         super.initialize();
      }
      
      override protected function onDispose() : void
      {
         this.vehicleTypeMarker = null;
         this.playerNameField = null;
         this._model = null;
         App.utils.data.cleanupDynamicObject(this._markerHash);
         this._markerHash = null;
         super.onDispose();
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(this._model != null && isInvalid(InvalidationType.DATA))
         {
            this.playerNameField.text = this._model.pName;
            App.utils.commons.updateTextFieldSize(this.playerNameField);
            this.playerNameField.x = -this.playerNameField.width >> 1;
            if(this._markerHash[this._model.vClass])
            {
               this.vehicleTypeMarker.gotoAndStop(this._model.vClass);
            }
         }
      }
      
      public function setVehicleInfo(param1:String, param2:String) : void
      {
         this._model = new PlatoonMarkerVO();
         this._model.vClass = param1;
         this._model.pName = param2;
         invalidateData();
      }
   }
}
