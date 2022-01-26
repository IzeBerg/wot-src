package net.wg.gui.tutorial.meta.impl
{
   import net.wg.data.constants.Errors;
   import net.wg.gui.tutorial.windows.TutorialDialog;
   
   public class TutorialConfirmRefuseDialogMeta extends TutorialDialog
   {
       
      
      public var setStartOnNextLogin:Function;
      
      public function TutorialConfirmRefuseDialogMeta()
      {
         super();
      }
      
      public function setStartOnNextLoginS(param1:Boolean) : void
      {
         App.utils.asserter.assertNotNull(this.setStartOnNextLogin,"setStartOnNextLogin" + Errors.CANT_NULL);
         this.setStartOnNextLogin(param1);
      }
   }
}
