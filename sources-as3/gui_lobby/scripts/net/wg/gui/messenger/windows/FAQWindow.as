package net.wg.gui.messenger.windows
{
   import flash.events.MouseEvent;
   import flash.events.TextEvent;
   import flash.text.TextField;
   import net.wg.gui.components.advanced.TextAreaSimple;
   import net.wg.gui.components.controls.ScrollBar;
   import net.wg.gui.components.controls.SoundButtonEx;
   import net.wg.gui.messenger.meta.IFAQWindowMeta;
   import net.wg.gui.messenger.meta.impl.FAQWindowMeta;
   import scaleform.clik.events.ButtonEvent;
   
   public class FAQWindow extends FAQWindowMeta implements IFAQWindowMeta
   {
       
      
      public var textArea:TextAreaSimple;
      
      public var closeButton:SoundButtonEx;
      
      public var scrollBar:ScrollBar;
      
      private var isLeftButtonClicked:Boolean = false;
      
      public function FAQWindow()
      {
         super();
      }
      
      public function as_appendText(param1:String) : void
      {
         this.textArea.appendHtml(param1);
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         App.utils.styleSheetManager.setLinkStyle(this.textArea.textField);
         var _loc1_:TextField = this.textArea.textField;
         _loc1_.addEventListener(TextEvent.LINK,this.handleLinkClick,false,0,true);
         _loc1_.addEventListener(MouseEvent.CLICK,this.handleMouseClick,false,0,true);
         this.closeButton.addEventListener(ButtonEvent.CLICK,this.handleCancelClick,false,0,true);
      }
      
      override protected function draw() : void
      {
         super.draw();
      }
      
      override protected function onPopulate() : void
      {
         super.onPopulate();
         window.useBottomBtns = true;
         window.title = MESSENGER.LOBBY_FAQ_TITLE;
      }
      
      override protected function onDispose() : void
      {
         var _loc1_:TextField = this.textArea.textField;
         _loc1_.removeEventListener(TextEvent.LINK,this.handleLinkClick,false);
         _loc1_.removeEventListener(MouseEvent.CLICK,this.handleMouseClick,false);
         this.closeButton.removeEventListener(ButtonEvent.CLICK,this.handleCancelClick,false);
         super.onDispose();
      }
      
      private function handleMouseClick(param1:MouseEvent) : void
      {
         this.isLeftButtonClicked = App.utils.commons.isLeftButton(param1);
      }
      
      private function handleLinkClick(param1:TextEvent) : void
      {
         if(this.isLeftButtonClicked)
         {
            onLinkClickedS(param1.text);
         }
      }
      
      private function handleCancelClick(param1:ButtonEvent) : void
      {
         onWindowCloseS();
      }
   }
}
