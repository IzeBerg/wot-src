package net.wg.gui.components.controls.achievements
{
   import flash.text.TextField;
   import scaleform.clik.core.UIComponent;
   
   public class AchievementProgressComponent extends UIComponent
   {
       
      
      public var progressBar:AchievementProgressBar;
      
      public var progressTextField:TextField;
      
      public function AchievementProgressComponent()
      {
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.progressBar.setActualSize(_originalWidth,this.progressBar.height);
      }
   }
}
