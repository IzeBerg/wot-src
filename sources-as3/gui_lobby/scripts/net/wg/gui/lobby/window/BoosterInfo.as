package net.wg.gui.lobby.window
{
   import flash.display.InteractiveObject;
   import flash.text.TextField;
   import net.wg.data.constants.Errors;
   import net.wg.gui.components.controls.SoundButtonEx;
   import net.wg.gui.components.controls.UILoaderAlt;
   import net.wg.gui.lobby.moduleInfo.ModuleParameters;
   import net.wg.infrastructure.base.meta.IBoosterInfoMeta;
   import net.wg.infrastructure.base.meta.impl.BoosterInfoMeta;
   import scaleform.clik.events.ButtonEvent;
   import scaleform.clik.utils.Padding;
   
   public class BoosterInfo extends BoosterInfoMeta implements IBoosterInfoMeta
   {
      
      private static const ADDITIONAL_RIGHT_PADDING:int = 10;
      
      private static const MIDDLE_PADDING:uint = 5;
       
      
      public var moduleIcon:UILoaderAlt;
      
      public var moduleName:TextField;
      
      public var moduleParams:ModuleParameters;
      
      public var closeBottomBtn:SoundButtonEx;
      
      public function BoosterInfo()
      {
         super();
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
         if(this.moduleIcon != null)
         {
            this.moduleIcon.dispose();
            this.moduleIcon = null;
         }
         this.moduleName = null;
         if(this.moduleParams != null)
         {
            this.moduleParams.dispose();
            this.moduleParams = null;
         }
         if(this.closeBottomBtn != null)
         {
            this.closeBottomBtn.removeEventListener(ButtonEvent.CLICK,this.onCloseBottomBtnClickHandler);
            this.closeBottomBtn.dispose();
            this.closeBottomBtn = null;
         }
         super.onDispose();
      }
      
      public function as_setBoosterInfo(param1:Object) : void
      {
         var _loc2_:uint = 0;
         window.title = param1.windowTitle;
         if(param1)
         {
            this.moduleName.text = param1.name;
            this.moduleIcon.source = param1.icon;
            this.moduleParams.setParameters(param1.parameters);
            _loc2_ = this.moduleParams.y + this.moduleParams.height;
            this.closeBottomBtn.y = _loc2_ + MIDDLE_PADDING;
            height = _loc2_ + this.closeBottomBtn.height + MIDDLE_PADDING;
         }
      }
      
      private function onCloseBottomBtnClickHandler(param1:ButtonEvent) : void
      {
         onCancelClickS();
      }
   }
}
