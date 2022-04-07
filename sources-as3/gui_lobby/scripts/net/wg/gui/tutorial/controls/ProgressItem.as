package net.wg.gui.tutorial.controls
{
   import flash.display.MovieClip;
   
   public class ProgressItem extends MovieClip
   {
       
      
      public var lineMC:MovieClip;
      
      public function ProgressItem()
      {
         super();
      }
      
      public function get phaseFrame() : int
      {
         return this.lineMC.currentFrame;
      }
      
      public function setPhase(param1:String) : void
      {
         var _loc2_:int = this.phaseFrame;
         this.lineMC.gotoAndStop(param1);
         if(_loc2_ != this.phaseFrame)
         {
            this.highlight();
         }
      }
      
      public function highlight() : void
      {
         gotoAndPlay(1);
      }
   }
}
