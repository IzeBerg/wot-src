package net.wg.gui.battle.pveBase.views.primaryObjective.controls
{
   import flash.display.MovieClip;
   import net.wg.gui.components.containers.AnimatedTextContainer;
   import net.wg.infrastructure.base.UIComponentEx;
   
   public class PrimaryObjectiveTaskBar extends UIComponentEx
   {
      
      private static const PROGRESSBAR_OFFSET:int = 12;
      
      private static const PROGRESSBAR_SMALL_OFFSET:int = 14;
       
      
      public var description:AnimatedTextContainer = null;
      
      public var descriptionSmall:AnimatedTextContainer = null;
      
      public var progressBar:MovieClip = null;
      
      private var _isSmall:Boolean = false;
      
      public function PrimaryObjectiveTaskBar()
      {
         super();
         this.progressBar.visible = false;
      }
      
      private function updateProgressBarPosition() : void
      {
         if(!this._isSmall)
         {
            this.progressBar.y = this.description.y + this.description.contentHeight + PROGRESSBAR_OFFSET >> 0;
         }
         else
         {
            this.progressBar.y = this.descriptionSmall.y + this.descriptionSmall.contentHeight + PROGRESSBAR_SMALL_OFFSET >> 0;
         }
      }
      
      public function updateStage(param1:Boolean) : void
      {
         this._isSmall = param1;
         this.description.visible = !param1;
         this.descriptionSmall.visible = param1;
         this.updateProgressBarPosition();
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
         this.descriptionSmall.htmlText = param1;
         this.updateProgressBarPosition();
      }
      
      override protected function onDispose() : void
      {
         this.description.dispose();
         this.description = null;
         this.descriptionSmall.dispose();
         this.descriptionSmall = null;
         this.progressBar = null;
         super.onDispose();
      }
   }
}
