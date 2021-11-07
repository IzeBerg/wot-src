package net.wg.gui.battle.tutorial.views.tutorial.components.taskPanel.containers
{
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class Icon extends Sprite implements IDisposable
   {
      
      private static const SHOW_LABEL:String = "show";
       
      
      public var inProgressIconSpr:Sprite = null;
      
      public var doneIconMc:MovieClip = null;
      
      public function Icon()
      {
         super();
      }
      
      public function setDoneIconVisible(param1:Boolean) : void
      {
         this.doneIconMc.visible = param1;
      }
      
      public function showDoneIconAnimate() : void
      {
         this.doneIconMc.gotoAndPlay(SHOW_LABEL);
      }
      
      public function setInProgressIconVisible(param1:Boolean) : void
      {
         this.inProgressIconSpr.visible = param1;
      }
      
      public function dispose() : void
      {
         this.inProgressIconSpr = null;
         this.doneIconMc = null;
      }
   }
}
