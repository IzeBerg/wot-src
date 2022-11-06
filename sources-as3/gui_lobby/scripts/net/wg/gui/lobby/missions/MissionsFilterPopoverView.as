package net.wg.gui.lobby.missions
{
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.text.TextField;
   import net.wg.gui.components.advanced.DashLine;
   import net.wg.gui.components.controls.CheckBox;
   import net.wg.gui.components.popovers.PopOver;
   import net.wg.gui.components.popovers.PopOverConst;
   import net.wg.gui.interfaces.ISoundButtonEx;
   import net.wg.gui.lobby.missions.data.MissionsFilterPopoverInitVO;
   import net.wg.gui.lobby.missions.data.MissionsFilterPopoverStateVO;
   import net.wg.infrastructure.base.meta.IMissionsFilterPopoverViewMeta;
   import net.wg.infrastructure.base.meta.impl.MissionsFilterPopoverViewMeta;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.events.ButtonEvent;
   
   public class MissionsFilterPopoverView extends MissionsFilterPopoverViewMeta implements IMissionsFilterPopoverViewMeta
   {
      
      private static const PADDING_BOTTOM:Number = 23;
      
      private static const INVALIDATE_STATE_DATA:String = "invalidate_state_data";
       
      
      public var lblTitle:TextField = null;
      
      public var btnDefault:ISoundButtonEx = null;
      
      public var hideUnavailableCheckBox:CheckBox = null;
      
      public var hideDoneCheckBox:CheckBox = null;
      
      public var separator:Sprite = null;
      
      public var separatorDotted:DashLine = null;
      
      private var _stateData:MissionsFilterPopoverStateVO = null;
      
      public function MissionsFilterPopoverView()
      {
         super();
      }
      
      override protected function initLayout() : void
      {
         PopOver(wrapper).isCloseBtnVisible = true;
         popoverLayout.preferredLayout = PopOverConst.ARROW_TOP;
         super.initLayout();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.btnDefault.addEventListener(ButtonEvent.CLICK,this.onBtnDefaultClickHandler);
         this.hideUnavailableCheckBox.addEventListener(ButtonEvent.CLICK,this.onCheckBoxClickHandler);
         this.hideDoneCheckBox.addEventListener(ButtonEvent.CLICK,this.onCheckBoxClickHandler);
         this.separatorDotted.x = 0;
         this.separatorDotted.width = width;
      }
      
      override protected function draw() : void
      {
         var _loc1_:int = 0;
         super.draw();
         if(isInvalid(InvalidationType.SIZE))
         {
            _loc1_ = this.btnDefault.y + this.btnDefault.height + PADDING_BOTTOM;
            setViewSize(width,_loc1_);
            this.btnDefault.x = width - this.btnDefault.width >> 1;
         }
         if(this._stateData && isInvalid(INVALIDATE_STATE_DATA))
         {
            this.hideUnavailableCheckBox.selected = this._stateData.hideUnavailable;
            this.hideDoneCheckBox.selected = this._stateData.hideDone;
         }
      }
      
      override protected function setInitData(param1:MissionsFilterPopoverInitVO) : void
      {
         this.lblTitle.htmlText = param1.titleLabel;
         this.hideUnavailableCheckBox.label = param1.hideUnavailableLabel;
         this.hideDoneCheckBox.label = param1.hideDoneLabel;
         this.btnDefault.label = param1.defaultButtonLabel;
         this.btnDefault.tooltip = param1.defaultButtonTooltip;
      }
      
      override protected function onDispose() : void
      {
         this.btnDefault.removeEventListener(ButtonEvent.CLICK,this.onBtnDefaultClickHandler);
         this.btnDefault.dispose();
         this.btnDefault = null;
         this.hideUnavailableCheckBox.removeEventListener(ButtonEvent.CLICK,this.onCheckBoxClickHandler);
         this.hideUnavailableCheckBox.dispose();
         this.hideUnavailableCheckBox = null;
         this.hideDoneCheckBox.removeEventListener(ButtonEvent.CLICK,this.onCheckBoxClickHandler);
         this.hideDoneCheckBox.dispose();
         this.hideDoneCheckBox = null;
         this.lblTitle = null;
         this.separator = null;
         this.separatorDotted.dispose();
         this.separatorDotted = null;
         this._stateData = null;
         super.onDispose();
      }
      
      override protected function setState(param1:MissionsFilterPopoverStateVO) : void
      {
         this._stateData = param1;
         invalidate(INVALIDATE_STATE_DATA);
      }
      
      public function as_enableDefaultBtn(param1:Boolean) : void
      {
         this.btnDefault.enabled = param1;
      }
      
      private function onBtnDefaultClickHandler(param1:ButtonEvent) : void
      {
         this.hideUnavailableCheckBox.selected = false;
         this.hideDoneCheckBox.selected = false;
         setDefaultFilterS();
      }
      
      private function onCheckBoxClickHandler(param1:Event) : void
      {
         changeFilterS(this.hideUnavailableCheckBox.selected,this.hideDoneCheckBox.selected);
      }
   }
}
