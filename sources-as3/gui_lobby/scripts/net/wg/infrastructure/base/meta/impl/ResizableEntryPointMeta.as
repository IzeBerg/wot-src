package net.wg.infrastructure.base.meta.impl
{
   import net.wg.data.constants.Errors;
   import net.wg.gui.lobby.hangar.eventEntryPoint.EventEntryPointBase;
   
   public class ResizableEntryPointMeta extends EventEntryPointBase
   {
       
      
      public var isSingle:Function;
      
      public function ResizableEntryPointMeta()
      {
         super();
      }
      
      public function isSingleS(param1:Boolean) : void
      {
         App.utils.asserter.assertNotNull(this.isSingle,"isSingle" + Errors.CANT_NULL);
         this.isSingle(param1);
      }
   }
}
