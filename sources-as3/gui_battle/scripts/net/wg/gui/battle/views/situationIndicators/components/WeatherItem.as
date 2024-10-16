package net.wg.gui.battle.views.situationIndicators.components
{
   import flash.events.MouseEvent;
   import net.wg.data.constants.BaseTooltips;
   import net.wg.data.constants.InvalidationType;
   import net.wg.data.managers.impl.TooltipProps;
   import net.wg.gui.battle.components.BattleAtlasSprite;
   import net.wg.gui.battle.components.BattleUIComponent;
   import net.wg.gui.battle.views.situationIndicators.data.WeatherItemVO;
   import net.wg.gui.battle.views.situationIndicators.events.SituationIndicatorsPanelEvent;
   import net.wg.gui.utils.FrameHelper;
   import net.wg.infrastructure.managers.ITooltipMgr;
   
   public class WeatherItem extends BattleUIComponent
   {
      
      private static const SHOW_FRAME:String = "show";
      
      private static const HIDE_FRAME:String = "hide";
      
      private static const SHOW_END_FRAME:String = "showLast";
      
      private static const HIDE_END_FRAME:String = "hideLast";
      
      private static const TOOLTIP_WIDTH:uint = 400;
       
      
      public var iconFront:BattleAtlasSprite = null;
      
      public var iconBack:BattleAtlasSprite = null;
      
      private var _frameHelper:FrameHelper = null;
      
      private var _weatherName:String;
      
      private var _state:int = 0;
      
      private var _tooltipMgr:ITooltipMgr;
      
      private var _toolTip:String = null;
      
      public function WeatherItem()
      {
         this._weatherName = String.prototype;
         this._tooltipMgr = App.toolTipMgr;
         super();
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         this._frameHelper = new FrameHelper(this);
         this.iconFront.isCentralize = this.iconBack.isCentralize = true;
         this.iconFront.isSmoothingEnabled = this.iconBack.isSmoothingEnabled = true;
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         hitArea = this.iconBack;
         this.iconFront.mouseChildren = this.iconFront.mouseEnabled = false;
         this.addEventListener(MouseEvent.MOUSE_OVER,this.onRollOverHandler);
         this.addEventListener(MouseEvent.ROLL_OUT,this.onRollOutHandler);
      }
      
      override protected function draw() : void
      {
         if(isInvalid(InvalidationType.STATE))
         {
            switch(this._state)
            {
               case WeatherItemVO.STATE_ACTIVE:
                  this.show();
                  break;
               case WeatherItemVO.STATE_INACTIVE:
                  this.hide();
            }
         }
      }
      
      override protected function onDispose() : void
      {
         this.removeEventListener(MouseEvent.ROLL_OVER,this.onRollOverHandler);
         this.removeEventListener(MouseEvent.ROLL_OUT,this.onRollOutHandler);
         this._frameHelper.dispose();
         this._frameHelper = null;
         this.iconFront = null;
         this.iconBack = null;
         this._tooltipMgr = null;
         super.onDispose();
      }
      
      private function hide() : void
      {
         var _loc1_:int = this._frameHelper.getFrameByLabel(HIDE_END_FRAME);
         this._frameHelper.addScriptToFrame(_loc1_,this.onHideAnimComplete);
         gotoAndPlay(HIDE_FRAME);
      }
      
      private function show() : void
      {
         var _loc1_:int = this._frameHelper.getFrameByLabel(SHOW_END_FRAME);
         this._frameHelper.addScriptToFrame(_loc1_,this.onShowAnimComplete);
         gotoAndPlay(SHOW_FRAME);
      }
      
      private function onShowAnimComplete() : void
      {
         this._frameHelper.removeScriptFromFrame(this._frameHelper.getFrameByLabel(SHOW_END_FRAME));
         gotoAndStop(this._frameHelper.getFrameByLabel(SHOW_END_FRAME));
         dispatchEvent(new SituationIndicatorsPanelEvent(SituationIndicatorsPanelEvent.SHOW_ITEM_ANIM_COMPLETE,true,true));
      }
      
      private function onHideAnimComplete() : void
      {
         this._frameHelper.removeScriptFromFrame(this._frameHelper.getFrameByLabel(HIDE_END_FRAME));
         gotoAndStop(this._frameHelper.getFrameByLabel(HIDE_END_FRAME));
         dispatchEvent(new SituationIndicatorsPanelEvent(SituationIndicatorsPanelEvent.HIDE_ITEM_ANIM_COMPLETE,true,true));
      }
      
      public function get weatherName() : String
      {
         return this._weatherName;
      }
      
      public function set weatherName(param1:String) : void
      {
         if(this._weatherName == param1)
         {
            return;
         }
         this._weatherName = param1;
         this.iconFront.imageName = this.iconBack.imageName = this._weatherName;
      }
      
      public function set state(param1:int) : void
      {
         if(this._state == param1)
         {
            return;
         }
         this._state = param1;
         invalidateState();
      }
      
      public function set toolTip(param1:String) : void
      {
         this._toolTip = param1;
      }
      
      private function onRollOverHandler(param1:MouseEvent) : void
      {
         this._tooltipMgr.showComplex(this._toolTip,new TooltipProps(BaseTooltips.TYPE_INFO,0,0,0,-1,0,TOOLTIP_WIDTH));
      }
      
      private function onRollOutHandler(param1:MouseEvent) : void
      {
         this._tooltipMgr.hide();
      }
   }
}
