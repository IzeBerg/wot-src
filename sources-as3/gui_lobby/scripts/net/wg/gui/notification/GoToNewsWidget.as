package net.wg.gui.notification
{
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import net.wg.data.constants.UniversalBtnStylesConst;
   import net.wg.gui.components.controls.universalBtn.UniversalBtn;
   import net.wg.infrastructure.base.UIComponentEx;
   
   public class GoToNewsWidget extends UIComponentEx
   {
      
      private static const SOUND_BTN_TYPE:String = "iconTextButton";
      
      private static const CHECK_NEWS_BTN_WIDTH:int = 160;
      
      private static const BTN_TEXT_FIELD_PADDING:int = 10;
       
      
      public var onCheckNewsClick:Function = null;
      
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
         this.checkNewsBtn.addEventListener(MouseEvent.CLICK,this.onCheckNewsBtnClickHandler);
         App.utils.universalBtnStyles.setStyle(this.checkNewsBtn,UniversalBtnStylesConst.STYLE_SLIM_BLACK);
      }
      
      override protected function onDispose() : void
      {
         this.onCheckNewsClick = null;
         this.headerTf = null;
         this.checkNewsBtn.removeEventListener(MouseEvent.CLICK,this.onCheckNewsBtnClickHandler);
         this.checkNewsBtn.dispose();
         this.checkNewsBtn = null;
         this.newsBlockBg = null;
         super.onDispose();
      }
      
      public function setCheckNewsBtnEnabled(param1:Boolean) : void
      {
         this.checkNewsBtn.enabled = param1;
      }
      
      private function onCheckNewsBtnClickHandler(param1:MouseEvent) : void
      {
         if(this.onCheckNewsClick != null)
         {
            this.onCheckNewsClick();
         }
      }
   }
}
