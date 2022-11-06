package net.wg.gui.lobby.components
{
   import flash.text.TextField;
   import net.wg.gui.components.controls.SoundButtonEx;
   import net.wg.gui.events.FiltersEvent;
   import net.wg.gui.lobby.components.data.InfoMessageVO;
   import net.wg.infrastructure.base.UIComponentEx;
   import org.idmedia.as3commons.util.StringUtils;
   import scaleform.clik.events.ButtonEvent;
   
   public class InfoMessageComponent extends UIComponentEx
   {
      
      private static const RETURN_BUTTON_GAP:int = 12;
      
      private static const MESSAGE_TEXT_TOP:int = 27;
      
      private static const TEXT_WIDTH_MAX:int = 480;
       
      
      public var titleTF:TextField;
      
      public var messageTF:TextField;
      
      public var returnBtn:SoundButtonEx;
      
      public function InfoMessageComponent()
      {
         super();
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         this.titleTF.visible = false;
         this.messageTF.visible = false;
         if(this.returnBtn != null)
         {
            this.returnBtn.visible = false;
         }
      }
      
      override protected function onDispose() : void
      {
         if(this.returnBtn != null)
         {
            this.returnBtn.removeEventListener(ButtonEvent.CLICK,this.onReturnButtonClickHandler);
            this.returnBtn.dispose();
            this.returnBtn = null;
         }
         this.titleTF = null;
         this.messageTF = null;
         super.onDispose();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         if(this.returnBtn != null)
         {
            this.returnBtn.addEventListener(ButtonEvent.CLICK,this.onReturnButtonClickHandler,false,0,true);
         }
      }
      
      public function setData(param1:InfoMessageVO) : void
      {
         this.titleTF.visible = !StringUtils.isEmpty(param1.title);
         if(this.titleTF.visible)
         {
            this.titleTF.width = TEXT_WIDTH_MAX;
            this.titleTF.htmlText = param1.title;
         }
         if(this.returnBtn != null)
         {
            this.returnBtn.visible = !StringUtils.isEmpty(param1.returnBtnLabel);
            if(this.returnBtn.visible)
            {
               this.returnBtn.label = param1.returnBtnLabel;
            }
         }
         this.messageTF.width = TEXT_WIDTH_MAX;
         this.messageTF.htmlText = param1.message;
         this.messageTF.visible = true;
         this.doLayout();
      }
      
      protected function doLayout() : void
      {
         App.utils.commons.updateTextFieldSize(this.titleTF,true,true);
         App.utils.commons.updateTextFieldSize(this.messageTF,true,true);
         if(this.titleTF.visible)
         {
            this.messageTF.y = MESSAGE_TEXT_TOP;
         }
         else
         {
            this.messageTF.y = this.titleTF.y | 0;
            this.titleTF.y = this.titleTF.height = 0;
         }
         if(this.returnBtn != null)
         {
            this.returnBtn.y = this.messageTF.y + (!!this.returnBtn.visible ? this.messageTF.height + RETURN_BUTTON_GAP : 0) | 0;
         }
         setSize(this.actualWidth,this.actualHeight);
      }
      
      private function onReturnButtonClickHandler(param1:ButtonEvent) : void
      {
         dispatchEvent(new FiltersEvent(FiltersEvent.RESET_ALL_FILTERS));
      }
   }
}
