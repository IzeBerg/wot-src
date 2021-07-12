package net.wg.gui.lobby.battleResults.components.detailsBlockStates
{
   import net.wg.gui.components.controls.Image;
   import net.wg.infrastructure.base.UIComponentEx;
   
   public class DetailsState extends UIComponentEx
   {
       
      
      public var backgroundIcon:Image = null;
      
      public function DetailsState()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         this.backgroundIcon.dispose();
         this.backgroundIcon = null;
         super.onDispose();
      }
   }
}
