package net.wg.gui.lobby.training
{
   import flash.display.InteractiveObject;
   import flash.text.TextField;
   import net.wg.data.VO.EpicBattleTrainingRoomTeamVO;
   import net.wg.data.VO.TrainingRoomRendererVO;
   import net.wg.data.VO.TrainingRoomTeamBaseVO;
   import net.wg.data.constants.Errors;
   import net.wg.data.constants.Linkages;
   import net.wg.data.constants.UniversalBtnStylesConst;
   import net.wg.gui.components.controls.ScrollBar;
   import net.wg.gui.components.controls.VO.BadgeVisualVO;
   import net.wg.gui.components.controls.universalBtn.UniversalBtn;
   import net.wg.infrastructure.base.meta.IEpicBattleTrainingRoomMeta;
   import net.wg.infrastructure.base.meta.impl.EpicBattleTrainingRoomMeta;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   import net.wg.infrastructure.interfaces.entity.IDropItem;
   import net.wg.utils.IUniversalBtnStyles;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.controls.CoreList;
   import scaleform.clik.core.UIComponent;
   import scaleform.clik.data.DataProvider;
   import scaleform.clik.events.ButtonEvent;
   import scaleform.clik.interfaces.IDataProvider;
   
   public class EpicBattleTrainingRoom extends EpicBattleTrainingRoomMeta implements IEpicBattleTrainingRoomMeta
   {
      
      private static const NO_LANE_ERROR:String = "There is NO LANE # ";
      
      private static const RENDERER_WIDTH:int = 221;
       
      
      public var scrollBar:ScrollBar = null;
      
      public var team1_east:DropList;
      
      public var team1_center:DropList;
      
      public var team1_west:DropList;
      
      public var team2_east:DropList;
      
      public var team2_center:DropList;
      
      public var team2_west:DropList;
      
      public var lane1_title:TextField;
      
      public var lane2_title:TextField;
      
      public var lane3_title:TextField;
      
      public var swapButton_11_21:UniversalBtn;
      
      public var swapButton_12_22:UniversalBtn;
      
      public var swapButton_13_23:UniversalBtn;
      
      public var swapButton_11_12:UniversalBtn;
      
      public var swapButton_12_13:UniversalBtn;
      
      public var swapButton_21_22:UniversalBtn;
      
      public var swapButton_22_23:UniversalBtn;
      
      public function EpicBattleTrainingRoom()
      {
         super();
      }
      
      private static function setupDataProvider(param1:Array) : IDataProvider
      {
         var _loc3_:Object = null;
         App.utils.asserter.assertNotNull(param1,"data" + Errors.CANT_NULL);
         var _loc2_:DataProvider = new DataProvider();
         for each(_loc3_ in param1)
         {
            _loc2_.push(new TrainingRoomRendererVO(_loc3_));
         }
         return _loc2_;
      }
      
      private static function get2TeamIndex(param1:Number) : Number
      {
         var _loc2_:Number = 0;
         if(param1 > 3)
         {
            _loc2_ = 2;
         }
         else if(param1 > 0)
         {
            _loc2_ = 1;
         }
         return _loc2_;
      }
      
      private static function getLaneIndex(param1:Number) : Number
      {
         var _loc2_:Number = -1;
         if(param1 != 0)
         {
            _loc2_ = param1 - 1;
            if(_loc2_ > 2)
            {
               _loc2_ -= 3;
            }
         }
         return _loc2_ + 1;
      }
      
      private static function releaseDataProvider(param1:IDataProvider) : void
      {
         var _loc2_:IDisposable = null;
         if(param1 != null)
         {
            if(param1.length > 0)
            {
               for each(_loc2_ in param1)
               {
                  _loc2_.dispose();
               }
               param1.cleanUp();
            }
            param1 = null;
         }
      }
      
      override protected function onDispose() : void
      {
         var _loc2_:CoreList = null;
         var _loc1_:Vector.<InteractiveObject> = slots;
         for each(_loc2_ in _loc1_)
         {
            releaseDataProvider(_loc2_.dataProvider);
         }
         this.scrollBar.dispose();
         this.scrollBar = null;
         this.team1_east.dispose();
         this.team1_east = null;
         this.team1_center.dispose();
         this.team1_center = null;
         this.team1_west.dispose();
         this.team1_west = null;
         this.team2_east.dispose();
         this.team2_east = null;
         this.team2_center.dispose();
         this.team2_center = null;
         this.team2_west.dispose();
         this.team2_west = null;
         this.lane1_title = null;
         this.lane2_title = null;
         this.lane3_title = null;
         this.swapButton_11_21.dispose();
         this.swapButton_11_21 = null;
         this.swapButton_12_22.dispose();
         this.swapButton_12_22 = null;
         this.swapButton_13_23.dispose();
         this.swapButton_13_23 = null;
         this.swapButton_11_12.dispose();
         this.swapButton_11_12 = null;
         this.swapButton_12_13.dispose();
         this.swapButton_12_13 = null;
         this.swapButton_21_22.dispose();
         this.swapButton_21_22 = null;
         this.swapButton_22_23.dispose();
         this.swapButton_22_23 = null;
         super.onDispose();
      }
      
      override protected function disableControls(param1:Boolean) : void
      {
         this.swapButton_11_21.enabled = !param1;
         this.swapButton_12_22.enabled = !param1;
         this.swapButton_13_23.enabled = !param1;
         this.swapButton_11_12.enabled = !param1;
         this.swapButton_12_13.enabled = !param1;
         this.swapButton_21_22.enabled = !param1;
         this.swapButton_22_23.enabled = !param1;
         super.disableControls(param1);
      }
      
      override protected function getSwapBtns() : Vector.<UIComponent>
      {
         return Vector.<UIComponent>([this.swapButton_11_21,this.swapButton_12_22,this.swapButton_13_23,this.swapButton_11_12,this.swapButton_12_13,this.swapButton_21_22,this.swapButton_22_23]);
      }
      
      override protected function setTeamsInfo() : void
      {
         this.lane1_title.text = EPIC_BATTLE.LANE_WEST_NAME;
         this.lane2_title.text = EPIC_BATTLE.LANE_CENTRAL_NAME;
         this.lane3_title.text = EPIC_BATTLE.LANE_EAST_NAME;
      }
      
      override protected function setOther(param1:TrainingRoomTeamBaseVO) : void
      {
         releaseDataProvider(other.dataProvider);
         var _loc2_:EpicBattleTrainingRoomTeamVO = param1 as EpicBattleTrainingRoomTeamVO;
         if(_loc2_)
         {
            other.dataProvider = setupDataProvider(_loc2_.listData);
         }
         super.setOther(param1);
      }
      
      override protected function doCheckStatusTeam1(param1:Number, param2:String, param3:String, param4:String, param5:String, param6:int, param7:BadgeVisualVO) : void
      {
         checkStatus(this.team1_east,param1,param2,param3,param4,param5,param6,param7);
         checkStatus(this.team1_center,param1,param2,param3,param4,param5,param6,param7);
         checkStatus(this.team1_west,param1,param2,param3,param4,param5,param6,param7);
      }
      
      override protected function doCheckStatusTeam2(param1:Number, param2:String, param3:String, param4:String, param5:String, param6:int, param7:BadgeVisualVO) : void
      {
         checkStatus(this.team2_east,param1,param2,param3,param4,param5,param6,param7);
         checkStatus(this.team2_center,param1,param2,param3,param4,param5,param6,param7);
         checkStatus(this.team2_west,param1,param2,param3,param4,param5,param6,param7);
      }
      
      override protected function setTeam1(param1:TrainingRoomTeamBaseVO) : void
      {
         var _loc3_:int = 0;
         var _loc2_:EpicBattleTrainingRoomTeamVO = param1 as EpicBattleTrainingRoomTeamVO;
         if(_loc2_)
         {
            _loc3_ = _loc2_.lane;
            if(_loc3_ == 1)
            {
               releaseDataProvider(this.team1_west.dataProvider);
               this.team1_west.dataProvider = setupDataProvider(_loc2_.listData);
            }
            else if(_loc3_ == 2)
            {
               releaseDataProvider(this.team1_center.dataProvider);
               this.team1_center.dataProvider = setupDataProvider(_loc2_.listData);
            }
            else if(_loc3_ == 3)
            {
               releaseDataProvider(this.team1_east.dataProvider);
               this.team1_east.dataProvider = setupDataProvider(_loc2_.listData);
            }
            else
            {
               DebugUtils.LOG_ERROR(NO_LANE_ERROR + _loc3_.toString());
            }
         }
         super.setTeam1(param1);
      }
      
      override protected function setTeam2(param1:TrainingRoomTeamBaseVO) : void
      {
         var _loc3_:int = 0;
         var _loc2_:EpicBattleTrainingRoomTeamVO = param1 as EpicBattleTrainingRoomTeamVO;
         if(_loc2_)
         {
            _loc3_ = _loc2_.lane;
            if(_loc3_ == 1)
            {
               releaseDataProvider(this.team2_west.dataProvider);
               this.team2_west.dataProvider = setupDataProvider(_loc2_.listData);
            }
            else if(_loc3_ == 2)
            {
               releaseDataProvider(this.team2_center.dataProvider);
               this.team2_center.dataProvider = setupDataProvider(_loc2_.listData);
            }
            else if(_loc3_ == 3)
            {
               releaseDataProvider(this.team2_east.dataProvider);
               this.team2_east.dataProvider = setupDataProvider(_loc2_.listData);
            }
            else
            {
               DebugUtils.LOG_ERROR(NO_LANE_ERROR + _loc3_.toString());
            }
         }
         super.setTeam2(param1);
      }
      
      override protected function doSetPlayerTagsInTeam1(param1:Number, param2:Array) : void
      {
         checkUserTags(this.team1_east,param1,param2);
         checkUserTags(this.team1_center,param1,param2);
         checkUserTags(this.team1_west,param1,param2);
      }
      
      override protected function doSetPlayerTagsInTeam2(param1:Number, param2:Array) : void
      {
         checkUserTags(this.team2_east,param1,param2);
         checkUserTags(this.team2_center,param1,param2);
         checkUserTags(this.team2_west,param1,param2);
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         var _loc1_:IUniversalBtnStyles = App.utils.universalBtnStyles;
         _loc1_.setStyle(this.swapButton_11_21,UniversalBtnStylesConst.STYLE_SLIM_BLACK);
         _loc1_.setStyle(this.swapButton_12_22,UniversalBtnStylesConst.STYLE_SLIM_BLACK);
         _loc1_.setStyle(this.swapButton_13_23,UniversalBtnStylesConst.STYLE_SLIM_BLACK);
         _loc1_.setStyle(this.swapButton_11_12,UniversalBtnStylesConst.STYLE_SLIM_BLACK);
         _loc1_.setStyle(this.swapButton_12_13,UniversalBtnStylesConst.STYLE_SLIM_BLACK);
         _loc1_.setStyle(this.swapButton_21_22,UniversalBtnStylesConst.STYLE_SLIM_BLACK);
         _loc1_.setStyle(this.swapButton_22_23,UniversalBtnStylesConst.STYLE_SLIM_BLACK);
         this.swapButton_11_21.iconSource = RES_ICONS.MAPS_ICONS_BUTTONS_SWAP3_ROTATED;
         this.swapButton_12_22.iconSource = RES_ICONS.MAPS_ICONS_BUTTONS_SWAP3_ROTATED;
         this.swapButton_13_23.iconSource = RES_ICONS.MAPS_ICONS_BUTTONS_SWAP3_ROTATED;
         this.swapButton_11_12.iconSource = RES_ICONS.MAPS_ICONS_BUTTONS_SWAP3;
         this.swapButton_12_13.iconSource = RES_ICONS.MAPS_ICONS_BUTTONS_SWAP3;
         this.swapButton_21_22.iconSource = RES_ICONS.MAPS_ICONS_BUTTONS_SWAP3;
         this.swapButton_22_23.iconSource = RES_ICONS.MAPS_ICONS_BUTTONS_SWAP3;
         other.columnWidth = RENDERER_WIDTH;
         other.smartScrollBar = false;
      }
      
      override protected function draw() : void
      {
         var _loc1_:Boolean = false;
         super.draw();
         if(isInvalid(InvalidationType.STATE))
         {
            _loc1_ = canChangePlayerTeamS();
            this.swapButton_11_21.visible = _loc1_;
            this.swapButton_12_22.visible = _loc1_;
            this.swapButton_13_23.visible = _loc1_;
            this.swapButton_11_12.visible = _loc1_;
            this.swapButton_12_13.visible = _loc1_;
            this.swapButton_21_22.visible = _loc1_;
            this.swapButton_22_23.visible = _loc1_;
         }
      }
      
      override protected function addListeners() : void
      {
         super.addListeners();
         this.swapButton_11_21.addEventListener(ButtonEvent.CLICK,this.onBtn1121ClickHandler);
         this.swapButton_12_22.addEventListener(ButtonEvent.CLICK,this.onBtn1222ClickHandler);
         this.swapButton_13_23.addEventListener(ButtonEvent.CLICK,this.onBtn1323ClickHandler);
         this.swapButton_11_12.addEventListener(ButtonEvent.CLICK,this.onBtn1112ClickHandler);
         this.swapButton_12_13.addEventListener(ButtonEvent.CLICK,this.onBtn1213ClickHandler);
         this.swapButton_21_22.addEventListener(ButtonEvent.CLICK,this.onBtn2122ClickHandler);
         this.swapButton_22_23.addEventListener(ButtonEvent.CLICK,this.onBtn2223ClickHandler);
      }
      
      override protected function getDragElementLinkage() : String
      {
         return Linkages.EPIC_TRAINING_DRAG_ELEMENT_UI;
      }
      
      override protected function removeListeners() : void
      {
         super.removeListeners();
         this.swapButton_11_21.removeEventListener(ButtonEvent.CLICK,this.onBtn1121ClickHandler);
         this.swapButton_12_22.removeEventListener(ButtonEvent.CLICK,this.onBtn1222ClickHandler);
         this.swapButton_13_23.removeEventListener(ButtonEvent.CLICK,this.onBtn1323ClickHandler);
         this.swapButton_11_12.removeEventListener(ButtonEvent.CLICK,this.onBtn1112ClickHandler);
         this.swapButton_12_13.removeEventListener(ButtonEvent.CLICK,this.onBtn1213ClickHandler);
         this.swapButton_21_22.removeEventListener(ButtonEvent.CLICK,this.onBtn2122ClickHandler);
         this.swapButton_22_23.removeEventListener(ButtonEvent.CLICK,this.onBtn2223ClickHandler);
      }
      
      override protected function doDrop(param1:InteractiveObject, param2:InteractiveObject, param3:InteractiveObject) : void
      {
         var _loc4_:Vector.<InteractiveObject> = null;
         var _loc5_:Number = NaN;
         var _loc6_:Number = NaN;
         var _loc7_:Number = NaN;
         var _loc8_:Number = NaN;
         var _loc9_:Number = NaN;
         var _loc10_:Boolean = false;
         var _loc11_:Boolean = false;
         var _loc12_:Number = NaN;
         if(param1 != param2)
         {
            _loc4_ = slots;
            _loc5_ = IDropItem(param3).data.accID;
            _loc6_ = _loc4_.indexOf(param2);
            _loc7_ = _loc4_.indexOf(param1);
            _loc8_ = get2TeamIndex(_loc6_);
            _loc9_ = getLaneIndex(_loc6_);
            _loc10_ = false;
            _loc11_ = false;
            if(isSlotDroppable(_loc5_,_loc8_))
            {
               if(_loc8_ != get2TeamIndex(_loc7_))
               {
                  _loc10_ = true;
               }
               if(_loc6_ != 0)
               {
                  _loc12_ = getLaneIndex(_loc7_);
                  if(_loc9_ != _loc12_)
                  {
                     _loc11_ = true;
                  }
               }
               if(_loc6_ == 0)
               {
                  onChangeTeamLaneS(_loc5_,_loc8_,0);
               }
               else if(_loc10_ || _loc11_)
               {
                  onChangeTeamLaneS(_loc5_,_loc8_,_loc9_);
               }
            }
         }
         super.doDrop(param1,param2,param3);
      }
      
      override protected function getSlots() : Vector.<InteractiveObject>
      {
         return Vector.<InteractiveObject>([other,this.team1_west,this.team1_center,this.team1_east,this.team2_west,this.team2_center,this.team2_east]);
      }
      
      override protected function getTrainingRoomTeamBaseVOForData(param1:Object) : TrainingRoomTeamBaseVO
      {
         return new EpicBattleTrainingRoomTeamVO(param1);
      }
      
      private function getDPForTeamAndLane(param1:Number, param2:Number) : IDataProvider
      {
         if(param1 == 1)
         {
            if(param2 == 1)
            {
               return this.team1_west.dataProvider;
            }
            if(param2 == 2)
            {
               return this.team1_center.dataProvider;
            }
            if(param2 == 3)
            {
               return this.team1_east.dataProvider;
            }
         }
         else if(param1 == 2)
         {
            if(param2 == 1)
            {
               return this.team2_west.dataProvider;
            }
            if(param2 == 2)
            {
               return this.team2_center.dataProvider;
            }
            if(param2 == 3)
            {
               return this.team2_east.dataProvider;
            }
         }
         return IDataProvider([]);
      }
      
      private function swapPlayers(param1:Number, param2:Number, param3:Number, param4:Number) : void
      {
         onSwapTeamLaneS(param1,param2,param3,param4);
      }
      
      private function onBtn1121ClickHandler(param1:ButtonEvent) : void
      {
         this.swapPlayers(1,1,2,1);
      }
      
      private function onBtn1222ClickHandler(param1:ButtonEvent) : void
      {
         this.swapPlayers(1,2,2,2);
      }
      
      private function onBtn1323ClickHandler(param1:ButtonEvent) : void
      {
         this.swapPlayers(1,3,2,3);
      }
      
      private function onBtn1112ClickHandler(param1:ButtonEvent) : void
      {
         this.swapPlayers(1,1,1,2);
      }
      
      private function onBtn1213ClickHandler(param1:ButtonEvent) : void
      {
         this.swapPlayers(1,2,1,3);
      }
      
      private function onBtn2122ClickHandler(param1:ButtonEvent) : void
      {
         this.swapPlayers(2,1,2,2);
      }
      
      private function onBtn2223ClickHandler(param1:ButtonEvent) : void
      {
         this.swapPlayers(2,2,2,3);
      }
   }
}
