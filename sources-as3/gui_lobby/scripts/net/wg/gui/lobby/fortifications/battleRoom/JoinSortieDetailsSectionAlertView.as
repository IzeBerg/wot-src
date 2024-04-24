package net.wg.gui.lobby.fortifications.battleRoom
{
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import net.wg.gui.components.controls.SoundButtonEx;
   import net.wg.gui.components.controls.UILoaderAlt;
   import net.wg.gui.events.UILoaderEvent;
   import net.wg.gui.lobby.fortifications.data.battleRoom.SortieAlertViewVO;
   import net.wg.gui.rally.events.RallyViewsEvent;
   import net.wg.infrastructure.base.UIComponentEx;
   import net.wg.infrastructure.interfaces.entity.IUpdatable;
   import scaleform.clik.events.ButtonEvent;
   
   public class JoinSortieDetailsSectionAlertView extends UIComponentEx implements IUpdatable
   {
      
      private static const BUTTON_PADDING:int = 17;
      
      private static const ADDITIONAL_TEXT_HEIGHT:int = 5;
      
      private static const ICON_PADDING:int = 6;
       
      
      public var joinButton:SoundButtonEx = null;
      
      public var alertIcon:UILoaderAlt = null;
      
      public var messageTitle:TextField = null;
      
      public var messageBody:TextField = null;
      
      public function JoinSortieDetailsSectionAlertView()
      {
         super();
         this.messageTitle.autoSize = TextFieldAutoSize.LEFT;
         this.joinButton.tooltip = TOOLTIPS.FORTIFICATION_SORTIE_LISTROOM_SINGINBTN;
      }
      
      public function update(param1:Object) : void
      {
         var _loc2_:SortieAlertViewVO = SortieAlertViewVO(param1);
         this.alertIcon.addEventListener(UILoaderEvent.COMPLETE,this.onLoadComplete);
         this.alertIcon.source = _loc2_.icon;
         this.messageTitle.htmlText = _loc2_.titleMsg;
         this.messageBody.htmlText = _loc2_.bodyMsg;
         this.joinButton.label = _loc2_.buttonLbl;
         this.messageTitle.x = this.width - this.messageTitle.width >> 1;
         this.messageBody.x = this.width - this.messageBody.width >> 1;
         this.messageBody.height = this.messageBody.textHeight + ADDITIONAL_TEXT_HEIGHT ^ 0;
         this.joinButton.x = this.width - this.joinButton.width >> 1;
         this.joinButton.y = this.messageBody.y + this.messageBody.height + BUTTON_PADDING ^ 0;
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.joinButton.label = FORTIFICATIONS.SORTIE_LISTVIEW_ENTERBTN;
         this.joinButton.addEventListener(ButtonEvent.CLICK,this.onJoinClick);
      }
      
      override protected function onDispose() : void
      {
         this.alertIcon.removeEventListener(UILoaderEvent.COMPLETE,this.onLoadComplete);
         this.alertIcon.dispose();
         this.alertIcon = null;
         this.joinButton.removeEventListener(ButtonEvent.CLICK,this.onJoinClick);
         this.joinButton.dispose();
         this.joinButton = null;
         this.messageTitle = null;
         this.messageBody = null;
         super.onDispose();
      }
      
      private function onLoadComplete(param1:UILoaderEvent) : void
      {
         this.alertIcon.x = this.messageTitle.x - this.alertIcon.width - ICON_PADDING;
      }
      
      protected function onJoinClick(param1:ButtonEvent) : void
      {
         dispatchEvent(new RallyViewsEvent(RallyViewsEvent.JOIN_RALLY_REQUEST));
      }
   }
}
