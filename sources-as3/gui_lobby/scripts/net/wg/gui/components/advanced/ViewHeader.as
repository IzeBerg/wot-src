package net.wg.gui.components.advanced
{
   import flash.text.TextField;
   import net.wg.gui.components.advanced.events.ViewHeaderEvent;
   import net.wg.gui.components.advanced.interfaces.IBackButton;
   import net.wg.gui.components.advanced.vo.ViewHeaderVO;
   import net.wg.infrastructure.base.UIComponentEx;
   import org.idmedia.as3commons.util.StringUtils;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.events.ButtonEvent;
   
   public class ViewHeader extends UIComponentEx
   {
      
      private static const BACK_BTN_LEFT_OFFSET:int = 16;
       
      
      public var backBtn:IBackButton;
      
      public var titleTf:TextField;
      
      public var descriptionTf:TextField;
      
      public function ViewHeader()
      {
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.backBtn.addEventListener(ButtonEvent.CLICK,this.onBackBtnClickHandler);
         this.backBtn.label = MENU.VIEWHEADER_BACKBTN_LABEL;
         mouseEnabled = false;
         this.titleTf.mouseEnabled = false;
         this.descriptionTf.mouseEnabled = false;
      }
      
      override protected function onDispose() : void
      {
         this.backBtn.removeEventListener(ButtonEvent.CLICK,this.onBackBtnClickHandler);
         this.backBtn.dispose();
         this.backBtn = null;
         this.titleTf = null;
         this.descriptionTf = null;
         super.onDispose();
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(InvalidationType.SIZE))
         {
            this.backBtn.x = BACK_BTN_LEFT_OFFSET;
            this.titleTf.x = _width - this.titleTf.width >> 1;
            this.descriptionTf.x = _width - this.descriptionTf.width >> 1;
         }
      }
      
      public function setDataVo(param1:ViewHeaderVO) : void
      {
         this.title = param1.title;
         this.description = param1.description;
         this.backBtnLabel = param1.backBtnLabel;
         this.backBtnDescription = param1.backBtnDescription;
         this.showBackBtn = param1.showBackBtn;
      }
      
      public function set title(param1:String) : void
      {
         this.titleTf.htmlText = param1;
      }
      
      public function set description(param1:String) : void
      {
         this.descriptionTf.visible = StringUtils.isNotEmpty(param1);
         this.descriptionTf.htmlText = param1;
      }
      
      public function set backBtnLabel(param1:String) : void
      {
         this.backBtn.label = param1;
      }
      
      public function set backBtnDescription(param1:String) : void
      {
         this.backBtn.descrLabel = param1;
      }
      
      public function set showBackBtn(param1:Boolean) : void
      {
         this.backBtn.visible = param1;
      }
      
      private function onBackBtnClickHandler(param1:ButtonEvent) : void
      {
         dispatchEvent(new ViewHeaderEvent(ViewHeaderEvent.BACK_BTN_CLICK));
      }
   }
}
