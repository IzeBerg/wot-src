package net.wg.gui.lobby.battleResults.components
{
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import flash.text.TextFormat;
   import net.wg.data.VO.ProgressElementVO;
   import net.wg.gui.components.controls.TextFieldShort;
   import net.wg.gui.lobby.components.ProgressIndicator;
   import net.wg.gui.lobby.interfaces.ISubtaskComponent;
   import net.wg.infrastructure.base.UIComponentEx;
   import org.idmedia.as3commons.util.StringUtils;
   import scaleform.clik.constants.InvalidationType;
   
   public class ProgressElement extends UIComponentEx implements ISubtaskComponent
   {
      
      private static const PROGRESS_INDICATOR_OFFSET_Y:int = 14;
      
      private static const LABEL_OFFSET_Y:int = -2;
      
      private static const HIT_MC_BOTTOM_MARGIN:int = 3;
      
      private static const STATE_RIGHT:int = 39;
      
      private static const STATUS_TEXT_SIZE:int = 12;
       
      
      public var titleTF:TextFieldShort = null;
      
      public var progressTF:TextFieldShort = null;
      
      public var progressDiff:MovieClip = null;
      
      public var progressIndicator:ProgressIndicator = null;
      
      public var hitMC:Sprite = null;
      
      public var questStatus:PersonalQuestState = null;
      
      private var _data:ProgressElementVO = null;
      
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
         this.titleTF.buttonMode = false;
         this.progressIndicator.visible = false;
      }
      
      override protected function onDispose() : void
      {
         this.progressDiff.removeEventListener(MouseEvent.CLICK,this.onProgressDiffClickHandler);
         this.progressDiff.removeEventListener(MouseEvent.ROLL_OUT,this.onProgressDiffRollOutHandler);
         this.progressDiff.removeEventListener(MouseEvent.ROLL_OVER,this.onProgressDiffRollOverHandler);
         this.progressTF.dispose();
         this.progressTF = null;
         this.questStatus.dispose();
         this.questStatus = null;
         this.titleTF.dispose();
         this.titleTF = null;
         this.progressDiff = null;
         this.hitMC = null;
         this.progressIndicator.dispose();
         this.progressIndicator = null;
         if(this._data)
         {
            this._data.dispose();
            this._data = null;
         }
         super.onDispose();
      }
      
      override protected function draw() : void
      {
         var _loc1_:Boolean = false;
         var _loc2_:TextField = null;
         var _loc3_:TextFormat = null;
         var _loc4_:int = 0;
         super.draw();
         if(isInvalid(InvalidationType.DATA))
         {
            if(this._data != null)
            {
               this.visible = true;
               this.titleTF.label = this._data.title;
               this.progressTF.label = this._data.description;
               _loc1_ = this._data.questState && this._data.questState.statusState;
               if(_loc1_)
               {
                  this.questStatus.update(this._data.questState);
                  this.questStatus.validateNow();
                  _loc2_ = this.questStatus.textField;
                  _loc3_ = _loc2_.getTextFormat();
                  _loc3_.size = STATUS_TEXT_SIZE;
                  _loc2_.setTextFormat(_loc3_);
               }
               else
               {
                  this.progressDiff.textField.text = this._data.progressDiff;
                  this._showProgressDiffTooltip = Boolean(this._data.progressDiff);
                  this.checkProgressIndicator();
               }
               this.progressDiff.visible = !_loc1_;
               this.questStatus.visible = _loc1_;
               invalidateSize();
            }
            else
            {
               this.visible = false;
               setSize(this.width,0);
            }
         }
         if(isInvalid(InvalidationType.SIZE))
         {
            _loc4_ = this.titleTF.label.length > 0 ? int(this.titleTF.height + LABEL_OFFSET_Y) : int(0);
            this.progressDiff.y = this.progressTF.y = _loc4_;
            this.progressIndicator.y = _loc4_ + PROGRESS_INDICATOR_OFFSET_Y;
            this.questStatus.x = width - this.questStatus.width - STATE_RIGHT | 0;
            this.questStatus.y = this.progressDiff.y;
            this.hitMC.height = this.progressIndicator.y + this.progressIndicator.height + HIT_MC_BOTTOM_MARGIN;
            setSize(this.width,this.hitMC.height);
         }
      }
      
      public function disableLinkBtns(param1:Vector.<String>) : void
      {
      }
      
      public function setData(param1:Object) : void
      {
         this._data = new ProgressElementVO(param1);
         invalidateData();
      }
      
      private function checkProgressIndicator() : void
      {
         if(StringUtils.isNotEmpty(this._data.progrBarType))
         {
            this.progressIndicator.visible = true;
            this.progressIndicator.setValues(this._data.progrBarType,this._data.currentProgrVal,this._data.maxProgrVal);
            this.progressIndicator.setTooltip(this._data.progrTooltip);
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
            App.toolTipMgr.show(this._data.progressDiffTooltip);
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
