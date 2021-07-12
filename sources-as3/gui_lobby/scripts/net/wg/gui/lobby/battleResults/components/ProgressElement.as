package net.wg.gui.lobby.battleResults.components
{
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import net.wg.data.VO.ProgressElementVO;
   import net.wg.gui.components.controls.TextFieldShort;
   import net.wg.gui.lobby.components.ProgressIndicator;
   import net.wg.gui.lobby.interfaces.ISubtaskComponent;
   import net.wg.infrastructure.base.UIComponentEx;
   import org.idmedia.as3commons.util.StringUtils;
   import scaleform.clik.constants.InvalidationType;
   
   public class ProgressElement extends UIComponentEx implements ISubtaskComponent
   {
       
      
      public var progressTF:TextFieldShort;
      
      public var progressDiff:MovieClip;
      
      public var progressIndicator:ProgressIndicator;
      
      public var data:ProgressElementVO = null;
      
      private var _showProgressDiffTooltip:Boolean = false;
      
      public function ProgressElement()
      {
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.progressDiff.addEventListener(MouseEvent.CLICK,this.onProgressDiffClickHandler);
         this.progressDiff.addEventListener(MouseEvent.ROLL_OUT,this.onProgressDiffRollOutHandler);
         this.progressDiff.addEventListener(MouseEvent.ROLL_OVER,this.onProgressDiffRollOverHandler);
         this.progressTF.buttonMode = false;
      }
      
      override protected function onDispose() : void
      {
         this.progressDiff.removeEventListener(MouseEvent.CLICK,this.onProgressDiffClickHandler);
         this.progressDiff.removeEventListener(MouseEvent.ROLL_OUT,this.onProgressDiffRollOutHandler);
         this.progressDiff.removeEventListener(MouseEvent.ROLL_OVER,this.onProgressDiffRollOverHandler);
         this.progressTF.dispose();
         this.progressTF = null;
         this.progressDiff = null;
         this.progressIndicator.dispose();
         this.progressIndicator = null;
         if(this.data)
         {
            this.data.dispose();
            this.data = null;
         }
         super.onDispose();
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(InvalidationType.DATA))
         {
            if(this.data != null)
            {
               this.visible = true;
               this.progressTF.label = this.data.description;
               this.progressDiff.textField.text = this.data.progressDiff;
               this._showProgressDiffTooltip = Boolean(this.data.progressDiff);
               this.checkProgressIndicator();
               setSize(this.width,this.height);
            }
            else
            {
               this.visible = false;
               setSize(this.width,0);
            }
         }
      }
      
      public function disableLinkBtns(param1:Vector.<String>) : void
      {
      }
      
      public function setData(param1:Object) : void
      {
         this.data = new ProgressElementVO(param1);
         invalidateData();
      }
      
      private function checkProgressIndicator() : void
      {
         if(StringUtils.isNotEmpty(this.data.progrBarType))
         {
            this.progressIndicator.visible = true;
            this.progressIndicator.setValues(this.data.progrBarType,this.data.currentProgrVal,this.data.maxProgrVal);
            this.progressIndicator.setTooltip(this.data.progrTooltip);
            this.progressIndicator.validateNow();
         }
         else
         {
            this.progressIndicator.visible = false;
         }
      }
      
      private function hideTooltip() : void
      {
         App.toolTipMgr.hide();
      }
      
      private function showDiffTooltip() : void
      {
         if(this._showProgressDiffTooltip)
         {
            App.toolTipMgr.show(this.data.progressDiffTooltip);
         }
      }
      
      private function onProgressDiffClickHandler(param1:MouseEvent) : void
      {
         this.hideTooltip();
      }
      
      private function onProgressDiffRollOutHandler(param1:MouseEvent) : void
      {
         this.hideTooltip();
      }
      
      private function onProgressDiffRollOverHandler(param1:MouseEvent) : void
      {
         this.showDiffTooltip();
      }
   }
}
