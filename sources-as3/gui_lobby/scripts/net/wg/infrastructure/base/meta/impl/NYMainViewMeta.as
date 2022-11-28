package net.wg.infrastructure.base.meta.impl
{
   import net.wg.data.constants.Errors;
   import net.wg.infrastructure.base.AbstractView;
   
   public class NYMainViewMeta extends AbstractView
   {
       
      
      public var onEscPress:Function;
      
      public var onSwitchView:Function;
      
      public function NYMainViewMeta()
      {
         super();
      }
      
      public function onEscPressS() : void
      {
         App.utils.asserter.assertNotNull(this.onEscPress,"onEscPress" + Errors.CANT_NULL);
         this.onEscPress();
      }
      
      public function onSwitchViewS() : void
      {
         App.utils.asserter.assertNotNull(this.onSwitchView,"onSwitchView" + Errors.CANT_NULL);
         this.onSwitchView();
      }
   }
}
