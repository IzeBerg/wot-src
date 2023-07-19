package net.wg.infrastructure.base.meta.impl
{
   import net.wg.data.constants.Errors;
   import net.wg.infrastructure.base.AbstractView;
   
   public class StrongholdViewMeta extends AbstractView
   {
       
      
      public var onEscapePress:Function;
      
      public var onFocusChange:Function;
      
      public var viewSize:Function;
      
      public function StrongholdViewMeta()
      {
         super();
      }
      
      public function onEscapePressS() : void
      {
         App.utils.asserter.assertNotNull(this.onEscapePress,"onEscapePress" + Errors.CANT_NULL);
         this.onEscapePress();
      }
      
      public function onFocusChangeS(param1:Boolean) : void
      {
         App.utils.asserter.assertNotNull(this.onFocusChange,"onFocusChange" + Errors.CANT_NULL);
         this.onFocusChange(param1);
      }
      
      public function viewSizeS(param1:Number, param2:Number) : void
      {
         App.utils.asserter.assertNotNull(this.viewSize,"viewSize" + Errors.CANT_NULL);
         this.viewSize(param1,param2);
      }
   }
}
