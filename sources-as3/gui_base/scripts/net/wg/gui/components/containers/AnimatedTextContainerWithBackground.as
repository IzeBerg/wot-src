package net.wg.gui.components.containers
{
   import flash.display.Sprite;
   
   public class AnimatedTextContainerWithBackground extends AnimatedTextContainer
   {
      
      private static const TEXT_PADDING:int = 10;
       
      
      public var background:Sprite;
      
      public function AnimatedTextContainerWithBackground()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         this.background = null;
         super.onDispose();
      }
      
      private function resizeBackground() : void
      {
         if(this.background)
         {
            this.background.width = Math.max(this.background.width,textField.x + textField.textWidth + TEXT_PADDING);
         }
      }
      
      override public function set text(param1:String) : void
      {
         super.text = param1;
         this.resizeBackground();
      }
      
      override public function set htmlText(param1:String) : void
      {
         super.htmlText = param1;
         this.resizeBackground();
      }
   }
}
