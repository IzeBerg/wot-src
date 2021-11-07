package net.wg.gui.lobby.manualChapter.controls
{
   import net.wg.gui.bootcamp.containers.AnimatedSpriteContainer;
   import net.wg.gui.bootcamp.containers.AnimatedTextContainer;
   
   public class TextContainer extends AnimatedSpriteContainer
   {
      
      private static const SMALL_STATE:String = "small";
      
      private static const NORMAL_STATE:String = "normal";
       
      
      public function TextContainer()
      {
         super();
      }
      
      public function updateScaleFactor(param1:Number) : void
      {
         AnimatedTextContainer(content).gotoAndStop(param1 < 1 ? SMALL_STATE : NORMAL_STATE);
      }
      
      override public function set text(param1:String) : void
      {
         super.text = param1;
         App.utils.commons.updateTextFieldSize(AnimatedTextContainer(content).textField,false,true);
      }
   }
}
