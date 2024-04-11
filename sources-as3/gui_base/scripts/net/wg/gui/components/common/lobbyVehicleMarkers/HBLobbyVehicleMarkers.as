package net.wg.gui.components.common.lobbyVehicleMarkers
{
   import flash.display.MovieClip;
   import flash.text.TextField;
   import net.wg.data.constants.Values;
   import net.wg.infrastructure.base.UIComponentEx;
   import net.wg.infrastructure.interfaces.IUserProps;
   import net.wg.utils.ICommons;
   import org.idmedia.as3commons.util.StringUtils;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.core.UIComponent;
   
   public class HBLobbyVehicleMarkers extends UIComponentEx
   {
       
      
      public var playerNameField:TextField = null;
      
      public var vehicleTypeMarker:MovieClip = null;
      
      public var vehicleNameField:TextField = null;
      
      private var _commons:ICommons;
      
      private var _model:HBLobbyVehicleMarkersVO = null;
      
      private var _markerHash:Object = null;
      
      private var _id:int = -1;
      
      public function HBLobbyVehicleMarkers()
      {
         this._commons = App.utils.commons;
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
         this.playerNameField = null;
         this._model = null;
         this._commons = null;
         App.utils.data.cleanupDynamicObject(this._markerHash);
         this._markerHash = null;
         super.onDispose();
      }
      
      override protected function draw() : void
      {
         var _loc1_:IUserProps = null;
         super.draw();
         if(this._model != null && isInvalid(InvalidationType.DATA))
         {
            this.vehicleNameField.text = this._model.vName;
            this._commons.updateTextFieldSize(this.vehicleNameField);
            this.vehicleNameField.x = -this.vehicleNameField.width >> 1;
            _loc1_ = this._commons.getUserProps(this._model.pName,this._model.pClan,Values.EMPTY_STR,0,null,Values.EMPTY_STR);
            this._commons.formatPlayerName(this.playerNameField,_loc1_,false,false,Values.THREE_DOTS);
            this.playerNameField.x = -this.playerNameField.width >> 1;
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
      
      public function setVehicleInfo(param1:String, param2:String, param3:String, param4:String) : void
      {
         this._model = new HBLobbyVehicleMarkersVO();
         this._model.vClass = param1;
         this._model.vName = param2;
         this._model.pName = param3;
         this._model.pClan = param4;
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
