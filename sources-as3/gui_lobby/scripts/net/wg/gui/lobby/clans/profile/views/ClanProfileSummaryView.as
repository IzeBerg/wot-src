package net.wg.gui.lobby.clans.profile.views
{
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import net.wg.data.constants.Values;
   import net.wg.data.constants.generated.CLANS_ALIASES;
   import net.wg.gui.components.common.containers.CenterAlignedGroupLayout;
   import net.wg.gui.components.containers.IGroupEx;
   import net.wg.gui.components.controls.HyperLink;
   import net.wg.gui.components.controls.SoundButtonEx;
   import net.wg.gui.lobby.clans.profile.ClanProfileEvent;
   import net.wg.gui.lobby.clans.profile.VOs.ClanProfileSummaryBlockVO;
   import net.wg.gui.lobby.clans.profile.VOs.ClanProfileSummaryLeaguesVO;
   import net.wg.gui.lobby.clans.profile.VOs.ClanProfileSummaryViewStatusVO;
   import net.wg.gui.lobby.clans.profile.VOs.ClanProfileSummaryViewVO;
   import net.wg.gui.lobby.clans.profile.cmp.ClanProfileSummaryBlock;
   import net.wg.gui.lobby.clans.profile.interfaces.IClanProfileSummaryBlock;
   import net.wg.gui.lobby.clans.utils.ClanHelper;
   import net.wg.infrastructure.base.meta.IClanProfileSummaryViewMeta;
   import net.wg.infrastructure.base.meta.impl.ClanProfileSummaryViewMeta;
   import net.wg.infrastructure.managers.ITooltipMgr;
   import net.wg.utils.ICommons;
   import net.wg.utils.IScheduler;
   import org.idmedia.as3commons.util.StringUtils;
   import scaleform.clik.events.ButtonEvent;
   import scaleform.gfx.TextFieldEx;
   
   public class ClanProfileSummaryView extends ClanProfileSummaryViewMeta implements IClanProfileSummaryViewMeta
   {
      
      private static const BLOCK_WIDTH:int = 279;
      
      private static const CLAN_DESCR_Y_POS:int = 345;
      
      private static const CLAN_DESCR_HEIGHT:int = 95;
      
      private static const BLOCK_Y_POSITION:int = 346;
      
      private static const NAVIGATION_BTN_Y_POS:int = 545;
      
      private static const TEXT_FIELD_WIDTH:int = 320;
      
      private static const ADDITIONAL_SPACING:int = 6;
      
      private static const LINK_PADDING:int = 23;
      
      private static const LEAGUES_RENDERER_WIDTH:Number = 80;
      
      private static const LEAGUES_RENDERER_HEIGHT:Number = 80;
      
      private static const LEAGUES_GAP:uint = 20;
      
      private static const INV_LEAGUES:String = "invLeagues";
      
      private static const CLAN_LEAGUE_RENDERER:String = "ClanLeagueRendererUI";
       
      
      public var totalRating:TextField = null;
      
      public var clanDescrTF:TextField = null;
      
      public var generalStatusTF:TextField = null;
      
      public var additionalStatusTF:TextField = null;
      
      public var fortificationBlock:ClanProfileSummaryBlock = null;
      
      public var generalBlock:IClanProfileSummaryBlock = null;
      
      public var globalMapBlock:IClanProfileSummaryBlock = null;
      
      public var fortNavigationBtn:SoundButtonEx = null;
      
      public var clanNavigationBtn:SoundButtonEx = null;
      
      public var personnelNavigationBtn:SoundButtonEx = null;
      
      public var sendRequestBtn:SoundButtonEx = null;
      
      public var gotoGlobalMapLink:HyperLink = null;
      
      public var gotoDetailsGlobalMapLink:HyperLink = null;
      
      public var leaguesGroup:IGroupEx = null;
      
      private var _onePartOfView:int = 0;
      
      private var _mainStatusTooltip:String = "";
      
      private var _totalRatingTooltip:String = "";
      
      private var _model:ClanProfileSummaryViewVO = null;
      
      private var _leaguesModel:ClanProfileSummaryLeaguesVO = null;
      
      private var _clanHelper:ClanHelper = null;
      
      private var _scheduler:IScheduler;
      
      private var _toolTipMgr:ITooltipMgr;
      
      private var _commons:ICommons;
      
      public function ClanProfileSummaryView()
      {
         this._scheduler = App.utils.scheduler;
         this._toolTipMgr = App.toolTipMgr;
         this._commons = App.utils.commons;
         super();
         currentLinkage = CLANS_ALIASES.CLAN_PROFILE_SUMMARY_VIEW_LINKAGE;
         this._clanHelper = new ClanHelper();
         this.fortNavigationBtn.visible = this.clanNavigationBtn.visible = this.personnelNavigationBtn.visible = this.sendRequestBtn.visible = false;
         this.generalStatusTF.visible = this.additionalStatusTF.visible = false;
         this.generalStatusTF.autoSize = TextFieldAutoSize.LEFT;
         this.gotoGlobalMapLink.visible = false;
         this.gotoDetailsGlobalMapLink.visible = false;
         this.leaguesGroup.visible = false;
         this.totalRating.width = TEXT_FIELD_WIDTH;
         this.clanDescrTF.width = TEXT_FIELD_WIDTH;
         TextFieldEx.setVerticalAlign(this.totalRating,TextFieldEx.VALIGN_CENTER);
         TextFieldEx.setVerticalAlign(this.clanDescrTF,TextFieldEx.VALIGN_CENTER);
         TextFieldEx.setVerticalAlign(this.additionalStatusTF,TextFieldEx.VALIGN_BOTTOM);
      }
      
      override public function as_setData(param1:Object) : void
      {
         this.update(param1);
      }
      
      override public function update(param1:Object) : void
      {
         super.update(param1);
         this.cleanUpData();
         this._model = new ClanProfileSummaryViewVO(param1);
         this._totalRatingTooltip = this._model.totalRatingTooltip;
         this.totalRating.htmlText = this._model.totalRating;
         this.clanDescrTF.htmlText = this._model.clanDescription;
         this.fortificationBlock.width = BLOCK_WIDTH;
         this.generalBlock.width = BLOCK_WIDTH;
         this.globalMapBlock.width = BLOCK_WIDTH;
         this.fortNavigationBtn.visible = this._model.isShowFortBtn;
         this.clanNavigationBtn.visible = this._model.isShowClanNavBtn;
         var _loc2_:Boolean = this._model.isShowUrlString;
         var _loc3_:Boolean = this._model.isDetailLinkEnabled;
         if(_loc2_)
         {
            this.gotoGlobalMapLink.label = CLANS.CLANPROFILE_SUMMARYVIEW_LINKS_GOTOMAP;
            this.gotoDetailsGlobalMapLink.label = CLANS.CLANPROFILE_SUMMARYVIEW_LINKS_DETAILSMAP;
            this.gotoGlobalMapLink.addEventListener(ButtonEvent.CLICK,this.onMapLinkClickHandler);
            this.gotoGlobalMapLink.validateNow();
            this.gotoDetailsGlobalMapLink.addEventListener(ButtonEvent.CLICK,this.onDetailsMapClickHandler);
            this.gotoDetailsGlobalMapLink.validateNow();
         }
         this.gotoGlobalMapLink.visible = _loc2_;
         this.gotoDetailsGlobalMapLink.visible = _loc2_ && _loc3_;
         this.leaguesGroup.visible = false;
         this._scheduler.scheduleOnNextFrame(this.repositionGeneralViewElements);
      }
      
      override protected function updateLeaguesBlock(param1:ClanProfileSummaryLeaguesVO) : void
      {
         this._leaguesModel = param1;
         this.fortificationBlock.isLeaguesEnabled = true;
         invalidate(INV_LEAGUES);
      }
      
      override protected function updateFortBlock(param1:ClanProfileSummaryBlockVO) : void
      {
         this.fortificationBlock.update(param1);
      }
      
      override protected function updateGeneralBlock(param1:ClanProfileSummaryBlockVO) : void
      {
         this.generalBlock.update(param1);
      }
      
      override protected function updateGlobalMapBlock(param1:ClanProfileSummaryBlockVO) : void
      {
         this.globalMapBlock.update(param1);
      }
      
      override protected function draw() : void
      {
         if(this._leaguesModel && isInvalid(INV_LEAGUES))
         {
            this.leaguesGroup.visible = true;
            this.leaguesGroup.dataProvider = this._leaguesModel.leagues;
         }
         super.draw();
      }
      
      override protected function onDispose() : void
      {
         this._scheduler.cancelTask(this.repositionGeneralViewElements);
         this.cleanUpData();
         this.removeListeners();
         this._clanHelper.dispose();
         this._clanHelper = null;
         this.generalStatusTF.removeEventListener(MouseEvent.MOUSE_OVER,this.onGeneralStatusTFMouseOverHandler);
         this.generalStatusTF.removeEventListener(MouseEvent.MOUSE_OUT,this.onComponentMouseOutHandler);
         this.generalStatusTF = null;
         this.additionalStatusTF = null;
         this.gotoGlobalMapLink.removeEventListener(ButtonEvent.CLICK,this.onMapLinkClickHandler);
         this.gotoGlobalMapLink.dispose();
         this.gotoGlobalMapLink = null;
         this.gotoDetailsGlobalMapLink.removeEventListener(ButtonEvent.CLICK,this.onDetailsMapClickHandler);
         this.gotoDetailsGlobalMapLink.dispose();
         this.gotoDetailsGlobalMapLink = null;
         this.fortNavigationBtn.dispose();
         this.fortNavigationBtn = null;
         this.clanNavigationBtn.dispose();
         this.clanNavigationBtn = null;
         this.personnelNavigationBtn.dispose();
         this.personnelNavigationBtn = null;
         this.sendRequestBtn.dispose();
         this.sendRequestBtn = null;
         this.totalRating = null;
         this.clanDescrTF = null;
         this._toolTipMgr = null;
         this._scheduler = null;
         this._commons = null;
         this.fortificationBlock.dispose();
         this.fortificationBlock = null;
         this.generalBlock.dispose();
         this.generalBlock = null;
         this.globalMapBlock.dispose();
         this.globalMapBlock = null;
         this.leaguesGroup.dispose();
         this.leaguesGroup = null;
         super.onDispose();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.leaguesGroup.layout = new CenterAlignedGroupLayout(LEAGUES_RENDERER_WIDTH,LEAGUES_RENDERER_HEIGHT);
         this.leaguesGroup.itemRendererLinkage = CLAN_LEAGUE_RENDERER;
         CenterAlignedGroupLayout(this.leaguesGroup.layout).gap = LEAGUES_GAP;
         this.addListeners();
      }
      
      override protected function updateStatus(param1:ClanProfileSummaryViewStatusVO) : void
      {
         this.sendRequestBtn.visible = param1.isShowRequestBtn;
         this.sendRequestBtn.enabled = param1.isEnabledRequestBtn;
         this.personnelNavigationBtn.visible = param1.isShowPersonnelBtn;
         if(StringUtils.isNotEmpty(param1.mainStatus))
         {
            this.generalStatusTF.visible = true;
            this.generalStatusTF.htmlText = param1.mainStatus;
            this.generalStatusTF.addEventListener(MouseEvent.MOUSE_OVER,this.onGeneralStatusTFMouseOverHandler);
            this.generalStatusTF.addEventListener(MouseEvent.MOUSE_OUT,this.onComponentMouseOutHandler);
            this._mainStatusTooltip = param1.tooltip;
         }
         else
         {
            this._mainStatusTooltip = Values.EMPTY_STR;
            this.generalStatusTF.visible = false;
         }
         if(StringUtils.isNotEmpty(param1.additionalStatus))
         {
            this.additionalStatusTF.visible = true;
            this.additionalStatusTF.htmlText = param1.additionalStatus;
         }
         else
         {
            this.additionalStatusTF.visible = false;
         }
         this.updateStatusElements();
      }
      
      override protected function onPopulate() : void
      {
         super.onPopulate();
         this.fortNavigationBtn.label = CLANS.CLANPROFILE_SUMMARYVIEW_BUTTONLBL_NAVIGATION;
         this.clanNavigationBtn.label = CLANS.CLANPROFILE_SUMMARYVIEW_BUTTONLBL_NAVIGATION;
         this.personnelNavigationBtn.label = CLANS.CLANPROFILE_MAINWINDOWTAB_PERSONNEL;
         this.sendRequestBtn.label = CLANS.CLANPROFILE_SUMMARYVIEW_BUTTONLBL_REQUEST;
         this.totalRating.x = this._clanHelper.getPositionOfCenter(this,this.totalRating.width);
         this.clanDescrTF.x = this._clanHelper.getPositionOfCenter(this,this.clanDescrTF.width);
      }
      
      public function repositionGeneralViewElements() : void
      {
         var _loc1_:int = 3;
         this._onePartOfView = this._width / _loc1_ ^ 0;
         this.fortificationBlock.x = this.getLeftPartPosition(this.fortificationBlock.width);
         this.globalMapBlock.x = this._clanHelper.getPositionOfRightPart(this,this._onePartOfView,this.globalMapBlock.width);
         this.generalBlock.x = this._clanHelper.getPositionOfCenter(this,this.generalBlock.width);
         this._commons.updateTextFieldSize(this.clanDescrTF,false,true);
         this.clanDescrTF.y = CLAN_DESCR_Y_POS + (CLAN_DESCR_HEIGHT - this.clanDescrTF.textHeight >> 1);
         var _loc2_:int = !!this.generalStatusTF.visible ? int(this.generalStatusTF.y) : int(this.sendRequestBtn.y);
         var _loc3_:int = _loc2_ - (this.clanDescrTF.y + this.clanDescrTF.height);
         this.generalBlock.y = this.clanDescrTF.y + ADDITIONAL_SPACING + this.clanDescrTF.height + (_loc3_ - this.generalBlock.getDynHeight() >> 1);
         this.fortificationBlock.y = BLOCK_Y_POSITION;
         this.globalMapBlock.y = BLOCK_Y_POSITION;
         this.fortNavigationBtn.x = this.getLeftPartPosition(this.fortNavigationBtn.width);
         this.fortNavigationBtn.y = NAVIGATION_BTN_Y_POS;
         this.clanNavigationBtn.x = this._clanHelper.getPositionOfRightPart(this,this._onePartOfView,this.clanNavigationBtn.width);
         this.clanNavigationBtn.y = NAVIGATION_BTN_Y_POS;
         this.gotoDetailsGlobalMapLink.y = NAVIGATION_BTN_Y_POS - LINK_PADDING;
         this.gotoDetailsGlobalMapLink.x = this._clanHelper.getPositionOfRightPart(this,this._onePartOfView,this.gotoDetailsGlobalMapLink.actualWidth);
         this.gotoGlobalMapLink.y = NAVIGATION_BTN_Y_POS + ADDITIONAL_SPACING;
         this.gotoGlobalMapLink.x = this._clanHelper.getPositionOfRightPart(this,this._onePartOfView,this.gotoGlobalMapLink.actualWidth);
         header.x = this._clanHelper.getPositionOfCenter(this,header.width);
      }
      
      private function addListeners() : void
      {
         this.personnelNavigationBtn.addEventListener(ButtonEvent.CLICK,this.onPersonnelNavigationBtnClickHandler);
         this.totalRating.addEventListener(MouseEvent.MOUSE_OVER,this.onTotalRatingMouseOverHandler);
         this.totalRating.addEventListener(MouseEvent.MOUSE_OUT,this.onComponentMouseOutHandler);
         this.fortNavigationBtn.addEventListener(ButtonEvent.CLICK,this.onFortNavigationBtnClickHandler);
         this.clanNavigationBtn.addEventListener(ButtonEvent.CLICK,this.onClanNavigationBtnClickHandler);
         this.sendRequestBtn.addEventListener(ButtonEvent.CLICK,this.onSendRequestBtnClickHandler);
      }
      
      private function removeListeners() : void
      {
         this.personnelNavigationBtn.removeEventListener(ButtonEvent.CLICK,this.onPersonnelNavigationBtnClickHandler);
         this.totalRating.removeEventListener(MouseEvent.MOUSE_OVER,this.onTotalRatingMouseOverHandler);
         this.totalRating.removeEventListener(MouseEvent.MOUSE_OUT,this.onComponentMouseOutHandler);
         this.fortNavigationBtn.removeEventListener(ButtonEvent.CLICK,this.onFortNavigationBtnClickHandler);
         this.clanNavigationBtn.removeEventListener(ButtonEvent.CLICK,this.onClanNavigationBtnClickHandler);
         this.sendRequestBtn.removeEventListener(ButtonEvent.CLICK,this.onSendRequestBtnClickHandler);
      }
      
      private function cleanUpData() : void
      {
         if(this._model)
         {
            this._model.dispose();
            this._model = null;
         }
         if(this._leaguesModel)
         {
            this._leaguesModel = null;
         }
      }
      
      private function updateStatusElements() : void
      {
         this.sendRequestBtn.x = this._clanHelper.getPositionOfCenter(this,this.sendRequestBtn.width);
         this.sendRequestBtn.y = NAVIGATION_BTN_Y_POS - ADDITIONAL_SPACING;
         this.generalStatusTF.x = this._clanHelper.getPositionOfCenter(this,this.generalStatusTF.width);
         this.additionalStatusTF.x = this._clanHelper.getPositionOfCenter(this,this.additionalStatusTF.width);
         this.personnelNavigationBtn.x = this._clanHelper.getPositionOfCenter(this,this.personnelNavigationBtn.width);
         this.personnelNavigationBtn.y = NAVIGATION_BTN_Y_POS;
      }
      
      private function getLeftPartPosition(param1:int) : int
      {
         return this._onePartOfView - param1 >> 1;
      }
      
      private function dispatchNavigationRequest(param1:String) : void
      {
         dispatchEvent(new ClanProfileEvent(ClanProfileEvent.NAVIGATION_BY_LINKAGE,null,param1));
      }
      
      private function onSendRequestBtnClickHandler(param1:ButtonEvent) : void
      {
         sendRequestHandlerS();
      }
      
      private function onPersonnelNavigationBtnClickHandler(param1:ButtonEvent) : void
      {
         this.dispatchNavigationRequest(CLANS_ALIASES.CLAN_PROFILE_PERSONNEL_VIEW_LINKAGE);
      }
      
      private function onClanNavigationBtnClickHandler(param1:ButtonEvent) : void
      {
         this.dispatchNavigationRequest(CLANS_ALIASES.CLAN_PROFILE_GLOBALMAP_VIEW_LINKAGE);
      }
      
      private function onFortNavigationBtnClickHandler(param1:ButtonEvent) : void
      {
         this.dispatchNavigationRequest(CLANS_ALIASES.CLAN_PROFILE_STRONGHOLDS_VIEW_LINKAGE);
      }
      
      private function onMapLinkClickHandler(param1:ButtonEvent) : void
      {
         hyperLinkGotoMapS();
      }
      
      private function onDetailsMapClickHandler(param1:ButtonEvent) : void
      {
         hyperLinkGotoDetailsMapS();
      }
      
      private function onGeneralStatusTFMouseOverHandler(param1:MouseEvent) : void
      {
         if(this._mainStatusTooltip != Values.EMPTY_STR)
         {
            this._toolTipMgr.showComplex(this._mainStatusTooltip);
         }
      }
      
      private function onComponentMouseOutHandler(param1:MouseEvent) : void
      {
         this._toolTipMgr.hide();
      }
      
      private function onTotalRatingMouseOverHandler(param1:MouseEvent) : void
      {
         if(StringUtils.isNotEmpty(this._totalRatingTooltip))
         {
            this._toolTipMgr.showComplex(this._totalRatingTooltip);
         }
      }
   }
}
