package net.wg.gui.lobby.personalMissions.components.popupComponents
{
   import flash.display.MovieClip;
   import flash.events.Event;
   import net.wg.gui.lobby.personalMissions.components.interfaces.IAwardSheetPopup;
   import net.wg.infrastructure.base.UIComponentEx;
   import scaleform.clik.core.UIComponent;
   import scaleform.clik.events.ButtonEvent;
   
   public class AbstractFreeSheetPopup extends UIComponentEx implements IAwardSheetPopup
   {
      
      private static const HIDE_FRAME:String = "hide";
       
      
      public var blink:MovieClip;
      
      public var bottomBlock:AwardSheetAcceptBtnCmp;
      
      public function AbstractFreeSheetPopup()
      {
         super();
         stop();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         mouseEnabled = false;
         this.blink.mouseChildren = this.blink.mouseEnabled = false;
         this.bottomBlock.init();
         this.bottomBlock.addEventListener(ButtonEvent.CLICK,this.onBottomBlockClickHandler);
         addFrameScript(this.hideFrameInd,this.onFadeOut);
         addFrameScript(totalFrames - 1,this.onAnimFinished);
         focusTarget = UIComponent(this.bottomBlock.acceptBtn);
      }
      
      override protected function onDispose() : void
      {
         stop();
         this.blink = null;
         this.bottomBlock.removeEventListener(ButtonEvent.CLICK,this.onBottomBlockClickHandler);
         this.bottomBlock.dispose();
         this.bottomBlock = null;
         super.onDispose();
      }
      
      public function init(param1:Boolean, param2:Object) : void
      {
         if(param1)
         {
            gotoAndPlay(1);
            mouseChildren = false;
         }
         else
         {
            gotoAndStop(this.hideFrameInd);
            mouseChildren = true;
         }
         App.popoverMgr.hide();
      }
      
      private function onFadeOut() : void
      {
         mouseChildren = true;
         stop();
      }
      
      private function onAnimFinished() : void
      {
         stop();
         dispatchEvent(new Event(Event.COMPLETE));
      }
      
      protected function get hideFrameInd() : int
      {
         return 1;
      }
      
      private function onBottomBlockClickHandler(param1:ButtonEvent) : void
      {
         mouseChildren = false;
         gotoAndPlay(HIDE_FRAME);
         dispatchEvent(new Event(Event.CLOSE));
      }
   }
}
