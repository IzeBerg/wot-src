package net.wg.gui.battle.views.vehicleMarkers
{
   public interface IVehicleMarkerInvokable
   {
       
      
      function hideArtyMarker() : void;
      
      function hideStatusMarker(param1:int, param2:int, param3:Boolean = false, param4:Boolean = false) : void;
      
      function hideSeparateMarker(param1:int, param2:Boolean = false) : void;
      
      function setEntityName(param1:String) : void;
      
      function setHealth(param1:int) : void;
      
      function setSpeaking(param1:Boolean) : void;
      
      function setStatusTimerSnapshot(param1:int) : void;
      
      function setVehicleInfo(param1:String, param2:String, param3:String, param4:int, param5:String, param6:String, param7:String, param8:String, param9:int, param10:String, param11:Boolean, param12:int, param13:String, param14:String = "", param15:int = 0) : void;
      
      function showActionMarker(param1:String) : void;
      
      function showExInfo() : void;
      
      function showStatusMarker(param1:int, param2:int, param3:Boolean, param4:Number, param5:int, param6:int, param7:Boolean = true, param8:Boolean = true) : void;
      
      function showSeparateMarker(param1:int, param2:Boolean, param3:Number, param4:Boolean = true, param5:Boolean = true) : void;
      
      function update() : void;
      
      function updateHealth(param1:int, param2:int, param3:String) : void;
      
      function updateState(param1:String, param2:Boolean, param3:String = "", param4:String = "") : void;
      
      function updateStatusEffectTimer(param1:int, param2:Number, param3:Boolean = false) : void;
      
      function updateTimer(param1:String) : void;
   }
}
