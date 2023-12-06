package net.wg.gui.cyberSport.views
{
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import net.wg.data.constants.Values;
   import net.wg.data.constants.generated.CYBER_SPORT_ALIASES;
   import net.wg.data.constants.generated.TOOLTIPS_CONSTANTS;
   import net.wg.gui.components.controls.SoundButtonEx;
   import net.wg.gui.cyberSport.controls.CSVehicleButton;
   import net.wg.gui.cyberSport.controls.events.CSComponentEvent;
   import net.wg.gui.cyberSport.vo.CSIntroViewTextsVO;
   import net.wg.gui.interfaces.ISoundButtonEx;
   import net.wg.gui.rally.events.RallyViewsEvent;
   import net.wg.gui.rally.vo.IntroVehicleVO;
   import net.wg.infrastructure.base.meta.IBaseRallyViewMeta;
   import net.wg.infrastructure.base.meta.ICyberSportIntroMeta;
   import net.wg.infrastructure.base.meta.impl.CyberSportIntroMeta;
   import net.wg.infrastructure.managers.ITooltipFormatter;
   import scaleform.clik.events.ButtonEvent;
   
   public class IntroView extends CyberSportIntroMeta implements ICyberSportIntroMeta, IBaseRallyViewMeta
   {
      
      private static const TEXT_FIELD_BORDER_PADDINGS:Number = 4;
      
      private static const HEADER_OFFSET:Number = -3;
      
      private static const DESCR_OFFSET:Number = -16;
      
      private static const INVALIDATION_SELECTED_VEHICLE_READY:String = "selectedVehicleReady";
      
      private static const INVALIDATION_SELECTED_VEHICLE_BUTTON_ENABLE:String = "selectedVehicleButtonEnable";
      
      private static const INVALIDATION_BACKEND_TEXTS:String = "backendTexts";
       
      
      public var autoMatchBtn:SoundButtonEx;
      
      public var autoTitleLbl:TextField;
      
      public var autoDescrLbl:TextField;
      
      public var vehicleBtnTitleTf:TextField;
      
      public var selectedVehicleBtn:CSVehicleButton;
      
      public var warningIcon:MovieClip;
      
      public var regulationsInfoLbl:TextField = null;
      
      public var rightBlockHeader:TextField = null;
      
      public var rightBlockDescr:TextField = null;
      
      private var _selectedVehicleData:IntroVehicleVO = null;
      
      private var _selectedVehicleIsReady:Boolean = false;
      
      private var _warnTooltip:String = "";
      
      private var _introViewTexts:CSIntroViewTextsVO = null;
      
      private var _originalCreateBtnWidth:Number = 0;
      
      private var _originalCreateBtnX:Number = 0;
      
      private var _originalCreateBtnAutoSize:String = "";
      
      private var _regulationsInfoTooltip:String = "";
      
      public function IntroView()
      {
         super();
      }
      
      override protected function setTexts(param1:CSIntroViewTextsVO) : void
      {
         this._introViewTexts = param1;
         invalidate(INVALIDATION_BACKEND_TEXTS);
      }
      
      override protected function getRallyViewAlias() : String
      {
         return CYBER_SPORT_ALIASES.UNIT_VIEW_UI;
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         titleLbl.x = width - titleLbl.width >> 1;
         titleLbl.autoSize = TextFieldAutoSize.CENTER;
         this.autoMatchBtn.addEventListener(ButtonEvent.CLICK,this.onAutoSearchClickHandler);
         this.autoMatchBtn.addEventListener(MouseEvent.ROLL_OVER,this.onControlRollOverHandler);
         this.autoMatchBtn.addEventListener(MouseEvent.ROLL_OUT,this.onControlRollOutHandler);
         this.selectedVehicleBtn.addEventListener(ButtonEvent.CLICK,this.onSelectedVehicleButtonClickHandler);
         this.selectedVehicleBtn.addEventListener(MouseEvent.ROLL_OVER,this.onControlRollOverHandler);
         this.selectedVehicleBtn.addEventListener(MouseEvent.ROLL_OUT,this.onControlRollOutHandler);
         this.warningIcon.addEventListener(MouseEvent.ROLL_OVER,this.onControlRollOverHandler);
         this.warningIcon.addEventListener(MouseEvent.ROLL_OUT,this.onControlRollOutHandler);
         this.regulationsInfoLbl.addEventListener(MouseEvent.ROLL_OVER,this.onControlRollOverHandler);
         this.regulationsInfoLbl.addEventListener(MouseEvent.ROLL_OUT,this.onControlRollOutHandler);
         createBtn.mouseEnabledOnDisabled = true;
         this._originalCreateBtnWidth = createBtn.width;
         this._originalCreateBtnX = createBtn.x;
         this._originalCreateBtnAutoSize = createBtn.autoSize;
      }
      
      override protected function draw() : void
      {
         super.draw();
         var _loc1_:Boolean = false;
         if(isInvalid(INVALIDATION_SELECTED_VEHICLE_READY))
         {
            this.updateAutoMatchEnability();
            this.updateWarningIconVisibility();
            _loc1_ = true;
         }
         if(!_loc1_ && isInvalid(INVALIDATION_SELECTED_VEHICLE_BUTTON_ENABLE))
         {
            this.updateWarningIconVisibility();
         }
         if(this._introViewTexts)
         {
            if(isInvalid(INVALIDATION_BACKEND_TEXTS))
            {
               titleLbl.htmlText = this._introViewTexts.titleLblText;
               descrLbl.htmlText = this._introViewTexts.descrLblText;
               listRoomTitleLbl.htmlText = this._introViewTexts.listRoomTitleLblText;
               listRoomDescrLbl.htmlText = this._introViewTexts.listRoomDescrLblText;
               listRoomBtn.label = this._introViewTexts.listRoomBtnLabel;
               this.autoTitleLbl.htmlText = this._introViewTexts.autoTitleLblText;
               this.autoDescrLbl.htmlText = this._introViewTexts.autoDescrLblText;
               this.vehicleBtnTitleTf.htmlText = this._introViewTexts.vehicleBtnTitleTfText;
               this.regulationsInfoLbl.htmlText = this._introViewTexts.regulationsInfoText;
               this._regulationsInfoTooltip = this._introViewTexts.regulationsInfoTooltip;
               this.rightBlockHeader.htmlText = this._introViewTexts.rightBlockHeader;
               this.rightBlockDescr.htmlText = this._introViewTexts.rightBlockDescr;
               createBtn.label = this._introViewTexts.rightBlockBtnLbl;
               this.resortBlockItems(createBtn,this.rightBlockHeader,this.rightBlockDescr);
               this.resortBlockItems(listRoomBtn,listRoomTitleLbl,listRoomDescrLbl);
            }
         }
      }
      
      override protected function onDispose() : void
      {
         this.autoMatchBtn.removeEventListener(ButtonEvent.CLICK,this.onAutoSearchClickHandler);
         this.autoMatchBtn.removeEventListener(MouseEvent.ROLL_OVER,this.onControlRollOverHandler);
         this.autoMatchBtn.removeEventListener(MouseEvent.ROLL_OUT,this.onControlRollOutHandler);
         this.selectedVehicleBtn.removeEventListener(ButtonEvent.CLICK,this.onSelectedVehicleButtonClickHandler);
         this.selectedVehicleBtn.removeEventListener(MouseEvent.ROLL_OVER,this.onControlRollOverHandler);
         this.selectedVehicleBtn.removeEventListener(MouseEvent.ROLL_OUT,this.onControlRollOutHandler);
         this.warningIcon.removeEventListener(MouseEvent.ROLL_OVER,this.onControlRollOverHandler);
         this.warningIcon.removeEventListener(MouseEvent.ROLL_OUT,this.onControlRollOutHandler);
         this.regulationsInfoLbl.removeEventListener(MouseEvent.ROLL_OVER,this.onControlRollOverHandler);
         this.regulationsInfoLbl.removeEventListener(MouseEvent.ROLL_OUT,this.onControlRollOutHandler);
         this.autoMatchBtn.dispose();
         this.autoMatchBtn = null;
         this.selectedVehicleBtn.dispose();
         this.selectedVehicleBtn = null;
         this.vehicleBtnTitleTf = null;
         this.warningIcon = null;
         this._selectedVehicleData = null;
         this.autoTitleLbl = null;
         this.autoDescrLbl = null;
         this.regulationsInfoLbl = null;
         this.rightBlockHeader = null;
         this.rightBlockDescr = null;
         this._introViewTexts = null;
         super.onDispose();
      }
      
      override protected function setSelectedVehicle(param1:IntroVehicleVO) : void
      {
         this._selectedVehicleData = param1;
         this._warnTooltip = param1.warnTooltip;
         var _loc2_:Array = [];
         if(this._selectedVehicleIsReady != param1.isReadyVehicle)
         {
            this._selectedVehicleIsReady = param1.isReadyVehicle;
            _loc2_.push(INVALIDATION_SELECTED_VEHICLE_READY);
         }
         this.selectedVehicleBtn.setVehicle(this._selectedVehicleData);
         if(!this.selectedVehicleBtn.enabled)
         {
            this.selectedVehicleBtn.enabled = true;
            _loc2_.push(INVALIDATION_SELECTED_VEHICLE_BUTTON_ENABLE);
         }
         if(_loc2_.length > 0)
         {
            invalidate.apply(null,_loc2_);
         }
      }
      
      public function as_setNoVehicles(param1:String) : void
      {
         this.selectedVehicleBtn.setVehicle(null);
         this._warnTooltip = param1;
         if(this.selectedVehicleBtn.enabled)
         {
            this.selectedVehicleBtn.enabled = false;
            invalidate(INVALIDATION_SELECTED_VEHICLE_BUTTON_ENABLE);
         }
      }
      
      private function resortBlockItems(param1:ISoundButtonEx, param2:TextField, param3:TextField) : void
      {
         param3.height = param3.textHeight + TEXT_FIELD_BORDER_PADDINGS;
         param2.height = param2.textHeight + TEXT_FIELD_BORDER_PADDINGS;
         param3.y = param1.y - param3.textHeight + DESCR_OFFSET;
         param2.y = param3.y - param2.textHeight + HEADER_OFFSET;
      }
      
      private function updateAutoMatchEnability() : void
      {
         this.autoMatchBtn.enabled = this._selectedVehicleIsReady;
         this.autoMatchBtn.mouseEnabledOnDisabled = true;
      }
      
      private function updateWarningIconVisibility() : void
      {
         this.warningIcon.visible = !this._selectedVehicleIsReady || !this.selectedVehicleBtn.enabled;
      }
      
      private function showUnitsListView() : void
      {
         var _loc1_:Object = {
            "alias":CYBER_SPORT_ALIASES.UNITS_LIST_VIEW_UI,
            "itemId":Number.NaN,
            "peripheryID":0,
            "slotIndex":-1
         };
         dispatchEvent(new RallyViewsEvent(RallyViewsEvent.LOAD_VIEW_REQUEST,_loc1_));
      }
      
      private function showWarningTooltip() : void
      {
         var _loc2_:ITooltipFormatter = null;
         var _loc1_:String = Values.EMPTY_STR;
         if(this._selectedVehicleData.state != Values.EMPTY_STR)
         {
            _loc2_ = App.toolTipMgr.getNewFormatter();
            _loc2_.addHeader(this._selectedVehicleData.state);
            _loc2_.addBody(TOOLTIPS.CYBERSPORT_UNIT_SLOT_VEHICLE_NOTREADY_TEMPORALLY_BODY,true);
            _loc1_ = _loc2_.make();
         }
         else
         {
            _loc1_ = this._warnTooltip;
         }
         App.toolTipMgr.showComplex(_loc1_);
      }
      
      override protected function controlRollOverPerformer(param1:MouseEvent = null) : void
      {
         if(param1 == null)
         {
            return;
         }
         var _loc2_:String = Values.EMPTY_STR;
         var _loc3_:String = Values.EMPTY_STR;
         switch(param1.currentTarget)
         {
            case listRoomBtn:
               App.toolTipMgr.showComplex(TOOLTIPS.CYBERSPORT_INTRO_SEARCH_BTN);
               break;
            case createBtn:
               showComplexTooltip(TOOLTIPS.CYBERSPORT_INTRO_CREATE_BTN_HEADER,TOOLTIPS.CYBERSPORT_INTRO_CREATE_BTN_BODY);
               break;
            case this.selectedVehicleBtn:
               if(this.selectedVehicleBtn.enabled)
               {
                  App.toolTipMgr.showSpecial(TOOLTIPS_CONSTANTS.CYBER_SPORT_SELECTED_VEHICLE,null,this._selectedVehicleData.intCD);
               }
               break;
            case this.regulationsInfoLbl:
               App.toolTipMgr.showSpecial(this._regulationsInfoTooltip,null);
               break;
            case this.autoMatchBtn:
               if(this._selectedVehicleIsReady)
               {
                  _loc2_ = CYBERSPORT.WINDOW_INTRO_AUTO_BTN_TOOLTIP_TITLE;
                  _loc3_ = !!this.autoMatchBtn.enabled ? CYBERSPORT.WINDOW_INTRO_AUTO_BTN_TOOLTIP_DESCRIPTION_ENABLED : CYBERSPORT.WINDOW_INTRO_AUTO_BTN_TOOLTIP_DESCRIPTION_DISABLED;
                  showComplexTooltip(_loc2_,_loc3_);
               }
               else
               {
                  this.showWarningTooltip();
               }
               break;
            case this.warningIcon:
               this.showWarningTooltip();
         }
      }
      
      override protected function showListRoom(param1:ButtonEvent) : void
      {
         var _loc2_:Object = {
            "alias":CYBER_SPORT_ALIASES.UNITS_LIST_VIEW_UI,
            "itemId":Number.NaN,
            "peripheryID":0,
            "slotIndex":-1
         };
         dispatchEvent(new RallyViewsEvent(RallyViewsEvent.LOAD_VIEW_REQUEST,_loc2_));
      }
      
      private function onControlRollOutHandler(param1:MouseEvent) : void
      {
         onControlRollOut();
      }
      
      private function onControlRollOverHandler(param1:MouseEvent) : void
      {
         this.controlRollOverPerformer(param1);
      }
      
      private function onAutoSearchClickHandler(param1:ButtonEvent) : void
      {
         dispatchEvent(new CSComponentEvent(CSComponentEvent.SHOW_AUTO_SEARCH_VIEW,{
            "state":CYBER_SPORT_ALIASES.INTRO_VIEW_UI,
            "cmpDescr":[this._selectedVehicleData.intCD]
         }));
      }
      
      private function onSelectedVehicleButtonClickHandler(param1:ButtonEvent) : void
      {
         showSelectorPopupS();
      }
   }
}
