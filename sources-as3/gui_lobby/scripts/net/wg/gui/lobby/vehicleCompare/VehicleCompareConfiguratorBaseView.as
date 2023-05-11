package net.wg.gui.lobby.vehicleCompare
{
   import flash.display.DisplayObject;
   import flash.display.InteractiveObject;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import flash.utils.Dictionary;
   import net.wg.gui.interfaces.ISoundButtonEx;
   import net.wg.gui.lobby.techtree.helpers.TweenWrapper;
   import net.wg.gui.lobby.vehicleCompare.configurator.VehConfBottomPanel;
   import net.wg.gui.lobby.vehicleCompare.data.VehicleCompareConfiguratorInitDataVO;
   import net.wg.gui.lobby.vehicleCompare.events.VehConfEvent;
   import net.wg.infrastructure.base.meta.IVehicleCompareConfiguratorBaseViewMeta;
   import net.wg.infrastructure.base.meta.impl.VehicleCompareConfiguratorBaseViewMeta;
   import net.wg.infrastructure.interfaces.IViewStackContent;
   import net.wg.utils.StageSizeBoundaries;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.events.ButtonEvent;
   import scaleform.clik.motion.Tween;
   
   public class VehicleCompareConfiguratorBaseView extends VehicleCompareConfiguratorBaseViewMeta implements IVehicleCompareConfiguratorBaseViewMeta, IViewStackContent
   {
      
      private static const INV_INIT_DATA:String = "InvInitData";
      
      private static const CLOSE_BTN_BORDER_OFFSET:int = 27;
      
      private static const TWEEN_DURATION:int = 150;
       
      
      public var titleTf:TextField;
      
      public var closeBtn:ISoundButtonEx;
      
      public var bottomPanel:VehConfBottomPanel;
      
      protected var _offsets:Dictionary;
      
      private var _initData:VehicleCompareConfiguratorInitDataVO;
      
      private var _newVisibility:Boolean = false;
      
      private var _tweenWrapper:TweenWrapper = null;
      
      private var _tween:Tween = null;
      
      public function VehicleCompareConfiguratorBaseView()
      {
         this._offsets = new Dictionary();
         super();
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         this._offsets[this.titleTf] = new Offsets(38,115);
         alpha = 0;
         this._tweenWrapper = new TweenWrapper(this);
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.titleTf.autoSize = TextFieldAutoSize.CENTER;
         this.closeBtn.addEventListener(ButtonEvent.CLICK,this.onCloseBtnClickHandler);
         this.closeBtn.label = VEH_COMPARE.HEADER_CLOSEBTN_LABEL;
         this.bottomPanel.addEventListener(VehConfEvent.CLOSE_CLICK,this.onBottomPanelCloseClickHandler);
         this.bottomPanel.addEventListener(VehConfEvent.RESET_CLICK,this.onBottomPanelResetClickHandler);
         this.bottomPanel.addEventListener(VehConfEvent.APPLY_CLICK,this.onBottomPanelApplyClickHandler);
      }
      
      override protected function onDispose() : void
      {
         this.clearTween();
         this._tweenWrapper.dispose();
         this._tweenWrapper = null;
         App.utils.data.cleanupDynamicObject(this._offsets);
         this._offsets = null;
         this.bottomPanel.removeEventListener(VehConfEvent.CLOSE_CLICK,this.onBottomPanelCloseClickHandler);
         this.bottomPanel.removeEventListener(VehConfEvent.RESET_CLICK,this.onBottomPanelResetClickHandler);
         this.bottomPanel.removeEventListener(VehConfEvent.APPLY_CLICK,this.onBottomPanelApplyClickHandler);
         this.closeBtn.removeEventListener(ButtonEvent.CLICK,this.onCloseBtnClickHandler);
         this.closeBtn.dispose();
         this.closeBtn = null;
         this.bottomPanel.dispose();
         this.bottomPanel = null;
         this.titleTf = null;
         this._initData = null;
         super.onDispose();
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(this._initData && isInvalid(INV_INIT_DATA))
         {
            this.titleTf.text = this._initData.title;
            this.bottomPanel.setTexts(this._initData.resetBtnLabel,this._initData.resetBtnTooltip,this._initData.cancelBtnLabel,this._initData.cancelBtnTooltip,this._initData.applyBtnLabel,this._initData.applyBtnTooltip);
         }
         if(isInvalid(InvalidationType.SIZE))
         {
            this.updateLayout();
         }
      }
      
      override protected function setInitData(param1:VehicleCompareConfiguratorInitDataVO) : void
      {
         this._initData = param1;
         invalidate(INV_INIT_DATA);
      }
      
      override protected function getVehicleCompareConfiguratorInitDataVOForData(param1:Object) : VehicleCompareConfiguratorInitDataVO
      {
         return new VehicleCompareConfiguratorInitDataVO(param1);
      }
      
      public function as_setApplyEnabled(param1:Boolean) : void
      {
         this.bottomPanel.setApplyEnabled(param1);
      }
      
      public function as_setResetEnabled(param1:Boolean) : void
      {
         this.bottomPanel.setResetEnabled(param1);
      }
      
      public function canShowAutomatically() : Boolean
      {
         return true;
      }
      
      public function getComponentForFocus() : InteractiveObject
      {
         return this;
      }
      
      public function update(param1:Object) : void
      {
      }
      
      protected function updateLayout() : void
      {
         var _loc3_:DisplayObject = null;
         var _loc4_:Offsets = null;
         var _loc5_:int = 0;
         var _loc6_:DisplayObject = null;
         var _loc1_:Number = (App.appHeight - StageSizeBoundaries.HEIGHT_768) / (StageSizeBoundaries.HEIGHT_1080 - StageSizeBoundaries.HEIGHT_768);
         var _loc2_:Vector.<DisplayObject> = this.itemsToLayoutList;
         for each(_loc6_ in _loc2_)
         {
            _loc4_ = this.offsets[_loc6_];
            _loc5_ = Boolean(_loc3_) ? int(_loc3_.y + _loc3_.height) : int(0);
            _loc6_.y = int(_loc5_ + _loc4_.min + (_loc4_.max - _loc4_.min) * _loc1_);
            _loc3_ = _loc6_;
         }
         this.closeBtn.x = width - this.closeBtn.width - CLOSE_BTN_BORDER_OFFSET;
         this.titleTf.x = width - this.titleTf.width >> 1;
      }
      
      private function clearTween() : void
      {
         if(this._tween)
         {
            this._tween.paused = true;
            this._tween.dispose();
            this._tween = null;
         }
      }
      
      private function onHideAnimationComplete(param1:Tween) : void
      {
         super.visible = this._newVisibility;
      }
      
      override public function set visible(param1:Boolean) : void
      {
         if(this._newVisibility == param1)
         {
            return;
         }
         this._newVisibility = param1;
         this.clearTween();
         if(this._newVisibility)
         {
            super.visible = this._newVisibility;
            this._tween = new Tween(TWEEN_DURATION,this._tweenWrapper,{"alpha":1});
         }
         else
         {
            this._tween = new Tween(TWEEN_DURATION,this._tweenWrapper,{"alpha":0},{"onComplete":this.onHideAnimationComplete});
         }
      }
      
      protected function get offsets() : Dictionary
      {
         return this._offsets;
      }
      
      protected function get itemsToLayoutList() : Vector.<DisplayObject>
      {
         return new <DisplayObject>[this.titleTf];
      }
      
      private function onBottomPanelApplyClickHandler(param1:VehConfEvent) : void
      {
         applyConfigS();
      }
      
      private function onBottomPanelResetClickHandler(param1:VehConfEvent) : void
      {
         resetConfigS();
      }
      
      private function onBottomPanelCloseClickHandler(param1:VehConfEvent) : void
      {
         onCloseViewS();
      }
      
      private function onCloseBtnClickHandler(param1:ButtonEvent) : void
      {
         onCloseViewS();
      }
   }
}
