package net.wg.gui.cyberSport.views.autoSearch
{
   import flash.text.TextField;
   import net.wg.data.constants.generated.CYBER_SPORT_ALIASES;
   
   public class ErrorState extends StateViewBase
   {
       
      
      public var headerField:TextField;
      
      public var ctxText:TextField;
      
      public function ErrorState()
      {
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.headerField.text = CYBERSPORT.WINDOW_AUTOSEARCH_ERRORSTATE_HEADERTEXT;
         this.ctxText.text = CYBERSPORT.WINDOW_AUTOSEARCH_ERRORSTATE_CTXMESSAGE;
         this.headerField.mouseEnabled = this.ctxText.mouseEnabled = false;
      }
      
      override protected function getSubmitLabel() : String
      {
         return CYBERSPORT.WINDOW_AUTOSEARCH_ERRORSTATE_SUBMITLLBL;
      }
      
      override protected function getCancelLabel() : String
      {
         return CYBERSPORT.WINDOW_AUTOSEARCH_ERRORSTATE_CANCELLBL;
      }
      
      override protected function getMainLabel() : String
      {
         return CYBERSPORT.WINDOW_AUTOSEARCH_ERRORSTATE_MAINTEXT;
      }
      
      override protected function getSearchState() : String
      {
         return CYBER_SPORT_ALIASES.AUTO_SEARCH_ERROR_STATE;
      }
   }
}
