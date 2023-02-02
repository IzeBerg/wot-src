package net.wg.infrastructure.base.meta.impl
{
   import net.wg.data.constants.Errors;
   import net.wg.gui.components.containers.MultipleGFContainerView;
   
   public class CarouselEventEntryMeta extends MultipleGFContainerView
   {
       
      
      public var updateState:Function;
      
      public function CarouselEventEntryMeta()
      {
         super();
      }
      
      public function updateStateS() : void
      {
         App.utils.asserter.assertNotNull(this.updateState,"updateState" + Errors.CANT_NULL);
         this.updateState();
      }
   }
}
