package net.wg.gui.lobby.clans.search
{
   import flash.display.InteractiveObject;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import net.wg.data.constants.Errors;
   import net.wg.data.constants.generated.TOOLTIPS_CONSTANTS;
   import net.wg.gui.components.advanced.AdvancedLineDescrIconText;
   import net.wg.gui.components.advanced.ClanEmblem;
   import net.wg.gui.components.advanced.Dummy;
   import net.wg.gui.components.advanced.vo.DummyVO;
   import net.wg.gui.components.common.waiting.WaitingComponent;
   import net.wg.gui.components.controls.AlertIco;
   import net.wg.gui.interfaces.ISoundButtonEx;
   import net.wg.gui.lobby.clans.search.VOs.ClanSearchInfoDataVO;
   import net.wg.gui.lobby.clans.search.VOs.ClanSearchInfoInitDataVO;
   import net.wg.gui.lobby.clans.search.VOs.ClanSearchInfoStateDataVO;
   import net.wg.infrastructure.base.meta.IClanSearchInfoMeta;
   import net.wg.infrastructure.base.meta.impl.ClanSearchInfoMeta;
   import net.wg.infrastructure.interfaces.IFocusChainContainer;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   import net.wg.utils.IUtils;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.events.ButtonEvent;
   
   public class ClanSearchInfo extends ClanSearchInfoMeta implements IClanSearchInfoMeta, IFocusChainContainer
   {
      
      private static const INV_INIT_DATA:String = "InvInitData";
      
      private static const INV_STATE_DATA:String = "InvStateData";
      
      private static const WIDTH:int = 410;
      
      private static const TEMP_EMBLEM_SIZE:int = 128;
      
      private static const EMBLEM_PLACE_SIZE:int = 112;
      
      private static const INV_EMBLEM_LAYOUT:String = "InvEmblemLayout";
      
      private static const CLAN_NAME_GAP:int = 3;
      
      private static const CLAN_BASE_INFO_PLACE:int = 225;
      
      private static const INV_COMPONENTS_VISIBILITY:String = "InvComponentsVisibility";
       
      
      public var bg:MovieClip = null;
      
      public var waitingCmp:WaitingComponent = null;
      
      public var emblem:ClanEmblem = null;
      
      public var clanNameTF:TextField = null;
      
      public var ratingTitleTF:TextField = null;
      
      public var ratingTF:TextField = null;
      
      public var ratingDescriptionTF:TextField = null;
      
      public var requestSentTF:TextField = null;
      
      public var clanProfileBtn:ISoundButtonEx = null;
      
      public var sendRequestBtn:ISoundButtonEx = null;
      
      public var stat1:AdvancedLineDescrIconText = null;
      
      public var stat2:AdvancedLineDescrIconText = null;
      
      public var stat3:AdvancedLineDescrIconText = null;
      
      public var dummy:Dummy = null;
      
      public var sendRequestAlert:AlertIco = null;
      
      private var _stats:Vector.<AdvancedLineDescrIconText> = null;
      
      private var _infoComponents:Vector.<InteractiveObject> = null;
      
      private var _initData:ClanSearchInfoInitDataVO = null;
      
      private var _stateData:ClanSearchInfoStateDataVO = null;
      
      private var _data:ClanSearchInfoDataVO = null;
      
      private var _rightClanProfileBtnX:int = 0;
      
      private var _utils:IUtils = null;
      
      private var _focusChain:Vector.<InteractiveObject>;
      
      private var _waitingVisible:Boolean = true;
      
      private var _dummyVisible:Boolean = false;
      
      public function ClanSearchInfo()
      {
         this._focusChain = new Vector.<InteractiveObject>();
         super();
         this.refreshFocusChain();
      }
      
      private static function onCmpRollOutHandler(param1:MouseEvent) : void
      {
         App.toolTipMgr.hide();
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(this._initData && isInvalid(INV_INIT_DATA))
         {
            this.ratingDescriptionTF.htmlText = this._initData.ratingDescription;
            this.requestSentTF.htmlText = this._initData.requestSent;
            this.sendRequestBtn.label = this._initData.sendRequestBtnLabel;
            this.clanProfileBtn.label = this._initData.clanProfileBtnLabel;
         }
         if(this._data && isInvalid(InvalidationType.DATA))
         {
            this.updateData();
         }
         if(this._stateData && isInvalid(INV_STATE_DATA))
         {
            this.updateStateData();
         }
         if(isInvalid(INV_EMBLEM_LAYOUT))
         {
            this.updateEmblemLayout();
         }
         if(isInvalid(INV_COMPONENTS_VISIBILITY))
         {
            this.updateComponentsVisibility();
         }
      }
      
      override protected function onDispose() : void
      {
         var _loc1_:IDisposable = null;
         this.removeListeners();
         this.emblem.dispose();
         this.emblem = null;
         this.clanProfileBtn.dispose();
         this.clanProfileBtn = null;
         this.sendRequestBtn.dispose();
         this.sendRequestBtn = null;
         this.waitingCmp.dispose();
         this.waitingCmp = null;
         this.sendRequestAlert.dispose();
         this.sendRequestAlert = null;
         this.dummy.dispose();
         this.dummy = null;
         this.ratingTF = null;
         this.ratingDescriptionTF = null;
         this._infoComponents.splice(0,this._infoComponents.length);
         this._infoComponents = null;
         this._focusChain.splice(0,this._focusChain.length);
         this._focusChain = null;
         for each(_loc1_ in this._stats)
         {
            _loc1_.dispose();
         }
         this._stats.splice(0,this._stats.length);
         this._stats = null;
         this.stat1 = null;
         this.stat2 = null;
         this.stat3 = null;
         this.clanNameTF = null;
         this.ratingTitleTF = null;
         this.requestSentTF = null;
         this._utils = null;
         this._initData = null;
         this._data = null;
         this._stateData = null;
         this.bg = null;
         super.onDispose();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this._utils = App.utils;
         this._stats = new <AdvancedLineDescrIconText>[this.stat1,this.stat2,this.stat3];
         this.sendRequestBtn.mouseEnabledOnDisabled = true;
         this.clanNameTF.wordWrap = true;
         this.clanNameTF.multiline = true;
         this.sendRequestAlert.buttonMode = false;
         this.bg.mouseEnabled = false;
         this.stat1.mouseEnabled = false;
         this.stat2.mouseEnabled = false;
         this.stat3.mouseEnabled = false;
         this.waitingCmp.backgroundVisibility = false;
         this._rightClanProfileBtnX = this.clanProfileBtn.x;
         this.addListeners();
      }
      
      override protected function setData(param1:ClanSearchInfoDataVO) : void
      {
         this._data = param1;
         invalidateData();
      }
      
      override protected function setInitData(param1:ClanSearchInfoInitDataVO) : void
      {
         this._initData = param1;
         invalidate(INV_INIT_DATA);
      }
      
      override protected function setStateData(param1:ClanSearchInfoStateDataVO) : void
      {
         this._stateData = param1;
         invalidate(INV_STATE_DATA);
      }
      
      override protected function onPopulate() : void
      {
         super.onPopulate();
         this._infoComponents = new <InteractiveObject>[this.emblem,this.clanNameTF,this.ratingTitleTF,this.ratingTF,this.ratingDescriptionTF,InteractiveObject(this.clanProfileBtn),this.stat1,this.stat2,this.stat3,this.bg];
      }
      
      override protected function setDummy(param1:DummyVO) : void
      {
         this.dummy.setData(param1);
      }
      
      public function as_setDummyVisible(param1:Boolean) : void
      {
         this._dummyVisible = param1;
         invalidate(INV_COMPONENTS_VISIBILITY);
      }
      
      public function as_setEmblem(param1:String) : void
      {
         this.emblem.setImage(param1);
         invalidate(INV_EMBLEM_LAYOUT);
      }
      
      public function as_setWaitingVisible(param1:Boolean) : void
      {
         this._waitingVisible = param1;
         invalidate(INV_COMPONENTS_VISIBILITY);
      }
      
      public function getFocusChain() : Vector.<InteractiveObject>
      {
         return this._focusChain;
      }
      
      public function setClanId(param1:Number) : void
      {
         requestDataS(param1);
      }
      
      private function updateComponentsVisibility() : void
      {
         var _loc1_:Boolean = !this._waitingVisible && !this._dummyVisible;
         this.contentVisible(_loc1_);
         this.updateRequestControlsVisibility(_loc1_);
         this.waitingCmp.visible = this._waitingVisible;
         this.dummy.visible = this._dummyVisible && !this._waitingVisible;
      }
      
      private function contentVisible(param1:Boolean) : void
      {
         var _loc2_:uint = this._infoComponents.length;
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_)
         {
            this._infoComponents[_loc3_].visible = param1;
            _loc3_++;
         }
      }
      
      private function updateEmblemLayout() : void
      {
         this._utils.commons.updateTextFieldSize(this.ratingTitleTF,false);
         var _loc1_:int = EMBLEM_PLACE_SIZE + CLAN_NAME_GAP + this.clanNameTF.height + this.ratingTitleTF.height >> 0;
         var _loc2_:int = CLAN_BASE_INFO_PLACE - _loc1_ >> 1;
         this.emblem.y = _loc2_ + (EMBLEM_PLACE_SIZE - TEMP_EMBLEM_SIZE >> 1);
         this.clanNameTF.y = _loc2_ + EMBLEM_PLACE_SIZE + CLAN_NAME_GAP;
         this.emblem.x = this.width - TEMP_EMBLEM_SIZE >> 1;
      }
      
      private function removeListeners() : void
      {
         this.sendRequestBtn.removeEventListener(MouseEvent.ROLL_OVER,this.onSendRequestRollOverHandler);
         this.sendRequestBtn.removeEventListener(MouseEvent.ROLL_OUT,onCmpRollOutHandler);
         this.sendRequestAlert.removeEventListener(MouseEvent.ROLL_OVER,this.onSendRequestRollOverHandler);
         this.sendRequestAlert.removeEventListener(MouseEvent.ROLL_OUT,onCmpRollOutHandler);
         this.sendRequestBtn.removeEventListener(ButtonEvent.CLICK,this.onSendRequestBtnClickHandler);
         this.clanProfileBtn.removeEventListener(ButtonEvent.CLICK,this.onClanProfileBtnClickHandler);
         this.ratingTF.removeEventListener(MouseEvent.ROLL_OVER,this.onRatingRollOverHandler);
         this.ratingTF.removeEventListener(MouseEvent.ROLL_OUT,onCmpRollOutHandler);
         this.ratingDescriptionTF.removeEventListener(MouseEvent.ROLL_OVER,this.onRatingRollOverHandler);
         this.ratingDescriptionTF.removeEventListener(MouseEvent.ROLL_OUT,onCmpRollOutHandler);
         this.emblem.removeEventListener(MouseEvent.ROLL_OVER,this.onClanNameEmblemRollOverHandler);
         this.emblem.removeEventListener(MouseEvent.ROLL_OUT,onCmpRollOutHandler);
         this.clanNameTF.removeEventListener(MouseEvent.ROLL_OVER,this.onClanNameEmblemRollOverHandler);
         this.clanNameTF.removeEventListener(MouseEvent.ROLL_OUT,onCmpRollOutHandler);
      }
      
      private function addListeners() : void
      {
         this.sendRequestBtn.addEventListener(MouseEvent.ROLL_OVER,this.onSendRequestRollOverHandler);
         this.sendRequestBtn.addEventListener(MouseEvent.ROLL_OUT,onCmpRollOutHandler);
         this.sendRequestAlert.addEventListener(MouseEvent.ROLL_OVER,this.onSendRequestRollOverHandler);
         this.sendRequestAlert.addEventListener(MouseEvent.ROLL_OUT,onCmpRollOutHandler);
         this.sendRequestBtn.addEventListener(ButtonEvent.CLICK,this.onSendRequestBtnClickHandler);
         this.clanProfileBtn.addEventListener(ButtonEvent.CLICK,this.onClanProfileBtnClickHandler);
         this.ratingTF.addEventListener(MouseEvent.ROLL_OVER,this.onRatingRollOverHandler);
         this.ratingTF.addEventListener(MouseEvent.ROLL_OUT,onCmpRollOutHandler);
         this.ratingDescriptionTF.addEventListener(MouseEvent.ROLL_OVER,this.onRatingRollOverHandler);
         this.ratingDescriptionTF.addEventListener(MouseEvent.ROLL_OUT,onCmpRollOutHandler);
         this.emblem.addEventListener(MouseEvent.ROLL_OVER,this.onClanNameEmblemRollOverHandler);
         this.emblem.addEventListener(MouseEvent.ROLL_OUT,onCmpRollOutHandler);
         this.clanNameTF.addEventListener(MouseEvent.ROLL_OVER,this.onClanNameEmblemRollOverHandler);
         this.clanNameTF.addEventListener(MouseEvent.ROLL_OUT,onCmpRollOutHandler);
      }
      
      private function updateStateData() : void
      {
         this.updateRequestControlsVisibility(!this._waitingVisible && !this._dummyVisible);
         this.sendRequestBtn.enabled = this._stateData.sendRequestBtnEnabled;
         if(this._stateData.sendRequestBtnVisible || this._stateData.requestSentVisible)
         {
            this.clanProfileBtn.x = this._rightClanProfileBtnX;
         }
         else
         {
            this.clanProfileBtn.x = this.width - this.clanProfileBtn.width >> 1;
         }
      }
      
      private function updateRequestControlsVisibility(param1:Boolean) : void
      {
         param1 = param1 && this._stateData != null;
         this.sendRequestBtn.visible = param1 && this._stateData.sendRequestBtnVisible;
         this.requestSentTF.visible = param1 && this._stateData.requestSentVisible;
         this.sendRequestAlert.visible = param1 && this._stateData.alertIconVisible;
      }
      
      private function updateData() : void
      {
         this._utils.commons.truncateTextFieldText(this.clanNameTF,this._data.clanName,false);
         this.ratingTitleTF.htmlText = this._data.ratingTitle;
         this.ratingTF.htmlText = this._data.rating;
         var _loc1_:uint = this._stats.length;
         this._utils.asserter.assertNotNull(this._data.stats,"_data.stats " + Errors.CANT_NULL);
         this._utils.asserter.assert(this._data.stats.length == _loc1_,"Stats length should be " + _loc1_);
         var _loc2_:int = 0;
         while(_loc2_ < _loc1_)
         {
            this._stats[_loc2_].setData(this._data.stats[_loc2_]);
            _loc2_++;
         }
         invalidate(INV_EMBLEM_LAYOUT);
      }
      
      private function refreshFocusChain() : void
      {
         this._focusChain.splice(0,this._focusChain.length);
         this._focusChain.push(this.sendRequestBtn);
         this._focusChain.push(this.clanProfileBtn);
      }
      
      override public function get width() : Number
      {
         return WIDTH;
      }
      
      private function onRatingRollOverHandler(param1:MouseEvent) : void
      {
         App.toolTipMgr.showComplex(this._initData.ratingTooltip);
      }
      
      private function onClanProfileBtnClickHandler(param1:ButtonEvent) : void
      {
         openClanProfileS();
      }
      
      private function onSendRequestBtnClickHandler(param1:ButtonEvent) : void
      {
         sendRequestS();
      }
      
      private function onSendRequestRollOverHandler(param1:MouseEvent) : void
      {
         if(this._stateData)
         {
            App.toolTipMgr.showComplex(this._stateData.sendRequestTooltip);
         }
      }
      
      private function onClanNameEmblemRollOverHandler(param1:MouseEvent) : void
      {
         if(this._data)
         {
            App.toolTipMgr.showSpecial(TOOLTIPS_CONSTANTS.CLAN_COMMON_INFO,null,this._data.clanId);
         }
      }
   }
}
