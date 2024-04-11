package net.wg.gui.battle.views.mapInfoTip
{
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import net.wg.infrastructure.base.meta.IMapInfoTipMeta;
   import net.wg.infrastructure.base.meta.impl.MapInfoTipMeta;
   import net.wg.infrastructure.managers.ITooltipMgr;
   
   public class MapInfoTip extends MapInfoTipMeta implements IMapInfoTipMeta
   {
      
      private static const MAP_INFO_WIDTH_BREAKPOINT:uint = 1366;
      
      private static const MAP_INFO_LINE_HEIGHT:uint = 20;
      
      private static const MAP_INFO_WIDTH_SMALL:uint = 140;
      
      private static const MAP_INFO_WIDTH_BIG:uint = 300;
      
      private static const OFFSET_MAP_INFO_Y:uint = 9;
      
      private static const OFFSET_MAP_INFO_Y_LARGE:int = -1;
       
      
      public var mapInfoTipTF:TextField;
      
      private var _tooltipMgr:ITooltipMgr;
      
      private var _mapInfoTipVisible:Boolean = false;
      
      public function MapInfoTip()
      {
         this._tooltipMgr = App.toolTipMgr;
         super();
      }
      
      override protected function configUI() : void
      {
         this.mapInfoTipTF.text = INGAME_GUI.DEVMAPS_MAPINFO_TEXT;
         this.mapInfoTipTF.addEventListener(MouseEvent.MOUSE_OVER,this.onMapInfoTipMouseOverHandler);
         this.mapInfoTipTF.addEventListener(MouseEvent.MOUSE_OUT,this.onMapInfoTipMouseOutHandler);
         this.mapInfoTipTF.visible = this._mapInfoTipVisible;
         this.updateLayout(App.appWidth);
         super.configUI();
      }
      
      override protected function onBeforeDispose() : void
      {
         this.mapInfoTipTF.removeEventListener(MouseEvent.MOUSE_OVER,this.onMapInfoTipMouseOverHandler);
         this.mapInfoTipTF.removeEventListener(MouseEvent.MOUSE_OUT,this.onMapInfoTipMouseOutHandler);
         super.onBeforeDispose();
      }
      
      override protected function onDispose() : void
      {
         this.mapInfoTipTF = null;
         this._tooltipMgr = null;
         super.onDispose();
      }
      
      public function as_setEnabled(param1:Boolean) : void
      {
         if(this._mapInfoTipVisible != param1)
         {
            this._mapInfoTipVisible = param1;
            this.mapInfoTipTF.visible = this._mapInfoTipVisible;
         }
      }
      
      public function updateLayout(param1:Number) : void
      {
         var _loc2_:Boolean = param1 <= MAP_INFO_WIDTH_BREAKPOINT;
         this.mapInfoTipTF.width = !!_loc2_ ? Number(MAP_INFO_WIDTH_SMALL) : Number(MAP_INFO_WIDTH_BIG);
         App.utils.commons.updateTextFieldSize(this.mapInfoTipTF,true,true);
         this.mapInfoTipTF.x = MAP_INFO_WIDTH_BIG - this.mapInfoTipTF.width | 0;
         this.mapInfoTipTF.y = this.mapInfoTipTF.height > MAP_INFO_LINE_HEIGHT ? Number(OFFSET_MAP_INFO_Y_LARGE) : Number(OFFSET_MAP_INFO_Y);
      }
      
      private function onMapInfoTipMouseOutHandler(param1:MouseEvent) : void
      {
         this._tooltipMgr.hide();
      }
      
      private function onMapInfoTipMouseOverHandler(param1:MouseEvent) : void
      {
         this._tooltipMgr.show(INGAME_GUI.DEVMAPS_MAPINFO_INFO);
      }
   }
}
