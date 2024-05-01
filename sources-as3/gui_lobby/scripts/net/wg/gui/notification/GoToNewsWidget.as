package net.wg.gui.notification
{
   import flash.display.Sprite;
   import flash.text.TextField;
   import net.wg.data.constants.UniversalBtnStylesConst;
   import net.wg.gui.components.controls.universalBtn.UniversalBtn;
   import net.wg.gui.notification.events.NewsWidgetEvent;
   import net.wg.infrastructure.base.UIComponentEx;
   import scaleform.clik.events.ButtonEvent;
   
   public class GoToNewsWidget extends UIComponentEx
   {
      
      private static const SOUND_BTN_TYPE:String = "iconTextButton";
      
      private static const CHECK_NEWS_BTN_WIDTH:int = 160;
      
      private static const BTN_TEXT_FIELD_PADDING:int = 10;
       
      
      public var headerTf:TextField = null;
      
      public var checkNewsBtn:UniversalBtn = null;
      
      public var newsBlockBg:Sprite = null;
      
      public function GoToNewsWidget()
      {
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.headerTf.text = MESSENGER.LISTVIEW_NEWS_HEADER;
         this.checkNewsBtn.label = MESSENGER.LISTVIEW_NEWS_CHECKNEWSBTN;
         this.checkNewsBtn.soundType = SOUND_BTN_TYPE;
         this.checkNewsBtn.changeSizeOnlyUpwards = true;
         this.checkNewsBtn.width = CHECK_NEWS_BTN_WIDTH;
         this.checkNewsBtn.paddingHorizontal = BTN_TEXT_FIELD_PADDING;
         this.checkNewsBtn.tooltip = TOOLTIPS.LOBY_MESSENGER_LISTVIEW_NEWS_TOOLTIP;
         this.checkNewsBtn.addEventListener(ButtonEvent.CLICK,this.onCheckNewsBtnClickHandler);
         App.utils.universalBtnStyles.setStyle(this.checkNewsBtn,UniversalBtnStylesConst.STYLE_SLIM_BLACK);
      }
      
      override protected function onDispose() : void
      {
         this.headerTf = null;
         this.checkNewsBtn.removeEventListener(ButtonEvent.CLICK,this.onCheckNewsBtnClickHandler);
         this.checkNewsBtn.dispose();
         this.checkNewsBtn = null;
         this.newsBlockBg = null;
         super.onDispose();
      }
      
      public function setCheckNewsBtnEnabled(param1:Boolean) : void
      {
         this.checkNewsBtn.enabled = param1;
      }
      
      private function onCheckNewsBtnClickHandler(param1:ButtonEvent) : void
      {
         dispatchEvent(new NewsWidgetEvent(NewsWidgetEvent.ON_CLICK));
      }
   }
}
