package net.wg.gui.lobby.epicBattles.components
{
   import flash.events.Event;
   import flash.events.MouseEvent;
   import net.wg.data.constants.SoundManagerStates;
   import net.wg.data.constants.SoundTypes;
   import net.wg.data.constants.generated.TOOLTIPS_CONSTANTS;
   import net.wg.gui.lobby.epicBattles.data.EpicBattlesWidgetEvent;
   import net.wg.gui.lobby.epicBattles.data.EpicBattlesWidgetVO;
   import net.wg.gui.lobby.hangar.quests.IHeaderFlagsEntryPoint;
   import net.wg.infrastructure.base.meta.IEpicBattlesWidgetMeta;
   import net.wg.infrastructure.base.meta.impl.EpicBattlesWidgetMeta;
   import net.wg.infrastructure.managers.ITooltipMgr;
   import net.wg.utils.StageSizeBoundaries;
   import org.idmedia.as3commons.util.StringUtils;
   import scaleform.clik.constants.InvalidationType;
   
   public class EpicBattlesWidget extends EpicBattlesWidgetMeta implements IEpicBattlesWidgetMeta, IHeaderFlagsEntryPoint
   {
      
      private static const OFFSET_POINTS_X_SMALL:uint = 6;
      
      private static const OFFSET_POINTS_X_BIG:uint = 8;
      
      private static const OFFSET_POINTS_Y_SMALL:uint = 98;
      
      private static const OFFSET_POINTS_Y_BIG:uint = 60;
      
      private static const MARGIN_RIGHT_DEFAULT:int = 25;
      
      private static const MARGIN_RIGHT_SMALL:int = -5;
      
      private static const MARGIN_RIGHT_BIG:int = 80;
       
      
      public var button:EpicBattlesWidgetButton = null;
      
      public var reservesPoints:EpicReservesPointsPanel = null;
      
      private var _data:EpicBattlesWidgetVO = null;
      
      private var _tooltipMgr:ITooltipMgr;
      
      private var _isSmall:Boolean = false;
      
      public function EpicBattlesWidget()
      {
         this._tooltipMgr = App.toolTipMgr;
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.button.addEventListener(MouseEvent.CLICK,this.onClickHandler);
         this.button.addEventListener(MouseEvent.ROLL_OVER,this.onRollOverHandler);
         this.button.addEventListener(MouseEvent.ROLL_OUT,this.onRollOutHandler);
         this.button.addEventListener(EpicBattlesWidgetEvent.LAYOUT_CHANGE,this.onResizeHandler);
         App.stage.addEventListener(Event.RESIZE,this.onResizeHandler,false,0,true);
         this.mouseEnabled = false;
      }
      
      override protected function onDispose() : void
      {
         this.button.removeEventListener(MouseEvent.CLICK,this.onClickHandler);
         this.button.removeEventListener(MouseEvent.ROLL_OVER,this.onRollOverHandler);
         this.button.removeEventListener(MouseEvent.ROLL_OUT,this.onRollOutHandler);
         this.button.removeEventListener(EpicBattlesWidgetEvent.LAYOUT_CHANGE,this.onResizeHandler);
         App.stage.removeEventListener(Event.RESIZE,this.onResizeHandler);
         this.button.dispose();
         this.button = null;
         this.reservesPoints.dispose();
         this.reservesPoints = null;
         if(this._data)
         {
            this._data.dispose();
            this._data = null;
         }
         this._tooltipMgr = null;
         super.onDispose();
      }
      
      override protected function setData(param1:EpicBattlesWidgetVO) : void
      {
         this._data = param1;
         this.button.setData(param1);
         this.reservesPoints.visible = StringUtils.isNotEmpty(param1.points);
         this.reservesPoints.setData(param1.points);
         invalidateData();
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(InvalidationType.SIZE))
         {
            this._isSmall = this.isSmall;
            this.validateSize();
         }
      }
      
      private function validateSize() : void
      {
         this.button.updateSize();
         this.reservesPoints.x = (this.button.ribbonWidth >> 1) - (!!this._isSmall ? OFFSET_POINTS_X_SMALL : OFFSET_POINTS_X_BIG);
         this.reservesPoints.y = !!this._isSmall ? Number(OFFSET_POINTS_Y_SMALL) : Number(OFFSET_POINTS_Y_BIG);
         this.reservesPoints.updateSize(this._isSmall);
      }
      
      public function get marginRight() : int
      {
         if(this.reservesPoints.visible)
         {
            return !!this.isSmall ? int(MARGIN_RIGHT_SMALL) : int(MARGIN_RIGHT_BIG);
         }
         return MARGIN_RIGHT_DEFAULT;
      }
      
      public function get marginLeft() : int
      {
         return MARGIN_RIGHT_DEFAULT;
      }
      
      public function get marginTop() : int
      {
         return 0;
      }
      
      private function onClickHandler(param1:MouseEvent) : void
      {
         App.soundMgr.playControlsSnd(SoundManagerStates.SND_PRESS,SoundTypes.NORMAL_BTN,null);
         onWidgetClickS();
      }
      
      private function onRollOverHandler(param1:MouseEvent) : void
      {
         this._tooltipMgr.showSpecial(TOOLTIPS_CONSTANTS.EPIC_BATTLE_WIDGET_INFO,null);
         this.button.updateOverState(true);
         App.soundMgr.playControlsSnd(SoundManagerStates.SND_OVER,SoundTypes.NORMAL_BTN,null);
      }
      
      private function onRollOutHandler(param1:MouseEvent) : void
      {
         this._tooltipMgr.hide();
         this.button.updateOverState(false);
      }
      
      private function onResizeHandler(param1:Event) : void
      {
         invalidateSize();
      }
      
      private function onStageResizeHandler(param1:Event) : void
      {
         invalidateSize();
      }
      
      private function get isSmall() : Boolean
      {
         return App.appWidth <= StageSizeBoundaries.WIDTH_1280;
      }
   }
}
