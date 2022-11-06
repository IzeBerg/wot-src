package net.wg.gui.components.advanced
{
   import net.wg.gui.components.controls.UILoaderAlt;
   import scaleform.clik.core.UIComponent;
   
   public class ScalableIconWrapper extends UIComponent
   {
       
      
      public var loader:UILoaderAlt;
      
      public function ScalableIconWrapper()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         this.loader.dispose();
         this.loader = null;
         super.onDispose();
      }
   }
}
