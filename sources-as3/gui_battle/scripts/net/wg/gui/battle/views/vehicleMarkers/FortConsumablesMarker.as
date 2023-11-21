package net.wg.gui.battle.views.vehicleMarkers
{
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.filters.DropShadowFilter;
   import flash.text.TextField;
   import flash.utils.getDefinitionByName;
   import net.wg.data.constants.Errors;
   import net.wg.data.constants.generated.BATTLE_MARKERS_CONSTS;
   import net.wg.gui.battle.components.BattleUIComponent;
   import net.wg.gui.battle.views.vehicleMarkers.events.VehicleMarkersManagerEvent;
   import org.idmedia.as3commons.util.StringUtils;
   import scaleform.gfx.TextFieldEx;
   
   public class FortConsumablesMarker extends BattleUIComponent
   {
      
      private static const MARKER_X:int = -52;
      
      private static const MARKER_Y:int = -58;
      
      private static const GREEN_DROPSHADOW_FILTERS:Array = [new DropShadowFilter(0,45,1536315,1,4,4,3.7)];
      
      private static const YELLOW_DROPSHADOW_FILTERS:Array = [new DropShadowFilter(0,45,13328640,1,4,4,3.7)];
      
      private static const RED_DROPSHADOW_FILTERS:Array = [new DropShadowFilter(0,45,8992034,1,4,4,3.7)];
      
      private static const PURPLE_DROPSHADOW_FILTERS:Array = [new DropShadowFilter(0,45,4730494,1,4,4,3.7)];
      
      private static const ARTILLERY_FORT_ENEMY:String = "artillery_fort_enemy";
      
      private static const ARTILLERY_FORT_ENEMY_COLOR_BLIND:String = "artillery_fort_enemy_color_blind";
       
      
      public var marker:MovieClip = null;
      
      public var bgShadow:MovieClip = null;
      
      public var timerTF:TextField = null;
      
      public var defaultTF:TextField = null;
      
      private var _timer:String = "";
      
      private var _markerBitmap:Bitmap = null;
      
      private var _vmManager:VehicleMarkersManager = null;
      
      private var _markerType:String = "";
      
      private var _markerColor:String = "";
      
      public function FortConsumablesMarker()
      {
         super();
         TextFieldEx.setNoTranslate(this.timerTF,true);
         TextFieldEx.setNoTranslate(this.defaultTF,true);
         this._vmManager = VehicleMarkersManager.getInstance();
         this._vmManager.addEventListener(VehicleMarkersManagerEvent.UPDATE_COLORS,this.onUpdateColorsHandler);
      }
      
      private function getFilters() : Array
      {
         if(this._markerColor == BATTLE_MARKERS_CONSTS.COLOR_GREEN)
         {
            return GREEN_DROPSHADOW_FILTERS;
         }
         if(this._markerColor == BATTLE_MARKERS_CONSTS.COLOR_RED)
         {
            if(this._vmManager.isColorBlind)
            {
               return PURPLE_DROPSHADOW_FILTERS;
            }
            return RED_DROPSHADOW_FILTERS;
         }
         return YELLOW_DROPSHADOW_FILTERS;
      }
      
      private function getMarkerClassName() : String
      {
         if(this._vmManager.isColorBlind && this._markerType == ARTILLERY_FORT_ENEMY)
         {
            return ARTILLERY_FORT_ENEMY_COLOR_BLIND;
         }
         return this._markerType;
      }
      
      override protected function onDispose() : void
      {
         this._vmManager.removeEventListener(VehicleMarkersManagerEvent.UPDATE_COLORS,this.onUpdateColorsHandler);
         this._vmManager = null;
         this.clearMarkerBitmap();
         this._markerBitmap = null;
         this.marker = null;
         this.bgShadow = null;
         this.timerTF.filters = null;
         this.timerTF = null;
         this.defaultTF.filters = null;
         this.defaultTF = null;
         super.onDispose();
      }
      
      public function init(param1:String, param2:String, param3:String, param4:String = "green") : void
      {
         this._timer = param2;
         this._markerType = param1;
         this._markerColor = param4;
         this.createMarker();
         this.defaultTF.text = param3;
         this.updateTimerText();
      }
      
      public function updateTimer(param1:String) : void
      {
         this._timer = param1;
         this.updateTimerText();
      }
      
      private function clearMarkerBitmap() : void
      {
         if(this._markerBitmap != null)
         {
            if(this.marker.contains(this._markerBitmap))
            {
               this.marker.removeChild(this._markerBitmap);
            }
            if(this._markerBitmap.bitmapData)
            {
               this._markerBitmap.bitmapData.dispose();
               this._markerBitmap.bitmapData = null;
            }
         }
      }
      
      private function updateTimerText() : void
      {
         this.timerTF.text = this._timer;
      }
      
      private function onUpdateColorsHandler(param1:VehicleMarkersManagerEvent) : void
      {
         if(StringUtils.isNotEmpty(this._markerType) && StringUtils.isNotEmpty(this._markerColor))
         {
            this.createMarker();
            invalidateData();
         }
      }
      
      private function createMarker() : void
      {
         this.clearMarkerBitmap();
         var _loc1_:Class = getDefinitionByName(this.getMarkerClassName()) as Class;
         if(!_loc1_)
         {
            App.utils.asserter.assertNotNull(_loc1_,Errors.BAD_LINKAGE + this._markerType);
         }
         else
         {
            this._markerBitmap = new Bitmap(new _loc1_());
            this._markerBitmap.x = MARKER_X;
            this._markerBitmap.y = MARKER_Y;
            this.marker.addChild(this._markerBitmap);
         }
         var _loc2_:Array = this.getFilters();
         this.defaultTF.filters = _loc2_;
         this.timerTF.filters = _loc2_;
      }
   }
}
