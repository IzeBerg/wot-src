package net.wg.gui.components.containers
{
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   
   public class HintContainer extends MovieClip
   {
      
      private static const TEXT_PADDING:int = 20;
       
      
      public var textField:TextField = null;
      
      public var background:Sprite = null;
      
      public var arrowRight:Sprite = null;
      
      public var arrowUpDown:Sprite = null;
      
      public function HintContainer()
      {
         super();
         this.textField.autoSize = TextFieldAutoSize.LEFT;
      }
      
      public function setLabel(param1:String) : void
      {
         this.textField.text = param1;
         this.background.width = this.textField.width + (TEXT_PADDING << 1);
         if(this.arrowRight)
         {
            this.background.x = this.arrowRight.x - this.arrowRight.width - this.background.width >> 0;
            this.textField.x = this.background.x + TEXT_PADDING;
         }
         if(this.arrowUpDown)
         {
            this.background.x = -this.background.width >> 1;
            this.textField.x = this.background.x + TEXT_PADDING;
         }
      }
      
      public final function dispose() : void
      {
         this.textField = null;
         this.background = null;
         this.arrowRight = null;
         this.arrowUpDown = null;
      }
   }
}
