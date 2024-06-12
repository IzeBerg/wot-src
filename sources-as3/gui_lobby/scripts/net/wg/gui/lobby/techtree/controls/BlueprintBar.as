package net.wg.gui.lobby.techtree.controls
{
   import flash.display.BlendMode;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import net.wg.data.constants.generated.TOOLTIPS_CONSTANTS;
   import net.wg.gui.components.controls.SoundButtonEx;
   import net.wg.gui.lobby.techtree.data.ResearchRootVO;
   import net.wg.infrastructure.interfaces.ITutorialCustomComponent;
   import net.wg.infrastructure.managers.ITooltipMgr;
   import scaleform.clik.constants.InvalidationType;
   
   public class BlueprintBar extends SoundButtonEx implements ITutorialCustomComponent
   {
       
      
      public var glowBorder:MovieClip = null;
      
      public var progressBar:BlueprintProgressBar = null;
      
      public var plus:FadeComponent = null;
      
      private var _glowEnabled:Boolean = false;
      
      private var _progressValue:Number = 0;
      
      private var _progressVisible:Boolean = false;
      
      private var _blueprintCanConvert:Boolean = false;
      
      private var _vehicleCD:uint = 0;
      
      private var _toolTipMgr:ITooltipMgr;
      
      public function BlueprintBar()
      {
         this._toolTipMgr = App.toolTipMgr;
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         preventAutosizing = true;
         useHtmlText = true;
         mouseChildren = true;
         App.utils.commons.updateChildrenMouseBehavior(this,false,false);
         this.plus.mouseEnabled = this.plus.buttonMode = true;
         this.plus.addEventListener(MouseEvent.ROLL_OVER,this.onPlusRollOverHandler,false,0,true);
         this.plus.addEventListener(MouseEvent.ROLL_OUT,this.onPlusRollOutHandler,false,0,true);
         this.progressBar.enabled = true;
         textField.blendMode = BlendMode.ADD;
         focusable = false;
      }
      
      override protected function onBeforeDispose() : void
      {
         this.plus.removeEventListener(MouseEvent.ROLL_OVER,this.onPlusRollOverHandler);
         this.plus.removeEventListener(MouseEvent.ROLL_OUT,this.onPlusRollOutHandler);
         super.onBeforeDispose();
      }
      
      override protected function onDispose() : void
      {
         this.glowBorder = null;
         this.progressBar.dispose();
         this.progressBar = null;
         this.plus.dispose();
         this.plus = null;
         this._toolTipMgr = null;
         super.onDispose();
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(InvalidationType.DATA))
         {
            this.glowBorder.visible = this._glowEnabled;
            this.progressBar.scaleX = this._progressValue;
            this.progressBar.completed = this._progressValue >= 1;
            this.progressBar.visible = this._progressVisible;
            this.plus.enabled = this._blueprintCanConvert && enabled && visible;
            this.plus.validateNow();
            if(this.plus.enabled && isReadyForTutorialByDefault())
            {
               tutorialFunctionPointer(this.plus);
            }
         }
      }
      
      override protected function updateDisable() : void
      {
         if(disableMc != null)
         {
            disableMc.x = disabledFillPadding.left;
            disableMc.y = disabledFillPadding.top;
            disableMc.scaleX = 1 / this.scaleX;
            disableMc.scaleY = 1 / this.scaleY;
            disableMc.widthFill = Math.round(this.glowBorder.width * this.scaleX) - disabledFillPadding.horizontal;
            disableMc.heightFill = Math.round(this.glowBorder.height * this.scaleY) - disabledFillPadding.vertical;
            disableMc.visible = !enabled;
         }
      }
      
      override protected function showTooltip() : void
      {
         if(this.plus.enabled && this.plus.hitTestPoint(stage.mouseX,stage.mouseY))
         {
            return;
         }
         this._toolTipMgr.showSpecial(TOOLTIPS_CONSTANTS.BLUEPRINT_INFO,null,this._vehicleCD);
      }
      
      public function generatedUnstoppableEvents() : Boolean
      {
         return true;
      }
      
      public function getTutorialDescriptionName() : String
      {
         return "";
      }
      
      public function needPreventInnerEvents() : Boolean
      {
         return true;
      }
      
      public function setData(param1:ResearchRootVO, param2:uint, param3:Boolean) : void
      {
         label = param1.blueprintLabel;
         this._glowEnabled = param1.bpbGlowEnabled;
         this._blueprintCanConvert = param1.blueprintCanConvert;
         this._progressValue = param1.blueprintProgress;
         this._progressVisible = param3;
         this._vehicleCD = param2;
         invalidateData();
      }
      
      override public function set visible(param1:Boolean) : void
      {
         if(visible != param1)
         {
            super.visible = param1;
            invalidateData();
         }
      }
      
      override public function set enabled(param1:Boolean) : void
      {
         if(enabled != param1)
         {
            super.enabled = param1;
            invalidateData();
         }
      }
      
      private function onPlusRollOverHandler(param1:MouseEvent) : void
      {
         param1.stopImmediatePropagation();
         this._toolTipMgr.showSpecial(TOOLTIPS_CONSTANTS.BLUEPRINT_CONVERT_INFO,null,this._vehicleCD);
      }
      
      private function onPlusRollOutHandler(param1:MouseEvent) : void
      {
         if(hitTestPoint(param1.stageX,param1.stageY))
         {
            this._toolTipMgr.showSpecial(TOOLTIPS_CONSTANTS.BLUEPRINT_INFO,null,this._vehicleCD);
         }
         else
         {
            this._toolTipMgr.hide();
         }
      }
   }
}
