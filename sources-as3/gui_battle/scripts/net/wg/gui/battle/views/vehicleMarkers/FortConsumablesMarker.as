package net.wg.gui.battle.views.vehicleMarkers
{
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.filters.DropShadowFilter;
   import flash.geom.Point;
   import flash.text.TextField;
   import flash.utils.getDefinitionByName;
   import net.wg.data.constants.Errors;
   import net.wg.data.constants.generated.BATTLE_MARKERS_CONSTS;
   import net.wg.gui.battle.components.BattleUIComponent;
   import scaleform.gfx.TextFieldEx;
   
   public class FortConsumablesMarker extends BattleUIComponent
   {
      
      private static const MARKER_XY:Point = new Point(-52,-58);
      
      private static const GREEN_DROPSHADOW_FILTERS:Array = [new DropShadowFilter(0,45,4550697,1,4,4,3.7)];
      
      private static const YELLOW_DROPSHADOW_FILTERS:Array = [new DropShadowFilter(0,45,13328640,1,4,4,3.7)];
       
      
      public var marker:MovieClip = null;
      
      public var bgShadow:MovieClip = null;
      
      public var timerTF:TextField = null;
      
      public var defaultTF:TextField = null;
      
      private var _timer:String = null;
      
      private var _markerBitmap:Bitmap = null;
      
      public function FortConsumablesMarker()
      {
         super();
         TextFieldEx.setNoTranslate(this.timerTF,true);
         TextFieldEx.setNoTranslate(this.defaultTF,true);
      }
      
      private static function getFilters(param1:String) : Array
      {
         if(param1 == BATTLE_MARKERS_CONSTS.COLOR_YELLOW)
         {
            return YELLOW_DROPSHADOW_FILTERS;
         }
         return GREEN_DROPSHADOW_FILTERS;
      }
      
      override protected function onDispose() : void
      {
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
         this.clearMarkerBitmap();
         var _loc5_:Class = getDefinitionByName(param1) as Class;
         if(!_loc5_)
         {
            App.utils.asserter.assertNotNull(_loc5_,Errors.BAD_LINKAGE + param1);
         }
         else
         {
            this._markerBitmap = new Bitmap(new _loc5_());
            this._markerBitmap.x = MARKER_XY.x;
            this._markerBitmap.y = MARKER_XY.y;
            this.marker.addChild(this._markerBitmap);
         }
         var _loc6_:Array = getFilters(param4);
         this.defaultTF.filters = _loc6_;
         this.timerTF.filters = _loc6_;
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
   }
}
