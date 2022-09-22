package net.wg.infrastructure.base.meta.impl
{
   import net.wg.data.constants.Errors;
   import net.wg.gui.rally.RallyMainWindowWithSearch;
   
   public class CyberSportMainWindowMeta extends RallyMainWindowWithSearch
   {
       
      
      public var showHelp:Function;
      
      public function CyberSportMainWindowMeta()
      {
         super();
      }
      
      public function showHelpS(param1:String) : void
      {
         App.utils.asserter.assertNotNull(this.showHelp,"showHelp" + Errors.CANT_NULL);
         this.showHelp(param1);
      }
   }
}
