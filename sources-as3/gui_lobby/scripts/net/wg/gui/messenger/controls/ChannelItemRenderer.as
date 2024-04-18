package net.wg.gui.messenger.controls
{
   import flash.text.TextFieldAutoSize;
   import net.wg.gui.components.controls.TextFieldShort;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.events.ComponentEvent;
   
   public class ChannelItemRenderer extends TextFieldShort
   {
       
      
      public function ChannelItemRenderer()
      {
         super();
      }
      
      override public function setData(param1:Object) : void
      {
         visible = param1 != null;
         super.setData(param1);
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         useHtml = true;
      }
      
      override protected function draw() : void
      {
         var _loc1_:Number = NaN;
         visible = data != null;
         if(isInvalid(InvalidationType.STATE))
         {
            if(_newFrame)
            {
               gotoAndPlay(_newFrame);
               _newFrame = null;
            }
            if(focusIndicator && _newFocusIndicatorFrame)
            {
               focusIndicator.gotoAndPlay(_newFocusIndicatorFrame);
               _newFocusIndicatorFrame = null;
            }
            updateAfterStateChange();
            dispatchEvent(new ComponentEvent(ComponentEvent.STATE_CHANGE));
            invalidate(InvalidationType.DATA,InvalidationType.SIZE);
         }
         if(isInvalid(InvalidationType.DATA))
         {
            updateText();
            if(autoSize != TextFieldAutoSize.NONE)
            {
               invalidateSize();
            }
            _toolTip = label;
            if(this.hitTestPoint(stage.mouseX,stage.mouseY,true))
            {
               displayToolTip();
            }
         }
         if(isInvalid(InvalidationType.SIZE))
         {
            if(!preventAutosizing)
            {
               alignForAutoSize();
               setActualSize(_width,_height);
            }
            if(!constraintsDisabled)
            {
               constraints.update(_width,_height);
            }
         }
         if(textField.getLineLength(0) < textField.text.length)
         {
            _loc1_ = textField.getLineLength(0);
            if(_loc1_ < 3)
            {
               _loc1_ = textField.getLineLength(1);
            }
            textField.text = textField.text.substring(0,_loc1_ - 2) + "..";
         }
      }
   }
}
