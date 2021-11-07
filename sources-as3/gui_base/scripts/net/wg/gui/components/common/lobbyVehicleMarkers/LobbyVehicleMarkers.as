package net.wg.gui.components.common.lobbyVehicleMarkers
{
   import flash.display.MovieClip;
   import flash.text.TextField;
   import net.wg.infrastructure.base.UIComponentEx;
   import org.idmedia.as3commons.util.StringUtils;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.core.UIComponent;
   
   public class LobbyVehicleMarkers extends UIComponentEx
   {
       
      
      public var vehicleTypeMarker:MovieClip;
      
      public var vehicleNameField:TextField;
      
      private var _model:LobbyVehicleMarkersVO = null;
      
      private var _markerHash:Object = null;
      
      private var _id:int = -1;
      
      public function LobbyVehicleMarkers()
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
         this.vehicleNameField = null;
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
            this.vehicleNameField.text = this._model.vName;
            App.utils.commons.updateTextFieldSize(this.vehicleNameField);
            this.vehicleNameField.x = -this.vehicleNameField.width >> 1;
            if(StringUtils.isNotEmpty(this._model.vClass) && this._markerHash[this._model.vClass])
            {
               this.vehicleTypeMarker.visible = true;
               this.vehicleTypeMarker.gotoAndStop(this._model.vClass);
            }
            else
            {
               this.vehicleTypeMarker.visible = false;
            }
         }
      }
      
      public function setVehicleInfo(param1:String, param2:String) : void
      {
         this._model = new LobbyVehicleMarkersVO();
         this._model.vClass = param1;
         this._model.vName = param2;
         invalidateData();
      }
      
      public function set id(param1:int) : void
      {
         this._id = param1;
      }
      
      public function get id() : int
      {
         return this._id;
      }
   }
}
