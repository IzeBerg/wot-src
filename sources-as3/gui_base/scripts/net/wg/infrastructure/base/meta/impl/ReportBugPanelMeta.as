package net.wg.infrastructure.base.meta.impl
{
   import net.wg.data.constants.Errors;
   import net.wg.infrastructure.base.BaseDAAPIComponent;
   
   public class ReportBugPanelMeta extends BaseDAAPIComponent
   {
       
      
      public var reportBug:Function;
      
      public function ReportBugPanelMeta()
      {
         super();
      }
      
      public function reportBugS() : void
      {
         App.utils.asserter.assertNotNull(this.reportBug,"reportBug" + Errors.CANT_NULL);
         this.reportBug();
      }
   }
}
