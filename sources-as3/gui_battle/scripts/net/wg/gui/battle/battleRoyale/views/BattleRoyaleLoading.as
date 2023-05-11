package net.wg.gui.battle.battleRoyale.views
{
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import net.wg.data.constants.ImageCacheTypes;
   import net.wg.gui.battle.battleRoyale.data.BattleRoyaleEventHeaderVO;
   import net.wg.gui.battle.battleRoyale.views.components.EventViewHeader;
   import net.wg.gui.battle.battleloading.vo.VisualTipInfoVO;
   import net.wg.gui.battle.eventInfoPanel.data.EventInfoPanelVO;
   import net.wg.gui.components.controls.Image;
   import net.wg.infrastructure.base.meta.IBattleRoyaleLoadingMeta;
   import net.wg.infrastructure.base.meta.impl.BattleRoyaleLoadingMeta;
   import net.wg.infrastructure.interfaces.IDAAPIDataClass;
   import scaleform.clik.controls.StatusIndicator;
   
   public class BattleRoyaleLoading extends BattleRoyaleLoadingMeta implements IBattleRoyaleLoadingMeta
   {
      
      private static const HELP_TIP_TEXT_OFFSET_Y:int = 38;
      
      private static const TIP_TEXT_OFFSET_Y:int = 1;
      
      private static const TEXT_BORDERS:int = 4;
      
      private static const BOTTOM_MARGIN:int = -24;
       
      
      public var header:EventViewHeader = null;
      
      public var tipHeader:TextField = null;
      
      public var tipBody:TextField = null;
      
      public var tipImage:Image = null;
      
      public var bottomBG:Sprite = null;
      
      public var loadingBar:StatusIndicator = null;
      
      private var _bottom:Sprite = null;
      
      private var _stageWidth:Number = 0;
      
      private var _stageHeight:Number = 0;
      
      public function BattleRoyaleLoading()
      {
         super();
      }
      
      override public function addVehiclesInfo(param1:IDAAPIDataClass) : void
      {
      }
      
      override public function as_setMapIcon(param1:String) : void
      {
      }
      
      override public function as_setProgress(param1:Number) : void
      {
         this.loadingBar.value = param1;
      }
      
      override public function as_setTip(param1:String) : void
      {
         this.tipBody.htmlText = param1;
      }
      
      override public function as_setTipTitle(param1:String) : void
      {
         this.tipHeader.htmlText = param1;
      }
      
      override public function resetFrags() : void
      {
      }
      
      override public function setArenaInfo(param1:IDAAPIDataClass) : void
      {
      }
      
      override public function setFrags(param1:IDAAPIDataClass) : void
      {
      }
      
      override public function setPersonalStatus(param1:uint) : void
      {
      }
      
      override public function setQuestStatus(param1:IDAAPIDataClass) : void
      {
      }
      
      override public function setUserTags(param1:IDAAPIDataClass) : void
      {
      }
      
      override public function setVehiclesData(param1:IDAAPIDataClass) : void
      {
      }
      
      override public function updateInvitationsStatuses(param1:IDAAPIDataClass) : void
      {
      }
      
      override public function updatePersonalStatus(param1:uint, param2:uint) : void
      {
      }
      
      override public function updatePlayerStatus(param1:IDAAPIDataClass) : void
      {
      }
      
      override public function updateUserTags(param1:IDAAPIDataClass) : void
      {
      }
      
      override public function updateVehicleStatus(param1:IDAAPIDataClass) : void
      {
      }
      
      override public function updateVehiclesData(param1:IDAAPIDataClass) : void
      {
      }
      
      override public function updateVehiclesStat(param1:IDAAPIDataClass) : void
      {
      }
      
      override public function updateStage(param1:Number, param2:Number) : void
      {
         this.header.updateStage(param1,param2);
         this.header.x = param1 >> 1;
         this._stageWidth = param1;
         this._stageHeight = param2;
         this.bottomBG.y = param2;
         this.bottomBG.width = param1;
         this.updateLayout();
      }
      
      override protected function onPopulate() : void
      {
      }
      
      override protected function onDispose() : void
      {
         this.header.dispose();
         this.header = null;
         this.tipHeader = null;
         this.tipBody = null;
         this.loadingBar.dispose();
         this.loadingBar = null;
         removeChild(this._bottom);
         this._bottom = null;
         this.bottomBG = null;
         this.tipImage.removeEventListener(Event.CHANGE,this.onCompleteHandler);
         this.tipImage.dispose();
         this.tipImage = null;
         super.onDispose();
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         this._bottom = new Sprite();
         addChild(this._bottom);
         this.tipHeader.autoSize = TextFieldAutoSize.LEFT;
         this.tipBody.x = -this.tipBody.width >> 1;
         this._bottom.addChild(this.tipHeader);
         this._bottom.addChild(this.tipBody);
         this._bottom.addChild(this.loadingBar);
         this.tipImage.cacheType = ImageCacheTypes.NOT_USE_CACHE;
         this.tipImage.addEventListener(Event.CHANGE,this.onCompleteHandler);
      }
      
      override protected function setVisualTipInfo(param1:VisualTipInfoVO) : void
      {
         this.tipImage.source = param1.tipIcon;
      }
      
      override protected function setEventInfoPanelData(param1:EventInfoPanelVO) : void
      {
      }
      
      override protected function setHeaderData(param1:BattleRoyaleEventHeaderVO) : void
      {
         this.header.setData(param1);
      }
      
      private function updateLayout() : void
      {
         var _loc1_:Number = Math.max(this._stageWidth / this.tipImage.bitmapWidth,this._stageHeight / this.tipImage.bitmapHeight);
         this.tipImage.width = this.tipImage.bitmapWidth * _loc1_ | 0;
         this.tipImage.height = this.tipImage.bitmapHeight * _loc1_ | 0;
         this.tipImage.x = this._stageWidth - this.tipImage.width >> 1;
         this.tipImage.y = this._stageHeight - this.tipImage.height >> 1;
         this._bottom.x = this._stageWidth >> 1;
         this._bottom.y = this._stageHeight - this._bottom.height + BOTTOM_MARGIN;
         this.tipHeader.x = -this.tipHeader.width >> 1;
         this.tipBody.y = this.tipHeader.height + TIP_TEXT_OFFSET_Y;
         this.tipBody.height = this.tipBody.textHeight + TEXT_BORDERS;
         this.loadingBar.y = this.tipBody.y + this.tipBody.height + HELP_TIP_TEXT_OFFSET_Y;
      }
      
      private function onCompleteHandler(param1:Event) : void
      {
         this.updateLayout();
      }
   }
}
