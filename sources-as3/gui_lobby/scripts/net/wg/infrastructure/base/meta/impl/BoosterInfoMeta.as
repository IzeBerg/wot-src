package net.wg.infrastructure.base.meta.impl
{
   import net.wg.data.constants.Errors;
   import net.wg.infrastructure.base.AbstractWindowView;
   
   public class BoosterInfoMeta extends AbstractWindowView
   {
       
      
      public var onCancelClick:Function;
      
      public function BoosterInfoMeta()
      {
         super();
      }
      
      public function onCancelClickS() : void
      {
         App.utils.asserter.assertNotNull(this.onCancelClick,"onCancelClick" + Errors.CANT_NULL);
         this.onCancelClick();
      }
   }
}
