package net.wg.gui.lobby.window
{
   import flash.display.InteractiveObject;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import net.wg.data.constants.Errors;
   import net.wg.gui.components.controls.SoundButtonEx;
   import net.wg.gui.components.controls.UILoaderAlt;
   import net.wg.gui.data.GoodieInfoVO;
   import net.wg.infrastructure.base.meta.IGoodieInfoMeta;
   import net.wg.infrastructure.base.meta.impl.GoodieInfoMeta;
   import scaleform.clik.events.ButtonEvent;
   import scaleform.clik.utils.Padding;
   
   public class GoodieInfo extends GoodieInfoMeta implements IGoodieInfoMeta
   {
      
      private static const ADDITIONAL_RIGHT_PADDING:int = 5;
       
      
      public var moduleIcon:UILoaderAlt = null;
      
      public var moduleName:TextField = null;
      
      public var moduleDescription:TextField = null;
      
      public var closeBottomBtn:SoundButtonEx = null;
      
      public function GoodieInfo()
      {
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.moduleDescription.autoSize = TextFieldAutoSize.LEFT;
      }
      
      override protected function onInitModalFocus(param1:InteractiveObject) : void
      {
         super.onInitModalFocus(param1);
         setFocus(this.closeBottomBtn);
      }
      
      override protected function onPopulate() : void
      {
         super.onPopulate();
         this.closeBottomBtn.addEventListener(ButtonEvent.CLICK,this.onCloseBottomBtnClickHandler);
         window.useBottomBtns = true;
         var _loc1_:Padding = window.contentPadding as Padding;
         App.utils.asserter.assertNotNull(_loc1_,Errors.CANT_NULL);
         _loc1_.right += ADDITIONAL_RIGHT_PADDING;
         window.contentPadding = _loc1_;
      }
      
      override protected function onDispose() : void
      {
         this.moduleIcon.dispose();
         this.moduleIcon = null;
         this.moduleName = null;
         this.moduleDescription = null;
         this.closeBottomBtn.removeEventListener(ButtonEvent.CLICK,this.onCloseBottomBtnClickHandler);
         this.closeBottomBtn.dispose();
         this.closeBottomBtn = null;
         super.onDispose();
      }
      
      override protected function setInfo(param1:GoodieInfoVO) : void
      {
         if(param1)
         {
            window.title = param1.windowTitle;
            this.moduleName.text = param1.name;
            this.moduleIcon.source = param1.icon;
            this.moduleDescription.text = param1.description;
            height = this.closeBottomBtn.y + this.closeBottomBtn.height;
         }
      }
      
      private function onCloseBottomBtnClickHandler(param1:ButtonEvent) : void
      {
         onCancelClickS();
      }
   }
}
