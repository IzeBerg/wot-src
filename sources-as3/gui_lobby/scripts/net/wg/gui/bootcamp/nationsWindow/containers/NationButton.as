package net.wg.gui.bootcamp.nationsWindow.containers
{
   import net.wg.gui.components.controls.SoundButtonEx;
   import net.wg.gui.components.controls.UILoaderAlt;
   
   public class NationButton extends SoundButtonEx
   {
       
      
      public var loader:UILoaderAlt = null;
      
      public function NationButton()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         this.loader.dispose();
         this.loader = null;
         super.onDispose();
      }
      
      public function setSource(param1:String) : void
      {
         this.loader.source = param1;
      }
   }
}
