package net.wg.gui.battle.views.vehicleMarkers.event
{
   import flash.display.Sprite;
   import flash.text.TextField;
   import scaleform.gfx.TextFieldEx;
   
   public class EventVolotProgress extends EventVolotBase
   {
       
      
      public var iconEnabled:Sprite;
      
      public var iconDisabled:Sprite;
      
      public var progressTF:TextField;
      
      private var _energyLeft:int = -1;
      
      public function EventVolotProgress()
      {
         super();
         this.iconEnabled.visible = false;
         this.iconDisabled.visible = false;
         TextFieldEx.setNoTranslate(this.progressTF,true);
      }
      
      override protected function onDispose() : void
      {
         this.iconEnabled = null;
         this.iconDisabled = null;
         this.progressTF = null;
         super.onDispose();
      }
      
      public function setEnabled(param1:Boolean) : void
      {
         this.iconEnabled.visible = param1;
         this.iconDisabled.visible = !param1;
         if(param1)
         {
            setMessage(EVENT.ARENA_MARKER_DELIVER_MATTER);
         }
         else
         {
            setMessage(EVENT.ARENA_MARKER_NEED_MATTER);
         }
      }
      
      public function setEnergyLeft(param1:int) : void
      {
         if(this._energyLeft == param1)
         {
            return;
         }
         this._energyLeft = param1;
         this.progressTF.text = this._energyLeft.toString();
      }
   }
}
