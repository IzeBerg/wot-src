package net.wg.gui.battle.eventBattle.views.teamBasePanel
{
   import flash.display.MovieClip;
   import net.wg.gui.battle.random.views.teamBasesPanel.TeamCaptureBar;
   import org.idmedia.as3commons.util.StringUtils;
   
   public class EventTeamCaptureBar extends TeamCaptureBar
   {
       
      
      public var generatorIcon:MovieClip = null;
      
      public var timerIcon:MovieClip = null;
      
      public var tankIcon:MovieClip = null;
      
      public function EventTeamCaptureBar()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         this.generatorIcon = null;
         this.timerIcon = null;
         this.tankIcon = null;
         super.onDispose();
      }
      
      override protected function getEaseArray(param1:Number) : Array
      {
         return TWEEN_EASE_NONE;
      }
      
      override protected function updateTitle(param1:String) : void
      {
         super.updateTitle(param1);
         this.generatorIcon.x = textField.x + (textField.width - textField.textWidth >> 1);
         this.tankIcon.visible = this.timerIcon.visible = this.generatorIcon.visible = StringUtils.isNotEmpty(param1);
      }
   }
}
