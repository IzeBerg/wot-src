package net.wg.gui.lobby.tankman
{
   import net.wg.gui.components.controls.UILoaderAlt;
   import net.wg.infrastructure.base.UIComponentEx;
   
   public class RankElement extends UIComponentEx
   {
       
      
      public var icoLoader:UILoaderAlt;
      
      public function RankElement()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         this.icoLoader.dispose();
         this.icoLoader = null;
         super.onDispose();
      }
      
      public function setSource(param1:String) : void
      {
         this.icoLoader.source = param1;
      }
   }
}
