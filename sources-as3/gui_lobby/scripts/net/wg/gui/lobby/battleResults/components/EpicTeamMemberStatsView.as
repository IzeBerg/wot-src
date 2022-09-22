package net.wg.gui.lobby.battleResults.components
{
   import flash.display.InteractiveObject;
   import flash.display.MovieClip;
   import flash.text.TextField;
   import net.wg.data.constants.UserTags;
   import net.wg.gui.components.controls.ScrollingListEx;
   import net.wg.gui.components.controls.SoundButtonEx;
   import net.wg.gui.components.controls.UserNameField;
   import net.wg.gui.events.ListEventEx;
   import net.wg.gui.lobby.battleResults.data.TeamMemberItemVO;
   import net.wg.infrastructure.events.FocusRequestEvent;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.data.DataProvider;
   import scaleform.clik.events.ButtonEvent;
   import scaleform.clik.events.ListEvent;
   
   public class EpicTeamMemberStatsView extends TeamMemberStatsViewBase
   {
      
      private static const STATE_WITH_MEDALS:int = 101;
      
      private static const STATE_WITHOUT_MEDALS:int = 38;
      
      private static const VEHICLE_X_POS:int = 150;
      
      private static const CLOSE_BTN_Y_OFFSET:int = 46;
      
      private static const INVALIDATE_CLOSE_BTN:String = "invalidateCloseBtn";
       
      
      public var tankListTitle:TextField = null;
      
      public var tankList:MultipleTankList = null;
      
      public var closeBtn:SoundButtonEx = null;
      
      public var achievements:MedalsList = null;
      
      public var playerNameLbl:UserNameField = null;
      
      public var vehicleStats:VehicleDetails = null;
      
      public var deadBg:MovieClip = null;
      
      public var medalBg:MovieClip = null;
      
      private var _list:ScrollingListEx = null;
      
      private var _isCloseBtnVisible:Boolean;
      
      private var _selectedVehicleIndex:int = 0;
      
      public function EpicTeamMemberStatsView()
      {
         super();
         scaleX = 1;
         scaleY = 1;
      }
      
      override public function getComponentForFocus() : InteractiveObject
      {
         return this._list;
      }
      
      override public function invalidateMedalsListData() : void
      {
         this.achievements.invalidateData();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.closeBtn.addEventListener(ButtonEvent.CLICK,this.onCloseButtonClickHandler);
         this._list.mouseEnabled = false;
         this.tankList.addEventListener(ListEvent.INDEX_CHANGE,this.onTankListIndexChangeHandler);
         this.tankList.addEventListener(ListEventEx.ITEM_CLICK,this.onTankListItemClickHandler);
      }
      
      override protected function onDispose() : void
      {
         this.closeBtn.removeEventListener(ButtonEvent.CLICK,this.onCloseButtonClickHandler);
         this.closeBtn.dispose();
         this.closeBtn = null;
         this.tankList.removeEventListener(ListEvent.INDEX_CHANGE,this.onTankListIndexChangeHandler);
         this.tankList.removeEventListener(ListEventEx.ITEM_CLICK,this.onTankListItemClickHandler);
         this.tankList.dispose();
         this.tankList = null;
         this._list = null;
         this.achievements.dispose();
         this.achievements = null;
         this.tankListTitle = null;
         this.playerNameLbl.dispose();
         this.playerNameLbl = null;
         this.vehicleStats.dispose();
         this.vehicleStats = null;
         this.deadBg = null;
         this.medalBg = null;
         super.onDispose();
      }
      
      override protected function draw() : void
      {
         var _loc1_:Boolean = false;
         super.draw();
         if(isInvalid(InvalidationType.DATA) && teamMemberItemData != null)
         {
            this.vehicleStats.state = VehicleDetails.STATE_EPIC;
            this.vehicleStats.x = VEHICLE_X_POS;
            this.vehicleStats.y = STATE_WITH_MEDALS;
            this.closeBtn.y = height - CLOSE_BTN_Y_OFFSET;
            this.achievements.visible = false;
            if(data)
            {
               this.initVehicleSelection(data);
               _loc1_ = UserTags.isCurrentPlayer(data.userVO.tags);
               this.playerNameLbl.userVO = data.userVO;
               this.playerNameLbl.useFakeName = !(_loc1_ || teamMemberItemData.isOwnSquad);
               this.playerNameLbl.showAnonymizerIcon = true;
               this.applyVehicleData();
               this.deadBg.visible = data.deathReason > -1;
               this.medalBg.visible = data.medalsCount > 0;
               if(data.medalsCount > 0)
               {
                  this.vehicleStats.y += STATE_WITHOUT_MEDALS;
                  this.achievements.visible = true;
                  if(this.achievements.dataProvider)
                  {
                     this.achievements.dataProvider.cleanUp();
                  }
                  this.achievements.dataProvider = new DataProvider(data.achievements);
                  this.achievements.validateNow();
               }
            }
            else
            {
               this.playerNameLbl.userVO = null;
               this.vehicleStats.data = null;
               this.deadBg.visible = false;
               this.medalBg.visible = false;
            }
         }
         if(isInvalid(INVALIDATE_CLOSE_BTN))
         {
            this.closeBtn.visible = this._isCloseBtnVisible;
         }
      }
      
      private function initVehicleSelection(param1:TeamMemberItemVO) : void
      {
         var _loc2_:Array = param1.vehicles;
         if(_loc2_.length > 0)
         {
            if(this.tankList.dataProvider != null)
            {
               this.tankList.dataProvider.cleanUp();
            }
            this.tankList.dataProvider = new DataProvider(_loc2_);
            this.tankList.selectedIndex = this._selectedVehicleIndex;
            this.tankList.invalidate();
         }
      }
      
      private function applyVehicleData() : void
      {
         if(this._selectedVehicleIndex < data.statValues.length)
         {
            this.vehicleStats.data = data.statValues[this._selectedVehicleIndex];
         }
      }
      
      override public function get isCloseBtnVisible() : Boolean
      {
         return this._isCloseBtnVisible;
      }
      
      override public function set isCloseBtnVisible(param1:Boolean) : void
      {
         if(this._isCloseBtnVisible == param1)
         {
            return;
         }
         this._isCloseBtnVisible = param1;
         invalidate(INVALIDATE_CLOSE_BTN);
      }
      
      public function get list() : ScrollingListEx
      {
         return this._list;
      }
      
      public function set list(param1:ScrollingListEx) : void
      {
         this._list = param1;
      }
      
      private function onTankListIndexChangeHandler(param1:ListEvent) : void
      {
         this._selectedVehicleIndex = param1.index;
         if(data != null)
         {
            this.applyVehicleData();
         }
      }
      
      private function onTankListItemClickHandler(param1:ListEvent) : void
      {
         this.tankList.selectedIndex = param1.index;
      }
      
      private function onCloseButtonClickHandler(param1:ButtonEvent) : void
      {
         this._list.selectedIndex = -1;
         dispatchEvent(new FocusRequestEvent(FocusRequestEvent.REQUEST_FOCUS,this));
      }
   }
}
