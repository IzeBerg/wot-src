package net.wg.gui.battle.views.vehicleMarkers.statusMarkers
{
   import flash.display.MovieClip;
   import flash.text.TextField;
   import scaleform.gfx.TextFieldEx;
   
   public class VehicleStunMarker extends VehicleAnimatedStatusBaseMarker
   {
       
      
      public var counterMc:MovieClip = null;
      
      public var arrowMc:MovieClip = null;
      
      private var _secString:String = "";
      
      private var _noTranslateEnabled:Boolean = false;
      
      public function VehicleStunMarker()
      {
         super();
      }
      
      override public function showEffectTimer(param1:Number, param2:Boolean, param3:Boolean, param4:Boolean = true, param5:Boolean = true) : void
      {
         this.counterMc.visible = param2;
         super.showEffectTimer(param1,param2,param3,param4,param5);
      }
      
      override public function updateEffectTimer(param1:int, param2:Boolean, param3:Boolean = false) : void
      {
         super.updateEffectTimer(param1,param2,param3);
         if(!this._noTranslateEnabled)
         {
            this._noTranslateEnabled = true;
            TextFieldEx.setNoTranslate(TextField(this.counterMc.labelTf),true);
         }
         this.counterMc.labelTf.text = param1 + this._secString;
      }
      
      override protected function onDispose() : void
      {
         this.counterMc = null;
         this.arrowMc = null;
         super.onDispose();
      }
      
      override protected function updateColorSettings(param1:uint) : void
      {
         this.arrowMc.gotoAndStop(color);
         TextField(this.counterMc.labelTf).textColor = param1;
      }
      
      public function setSecondString(param1:String) : void
      {
         this._secString = param1;
      }
   }
}
