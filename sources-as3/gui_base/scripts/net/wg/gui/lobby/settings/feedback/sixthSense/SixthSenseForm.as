package net.wg.gui.lobby.settings.feedback.sixthSense
{
   import flash.display.MovieClip;
   import flash.text.TextField;
   import net.wg.data.constants.Linkages;
   import net.wg.data.constants.generated.SIXTHSENSEINDICATOR_CONSTS;
   import net.wg.gui.components.controls.InfoIcon;
   import net.wg.gui.components.controls.LabelControl;
   import net.wg.gui.components.controls.Slider;
   import net.wg.gui.lobby.settings.components.RadioButtonBar;
   import net.wg.gui.lobby.settings.feedback.FeedbackBaseForm;
   import scaleform.clik.constants.InvalidationType;
   
   public class SixthSenseForm extends FeedbackBaseForm
   {
      
      private static const INFO_DELTA:int = 5;
      
      private static const TO_ALPHA_COEFF:Number = 0.01;
       
      
      public var indicatorSizeLabel:TextField = null;
      
      public var indicatorSizeButtonBar:RadioButtonBar = null;
      
      public var indicatorSizeInfoIcon:InfoIcon = null;
      
      public var indicatorAlphaLabel:TextField = null;
      
      public var indicatorAlphaSlider:Slider = null;
      
      public var indicatorAlphaValue:LabelControl = null;
      
      public var indicatorAlphaInfoIcon:InfoIcon = null;
      
      public var indicator:MovieClip = null;
      
      private var _sizeLbl:String = "big";
      
      private var _alphaValue:uint = 100;
      
      public function SixthSenseForm()
      {
         super();
      }
      
      override public function setData(param1:Object) : void
      {
         super.setData(param1);
         this.setIndicatorSize();
         this.setIndicatorAlpha();
      }
      
      override protected function onDispose() : void
      {
         this.indicatorSizeLabel = null;
         this.indicatorSizeButtonBar.dispose();
         this.indicatorSizeButtonBar = null;
         this.indicatorSizeInfoIcon.dispose();
         this.indicatorSizeInfoIcon = null;
         this.indicatorAlphaLabel = null;
         this.indicatorAlphaSlider.dispose();
         this.indicatorAlphaSlider = null;
         this.indicatorAlphaValue.dispose();
         this.indicatorAlphaValue = null;
         this.indicatorAlphaInfoIcon.dispose();
         this.indicatorAlphaInfoIcon = null;
         this.indicator = null;
         super.onDispose();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.indicatorAlphaSlider.maximum = SIXTHSENSEINDICATOR_CONSTS.MAX_VALUE;
         this.indicatorAlphaSlider.minimum = SIXTHSENSEINDICATOR_CONSTS.MIN_VALUE;
         this.indicatorSizeLabel.text = SETTINGS.FEEDBACK_TAB_SIXTHSENSE_SIZE;
         App.utils.commons.updateTextFieldSize(this.indicatorSizeLabel,true,false);
         this.indicatorSizeInfoIcon.icoType = InfoIcon.TYPE_INFO;
         this.indicatorSizeInfoIcon.tooltip = TOOLTIPS.SETTINGS_FEEDBACK_SIXTHSENSE_SIZEINFO;
         this.indicatorSizeInfoIcon.x = this.indicatorSizeLabel.x + this.indicatorSizeLabel.width + INFO_DELTA ^ 0;
         this.indicatorAlphaLabel.text = SETTINGS.FEEDBACK_TAB_SIXTHSENSE_ALPHA;
         App.utils.commons.updateTextFieldSize(this.indicatorAlphaLabel,true,false);
         this.indicatorAlphaInfoIcon.icoType = InfoIcon.TYPE_INFO;
         this.indicatorAlphaInfoIcon.tooltip = TOOLTIPS.SETTINGS_FEEDBACK_SIXTHSENSE_ALPHAINFO;
         this.indicatorAlphaInfoIcon.x = this.indicatorAlphaLabel.x + this.indicatorAlphaLabel.width + INFO_DELTA ^ 0;
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(InvalidationType.SIZE))
         {
            this.indicator.gotoAndStop(this._sizeLbl);
         }
         if(isInvalid(InvalidationType.LAYOUT))
         {
            this.indicator.alpha = this._alphaValue * TO_ALPHA_COEFF;
            this.indicatorAlphaValue.text = this._alphaValue.toString();
         }
      }
      
      override protected function onSliderValueChange(param1:Slider) : void
      {
         super.onSliderValueChange(param1);
         if(param1 == this.indicatorAlphaSlider)
         {
            this.setIndicatorAlpha();
         }
      }
      
      override protected function onButtonBarIndexChange(param1:RadioButtonBar) : void
      {
         super.onButtonBarIndexChange(param1);
         if(param1 == this.indicatorSizeButtonBar)
         {
            this.setIndicatorSize();
         }
      }
      
      private function setIndicatorSize() : void
      {
         var _loc1_:int = int(this.indicatorSizeButtonBar.dataProvider[this.indicatorSizeButtonBar.selectedIndex].data);
         if(_loc1_ >= SIXTHSENSEINDICATOR_CONSTS.SIZES.length)
         {
            this._sizeLbl = SIXTHSENSEINDICATOR_CONSTS.SIZE_BIG;
         }
         else
         {
            this._sizeLbl = SIXTHSENSEINDICATOR_CONSTS.SIZES[_loc1_];
         }
         invalidateSize();
      }
      
      private function setIndicatorAlpha() : void
      {
         this._alphaValue = Math.max(SIXTHSENSEINDICATOR_CONSTS.MIN_VALUE,this.indicatorAlphaSlider.value);
         invalidateLayout();
      }
      
      override public function get formId() : String
      {
         return Linkages.FEEDBACK_SIXTH_SENSE;
      }
   }
}
