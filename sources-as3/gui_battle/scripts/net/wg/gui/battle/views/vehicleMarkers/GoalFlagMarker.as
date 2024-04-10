package net.wg.gui.battle.views.vehicleMarkers
{
   import flash.display.Sprite;
   import flash.display.Stage;
   import flash.events.Event;
   import flash.text.TextField;
   import net.wg.data.constants.Linkages;
   import net.wg.data.constants.Values;
   import net.wg.gui.battle.views.actionMarkers.BaseActionMarker;
   import scaleform.gfx.TextFieldEx;
   
   public class GoalFlagMarker extends BaseActionMarker
   {
      
      private static const HEIGHT:int = 67;
      
      private static const BIG_FLAG_FRAME:int = 2;
       
      
      public var distanceTF:TextField = null;
      
      public var flagMC:Sprite = null;
      
      public var marker:Sprite;
      
      private var _stage:Stage;
      
      private var _metersString:String = "";
      
      private var _distance:Number = 0;
      
      public function GoalFlagMarker()
      {
         this.marker = new Sprite();
         super();
         TextFieldEx.setNoTranslate(this.distanceTF,true);
      }
      
      override protected function onDispose() : void
      {
         if(this._stage)
         {
            this._stage.removeEventListener(Event.ENTER_FRAME,this.onEnterFrameHandler);
            this._stage = null;
         }
         this.distanceTF = null;
         this.flagMC = null;
         this.marker = null;
         super.onDispose();
      }
      
      public function setDistance(param1:Number) : void
      {
         this._distance = param1;
         this.drawDistance();
      }
      
      private function drawDistance() : void
      {
         if(this._distance != 0)
         {
            this.distanceTF.text = this._distance.toString() + this._metersString;
         }
         else
         {
            this.distanceTF.text = Values.EMPTY_STR;
         }
      }
      
      public function setMeters(param1:String) : void
      {
         this._metersString = param1;
         this.drawDistance();
      }
      
      public function init(... rest) : void
      {
         this._metersString = rest[6];
         this._distance = rest[3];
         this.drawDistance();
         if(stage)
         {
            this._stage = stage;
            this._stage.addEventListener(Event.ENTER_FRAME,this.onEnterFrameHandler,false,0,true);
         }
         this.distanceTF.visible = this.flagMC.visible = stickyMarker.arrow.visible = false;
         gotoAndStop(BIG_FLAG_FRAME);
      }
      
      private function onEnterFrameHandler(param1:Event) : void
      {
         this.distanceTF.visible = this.flagMC.visible = stickyMarker.arrow.visible;
      }
      
      public function setActiveState(param1:int) : void
      {
      }
      
      override public function get height() : Number
      {
         return HEIGHT;
      }
      
      override protected function get stickyMarkerClassLinkage() : String
      {
         return Linkages.FLAG_STICKY_MARKER_UI;
      }
   }
}
