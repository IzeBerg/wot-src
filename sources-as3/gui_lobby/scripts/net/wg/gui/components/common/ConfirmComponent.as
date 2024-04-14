package net.wg.gui.components.common
{
   import flash.text.TextField;
   import net.wg.data.VO.ConfirmDialogVO;
   import net.wg.gui.components.controls.CheckBox;
   import net.wg.gui.components.controls.SoundButtonEx;
   import net.wg.infrastructure.base.UIComponentEx;
   import net.wg.infrastructure.interfaces.entity.IUpdatable;
   import scaleform.clik.constants.InvalidationType;
   
   public class ConfirmComponent extends UIComponentEx implements IUpdatable
   {
      
      private static const TEXT_HEIGHT_PADDING:uint = 3;
      
      private static const TEXT_ANTIALIAS_PADDING:uint = 5;
      
      private static const CHECK_BOX_HEIGHT_PADDING:uint = 8;
      
      private static const ADDITIONAL_MULTI_LINE_PADDING:uint = 10;
      
      private static const BOTTOM_PADDING:uint = 5;
       
      
      public var submitBtn:SoundButtonEx = null;
      
      public var cancelBtn:SoundButtonEx = null;
      
      public var checkBox:CheckBox = null;
      
      public var description:TextField = null;
      
      private var _minHeight:int;
      
      private const MIN_HEIGHT:int = 115;
      
      public function ConfirmComponent()
      {
         this._minHeight = this.MIN_HEIGHT;
         super();
      }
      
      override protected function onDispose() : void
      {
         this.submitBtn.dispose();
         this.submitBtn = null;
         this.cancelBtn.dispose();
         this.cancelBtn = null;
         this.checkBox.dispose();
         this.checkBox = null;
         this.description = null;
         super.onDispose();
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(InvalidationType.SIZE))
         {
            this.updateLayout();
         }
      }
      
      public function update(param1:Object) : void
      {
         var _loc2_:ConfirmDialogVO = ConfirmDialogVO(param1);
         this.description.text = _loc2_.description;
         this.submitBtn.label = _loc2_.submitBtnLabel;
         this.cancelBtn.label = _loc2_.cancelBtnLabel;
         this.checkBox.label = _loc2_.checkBoxLabel;
         this.checkBox.selected = _loc2_.checkBoxSelected;
         invalidateSize();
      }
      
      protected function getTextAreaCurrentHeight() : int
      {
         return Math.ceil(this.description.y + this.description.textHeight + ADDITIONAL_MULTI_LINE_PADDING);
      }
      
      protected function getTextAreaMinHeight() : int
      {
         return Math.ceil(this._minHeight - this.getButtonHeight() - TEXT_HEIGHT_PADDING);
      }
      
      protected function getTextActualHeight() : int
      {
         return Math.max(this.getTextAreaCurrentHeight(),this.getTextAreaMinHeight());
      }
      
      private function updateLayout() : void
      {
         this.description.height = this.description.textHeight + TEXT_ANTIALIAS_PADDING;
         this.checkBox.y = this.getTextActualHeight() + TEXT_HEIGHT_PADDING;
         var _loc1_:int = this.checkBox.y + this.checkBox.height + CHECK_BOX_HEIGHT_PADDING;
         this.submitBtn.y = _loc1_;
         this.cancelBtn.y = _loc1_;
      }
      
      private function getButtonHeight() : int
      {
         return this.checkBox.height + CHECK_BOX_HEIGHT_PADDING + this.submitBtn.height + BOTTOM_PADDING >> 0;
      }
      
      override public function get height() : Number
      {
         return this.getTextActualHeight() + TEXT_HEIGHT_PADDING + this.getButtonHeight();
      }
   }
}
