package net.wg.gui.battle.views.vehicleMarkers
{
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.geom.Point;
   import flash.text.TextField;
   import flash.utils.getDefinitionByName;
   import net.wg.data.constants.Errors;
   import net.wg.gui.battle.components.BattleUIComponent;
   import scaleform.gfx.TextFieldEx;
   
   public class FortConsumablesMarker extends BattleUIComponent
   {
      
      private static const MARKER_XY:Point = new Point(-52,-58);
       
      
      public var marker:MovieClip = null;
      
      public var bgShadow:MovieClip = null;
      
      public var timerTF:TextField = null;
      
      public var defaultTF:TextField = null;
      
      private var _orderType:String = null;
      
      private var _timer:String = null;
      
      private var _defaultPostfix:String = null;
      
      private var _markerBitmap:Bitmap = null;
      
      public function FortConsumablesMarker()
      {
         super();
         TextFieldEx.setNoTranslate(this.timerTF,true);
         TextFieldEx.setNoTranslate(this.defaultTF,true);
      }
      
      override protected function onDispose() : void
      {
         this._markerBitmap.bitmapData.dispose();
         this._markerBitmap.bitmapData = null;
         this._markerBitmap = null;
         this.marker = null;
         this.bgShadow = null;
         this.timerTF = null;
         this.defaultTF = null;
         super.onDispose();
      }
      
      public function init(param1:String, param2:String, param3:String) : void
      {
         this._defaultPostfix = param3;
         this._orderType = param1;
         this._timer = param2;
         this.initAllElements();
      }
      
      public function updateTimer(param1:String) : void
      {
         this._timer = param1;
         this.updateTimerText();
      }
      
      private function initAllElements() : void
      {
         this.initIconFrames();
         this.updateDefaultText();
         this.updateTimerText();
      }
      
      private function initIconFrames() : void
      {
         var shapeBitmapClass:Class = null;
         if(this._markerBitmap != null)
         {
            this.marker.removeChild(this._markerBitmap);
            this._markerBitmap.bitmapData.dispose();
            this._markerBitmap.bitmapData = null;
         }
         try
         {
            shapeBitmapClass = getDefinitionByName(this._orderType) as Class;
            this._markerBitmap = new Bitmap(new shapeBitmapClass());
            this._markerBitmap.x = MARKER_XY.x;
            this._markerBitmap.y = MARKER_XY.y;
            this.marker.addChild(this._markerBitmap);
         }
         catch(error:ReferenceError)
         {
            DebugUtils.LOG_ERROR(Errors.BAD_LINKAGE + _orderType);
         }
      }
      
      private function updateDefaultText() : void
      {
         this.defaultTF.text = this._defaultPostfix;
      }
      
      private function updateTimerText() : void
      {
         this.timerTF.text = this._timer;
      }
   }
}
