package net.wg.gui.lobby.sessionStats.components
{
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import net.wg.data.constants.Values;
   import net.wg.data.constants.generated.TOOLTIPS_CONSTANTS;
   import net.wg.data.managers.impl.TooltipProps;
   import net.wg.gui.components.controls.Image;
   import net.wg.gui.lobby.sessionStats.data.SessionVehicleStatsRendererVO;
   import net.wg.infrastructure.base.UIComponentEx;
   import net.wg.infrastructure.interfaces.entity.IUpdatable;
   import org.idmedia.as3commons.util.StringUtils;
   import scaleform.clik.constants.InvalidationType;
   
   public class SessionVehicleStatsRenderer extends UIComponentEx implements IUpdatable
   {
      
      private static const MIN_SCREEN_SIZE:int = 800;
      
      private static const SCREEN_SIZE_INFO_POSITION_X:int = 865;
      
      private static const SCREEN_SIZE_INFO_POSITION_Y:int = 33;
      
      private static const MIN_SCREEN_SIZE_INFO_POSITION_Y:int = 688;
       
      
      public var flag:Image = null;
      
      public var icon:Image = null;
      
      public var level:MovieClip = null;
      
      public var label:TextField = null;
      
      public var type:MovieClip = null;
      
      public var total:TextField = null;
      
      public var damage:TextField = null;
      
      public var rate:SessionStatsRateComponent = null;
      
      private var _data:SessionVehicleStatsRendererVO = null;
      
      private var _levelPosX:int;
      
      public function SessionVehicleStatsRenderer()
      {
         super();
         this._levelPosX = this.level.x;
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         addEventListener(MouseEvent.ROLL_OVER,this.onMouseRollOverHandler);
         addEventListener(MouseEvent.ROLL_OUT,this.onMouseRollOutHandler);
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(InvalidationType.DATA) && this._data)
         {
            this.level.visible = this._data.level != Values.DEFAULT_INT;
            if(this.level.visible)
            {
               this.level.gotoAndStop(this._data.level);
            }
            this.type.visible = StringUtils.isNotEmpty(this._data.type);
            if(this.type.visible)
            {
               this.type.gotoAndStop(this._data.type);
            }
            this.label.htmlText = this._data.label;
            this.icon.source = this._data.icon;
            this.flag.source = this._data.nationIcon;
            this.total.htmlText = this._data.total;
            this.damage.htmlText = this._data.damage;
            this.rate.value = this._data.wtr;
            if(this._data.delta)
            {
               this.rate.delta = this._data.delta.value;
               this.rate.icon = this._data.delta.icon;
            }
            this.level.x = this._levelPosX - (this.level.width >> 1);
         }
      }
      
      override protected function onDispose() : void
      {
         removeEventListener(MouseEvent.ROLL_OVER,this.onMouseRollOverHandler);
         removeEventListener(MouseEvent.ROLL_OUT,this.onMouseRollOutHandler);
         this.flag.dispose();
         this.flag = null;
         this.icon.dispose();
         this.icon = null;
         this.rate.dispose();
         this.rate = null;
         this.label = null;
         this.type = null;
         this.level = null;
         this.total = null;
         this.damage = null;
         this._data = null;
         super.onDispose();
      }
      
      public function update(param1:Object) : void
      {
         this._data = SessionVehicleStatsRendererVO(param1);
         invalidateData();
      }
      
      private function onMouseRollOverHandler(param1:MouseEvent) : void
      {
         var _loc2_:Boolean = false;
         var _loc3_:int = 0;
         var _loc4_:TooltipProps = null;
         if(this._data.intCD != Values.DEFAULT_INT)
         {
            _loc2_ = App.appHeight < MIN_SCREEN_SIZE;
            _loc3_ = !!_loc2_ ? int(MIN_SCREEN_SIZE_INFO_POSITION_Y) : int(SCREEN_SIZE_INFO_POSITION_Y);
            _loc4_ = new TooltipProps(TOOLTIPS_CONSTANTS.SESSION_STATS_TANK_INFO,App.appWidth - SCREEN_SIZE_INFO_POSITION_X,App.appHeight - _loc3_);
            App.toolTipMgr.showSpecial(TOOLTIPS_CONSTANTS.SESSION_STATS_TANK_INFO,_loc4_,this._data.intCD,_loc2_);
         }
      }
      
      private function onMouseRollOutHandler(param1:MouseEvent) : void
      {
         App.toolTipMgr.hide();
      }
   }
}
