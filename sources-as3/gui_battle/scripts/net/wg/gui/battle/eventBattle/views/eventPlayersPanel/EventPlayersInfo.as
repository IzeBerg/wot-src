package net.wg.gui.battle.eventBattle.views.eventPlayersPanel
{
   import flash.display.MovieClip;
   import flash.text.TextField;
   import net.wg.gui.battle.components.BattleUIComponent;
   import scaleform.gfx.TextFieldEx;
   
   public class EventPlayersInfo extends BattleUIComponent
   {
      
      private static const GOAL_COLLECT_MATTER:uint = 1;
      
      private static const GOAL_DELIVER_MATTER:uint = 2;
      
      private static const GOAL_GET_TO_COLLECTOR:uint = 3;
      
      private static const FRAME_NOT_READY:String = "not_ready";
      
      private static const FRAME_READY:String = "ready";
      
      private static const FRAME_FULL:String = "full";
       
      
      public var teamTF:TextField = null;
      
      public var collectorTF:TextField = null;
      
      public var collectorValueTF:TextField = null;
      
      public var teamValueTF:TextField = null;
      
      public var collectorState:MovieClip = null;
      
      public function EventPlayersInfo()
      {
         super();
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         TextFieldEx.setNoTranslate(this.collectorValueTF,true);
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.teamTF.text = INGAME_GUI.PLAYERS_PANEL_INFO_TEAM;
      }
      
      override protected function onDispose() : void
      {
         this.teamTF = null;
         this.collectorTF = null;
         this.collectorValueTF = null;
         this.collectorState = null;
         this.teamValueTF = null;
         super.onDispose();
      }
      
      public function setCountSouls(param1:uint) : void
      {
         this.teamValueTF.text = param1.toString();
      }
      
      public function setCollectorValue(param1:int) : void
      {
         this.collectorValueTF.text = param1.toString();
      }
      
      public function setGoal(param1:int) : void
      {
         switch(param1)
         {
            case GOAL_DELIVER_MATTER:
               this.collectorTF.text = INGAME_GUI.PLAYERS_PANEL_INFO_COLLECTOR;
               this.collectorValueTF.visible = true;
               this.collectorState.gotoAndStop(FRAME_READY);
               break;
            case GOAL_GET_TO_COLLECTOR:
               this.collectorTF.text = INGAME_GUI.PLAYERS_PANEL_INFO_COLLECTOR_FULL;
               this.collectorValueTF.visible = false;
               this.collectorState.gotoAndStop(FRAME_FULL);
               break;
            case GOAL_COLLECT_MATTER:
            default:
               this.collectorTF.text = INGAME_GUI.PLAYERS_PANEL_INFO_COLLECTOR;
               this.collectorValueTF.visible = true;
               this.collectorState.gotoAndStop(FRAME_NOT_READY);
         }
      }
   }
}
