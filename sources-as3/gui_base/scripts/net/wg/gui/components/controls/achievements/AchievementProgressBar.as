package net.wg.gui.components.controls.achievements
{
   import flash.display.MovieClip;
   import net.wg.gui.components.controls.ProgressBar;
   
   public class AchievementProgressBar extends ProgressBar
   {
       
      
      public var mcMask:MovieClip;
      
      public var dot:MovieClip;
      
      public function AchievementProgressBar()
      {
         super();
      }
      
      override protected function applyDataChanges() : void
      {
         super.applyDataChanges();
         var _loc1_:Number = (value - minimum) / (maximum - minimum);
         var _loc2_:Number = Math.round(_originalWidth * _loc1_);
         this.mcMask.width = _loc2_;
         if(_loc2_ == 0)
         {
            this.dot.x = 3;
            this.dot.visible = false;
         }
         else
         {
            this.dot.visible = true;
            this.dot.x = _loc2_;
         }
      }
   }
}
