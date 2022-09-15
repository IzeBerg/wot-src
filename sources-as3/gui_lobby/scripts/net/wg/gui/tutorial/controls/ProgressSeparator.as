package net.wg.gui.tutorial.controls
{
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.text.TextField;
   
   public class ProgressSeparator extends MovieClip
   {
       
      
      public var labelMc:MovieClip;
      
      public var marker:Sprite;
      
      public function ProgressSeparator()
      {
         super();
      }
      
      public function get label() : TextField
      {
         return this.labelMc.getChildByName("label") as TextField;
      }
      
      public function setup(param1:int, param2:Number) : void
      {
         this.label.text = String(param1 + 1);
         this.labelMc.x = param2 - this.label.textWidth >> 1;
         if(param1 == 0)
         {
            this.marker.visible = false;
         }
      }
   }
}
