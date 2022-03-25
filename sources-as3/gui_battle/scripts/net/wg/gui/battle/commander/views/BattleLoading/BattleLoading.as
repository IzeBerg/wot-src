package net.wg.gui.battle.commander.views.BattleLoading
{
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.text.TextField;
   import net.wg.data.constants.ImageCacheTypes;
   import net.wg.gui.battle.battleloading.BaseBattleLoading;
   import net.wg.gui.battle.battleloading.vo.VisualTipInfoVO;
   import net.wg.gui.battle.eventInfoPanel.data.EventInfoPanelVO;
   import net.wg.gui.components.controls.Image;
   import net.wg.infrastructure.interfaces.IDAAPIDataClass;
   import scaleform.clik.controls.StatusIndicator;
   
   public class BattleLoading extends BaseBattleLoading
   {
      
      private static const HELP_TIP_TEXT_OFFSET_Y:int = 38;
      
      private static const TEXT_BORDERS:int = 4;
      
      private static const BOTTOM_MARGIN:int = -24;
       
      
      public var tipText:TextField = null;
      
      public var tipImage:Image = null;
      
      public var bottomBG:Sprite = null;
      
      public var topBG:Sprite = null;
      
      public var loadingBar:StatusIndicator = null;
      
      private var _bottom:Sprite = null;
      
      private var _stageWidth:Number = 0;
      
      private var _stageHeight:Number = 0;
      
      public function BattleLoading()
      {
         super();
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         this._bottom = new Sprite();
         addChild(this._bottom);
         this.tipText.x = -this.tipText.width >> 1;
         this._bottom.addChild(this.tipText);
         this._bottom.addChild(this.loadingBar);
         this.tipImage.cacheType = ImageCacheTypes.NOT_USE_CACHE;
         this.tipImage.addEventListener(Event.CHANGE,this.onCompleteHandler);
      }
      
      override protected function onDispose() : void
      {
         this._bottom.removeChild(this.tipText);
         this._bottom.removeChild(this.loadingBar);
         removeChild(this._bottom);
         this._bottom = null;
         this.tipImage.removeEventListener(Event.CHANGE,this.onCompleteHandler);
         this.tipImage.dispose();
         this.tipImage = null;
         this.loadingBar.dispose();
         this.loadingBar = null;
         this.tipText = null;
         this.bottomBG = null;
         this.topBG = null;
         super.onDispose();
      }
      
      override public function as_setProgress(param1:Number) : void
      {
         this.loadingBar.value = param1;
      }
      
      override public function as_setTip(param1:String) : void
      {
         this.tipText.text = param1;
      }
      
      override protected function setVisualTipInfo(param1:VisualTipInfoVO) : void
      {
         this.tipImage.source = param1.tipIcon;
      }
      
      override public function updateStage(param1:Number, param2:Number) : void
      {
         this._stageWidth = param1;
         this._stageHeight = param2;
         this.bottomBG.y = param2;
         this.bottomBG.width = param1;
         this.topBG.width = param1;
         this.updateLayout();
      }
      
      override public function getContentY() : int
      {
         return 0;
      }
      
      override public function updateVehiclesStat(param1:IDAAPIDataClass) : void
      {
      }
      
      override public function updateVehicleStatus(param1:IDAAPIDataClass) : void
      {
      }
      
      override public function setFrags(param1:IDAAPIDataClass) : void
      {
      }
      
      override public function as_setMapIcon(param1:String) : void
      {
      }
      
      override public function setArenaInfo(param1:IDAAPIDataClass) : void
      {
      }
      
      override public function setUserTags(param1:IDAAPIDataClass) : void
      {
      }
      
      override public function as_setTipTitle(param1:String) : void
      {
      }
      
      override public function updatePersonalStatus(param1:uint, param2:uint) : void
      {
      }
      
      override public function updateVehiclesData(param1:IDAAPIDataClass) : void
      {
      }
      
      override public function updateTriggeredChatCommands(param1:IDAAPIDataClass) : void
      {
      }
      
      override public function setPersonalStatus(param1:uint) : void
      {
      }
      
      override public function updateUserTags(param1:IDAAPIDataClass) : void
      {
      }
      
      override public function setVehiclesData(param1:IDAAPIDataClass) : void
      {
      }
      
      override public function addVehiclesInfo(param1:IDAAPIDataClass) : void
      {
      }
      
      override public function updateInvitationsStatuses(param1:IDAAPIDataClass) : void
      {
      }
      
      override public function hasAmmunitionPanel(param1:Boolean) : void
      {
      }
      
      override public function resetFrags() : void
      {
      }
      
      override public function updatePlayerStatus(param1:IDAAPIDataClass) : void
      {
      }
      
      override public function setQuestStatus(param1:IDAAPIDataClass) : void
      {
      }
      
      override protected function setEventInfoPanelData(param1:EventInfoPanelVO) : void
      {
      }
      
      private function updateLayout() : void
      {
         var _loc1_:Number = Math.max(this._stageWidth / this.tipImage.bitmapWidth,this._stageHeight / this.tipImage.bitmapHeight);
         this.tipImage.width = this.tipImage.bitmapWidth * _loc1_ | 0;
         this.tipImage.height = this.tipImage.bitmapHeight * _loc1_ | 0;
         this.tipImage.x = this._stageWidth - this.tipImage.width >> 1;
         this.tipImage.y = this._stageHeight - this.tipImage.height >> 1;
         this.tipText.height = this.tipText.textHeight + TEXT_BORDERS;
         this.loadingBar.y = this.tipText.height + HELP_TIP_TEXT_OFFSET_Y;
         this._bottom.x = this._stageWidth >> 1;
         this._bottom.y = this._stageHeight - this._bottom.height + BOTTOM_MARGIN;
      }
      
      private function onCompleteHandler(param1:Event) : void
      {
         this.updateLayout();
      }
   }
}
