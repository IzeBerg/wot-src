package net.wg.gui.battle.halloween.basesPanel
{
   import flash.text.TextField;
   import net.wg.gui.battle.views.actionMarkers.ActionMarkerStates;
   import net.wg.gui.battle.views.staticMarkers.halloween.HWBaseMarker;
   import net.wg.infrastructure.base.meta.impl.EventBasesPanelMeta;
   
   public class HWBasesPanel extends EventBasesPanelMeta
   {
      
      private static const NONE:String = "none";
       
      
      public var base1:HWBaseMarker = null;
      
      public var base2:HWBaseMarker = null;
      
      public var base1TimerTF:TextField = null;
      
      public var base2TimerTF:TextField = null;
      
      private var _owningTeam1:String = "none";
      
      private var _owningTeam2:String = "none";
      
      public function HWBasesPanel()
      {
         super();
      }
      
      public function as_setVisibility(param1:Boolean) : void
      {
         setCompVisible(param1);
      }
      
      public function as_setColorBlind(param1:Boolean) : void
      {
         this.base1.setColorBlind(param1);
         this.base2.setColorBlind(param1);
      }
      
      public function as_setBase1ID(param1:int) : void
      {
         this.base1.setIdentifier(param1);
      }
      
      public function as_setBase2ID(param1:int) : void
      {
         this.base2.setIdentifier(param1);
      }
      
      public function as_setBase1State(param1:String, param2:String) : void
      {
         this._owningTeam1 = param1;
         this.base1.setTeamStatus(param1,param2);
      }
      
      public function as_setBase2State(param1:String, param2:String) : void
      {
         this._owningTeam2 = param1;
         this.base2.setTeamStatus(param1,param2);
      }
      
      public function as_setBase1Progress(param1:Number, param2:String) : void
      {
         this.base1.setCapturePoints(param1);
         this.base1TimerTF.text = param2;
      }
      
      public function as_setBase2Progress(param1:Number, param2:String) : void
      {
         this.base2.setCapturePoints(param1);
         this.base2TimerTF.text = param2;
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.base1.setActiveState(ActionMarkerStates.NEUTRAL);
         this.base2.setActiveState(ActionMarkerStates.NEUTRAL);
         this.base1.showReplyMarker(false);
         this.base2.showReplyMarker(false);
      }
      
      override protected function onDispose() : void
      {
         this.base1.dispose();
         this.base1 = null;
         this.base2.dispose();
         this.base2 = null;
         this.base1TimerTF = null;
         this.base2TimerTF = null;
         super.onDispose();
      }
   }
}
