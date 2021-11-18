package net.wg.gui.lobby.personalMissions.components.popupComponents
{
   import flash.display.MovieClip;
   import net.wg.gui.interfaces.ISoundButtonEx;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   import scaleform.clik.events.ButtonEvent;
   
   public class AwardSheetAcceptBtnCmp extends MovieClip implements IDisposable
   {
       
      
      public var acceptBtn:ISoundButtonEx;
      
      public function AwardSheetAcceptBtnCmp()
      {
         super();
      }
      
      public final function dispose() : void
      {
         this.acceptBtn.removeEventListener(ButtonEvent.CLICK,this.onAcceptBtnClickHandler);
         this.acceptBtn.dispose();
         this.acceptBtn = null;
         this.onDispose();
      }
      
      public function init() : void
      {
         this.acceptBtn.label = PERSONAL_MISSIONS.PERSONALMISSIONFIRSTENTRYVIEW_ACKNOWLEDGEBTN;
         this.acceptBtn.addEventListener(ButtonEvent.CLICK,this.onAcceptBtnClickHandler);
      }
      
      protected function onDispose() : void
      {
      }
      
      private function onAcceptBtnClickHandler(param1:ButtonEvent) : void
      {
         dispatchEvent(new ButtonEvent(ButtonEvent.CLICK));
         this.acceptBtn.enabled = false;
      }
   }
}
