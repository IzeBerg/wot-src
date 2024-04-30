package net.wg.gui.battle.historicalBattles.timer.controls
{
   import flash.display.MovieClip;
   import net.wg.gui.bootcamp.containers.AnimatedTextContainer;
   import net.wg.infrastructure.base.UIComponentEx;
   
   public class TimerTaskBar extends UIComponentEx
   {
      
      private static const PROGRESSBAR_OFFSET:int = 12;
       
      
      public var description:AnimatedTextContainer = null;
      
      public var progressBar:MovieClip = null;
      
      public function TimerTaskBar()
      {
         super();
      }
      
      public function updateProgressBar(param1:int, param2:Boolean) : void
      {
         this.progressBar.visible = param2;
         if(param2)
         {
            this.progressBar.gotoAndStop(param1 + 1);
         }
      }
      
      public function setText(param1:String) : void
      {
         this.description.htmlText = param1;
         this.progressBar.y = this.description.y + this.description.contentHeight + PROGRESSBAR_OFFSET;
      }
      
      override protected function onDispose() : void
      {
         this.description.dispose();
         this.description = null;
         this.progressBar = null;
         super.onDispose();
      }
   }
}
