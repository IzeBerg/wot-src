package net.wg.gui.lobby.training
{
   import flash.events.MouseEvent;
   import net.wg.data.VO.TrainingRoomRendererVO;
   import net.wg.data.constants.Values;
   import net.wg.gui.components.controls.UILoaderAlt;
   import net.wg.infrastructure.managers.ITooltipMgr;
   import org.idmedia.as3commons.util.StringUtils;
   
   public class TrainingPlayerItemRendererEpic extends TrainingPlayerItemRendererBase
   {
       
      
      public var statusIco:UILoaderAlt = null;
      
      private var _tooltipMgr:ITooltipMgr;
      
      private var _playerState:String = "";
      
      public function TrainingPlayerItemRendererEpic()
      {
         super();
         this._tooltipMgr = App.toolTipMgr;
      }
      
      override protected function onDispose() : void
      {
         this.statusIco.removeEventListener(MouseEvent.MOUSE_OVER,this.onStatusIconMouseOverHandler);
         this.statusIco.removeEventListener(MouseEvent.MOUSE_OUT,this.onStatusIconMouseOutHandler);
         this.statusIco.removeEventListener(MouseEvent.CLICK,this.onStatusIconClickHandler);
         this._tooltipMgr = null;
         this.statusIco.dispose();
         this.statusIco = null;
         super.onDispose();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.statusIco.addEventListener(MouseEvent.MOUSE_OVER,this.onStatusIconMouseOverHandler);
         this.statusIco.addEventListener(MouseEvent.MOUSE_OUT,this.onStatusIconMouseOutHandler);
         this.statusIco.addEventListener(MouseEvent.CLICK,this.onStatusIconClickHandler);
      }
      
      override protected function doUpdateData(param1:TrainingRoomRendererVO) : void
      {
         super.doUpdateData(param1);
         if(StringUtils.isNotEmpty(param1.stateString))
         {
            this._playerState = param1.stateString;
            this.statusIco.visible = true;
            this.statusIco.source = RES_ICONS.MAPS_ICONS_LIBRARY_CANCELICON_1;
         }
         else
         {
            this._playerState = Values.EMPTY_STR;
            this.statusIco.visible = false;
         }
      }
      
      override protected function resetData() : void
      {
         super.resetData();
         this.statusIco.unload();
         this.statusIco.visible = false;
      }
      
      private function onStatusIconMouseOverHandler(param1:MouseEvent) : void
      {
         if(StringUtils.isNotEmpty(this._playerState))
         {
            this._tooltipMgr.show(this._playerState);
         }
      }
      
      private function onStatusIconMouseOutHandler(param1:MouseEvent) : void
      {
         this._tooltipMgr.hide();
         var _loc2_:Boolean = updateHoverState();
         if(_loc2_)
         {
            dispatchEvent(new MouseEvent(MouseEvent.ROLL_OVER));
         }
      }
      
      private function onStatusIconClickHandler(param1:MouseEvent) : void
      {
         this._tooltipMgr.hide();
      }
   }
}
