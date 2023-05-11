package net.wg.gui.login.EULA
{
   import flash.display.InteractiveObject;
   import flash.events.TextEvent;
   import net.wg.data.constants.Errors;
   import net.wg.gui.components.advanced.TextAreaSimple;
   import net.wg.gui.components.controls.SoundButtonEx;
   import net.wg.infrastructure.base.meta.IEULAMeta;
   import net.wg.infrastructure.base.meta.impl.EULAMeta;
   import net.wg.utils.IAssertable;
   import scaleform.clik.constants.ConstrainMode;
   import scaleform.clik.events.ButtonEvent;
   import scaleform.clik.utils.Constraints;
   import scaleform.clik.utils.Padding;
   
   public class EULADlg extends EULAMeta implements IEULAMeta
   {
       
      
      public var applyButton:SoundButtonEx = null;
      
      public var textArea:TextAreaSimple = null;
      
      public function EULADlg()
      {
         super();
      }
      
      override public final function setViewSize(param1:Number, param2:Number) : void
      {
         _originalWidth = width;
         _originalHeight = height;
         setActualSize(width,height);
         setActualScale(1,1);
      }
      
      override public function updateStage(param1:Number, param2:Number) : void
      {
         if(this.isAutoResize())
         {
            this.updatePosition();
         }
         else
         {
            super.updateStage(param1,param2);
         }
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         App.utils.styleSheetManager.setLinkStyle(this.textArea.textField);
      }
      
      override protected function onInitModalFocus(param1:InteractiveObject) : void
      {
         super.onInitModalFocus(param1);
         setFocus(this.applyButton);
      }
      
      override protected function preInitialize() : void
      {
         constraints = new Constraints(this,ConstrainMode.REFLOW);
      }
      
      override protected function onPopulate() : void
      {
         super.onPopulate();
         window.useBottomBtns = true;
         var _loc1_:Padding = window.contentPadding as Padding;
         App.utils.asserter.assertNotNull(_loc1_,"wndPadding" + Errors.CANT_NULL);
         _loc1_.bottom -= 1;
         window.contentPadding = _loc1_;
         this.applyButton.addEventListener(ButtonEvent.CLICK,this.onApplyBtnClickHandler);
         this.textArea.addEventListener(TextEvent.LINK,this.onLinkClickHandler);
         constraints.addElement(this.applyButton.name,this.applyButton,Constraints.BOTTOM | Constraints.RIGHT);
         window.title = DIALOGS.EULA_TITLE;
         this.updateStage(App.appWidth,App.appHeight);
         requestEULATextS();
      }
      
      override protected function onDispose() : void
      {
         this.applyButton.removeEventListener(ButtonEvent.CLICK,this.onApplyBtnClickHandler);
         this.textArea.removeEventListener(TextEvent.LINK,this.onLinkClickHandler);
         this.textArea.dispose();
         this.textArea = null;
         this.applyButton.dispose();
         this.applyButton = null;
         super.onDispose();
      }
      
      public function as_setEULAText(param1:String) : void
      {
         var _loc5_:Number = NaN;
         var _loc2_:String = "Incorrect invoking as_setEULAText!" + "Method must be call once time only!";
         var _loc3_:IAssertable = App.utils.asserter;
         _loc3_.assertNotNull(this.textArea,"content.textArea in EULADlg" + Errors.CANT_NULL);
         _loc3_.assert(this.textArea.htmlText != param1,_loc2_);
         var _loc4_:Number = height - this.textArea.height;
         this.textArea.htmlText = param1;
         if(this.isAutoResize())
         {
            this.textArea.validateNow();
            if(this.textArea.height - this.textArea.textField.textHeight > 5)
            {
               this.textArea.height = this.textArea.textField.textHeight + 5;
               this.textArea.validateNow();
               _loc5_ = _loc4_ + this.textArea.height;
               this.height = Math.round(_loc5_);
               this.updatePosition();
            }
         }
      }
      
      protected function isAutoResize() : Boolean
      {
         return true;
      }
      
      private function updatePosition() : void
      {
         geometry.setPosition(window);
      }
      
      private function onApplyBtnClickHandler(param1:ButtonEvent) : void
      {
         onApplyS();
      }
      
      private function onLinkClickHandler(param1:TextEvent) : void
      {
         onLinkClickS(param1.text);
      }
   }
}
