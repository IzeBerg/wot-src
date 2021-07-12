package net.wg.gui.lobby.lobbyVehicleMarkerView
{
   import flash.display.DisplayObject;
   import flash.utils.Dictionary;
   import net.wg.data.constants.Linkages;
   import net.wg.gui.components.common.lobbyVehicleMarkers.LobbyVehicleMarkers;
   import net.wg.gui.components.common.lobbyVehicleMarkers.PlatoonMarker;
   import net.wg.infrastructure.base.meta.ILobbyVehicleMarkerViewMeta;
   import net.wg.infrastructure.base.meta.impl.LobbyVehicleMarkerViewMeta;
   
   public class LobbyVehicleMarkerView extends LobbyVehicleMarkerViewMeta implements ILobbyVehicleMarkerViewMeta
   {
       
      
      private var _markers:Dictionary;
      
      public function LobbyVehicleMarkerView()
      {
         this._markers = new Dictionary();
         super();
      }
      
      override protected function onDispose() : void
      {
         App.utils.data.cleanupDynamicObject(this._markers);
         this._markers = null;
         super.onDispose();
      }
      
      override protected function allowHandleInput() : Boolean
      {
         return false;
      }
      
      public function as_createMarker(param1:int, param2:String, param3:String) : DisplayObject
      {
         var _loc4_:LobbyVehicleMarkers = App.instance.utils.classFactory.getComponent(Linkages.LOBBY_VEH_MARKER,LobbyVehicleMarkers);
         _loc4_.setVehicleInfo(param2,param3);
         addChild(_loc4_);
         this._markers[param1] = _loc4_;
         return _loc4_;
      }
      
      public function as_createPlatoonMarker(param1:int, param2:String, param3:String) : DisplayObject
      {
         var _loc4_:PlatoonMarker = App.instance.utils.classFactory.getComponent(Linkages.PLATOON_VEH_MARKER,PlatoonMarker);
         _loc4_.setVehicleInfo(param2,param3);
         addChild(_loc4_);
         this._markers[param1] = _loc4_;
         return _loc4_;
      }
      
      public function as_removeMarker(param1:int) : void
      {
         this.removeMarker(param1);
      }
      
      public function removeMarker(param1:int) : void
      {
         if(this._markers[param1])
         {
            removeChild(this._markers[param1]);
            this._markers[param1].dispose();
            this._markers[param1] = null;
         }
      }
   }
}
