package net.wg.infrastructure.base.meta.impl
{
   import net.wg.data.constants.Errors;
   import net.wg.infrastructure.base.BaseDAAPIComponent;
   
   public class PaginationMeta extends BaseDAAPIComponent
   {
       
      
      public var showPage:Function;
      
      public function PaginationMeta()
      {
         super();
      }
      
      public function showPageS(param1:int) : void
      {
         App.utils.asserter.assertNotNull(this.showPage,"showPage" + Errors.CANT_NULL);
         this.showPage(param1);
      }
   }
}
