package net.wg.gui.lobby.rankedBattles19.view.seasonComplete
{
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import net.wg.gui.components.controls.Image;
   import net.wg.infrastructure.managers.ITooltipMgr;
   import org.idmedia.as3commons.util.StringUtils;
   
   public class SeasonPlaceResultRenderer extends SeasonResultRenderer
   {
      
      private static const INFO_ICON_OFFSET_Y:int = 4;
      
      private static const INFO_ICON_OFFSET_X:int = 4;
       
      
      public var infoIcon:Image = null;
      
      public var position:MovieClip = null;
      
      private var _tooltip:String = null;
      
      private var _tooltipMgr:ITooltipMgr;
      
      public function SeasonPlaceResultRenderer()
      {
         this._tooltipMgr = App.toolTipMgr;
         super();
      }
      
      override protected function onDispose() : void
      {
         this.infoIcon.removeEventListener(MouseEvent.ROLL_OVER,this.onInfoIconRollOverHandler);
         this.infoIcon.removeEventListener(MouseEvent.ROLL_OUT,this.onInfoIconRollOutHandler);
         this.infoIcon.dispose();
         this.infoIcon = null;
         this.position = null;
         this._tooltipMgr = null;
         super.onDispose();
      }
      
      public function setInfoTooltip(param1:String) : void
      {
         if(StringUtils.isNotEmpty(param1) && this._tooltip != param1)
         {
            this._tooltip = param1;
            this.infoIcon.source = RES_ICONS.MAPS_ICONS_LIBRARY_INFORMATIONICON;
            this.infoIcon.addEventListener(MouseEvent.ROLL_OVER,this.onInfoIconRollOverHandler);
            this.infoIcon.addEventListener(MouseEvent.ROLL_OUT,this.onInfoIconRollOutHandler);
            App.utils.commons.updateTextFieldSize(labelTF,true,false);
            labelTF.x = (this.position.width - labelTF.width >> 1) + this.position.x;
            this.infoIcon.x = labelTF.x + labelTF.width + INFO_ICON_OFFSET_X | 0;
            this.infoIcon.y = labelTF.y + INFO_ICON_OFFSET_Y | 0;
         }
      }
      
      private function onInfoIconRollOverHandler(param1:MouseEvent) : void
      {
         this._tooltipMgr.showSpecial(this._tooltip,null);
      }
      
      private function onInfoIconRollOutHandler(param1:MouseEvent) : void
      {
         this._tooltipMgr.hide();
      }
   }
}
