package net.wg.gui.lobby.training
{
   import flash.display.DisplayObject;
   import flash.display.InteractiveObject;
   import flash.utils.Dictionary;
   import net.wg.data.VO.TrainingRoomInfoVO;
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
      
      private static const COMMENT_OFFSET_Y:uint = 8;
      
      private static const CONTENT_OFFSET_Y:uint = 21;
       
      
      public var swapButton:UniversalBtn;
      
      public var team1:DropList;
      
      public var team2:DropList;
      
      public var additionalInfo:AdditionalInfo = null;
      
      private var _originYDict:Dictionary = null;
      
      public function TrainingRoom()
      {
         super();
      }
      
      override public function as_updateMap(param1:Number, param2:Number, param3:String, param4:String, param5:String, param6:String, param7:String, param8:String, param9:Boolean) : void
      {
         super.as_updateMap(param1,param2,param3,param4,param5,param6,param7,param8,param9);
         this.updateAdditionalInfo(param8);
      }
      
      override protected function getSwapBtns() : Vector.<UIComponent>
      {
         return Vector.<UIComponent>([this.swapButton]);
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         this.updateAdditionalInfo(null);
         this.additionalInfo.setContentLayout(AdditionalInfoContent.LAYOUT_BIG);
         this._originYDict = new Dictionary();
         this._originYDict[comment] = comment.y;
         this._originYDict[team1Label] = team1Label.y;
         this._originYDict[team2Label] = team2Label.y;
         this._originYDict[this.team1] = this.team1.y;
         this._originYDict[this.team2] = this.team2.y;
         this._originYDict[this.swapButton] = this.swapButton.y;
         this._originYDict[otherLabel] = otherLabel.y;
         this._originYDict[inviteButton] = inviteButton.y;
         this._originYDict[other] = other.y;
         this._originYDict[minimap] = minimap.y;
         this._originYDict[map] = map.y;
         this._originYDict[description] = description.y;
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
         this.additionalInfo.dispose();
         this.additionalInfo = null;
         App.utils.data.cleanupDynamicObject(this._originYDict);
         this._originYDict = null;
         super.onDispose();
      }
      
      override protected function draw() : void
      {
         var _loc1_:* = null;
         var _loc2_:int = 0;
         super.draw();
         if(isInvalid(InvalidationType.STATE))
         {
            this.swapButton.visible = canChangePlayerTeamS();
         }
         if(isInvalid(InvalidationType.LAYOUT))
         {
            for(_loc1_ in this._originYDict)
            {
               (_loc1_ as DisplayObject).y = this._originYDict[_loc1_];
            }
            if(this.additionalInfo.visible)
            {
               comment.y = this._originYDict[comment] + this.additionalInfo.height + COMMENT_OFFSET_Y;
               _loc2_ = comment.textHeight - CONTENT_OFFSET_Y;
               if(_loc2_ > 0)
               {
                  team1Label.y += _loc2_;
                  team2Label.y += _loc2_;
                  this.team1.y += _loc2_;
                  this.team2.y += _loc2_;
                  this.swapButton.y += _loc2_;
                  otherLabel.y += _loc2_;
                  inviteButton.y += _loc2_;
                  other.y += _loc2_;
                  minimap.y += _loc2_;
                  map.y += _loc2_;
                  description.y += _loc2_;
               }
            }
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
      
      override protected function setInfo(param1:TrainingRoomInfoVO) : void
      {
         super.setInfo(param1);
         this.updateAdditionalInfo(param1.additionalInfo);
      }
      
      private function updateAdditionalInfo(param1:String) : void
      {
         if(param1)
         {
            this.additionalInfo.visible = true;
            this.additionalInfo.setType(param1);
         }
         else
         {
            this.additionalInfo.visible = false;
         }
         invalidateLayout();
      }
      
      private function onSwapButtonClickHandler(param1:ButtonEvent) : void
      {
         swapTeamsS();
      }
   }
}
