package net.wg.gui.lobby.modulesPanel.components
{
   import net.wg.gui.lobby.profile.components.SimpleLoader;
   
   public class ExtraIcon extends SimpleLoader
   {
       
      
      public function ExtraIcon()
      {
         super();
      }
      
      override protected function startLoading(param1:String) : void
      {
         super.startLoading(param1);
         loader.visible = false;
      }
      
      override protected function onLoadingComplete() : void
      {
         super.onLoadingComplete();
         loader.visible = true;
      }
   }
}
