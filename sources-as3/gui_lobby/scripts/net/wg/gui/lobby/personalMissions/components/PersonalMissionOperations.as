package net.wg.gui.lobby.personalMissions.components
{
   import flash.display.Graphics;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import net.wg.data.constants.LobbyMetrics;
   import net.wg.data.constants.generated.TOOLTIPS_CONSTANTS;
   import net.wg.gui.lobby.personalMissions.components.operationsHeader.OperationTitleInfo;
   import net.wg.gui.lobby.personalMissions.data.OperationDataVO;
   import net.wg.gui.lobby.personalMissions.data.OperationTitleVO;
   import net.wg.gui.lobby.personalMissions.events.OperationEvent;
   import net.wg.infrastructure.base.meta.IPersonalMissionOperationsMeta;
   import net.wg.infrastructure.base.meta.impl.PersonalMissionOperationsMeta;
   import net.wg.infrastructure.managers.ITooltipMgr;
   import net.wg.utils.StageSizeBoundaries;
   import scaleform.clik.constants.InvalidationType;
   
   public class PersonalMissionOperations extends PersonalMissionOperationsMeta implements IPersonalMissionOperationsMeta
   {
      
      private static const INVALID_OPERATIONS:String = "invalidOperations";
      
      private static const INVALID_TITLE:String = "invalidTitle";
      
      private static const HEADER_TOP_POSITION_MAX:int = 85;
      
      private static const HEADER_TOP_POSITION_MIN:int = 55;
      
      private static const CONTENT_TOP_POSITION_MIN:int = 300;
      
      private static const HEIGHT_BREAK_POINT:int = 812;
      
      private static const PAGE_HEIGHT_STATE_TALL:String = "stateTall";
      
      private static const PAGE_HEIGHT_STATE_SHORT:String = "stateShort";
      
      private static const MENU_POSITION_X:int = 32;
      
      private static const MENU_POSITION_X_SMALL:int = 16;
      
      private static const FRAME_SMALL:int = 2;
      
      private static const FRAME_BIG:int = 1;
      
      private static const ITEM_WIDTH_SMALL:uint = 68;
      
      private static const ITEM_WIDTH:uint = 100;
      
      private static const ITEM_HEIGHT_SMALL:uint = 54;
      
      private static const ITEM_HEIGHT:uint = 80;
      
      private static const NEW_PM_OFFSET_Y_SMALL:int = -54;
      
      private static const NEW_PM_OFFSET_Y:int = -80;
       
      
      public var operationInfo:OperationTitleInfo = null;
      
      public var content:AllOperationsContent = null;
      
      public var bg:Sprite = null;
      
      public var widget:MovieClip = null;
      
      private var _titleVo:OperationTitleVO = null;
      
      private var _operations:Vector.<OperationDataVO> = null;
      
      private var _pageHeightState:String = "";
      
      private var _newPM:Sprite = null;
      
      private var _oldPM:Sprite = null;
      
      private var _tooltipMgr:ITooltipMgr;
      
      public function PersonalMissionOperations()
      {
         this._tooltipMgr = App.toolTipMgr;
         super();
      }
      
      private static function calcPageHeightState(param1:Number) : String
      {
         return param1 >= HEIGHT_BREAK_POINT ? PAGE_HEIGHT_STATE_TALL : PAGE_HEIGHT_STATE_SHORT;
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.content.addEventListener(OperationEvent.CLICK,this.onContentOperationClickHandler);
         this.operationInfo.addEventListener(OperationEvent.INFO_BTN_CLICK,this.onOperationInfoBtnClickHandler);
         this.widget.mouseEnabled = false;
         this._newPM = new Sprite();
         this._oldPM = new Sprite();
         this._newPM.mouseEnabled = this._oldPM.mouseEnabled = true;
         this._newPM.addEventListener(MouseEvent.ROLL_OVER,this.onNewPMRollOverHandler);
         this._newPM.addEventListener(MouseEvent.ROLL_OUT,this.onNewPMROllOutHandler);
         this._oldPM.addEventListener(MouseEvent.ROLL_OVER,this.onOldPMRollOverHandler);
         this._oldPM.addEventListener(MouseEvent.ROLL_OUT,this.onOldPMROllOutHandler);
         var _loc1_:Graphics = this._newPM.graphics;
         _loc1_.beginFill(4095,0);
         _loc1_.drawRect(0,0,1,1);
         _loc1_.endFill();
         this.widget.addChild(this._newPM);
         _loc1_ = this._oldPM.graphics;
         _loc1_.beginFill(4095,0);
         _loc1_.drawRect(0,0,1,1);
         _loc1_.endFill();
         this.widget.addChild(this._oldPM);
         this.updateWidgetSizeAndPosition();
      }
      
      override protected function onBeforeDispose() : void
      {
         this.operationInfo.removeEventListener(OperationEvent.INFO_BTN_CLICK,this.onOperationInfoBtnClickHandler);
         this.content.removeEventListener(OperationEvent.CLICK,this.onContentOperationClickHandler);
         this._newPM.removeEventListener(MouseEvent.ROLL_OVER,this.onNewPMRollOverHandler);
         this._newPM.removeEventListener(MouseEvent.ROLL_OUT,this.onNewPMROllOutHandler);
         this._oldPM.removeEventListener(MouseEvent.ROLL_OVER,this.onOldPMRollOverHandler);
         this._oldPM.removeEventListener(MouseEvent.ROLL_OUT,this.onOldPMROllOutHandler);
         super.onBeforeDispose();
      }
      
      override protected function onDispose() : void
      {
         this.operationInfo.dispose();
         this.operationInfo = null;
         this._operations = null;
         this.content.dispose();
         this.content = null;
         this.widget = null;
         this.bg = null;
         this._titleVo = null;
         this._oldPM = null;
         this._newPM = null;
         this._tooltipMgr = null;
         super.onDispose();
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(this._titleVo && isInvalid(INVALID_TITLE))
         {
            this.operationInfo.update(this._titleVo);
         }
         if(this._operations && isInvalid(INVALID_OPERATIONS))
         {
            this.content.setOperations(this._operations);
         }
         if(isInvalid(InvalidationType.SIZE))
         {
            this.updateSize();
         }
      }
      
      override protected function onEscapeKeyDown() : void
      {
         closeViewS();
      }
      
      override protected function setOperations(param1:Vector.<OperationDataVO>) : void
      {
         this._operations = param1;
         invalidate(INVALID_OPERATIONS);
      }
      
      override protected function setTitle(param1:OperationTitleVO) : void
      {
         this._titleVo = param1;
         invalidate(INVALID_TITLE);
      }
      
      private function updateSize() : void
      {
         var _loc1_:String = calcPageHeightState(height);
         if(this._pageHeightState != _loc1_)
         {
            this._pageHeightState = _loc1_;
            this.updateDependentComponents(this._pageHeightState);
         }
         var _loc2_:int = width >> 1;
         var _loc3_:int = height >> 1;
         this.content.x = _loc2_;
         this.content.y = _loc1_ == PAGE_HEIGHT_STATE_SHORT ? Number(CONTENT_TOP_POSITION_MIN + (App.appHeight - LobbyMetrics.MIN_STAGE_HEIGHT >> 1)) : Number(_loc3_);
         this.operationInfo.x = _loc2_;
         this.operationInfo.y = Math.min(HEADER_TOP_POSITION_MIN + (App.appHeight - LobbyMetrics.MIN_STAGE_HEIGHT >> 1),HEADER_TOP_POSITION_MAX);
         this.bg.width = width;
         this.bg.height = height + LobbyMetrics.LOBBY_MESSENGER_HEIGHT;
         this.updateWidgetSizeAndPosition();
      }
      
      private function updateDependentComponents(param1:String) : void
      {
         this.operationInfo.fontSize = param1 == PAGE_HEIGHT_STATE_TALL ? int(OperationTitleInfo.HEADER_FONT_BIG) : int(OperationTitleInfo.HEADER_FONT_SMALL);
      }
      
      private function updateWidgetSizeAndPosition() : void
      {
         this.widget.y = height >> 1;
         if(App.appWidth < StageSizeBoundaries.WIDTH_1600 || App.appHeight < StageSizeBoundaries.HEIGHT_900)
         {
            this.widget.gotoAndStop(FRAME_SMALL);
            this._newPM.width = this._oldPM.width = ITEM_WIDTH_SMALL;
            this._newPM.height = this._oldPM.height = ITEM_HEIGHT_SMALL;
            this._newPM.y = NEW_PM_OFFSET_Y_SMALL;
            this._newPM.x = this._oldPM.x = MENU_POSITION_X_SMALL;
         }
         else
         {
            this.widget.gotoAndStop(FRAME_BIG);
            this._newPM.width = this._oldPM.width = ITEM_WIDTH;
            this._newPM.height = this._oldPM.height = ITEM_HEIGHT;
            this._newPM.y = NEW_PM_OFFSET_Y;
            this._newPM.x = this._oldPM.x = MENU_POSITION_X;
         }
      }
      
      override public function get isModal() : Boolean
      {
         return true;
      }
      
      private function onOldPMROllOutHandler(param1:MouseEvent) : void
      {
         this._tooltipMgr.hide();
      }
      
      private function onNewPMROllOutHandler(param1:MouseEvent) : void
      {
         this._tooltipMgr.hide();
      }
      
      private function onOldPMRollOverHandler(param1:MouseEvent) : void
      {
      }
      
      private function onNewPMRollOverHandler(param1:MouseEvent) : void
      {
         this._tooltipMgr.showWulfTooltip(TOOLTIPS_CONSTANTS.PERSONAL_MISSIONS_ANNOUNCE);
      }
      
      private function onOperationInfoBtnClickHandler(param1:OperationEvent) : void
      {
         showInfoS();
      }
      
      private function onContentOperationClickHandler(param1:OperationEvent) : void
      {
         onOperationClickS(param1.pmType,param1.id);
      }
   }
}
