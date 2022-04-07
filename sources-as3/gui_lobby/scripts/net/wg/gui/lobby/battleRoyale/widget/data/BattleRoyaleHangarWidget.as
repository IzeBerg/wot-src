package net.wg.gui.lobby.battleRoyale.widget.data
{
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import net.wg.data.constants.SoundManagerStates;
   import net.wg.data.constants.SoundTypes;
   import net.wg.gui.lobby.hangar.alertMessage.AlertMessageBlock;
   import net.wg.gui.lobby.hangar.quests.IHeaderFlagsEntryPoint;
   import net.wg.infrastructure.base.meta.IBattleRoyaleHangarWidgetMeta;
   import net.wg.infrastructure.base.meta.impl.BattleRoyaleHangarWidgetMeta;
   import net.wg.infrastructure.managers.ITooltipMgr;
   import net.wg.utils.IStageSizeDependComponent;
   import net.wg.utils.StageSizeBoundaries;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.gfx.MouseEventEx;
   
   public class BattleRoyaleHangarWidget extends BattleRoyaleHangarWidgetMeta implements IBattleRoyaleHangarWidgetMeta, IHeaderFlagsEntryPoint, IStageSizeDependComponent
   {
      
      private static const BG_NORMAL_Y_OFFSET:int = -1;
      
      private static const ALERT_BG_Y_OFFSET:int = 39;
      
      private static const MARGIN_LEFT:int = 12;
      
      private static const MARGIN_LEFT_SMALL:int = 7;
      
      private static const OUT_LABEL:String = "out";
      
      private static const OVER_LABEL:String = "over";
       
      
      public var hit:MovieClip = null;
      
      public var calendarStatus:AlertMessageBlock = null;
      
      public var content:BattleRoyaleHangarWidgetContent = null;
      
      private var _tooltipId:String = "";
      
      private var _toolTipMgr:ITooltipMgr;
      
      private var _isCompactLayout:Boolean = false;
      
      private var _data:BattleRoyaleHangarWidgetVO = null;
      
      public function BattleRoyaleHangarWidget()
      {
         this._toolTipMgr = App.toolTipMgr;
         super();
      }
      
      override public function get width() : Number
      {
         return this.content.width;
      }
      
      override public function get height() : Number
      {
         return this.content.height;
      }
      
      public function get marginRight() : int
      {
         return 0;
      }
      
      public function get marginLeft() : int
      {
         return !!this._isCompactLayout ? int(MARGIN_LEFT_SMALL) : int(MARGIN_LEFT);
      }
      
      public function get marginTop() : int
      {
         return this.hit.y;
      }
      
      public function setStateSizeBoundaries(param1:int, param2:int) : void
      {
         this._isCompactLayout = param1 <= StageSizeBoundaries.WIDTH_1024 || param2 <= StageSizeBoundaries.HEIGHT_800;
         invalidateLayout();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         App.stageSizeMgr.register(this);
         this.hit.buttonMode = this.hit.useHandCursor = true;
         this.hit.addEventListener(MouseEvent.ROLL_OUT,this.onMouseRollOutHandler);
         this.hit.addEventListener(MouseEvent.ROLL_OVER,this.onMouseRollOverHandler);
         this.hit.addEventListener(MouseEvent.CLICK,this.onMouseClickHandler);
         this.calendarStatus.x = -this.calendarStatus.width >> 1;
         this.content.addEventListener(Event.RESIZE,this.onContentResizeHandler);
      }
      
      override protected function setData(param1:BattleRoyaleHangarWidgetVO) : void
      {
         this._data = param1;
         this._tooltipId = param1.tooltipId;
         this.hit.y = !!this._data.showAlert ? Number(ALERT_BG_Y_OFFSET) : Number(BG_NORMAL_Y_OFFSET);
         this.content.yOffset = this.hit.y;
         invalidateData();
      }
      
      override protected function draw() : void
      {
         var _loc1_:Boolean = false;
         super.draw();
         if(isInvalid(InvalidationType.DATA))
         {
            if(this._data)
            {
               _loc1_ = this.calendarStatus.visible != this._data.showAlert;
               this.calendarStatus.visible = this._data.showAlert;
               this.calendarStatus.setLocalData(this._data.calendarStatus);
               this.calendarStatus.btnClickHandler = onChangeServerClickS;
               if(_loc1_)
               {
                  dispatchEvent(new Event(Event.RESIZE));
               }
               if(this._data.isSeasonActive)
               {
                  this.content.setIcon(!!this._isCompactLayout ? RES_ICONS.MAPS_ICONS_BATTLEROYALE_TITLES_130X130_BG1 : RES_ICONS.MAPS_ICONS_BATTLEROYALE_TITLES_150X150_BG1);
               }
               else
               {
                  this.content.setIcon(!!this._isCompactLayout ? RES_ICONS.MAPS_ICONS_BATTLEROYALE_TITLES_130X130_BG0 : RES_ICONS.MAPS_ICONS_BATTLEROYALE_TITLES_150X150_BG0);
               }
               this.content.setEpisode(this._data.episode);
            }
            else
            {
               this.content.setIcon(!!this._isCompactLayout ? RES_ICONS.MAPS_ICONS_BATTLEROYALE_TITLES_130X130_BG0 : RES_ICONS.MAPS_ICONS_BATTLEROYALE_TITLES_150X150_BG0);
            }
         }
         if(isInvalid(InvalidationType.LAYOUT))
         {
            this.content.isCompact = this._isCompactLayout;
            this.content.setBgIcon(!!this._isCompactLayout ? RES_ICONS.MAPS_ICONS_BATTLEROYALE_RIBBON_MEDIUM : RES_ICONS.MAPS_ICONS_BATTLEROYALE_RIBBON_BIG);
         }
      }
      
      override protected function onDispose() : void
      {
         App.stageSizeMgr.unregister(this);
         this.hit.removeEventListener(MouseEvent.ROLL_OUT,this.onMouseRollOutHandler);
         this.hit.removeEventListener(MouseEvent.ROLL_OVER,this.onMouseRollOverHandler);
         this.hit.removeEventListener(MouseEvent.CLICK,this.onMouseClickHandler);
         this.hit = null;
         this.calendarStatus.dispose();
         this.calendarStatus = null;
         this.content.removeEventListener(Event.RESIZE,this.onContentResizeHandler);
         this.content.dispose();
         this.content = null;
         this._toolTipMgr = null;
         this._data = null;
         super.onDispose();
      }
      
      private function onMouseRollOutHandler(param1:MouseEvent) : void
      {
         this._toolTipMgr.hide();
         gotoAndPlay(OUT_LABEL);
      }
      
      private function onMouseRollOverHandler(param1:MouseEvent) : void
      {
         App.soundMgr.playControlsSnd(SoundManagerStates.SND_OVER,SoundTypes.NORMAL_BTN,null);
         this._toolTipMgr.showSpecial(this._tooltipId,null);
         gotoAndPlay(OVER_LABEL);
      }
      
      private function onMouseClickHandler(param1:MouseEvent) : void
      {
         var _loc2_:MouseEventEx = param1 as MouseEventEx;
         var _loc3_:uint = _loc2_ == null ? uint(0) : uint(_loc2_.buttonIdx);
         if(_loc3_ == MouseEventEx.LEFT_BUTTON)
         {
            App.soundMgr.playControlsSnd(SoundManagerStates.SND_PRESS,SoundTypes.NORMAL_BTN,null);
            onClickS();
         }
      }
      
      private function onContentResizeHandler(param1:Event) : void
      {
         this.hit.width = this.content.width;
         this.hit.height = this.content.height;
         dispatchEvent(new Event(Event.RESIZE));
      }
   }
}
