package net.wg.gui.lobby.retrainCrewWindow
{
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.text.TextField;
   import net.wg.data.constants.IconsTypes;
   import net.wg.data.constants.Linkages;
   import net.wg.gui.components.advanced.DashLine;
   import net.wg.gui.components.containers.HorizontalGroupLayout;
   import net.wg.gui.components.containers.IGroupEx;
   import net.wg.gui.components.controls.IconText;
   import net.wg.gui.interfaces.ISoundButtonEx;
   import net.wg.gui.lobby.profile.components.ColoredDeshLineTextItem;
   import net.wg.gui.lobby.questsWindow.VehicleBlock;
   import net.wg.gui.lobby.questsWindow.components.QuestsDashlineItem;
   import net.wg.gui.utils.VO.PriceVO;
   import net.wg.infrastructure.base.meta.IRetrainCrewWindowMeta;
   import net.wg.infrastructure.base.meta.impl.RetrainCrewWindowMeta;
   import net.wg.infrastructure.interfaces.IWindow;
   import net.wg.utils.ILocale;
   import scaleform.clik.events.ButtonEvent;
   import scaleform.clik.events.IndexEvent;
   import scaleform.clik.utils.Padding;
   
   public class RetrainCrewWindow extends RetrainCrewWindowMeta implements IRetrainCrewWindowMeta
   {
      
      private static const VEHICLE_BLOCK_INVALID:String = "vehBlockInv";
      
      private static const CREW_BLOCK_INVALID:String = "crewBlockInv";
      
      private static const SIDE_PADDING:uint = 12;
      
      private static const RESULT_ICON_PADDING:uint = 19;
      
      private static const NOT_ENOUGH_MONEY_COLOR:uint = 16711680;
      
      private static const SUMM_PATTERN:String = " x ";
      
      private static const SUMM_ZERO_PATTERN:String = "0 x 0";
      
      private static const CANCEL_BTN_ADDITIONAL_HEIGHT:int = 4;
       
      
      public var btnsGroup:RetrainCrewMainButtons;
      
      public var separator:DashLine;
      
      public var txtCrewMembers:TextField;
      
      public var txtPercent:TextField;
      
      public var txtTechnics:TextField;
      
      public var summIconText:IconText;
      
      public var resultIcon:IconText;
      
      public var submitBtn:ISoundButtonEx;
      
      public var cancelBtn:ISoundButtonEx;
      
      public var shadowSeparator:MovieClip;
      
      public var result:ColoredDeshLineTextItem;
      
      public var vehicleBlock:VehicleBlock;
      
      public var rolesGroup:IGroupEx;
      
      private var _initVehicleVO:RetrainVehicleBlockVO;
      
      private var _crewVO:RetrainCrewBlockVO;
      
      private var _crewOperationVO:RetrainCrewOperationVO;
      
      private var _enoughMoneyColor:uint = 16777215;
      
      public function RetrainCrewWindow()
      {
         super();
      }
      
      override public function setWindow(param1:IWindow) : void
      {
         super.setWindow(param1);
         window.title = RETRAIN_CREW.WINDOW_TITLE;
         var _loc2_:Padding = Padding(window.contentPadding);
         var _loc3_:Number = this.cancelBtn.height;
         _loc2_.bottom -= this.shadowSeparator.y + this.shadowSeparator.height - (_loc3_ + this.cancelBtn.y);
         param1.contentPadding = _loc2_;
         var _loc4_:Padding = param1.formBgPadding;
         _loc4_.bottom += _loc3_ + CANCEL_BTN_ADDITIONAL_HEIGHT;
         param1.formBgPadding = _loc4_;
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this._enoughMoneyColor = this.result.valueTextField.textColor;
         this.rolesGroup.layout = new HorizontalGroupLayout();
         this.rolesGroup.itemRendererLinkage = Linkages.RETRAIN_CREW_ROLE_IR_UI;
         this.rolesGroup.addEventListener(Event.RESIZE,this.onRolesGroupResizeHandler,false,0,true);
         var _loc1_:ILocale = App.utils.locale;
         this.submitBtn.label = _loc1_.makeString(RETRAIN_CREW.LABEL_BUTTON_SUBMIT);
         this.submitBtn.addEventListener(ButtonEvent.CLICK,this.onSubmitBtnClickHandler,false,0,true);
         this.cancelBtn.label = _loc1_.makeString(RETRAIN_CREW.LABEL_BUTTON_CANCEL);
         this.cancelBtn.addEventListener(ButtonEvent.CLICK,this.onCancelBtnClickHandler,false,0,true);
         this.txtTechnics.text = _loc1_.makeString(RETRAIN_CREW.LABEL_ONTHETECHNICS);
         this.txtPercent.text = _loc1_.makeString(RETRAIN_CREW.LABEL_EXPERIENCERETENTION);
         this.result.label = _loc1_.makeString(RETRAIN_CREW.LABEL_RESULT);
         this.separator.x = this.result.x = SIDE_PADDING;
         var _loc2_:Number = _width - (SIDE_PADDING << 1);
         this.separator.width = _loc2_;
         this.result.width = _loc2_ - RESULT_ICON_PADDING;
         this.btnsGroup.addEventListener(IndexEvent.INDEX_CHANGE,this.onBtnsGroupIndexChangeHandler,false,0,true);
      }
      
      override protected function draw() : void
      {
         var _loc1_:QuestsDashlineItem = null;
         var _loc2_:ILocale = null;
         var _loc3_:PriceVO = null;
         var _loc4_:uint = 0;
         var _loc5_:Number = NaN;
         var _loc6_:Number = NaN;
         super.draw();
         if(this._initVehicleVO && isInvalid(VEHICLE_BLOCK_INVALID))
         {
            this.vehicleBlock.validateNow();
            _loc1_ = this.vehicleBlock.discountDL;
            _loc1_.validateNow();
            this.vehicleBlock.x = _width - (_loc1_.x + _loc1_.labelTextField.x + _loc1_.labelTextField.textWidth + RESULT_ICON_PADDING) | 0;
         }
         if(this._crewVO && isInvalid(CREW_BLOCK_INVALID))
         {
            this.rolesGroup.dataProvider = this._crewVO.crewInfoVO;
            this.txtCrewMembers.htmlText = this._crewVO.crewMembersText;
            if(this._crewVO.priceInfo)
            {
               _loc2_ = App.utils.locale;
               _loc3_ = this._crewVO.priceInfo;
               _loc4_ = this.rolesGroup.getProviderLength();
               _loc5_ = 0;
               this.resultIcon.icon = this.summIconText.icon = !!_loc3_.isGold ? IconsTypes.GOLD : IconsTypes.CREDITS;
               _loc6_ = _loc3_.price;
               if(this.btnsGroup.selectedId != -1)
               {
                  if(_loc3_.isGold)
                  {
                     _loc5_ = this._crewOperationVO.tankmanCost[this.btnsGroup.selectedId].gold;
                  }
                  else
                  {
                     _loc5_ = this._crewOperationVO.tankmanCost[this.btnsGroup.selectedId].credits;
                  }
                  this.summIconText.text = _loc4_ + SUMM_PATTERN + _loc2_.integer(_loc5_);
                  this.result.valueTextColor = !!this._crewVO.enableSubmitButton ? uint(IconsTypes.getTextColor(this.resultIcon.icon)) : uint(NOT_ENOUGH_MONEY_COLOR);
                  this.submitBtn.enabled = this._crewVO.enableSubmitButton;
               }
               this.result.value = _loc2_.integer(_loc6_);
            }
         }
      }
      
      override protected function onDispose() : void
      {
         this.btnsGroup.removeEventListener(IndexEvent.INDEX_CHANGE,this.onBtnsGroupIndexChangeHandler);
         this.btnsGroup.dispose();
         this.btnsGroup = null;
         this.separator.dispose();
         this.separator = null;
         this.summIconText.dispose();
         this.summIconText = null;
         this.resultIcon.dispose();
         this.resultIcon = null;
         this.submitBtn.removeEventListener(ButtonEvent.CLICK,this.onSubmitBtnClickHandler);
         this.submitBtn.dispose();
         this.submitBtn = null;
         this.cancelBtn.removeEventListener(ButtonEvent.CLICK,this.onCancelBtnClickHandler);
         this.cancelBtn.dispose();
         this.cancelBtn = null;
         this.result.dispose();
         this.result = null;
         this.vehicleBlock.dispose();
         this.vehicleBlock = null;
         this.rolesGroup.removeEventListener(Event.RESIZE,this.onRolesGroupResizeHandler);
         this.rolesGroup.dispose();
         this.rolesGroup = null;
         this.shadowSeparator = null;
         this.txtCrewMembers = null;
         this.txtPercent = null;
         this.txtTechnics = null;
         this._crewVO = null;
         this._initVehicleVO = null;
         this._crewOperationVO = null;
         super.onDispose();
      }
      
      override protected function setCrewOperationData(param1:RetrainCrewOperationVO) : void
      {
         this._crewOperationVO = param1;
         this.btnsGroup.updateRetrainingButtons(this._crewOperationVO.retrainButtons);
      }
      
      override protected function setCrewData(param1:RetrainCrewBlockVO) : void
      {
         this._crewVO = param1;
         invalidate(CREW_BLOCK_INVALID);
      }
      
      override protected function setVehicleData(param1:RetrainVehicleBlockVO) : void
      {
         this._initVehicleVO = param1;
         this.vehicleBlock.setData(this._initVehicleVO);
         invalidate(VEHICLE_BLOCK_INVALID);
      }
      
      private function onBtnsGroupIndexChangeHandler(param1:IndexEvent) : void
      {
         if(param1.index != -1)
         {
            changeRetrainTypeS(param1.index);
         }
         else
         {
            this.summIconText.text = SUMM_ZERO_PATTERN;
            this.result.valueTextColor = this._enoughMoneyColor;
            this.result.value = "0";
            this.submitBtn.enabled = false;
         }
      }
      
      private function onRolesGroupResizeHandler(param1:Event) : void
      {
         this.rolesGroup.x = _width - this.rolesGroup.width - SIDE_PADDING;
      }
      
      private function onSubmitBtnClickHandler(param1:ButtonEvent) : void
      {
         submitS(this.btnsGroup.selectedId);
      }
      
      private function onCancelBtnClickHandler(param1:ButtonEvent) : void
      {
         onWindowCloseS();
      }
   }
}
