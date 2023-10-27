package net.wg.gui.lobby.personalMissions.components
{
   import flash.display.InteractiveObject;
   import flash.display.Sprite;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import net.wg.data.VO.DialogSettingsVO;
   import net.wg.gui.components.advanced.DashLine;
   import net.wg.gui.components.controls.UILoaderAlt;
   import net.wg.gui.interfaces.ISoundButtonEx;
   import net.wg.gui.lobby.personalMissions.data.UseAwardSheetWindowVO;
   import net.wg.infrastructure.base.meta.IUseAwardSheetWindowMeta;
   import net.wg.infrastructure.base.meta.impl.UseAwardSheetWindowMeta;
   import net.wg.infrastructure.constants.WindowViewInvalidationType;
   import net.wg.infrastructure.interfaces.IWindow;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.events.ButtonEvent;
   
   public class UseAwardSheetWindow extends UseAwardSheetWindowMeta implements IUseAwardSheetWindowMeta
   {
      
      private static const SETTINGS_INVALID:String = "settingsInv";
      
      private static const DASH_LINE_PADDING:int = 4;
      
      private static const TOP_BLOCK_HEIGHT:int = 26;
      
      private static const BOTTOM_BLOCK_HEIGHT:int = 34;
      
      private static const TF_BOTTOM_PADDING:int = 15;
      
      private static const STATUS_TF_PADDING:int = 30;
      
      private static const CONTROLS_PADDING:int = 10;
       
      
      public var neededLabelTf:TextField = null;
      
      public var neededValueTf:TextField = null;
      
      public var totalLabelTf:TextField = null;
      
      public var totalValueTf:TextField = null;
      
      public var statusTf:TextField = null;
      
      public var icon:UILoaderAlt = null;
      
      public var dashLineNeeded:DashLine = null;
      
      public var dashLineTotal:DashLine = null;
      
      public var dashLineStatus:DashLine = null;
      
      public var submitBtn:ISoundButtonEx = null;
      
      public var cancelBtn:ISoundButtonEx = null;
      
      public var background:Sprite = null;
      
      private var _settingsVO:DialogSettingsVO;
      
      private var _data:UseAwardSheetWindowVO;
      
      public function UseAwardSheetWindow()
      {
         super();
      }
      
      override public function setWindow(param1:IWindow) : void
      {
         super.setWindow(param1);
         if(param1)
         {
            invalidate(SETTINGS_INVALID);
            window.visible = false;
            App.utils.scheduler.scheduleOnNextFrame(this.showAndUpdateWindowSize);
         }
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         showWindowBgForm = false;
         this.neededLabelTf.autoSize = this.totalLabelTf.autoSize = TextFieldAutoSize.LEFT;
         this.neededValueTf.autoSize = this.totalValueTf.autoSize = TextFieldAutoSize.RIGHT;
         this.statusTf.autoSize = TextFieldAutoSize.CENTER;
      }
      
      override protected function onDispose() : void
      {
         this.submitBtn.removeEventListener(ButtonEvent.CLICK,this.onSubmitBtnClickHandler);
         this.cancelBtn.removeEventListener(ButtonEvent.CLICK,this.onCancelBtnClickHandler);
         this.submitBtn.dispose();
         this.submitBtn = null;
         this.cancelBtn.dispose();
         this.cancelBtn = null;
         this.dashLineNeeded.dispose();
         this.dashLineNeeded = null;
         this.dashLineTotal.dispose();
         this.dashLineTotal = null;
         this.dashLineStatus.dispose();
         this.dashLineStatus = null;
         this.icon.dispose();
         this.icon = null;
         this.neededLabelTf = null;
         this.neededValueTf = null;
         this.totalLabelTf = null;
         this.totalValueTf = null;
         this.statusTf = null;
         this.background = null;
         this._settingsVO = null;
         this._data = null;
         super.onDispose();
      }
      
      override protected function setSettings(param1:DialogSettingsVO) : void
      {
         this._settingsVO = param1;
         invalidate(SETTINGS_INVALID);
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(SETTINGS_INVALID) && window != null && this._settingsVO != null)
         {
            window.title = this._settingsVO.title;
            this.submitBtn.label = this._settingsVO.submitBtnLabel;
            this.cancelBtn.label = this._settingsVO.cancelBtnLabel;
         }
         if(this._data != null && isInvalid(InvalidationType.DATA))
         {
            this.neededLabelTf.htmlText = this._data.neededLabel;
            this.neededValueTf.htmlText = this._data.neededValue;
            this.totalLabelTf.htmlText = this._data.totalLabel;
            this.totalValueTf.htmlText = this._data.totalValue;
            this.statusTf.htmlText = this._data.statusText;
            this.icon.source = this._data.icon;
         }
         if(isInvalid(InvalidationType.SIZE))
         {
            this.dashLineNeeded.x = this.neededLabelTf.x + this.neededLabelTf.width + DASH_LINE_PADDING ^ 0;
            this.dashLineNeeded.width = this.neededValueTf.x - this.dashLineNeeded.x ^ 0;
            this.dashLineTotal.x = this.totalLabelTf.x + this.totalLabelTf.width + DASH_LINE_PADDING ^ 0;
            this.dashLineTotal.width = this.totalValueTf.x - this.dashLineTotal.x ^ 0;
            this.dashLineStatus.width = width ^ 0;
         }
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         setFocus(InteractiveObject(this.submitBtn));
         this.submitBtn.addEventListener(ButtonEvent.CLICK,this.onSubmitBtnClickHandler);
         this.cancelBtn.addEventListener(ButtonEvent.CLICK,this.onCancelBtnClickHandler);
      }
      
      override protected function setData(param1:UseAwardSheetWindowVO) : void
      {
         this._data = param1;
         invalidateData();
      }
      
      private function showAndUpdateWindowSize() : void
      {
         var _loc1_:uint = this.statusTf.y + this.statusTf.height;
         var _loc2_:uint = _loc1_ + TOP_BLOCK_HEIGHT + BOTTOM_BLOCK_HEIGHT + TF_BOTTOM_PADDING + STATUS_TF_PADDING;
         var _loc3_:uint = _loc1_ + TF_BOTTOM_PADDING;
         this.background.height = _loc3_;
         this.submitBtn.y = this.cancelBtn.y = _loc3_ + CONTROLS_PADDING;
         window.updateSize(window.width,_loc2_);
         window.visible = true;
         invalidate(WindowViewInvalidationType.POSITION_INVALID);
      }
      
      private function onCancelBtnClickHandler(param1:ButtonEvent) : void
      {
         cancelS();
      }
      
      private function onSubmitBtnClickHandler(param1:ButtonEvent) : void
      {
         acceptS();
      }
   }
}
