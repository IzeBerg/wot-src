package net.wg.gui.cyberSport.views.autoSearch
{
   import flash.text.TextField;
   import net.wg.data.constants.generated.CYBER_SPORT_ALIASES;
   
   public class SearchCommands extends StateViewBase
   {
       
      
      public var ctxText:TextField;
      
      public var dynamicCtxText:TextField;
      
      public function SearchCommands()
      {
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.ctxText.text = CYBERSPORT.WINDOW_AUTOSEARCH_SEARCHCOMMAND_CTXMESSAGE;
         this.ctxText.mouseEnabled = this.dynamicCtxText.mouseEnabled = false;
      }
      
      override protected function getCancelLabel() : String
      {
         return CYBERSPORT.WINDOW_AUTOSEARCH_SEARCHCOMMAND_CANCELLBL;
      }
      
      override protected function getMainLabel() : String
      {
         return CYBERSPORT.WINDOW_AUTOSEARCH_SEARCHCOMMAND_MAINTEXT;
      }
      
      override protected function getSearchState() : String
      {
         return CYBER_SPORT_ALIASES.AUTO_SEARCH_COMMANDS_STATE;
      }
      
      override protected function updateView() : void
      {
         super.updateView();
         updateTime();
         startTimer();
         this.contextMessage(model.contextMessage);
      }
      
      override protected function onTimer() : void
      {
         super.onTimer();
         updateTime();
         startTimer();
      }
      
      override protected function contextMessage(param1:String) : void
      {
         super.contextMessage(param1);
         this.dynamicCtxText.htmlText = param1;
      }
   }
}
