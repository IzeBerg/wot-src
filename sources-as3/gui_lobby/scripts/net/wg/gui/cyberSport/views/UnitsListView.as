package net.wg.gui.cyberSport.views
{
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import net.wg.data.constants.generated.CYBER_SPORT_ALIASES;
   import net.wg.data.constants.generated.TOOLTIPS_CONSTANTS;
   import net.wg.data.daapi.base.DAAPIDataClass;
   import net.wg.gui.components.advanced.ViewStack;
   import net.wg.gui.components.advanced.interfaces.IDummy;
   import net.wg.gui.components.advanced.vo.DummyVO;
   import net.wg.gui.components.controls.BlackButton;
   import net.wg.gui.cyberSport.views.unit.IStaticRallyDetailsSection;
   import net.wg.gui.cyberSport.vo.CSCommadDetailsVO;
   import net.wg.gui.cyberSport.vo.CSCommandVO;
   import net.wg.gui.cyberSport.vo.NavigationBlockVO;
   import net.wg.gui.cyberSport.vo.UnitListViewHeaderVO;
   import net.wg.gui.rally.controls.RallyInvalidationType;
   import net.wg.gui.rally.data.ManualSearchDataProvider;
   import net.wg.gui.rally.events.RallyViewsEvent;
   import net.wg.gui.rally.interfaces.IRallyListItemVO;
   import net.wg.gui.rally.interfaces.IRallyVO;
   import net.wg.gui.rally.views.list.BaseRallyDetailsSection;
   import net.wg.gui.rally.vo.RallyShortVO;
   import net.wg.infrastructure.base.meta.IBaseRallyViewMeta;
   import net.wg.infrastructure.base.meta.ICyberSportUnitsListMeta;
   import net.wg.infrastructure.base.meta.impl.CyberSportUnitsListMeta;
   import org.idmedia.as3commons.util.StringUtils;
   import scaleform.clik.data.DataProvider;
   import scaleform.clik.events.ButtonEvent;
   
   public class UnitsListView extends CyberSportUnitsListMeta implements ICyberSportUnitsListMeta, IBaseRallyViewMeta
   {
      
      private static const BTNS_PADDING:Number = 9;
      
      private static const SORT_LBL_PADDING:Number = 5;
      
      private static const HEADER_INV:String = "headerInv";
       
      
      public var sortLabel:TextField = null;
      
      public var refreshBtn:BlackButton = null;
      
      public var detailsViewStack:ViewStack = null;
      
      public var dummy:IDummy = null;
      
      public var previousButton:BlackButton;
      
      public var nextButton:BlackButton;
      
      private var _detailsData:DAAPIDataClass = null;
      
      private var _vehiclesLabel:String = null;
      
      private var _headerDataVO:UnitListViewHeaderVO = null;
      
      public function UnitsListView()
      {
         super();
         listDataProvider = new ManualSearchDataProvider(CSCommandVO);
      }
      
      override public function as_setDetails(param1:Object) : void
      {
         var _loc2_:CSCommadDetailsVO = null;
         _loc2_ = new CSCommadDetailsVO(param1);
         super.as_setDetails(_loc2_.data);
         this.detailsViewStack.visible = true;
         _loc2_.dispose();
      }
      
      override public function as_setVehiclesTitle(param1:String) : void
      {
         super.as_setVehiclesTitle(param1);
         this._vehiclesLabel = param1;
         invalidate(RallyInvalidationType.VEHICLE_LABEL);
      }
      
      override protected function draw() : void
      {
         var _loc1_:BaseRallyDetailsSection = null;
         super.draw();
         if(isInvalid(RallyInvalidationType.VEHICLE_LABEL))
         {
            _loc1_ = this.detailsViewStack.currentView as BaseRallyDetailsSection;
            if(_loc1_ != null)
            {
               _loc1_.vehiclesLabel = this._vehiclesLabel;
            }
         }
         if(this._headerDataVO != null && isInvalid(HEADER_INV))
         {
            createBtn.label = this._headerDataVO.createBtnLabel;
            createBtn.enabled = this._headerDataVO.createBtnEnabled;
            createBtn.mouseEnabled = true;
            titleLbl.htmlText = this._headerDataVO.title;
            if(StringUtils.isNotEmpty(this._headerDataVO.createBtnTooltip))
            {
               createBtn.tooltip = this._headerDataVO.createBtnTooltip;
            }
            rallyTable.headerDP = new DataProvider(App.utils.data.vectorToArray(this._headerDataVO.header));
         }
      }
      
      override protected function convertToRallyVO(param1:Object) : IRallyVO
      {
         return new RallyShortVO(param1);
      }
      
      override protected function getRallyTooltipLinkage() : String
      {
         return TOOLTIPS_CONSTANTS.CYBER_SPORT_TEAM;
      }
      
      override protected function getRallyTooltipData(param1:IRallyListItemVO) : Object
      {
         var _loc2_:CSCommandVO = CSCommandVO(param1);
         return {
            "creatorName":_loc2_.creatorName,
            "rating":_loc2_.rating,
            "description":_loc2_.description
         };
      }
      
      override protected function getRallyViewAlias() : String
      {
         return CYBER_SPORT_ALIASES.UNIT_VIEW_UI;
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.sortLabel.autoSize = TextFieldAutoSize.LEFT;
         this.sortLabel.text = CYBERSPORT.WINDOW_UNITLISTVIEW_SORT_LABEL;
         this.previousButton.iconSource = RES_ICONS.MAPS_ICONS_BUTTONS_ICONUP;
         this.nextButton.iconSource = RES_ICONS.MAPS_ICONS_BUTTONS_ICONDOWN;
         this.previousButton.x = this.sortLabel.x + this.sortLabel.width + SORT_LBL_PADDING;
         this.nextButton.x = this.previousButton.x + this.previousButton.width + BTNS_PADDING;
         this.refreshBtn.label = CYBERSPORT.WINDOW_UNITLISTVIEW_REFRESHLIST;
         this.refreshBtn.addEventListener(ButtonEvent.CLICK,this.onRefreshBtnClickHandler);
         this.refreshBtn.iconSource = RES_ICONS.MAPS_ICONS_LIBRARY_CYBERSPORT_REFRESHICON;
         this.refreshBtn.tooltip = TOOLTIPS.CYBERSPORT_UNITLIST_REFRESH;
         this.previousButton.addEventListener(ButtonEvent.CLICK,this.onPreviousButtonClickHandler);
         this.nextButton.addEventListener(ButtonEvent.CLICK,this.onNextButtonClickHandler);
         this.detailsViewStack.addEventListener(RallyViewsEvent.JOIN_RALLY_REQUEST,this.onJoinRallyRequestHandler);
         this.dummy.visible = false;
         backBtn.tooltip = TOOLTIPS.CYBERSPORT_UNITLEVEL_BACK;
      }
      
      override protected function onDispose() : void
      {
         this.previousButton.removeEventListener(ButtonEvent.CLICK,this.onPreviousButtonClickHandler);
         this.nextButton.removeEventListener(ButtonEvent.CLICK,this.onNextButtonClickHandler);
         this.previousButton.dispose();
         this.nextButton.dispose();
         this.previousButton = null;
         this.nextButton = null;
         this.refreshBtn.removeEventListener(ButtonEvent.CLICK,this.onRefreshBtnClickHandler);
         this.refreshBtn.dispose();
         this.refreshBtn = null;
         this.sortLabel = null;
         this.detailsViewStack.removeEventListener(RallyViewsEvent.JOIN_RALLY_REQUEST,this.onJoinRallyRequestHandler);
         this.detailsViewStack.dispose();
         this.detailsViewStack = null;
         this.dummy.dispose();
         this.dummy = null;
         this.clearDetailsData();
         this._headerDataVO = null;
         super.onDispose();
      }
      
      override protected function coolDownControls(param1:Boolean, param2:int) : void
      {
         this.refreshBtn.enabled = param1;
         super.coolDownControls(param1,param2);
      }
      
      override protected function setHeader(param1:UnitListViewHeaderVO) : void
      {
         this._headerDataVO = param1;
         invalidate(HEADER_INV);
      }
      
      override protected function setDummy(param1:DummyVO) : void
      {
         this.dummy.setData(param1);
      }
      
      override protected function updateNavigationBlock(param1:NavigationBlockVO) : void
      {
         this.nextButton.enabled = param1.nextEnabled;
         this.nextButton.visible = param1.nextVisible;
         this.previousButton.enabled = param1.previousEnabled;
         this.previousButton.visible = param1.previousVisible;
      }
      
      public function as_setDummyVisible(param1:Boolean) : void
      {
         this.dummy.visible = param1;
      }
      
      public function as_updateRallyIcon(param1:String) : void
      {
         var _loc2_:IStaticRallyDetailsSection = this.detailsViewStack.currentView as IStaticRallyDetailsSection;
         App.utils.asserter.assertNotNull(_loc2_,"Calling as_updateRallyIcon for view without icon.");
         _loc2_.updateRallyIcon(param1);
      }
      
      private function clearDetailsData() : void
      {
         if(this._detailsData != null)
         {
            this._detailsData.dispose();
            this._detailsData = null;
         }
      }
      
      private function onRefreshBtnClickHandler(param1:ButtonEvent) : void
      {
         refreshTeamsS();
      }
      
      private function onPreviousButtonClickHandler(param1:ButtonEvent) : void
      {
         loadPreviousS();
      }
      
      private function onNextButtonClickHandler(param1:ButtonEvent) : void
      {
         loadNextS();
      }
      
      private function onJoinRallyRequestHandler(param1:RallyViewsEvent) : void
      {
         joinRallyRequestPerformer(param1);
      }
   }
}
