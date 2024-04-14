package net.wg.gui.lobby.training
{
   import flash.display.InteractiveObject;
   import net.wg.data.VO.TrainingRoomTeamBaseVO;
   import net.wg.data.VO.TrainingRoomTeamVO;
   import net.wg.data.constants.UniversalBtnStylesConst;
   import net.wg.gui.components.controls.VO.BadgeVisualVO;
   import net.wg.gui.components.controls.universalBtn.UniversalBtn;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.controls.ListItemRenderer;
   import scaleform.clik.core.UIComponent;
   import scaleform.clik.events.ButtonEvent;
   
   public class TrainingRoom extends TrainingRoomBase
   {
       
      
      public var swapButton:UniversalBtn;
      
      public var team1:DropList;
      
      public var team2:DropList;
      
      public function TrainingRoom()
      {
         super();
      }
      
      override protected function getSwapBtns() : Vector.<UIComponent>
      {
         return Vector.<UIComponent>([this.swapButton]);
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         App.utils.universalBtnStyles.setStyle(this.swapButton,UniversalBtnStylesConst.STYLE_SLIM_GREEN);
         this.swapButton.iconSource = RES_ICONS.MAPS_ICONS_BUTTONS_SWAP2;
      }
      
      override protected function onDispose() : void
      {
         this.swapButton.dispose();
         this.swapButton = null;
         this.team1.dispose();
         this.team1 = null;
         this.team2.dispose();
         this.team2 = null;
         super.onDispose();
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(InvalidationType.STATE))
         {
            this.swapButton.visible = canChangePlayerTeamS();
         }
      }
      
      override protected function addListeners() : void
      {
         super.addListeners();
         this.swapButton.addEventListener(ButtonEvent.CLICK,this.onSwapButtonClickHandler);
      }
      
      override protected function removeListeners() : void
      {
         super.removeListeners();
         this.swapButton.removeEventListener(ButtonEvent.CLICK,this.onSwapButtonClickHandler);
      }
      
      override protected function disableControls(param1:Boolean) : void
      {
         this.swapButton.enabled = !param1;
         super.disableControls(param1);
      }
      
      override protected function getSlots() : Vector.<InteractiveObject>
      {
         return Vector.<InteractiveObject>([other,this.team1,this.team2]);
      }
      
      override protected function doDrop(param1:InteractiveObject, param2:InteractiveObject, param3:InteractiveObject) : void
      {
         var _loc5_:Number = NaN;
         var _loc6_:Number = NaN;
         var _loc4_:Vector.<InteractiveObject> = slots;
         if(param1 != param2)
         {
            _loc5_ = ListItemRenderer(param3).data.accID;
            _loc6_ = _loc4_.indexOf(param2);
            if(isSlotDroppable(_loc5_,_loc6_))
            {
               changeTeamS(_loc5_,_loc6_);
            }
         }
         super.doDrop(param1,param2,param3);
      }
      
      override protected function setTeamsInfo() : void
      {
         team1Label.htmlText = MENU.TRAINING_INFO_TEAM1LABEL;
         team2Label.htmlText = MENU.TRAINING_INFO_TEAM2LABEL;
         otherLabel.htmlText = MENU.TRAINING_INFO_OTHERLABEL;
      }
      
      override protected function setOther(param1:TrainingRoomTeamBaseVO) : void
      {
         var _loc2_:TrainingRoomTeamVO = param1 as TrainingRoomTeamVO;
         if(_loc2_)
         {
            other.dataProvider = _loc2_.listData;
         }
         super.setOther(param1);
      }
      
      override protected function doCheckStatusTeam1(param1:Number, param2:String, param3:String, param4:String, param5:String, param6:int, param7:BadgeVisualVO) : void
      {
         checkStatus(this.team1,param1,param2,param3,param4,param5,param6,param7);
      }
      
      override protected function doCheckStatusTeam2(param1:Number, param2:String, param3:String, param4:String, param5:String, param6:int, param7:BadgeVisualVO) : void
      {
         checkStatus(this.team2,param1,param2,param3,param4,param5,param6,param7);
      }
      
      override protected function setTeam1(param1:TrainingRoomTeamBaseVO) : void
      {
         var _loc2_:TrainingRoomTeamVO = param1 as TrainingRoomTeamVO;
         if(_loc2_)
         {
            this.team1.dataProvider = _loc2_.listData;
         }
         super.setTeam1(param1);
      }
      
      override protected function setTeam2(param1:TrainingRoomTeamBaseVO) : void
      {
         var _loc2_:TrainingRoomTeamVO = param1 as TrainingRoomTeamVO;
         if(_loc2_)
         {
            this.team2.dataProvider = _loc2_.listData;
         }
         super.setTeam2(param1);
      }
      
      override protected function doSetPlayerTagsInTeam1(param1:Number, param2:Array) : void
      {
         checkUserTags(this.team1,param1,param2);
      }
      
      override protected function doSetPlayerTagsInTeam2(param1:Number, param2:Array) : void
      {
         checkUserTags(this.team2,param1,param2);
      }
      
      override protected function getTrainingRoomTeamBaseVOForData(param1:Object) : TrainingRoomTeamBaseVO
      {
         return new TrainingRoomTeamVO(param1);
      }
      
      private function onSwapButtonClickHandler(param1:ButtonEvent) : void
      {
         swapTeamsS();
      }
   }
}
