package net.wg.gui.prebattle.abstract
{
   import net.wg.gui.prebattle.meta.IPrequeueWindowMeta;
   import net.wg.gui.prebattle.meta.impl.PrequeueWindowMeta;
   import net.wg.infrastructure.exceptions.AbstractException;
   
   public class PrequeueWindow extends PrequeueWindowMeta implements IPrequeueWindowMeta
   {
       
      
      public function PrequeueWindow()
      {
         super();
      }
      
      public function as_enableLeaveBtn(param1:Boolean) : void
      {
         throw new AbstractException("This method should be overriden");
      }
      
      public function as_enableEnqueueBtn(param1:Boolean) : void
      {
         throw new AbstractException("This method should be overriden");
      }
   }
}
