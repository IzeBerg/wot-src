package net.wg.gui.lobby.techtree.controls
{
   import net.wg.gui.components.controls.SoundButtonEx;
   
   public class AnimatedTextButton extends SoundButtonEx
   {
       
      
      public var textLabel:AnimatedTextLabel = null;
      
      public function AnimatedTextButton()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         this.textLabel.dispose();
         this.textLabel = null;
         super.onDispose();
      }
      
      override protected function updateText() : void
      {
         if(_label != null)
         {
            this.textLabel.text = _label;
         }
      }
   }
}
