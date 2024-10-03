package net.wg.white_tiger.gui.battle.views.wtTeamBasePanel
{
   import flash.display.MovieClip;
   import net.wg.gui.battle.random.views.teamBasesPanel.TeamCaptureBar;
   import org.idmedia.as3commons.util.StringUtils;
   
   public class TeamCaptureBar extends net.wg.gui.battle.random.views.teamBasesPanel.TeamCaptureBar
   {
       
      
      public var generatorIcon:MovieClip = null;
      
      public var timerIcon:MovieClip = null;
      
      public var tankIcon:MovieClip = null;
      
      public function TeamCaptureBar()
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
