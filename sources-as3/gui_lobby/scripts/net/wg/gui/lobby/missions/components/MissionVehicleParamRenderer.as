package net.wg.gui.lobby.missions.components
{
   import flash.events.MouseEvent;
   import net.wg.gui.components.controls.Image;
   import net.wg.gui.lobby.missions.data.MissionVehicleParamRendererVO;
   import net.wg.infrastructure.base.UIComponentEx;
   import net.wg.infrastructure.managers.ITooltipMgr;
   import org.idmedia.as3commons.util.StringUtils;
   import scaleform.clik.core.UIComponent;
   import scaleform.clik.data.ListData;
   import scaleform.clik.interfaces.IListItemRenderer;
   
   public class MissionVehicleParamRenderer extends UIComponentEx implements IListItemRenderer
   {
       
      
      public var img:Image = null;
      
      private var _data:MissionVehicleParamRendererVO = null;
      
      private var _toolTipMgr:ITooltipMgr;
      
      public function MissionVehicleParamRenderer()
      {
         this._toolTipMgr = App.toolTipMgr;
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         addEventListener(MouseEvent.ROLL_OVER,this.onRollOverHandler);
         addEventListener(MouseEvent.ROLL_OUT,this.onRollOutHandler);
      }
      
      override protected function onDispose() : void
      {
         removeEventListener(MouseEvent.ROLL_OVER,this.onRollOverHandler);
         removeEventListener(MouseEvent.ROLL_OUT,this.onRollOutHandler);
         this.img.dispose();
         this.img = null;
         this._data = null;
         this._toolTipMgr = null;
         super.onDispose();
      }
      
      public function getData() : Object
      {
         return null;
      }
      
      public function setData(param1:Object) : void
      {
         this._data = MissionVehicleParamRendererVO(param1);
         this.img.source = this._data.icon;
      }
      
      public function setListData(param1:ListData) : void
      {
      }
      
      public function get index() : uint
      {
         return 0;
      }
      
      public function set index(param1:uint) : void
      {
      }
      
      public function get owner() : UIComponent
      {
         return null;
      }
      
      public function set owner(param1:UIComponent) : void
      {
      }
      
      public function get selectable() : Boolean
      {
         return false;
      }
      
      public function set selectable(param1:Boolean) : void
      {
      }
      
      public function get selected() : Boolean
      {
         return false;
      }
      
      public function set selected(param1:Boolean) : void
      {
      }
      
      private function onRollOutHandler(param1:MouseEvent) : void
      {
         this._toolTipMgr.hide();
      }
      
      private function onRollOverHandler(param1:MouseEvent) : void
      {
         if(StringUtils.isNotEmpty(this._data.tooltip))
         {
            this._toolTipMgr.show(this._data.tooltip);
         }
      }
   }
}
