package net.wg.gui.lobby.personalMissions.components
{
   import flash.display.Sprite;
   import net.wg.data.constants.LobbyMetrics;
   import net.wg.gui.lobby.personalMissions.components.operationsHeader.OperationTitleInfo;
   import net.wg.gui.lobby.personalMissions.data.OperationDataVO;
   import net.wg.gui.lobby.personalMissions.data.OperationTitleVO;
   import net.wg.gui.lobby.personalMissions.events.OperationEvent;
   import net.wg.infrastructure.base.meta.IPersonalMissionOperationsMeta;
   import net.wg.infrastructure.base.meta.impl.PersonalMissionOperationsMeta;
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
       
      
      public var operationInfo:OperationTitleInfo = null;
      
      public var content:AllOperationsContent = null;
      
      public var bg:Sprite = null;
      
      private var _titleVo:OperationTitleVO = null;
      
      private var _operations:Vector.<OperationDataVO> = null;
      
      private var _pageHeightState:String = "";
      
      public function PersonalMissionOperations()
      {
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
      }
      
      override protected function onBeforeDispose() : void
      {
         this.operationInfo.removeEventListener(OperationEvent.INFO_BTN_CLICK,this.onOperationInfoBtnClickHandler);
         this.content.removeEventListener(OperationEvent.CLICK,this.onContentOperationClickHandler);
         super.onBeforeDispose();
      }
      
      override protected function onDispose() : void
      {
         this.operationInfo.dispose();
         this.operationInfo = null;
         this._operations = null;
         this.content.dispose();
         this.content = null;
         this.bg = null;
         this._titleVo = null;
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
         var _loc1_:String = null;
         _loc1_ = calcPageHeightState(height);
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
      }
      
      private function updateDependentComponents(param1:String) : void
      {
         this.operationInfo.fontSize = param1 == PAGE_HEIGHT_STATE_TALL ? int(OperationTitleInfo.HEADER_FONT_BIG) : int(OperationTitleInfo.HEADER_FONT_SMALL);
      }
      
      override public function get isModal() : Boolean
      {
         return true;
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
