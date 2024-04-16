package net.wg.gui.cyberSport.views.autoSearch
{
   import flash.events.Event;
   import flash.text.TextField;
   import net.wg.data.constants.SoundManagerStates;
   import net.wg.data.constants.SoundTypes;
   import net.wg.data.constants.generated.CYBER_SPORT_ALIASES;
   
   public class ConfirmationReadinessStatus extends StateViewBase
   {
       
      
      public var headerField:TextField;
      
      public var ctxText:TextField;
      
      public var countDown:TextField;
      
      public var countDownSec:TextField;
      
      public function ConfirmationReadinessStatus()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         this.headerField = null;
         this.ctxText = null;
         this.countDown = null;
         this.countDownSec = null;
         super.onDispose();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.headerField.text = CYBERSPORT.WINDOW_AUTOSEARCH_CONFIRMATION_HEADERTEXT;
         this.ctxText.text = CYBERSPORT.WINDOW_AUTOSEARCH_CONFIRMATION_CTXMESSAGE;
         this.countDownSec.text = CYBERSPORT.WINDOW_AUTOSEARCH_CONFIRMATION_CTXSECONDS;
         this.countDown.mouseEnabled = this.countDownSec.mouseEnabled = false;
         this.headerField.mouseEnabled = this.ctxText.mouseEnabled = false;
      }
      
      override protected function getSubmitLabel() : String
      {
         return CYBERSPORT.WINDOW_AUTOSEARCH_CONFIRMATION_SUBMITLLBL;
      }
      
      override protected function getCancelLabel() : String
      {
         return CYBERSPORT.WINDOW_AUTOSEARCH_CONFIRMATION_CANCELLBL;
      }
      
      override protected function getMainLabel() : String
      {
         return CYBERSPORT.WINDOW_AUTOSEARCH_CONFIRMATION_MAINTEXT;
      }
      
      override protected function getSearchState() : String
      {
         return CYBER_SPORT_ALIASES.AUTO_SEARCH_CONFIRMATION_STATE;
      }
      
      override protected function updateView() : void
      {
         App.soundMgr.playControlsSnd(SoundManagerStates.SND_PRESS,SoundTypes.CYBERSPORT_AUTO_SEARCH,null);
         time = model.countDownSeconds;
         this.contextMessage(String(time));
         startTimer();
      }
      
      override protected function onTimer() : void
      {
         --time;
         if(time > 0)
         {
            this.contextMessage(String(time));
            startTimer();
         }
      }
      
      override protected function contextMessage(param1:String) : void
      {
         this.countDown.text = param1;
         dispatchEvent(new Event(UPDATE_TIMER,true));
      }
   }
}
