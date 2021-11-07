package net.wg.gui.battle.tutorial.views.tutorial.components.taskPanel.containers
{
   import flash.display.MovieClip;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class Task extends MovieClip implements IDisposable
   {
      
      private static const SHOW_LABEL:String = "show";
       
      
      public var taskAnimSpr:TaskAnimation = null;
      
      public function Task()
      {
         super();
      }
      
      public function animate() : void
      {
         gotoAndPlay(SHOW_LABEL);
      }
      
      public function setTaskText(param1:String) : void
      {
         this.taskAnimSpr.setTaskText(param1);
      }
      
      public function getTaskTextHeight() : int
      {
         return this.taskAnimSpr.getTaskTextHeight();
      }
      
      public function dispose() : void
      {
         this.taskAnimSpr.dispose();
         this.taskAnimSpr = null;
      }
   }
}
