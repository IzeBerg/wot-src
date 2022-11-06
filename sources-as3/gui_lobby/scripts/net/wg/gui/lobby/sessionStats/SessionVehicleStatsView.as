package net.wg.gui.lobby.sessionStats
{
   import flash.display.InteractiveObject;
   import flash.display.MovieClip;
   import flash.text.TextField;
   import net.wg.data.constants.Linkages;
   import net.wg.gui.components.containers.GroupEx;
   import net.wg.gui.components.containers.VerticalGroupLayout;
   import net.wg.gui.lobby.components.IResizableContent;
   import net.wg.gui.lobby.components.ImageWrapper;
   import net.wg.gui.lobby.sessionStats.data.SessionVehicleStatsViewVO;
   import net.wg.infrastructure.base.meta.impl.SessionVehicleStatsViewMeta;
   import scaleform.clik.constants.InvalidationType;
   
   public class SessionVehicleStatsView extends SessionVehicleStatsViewMeta implements IResizableContent
   {
      
      private static const RENDERER_HEIGHT:int = 31;
      
      private static const GAP:int = 10;
       
      
      public var headerName:TextField = null;
      
      public var totalIcon:ImageWrapper = null;
      
      public var damageIcon:ImageWrapper = null;
      
      public var wtrIcon:ImageWrapper = null;
      
      public var vehicles:GroupEx = null;
      
      public var vehiclesMask:MovieClip = null;
      
      private var _data:SessionVehicleStatsViewVO = null;
      
      public function SessionVehicleStatsView()
      {
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         var _loc1_:VerticalGroupLayout = new VerticalGroupLayout();
         _loc1_.gap = GAP;
         this.vehicles.layout = _loc1_;
         this.vehicles.itemRendererLinkage = Linkages.SESSION_VEHICLE_STATS_RENDERER_UI;
         this.vehicles.mask = this.vehiclesMask;
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(this._data && isInvalid(InvalidationType.DATA))
         {
            this.headerName.htmlText = this._data.headerName;
            this.totalIcon.source = this._data.headerTotalIcon;
            this.totalIcon.tooltip = this._data.headerTotalTooltip;
            this.damageIcon.source = this._data.headerDamageIcon;
            this.damageIcon.tooltip = this._data.headerDamageTooltip;
            this.wtrIcon.source = this._data.headerWtrIcon;
            this.wtrIcon.tooltip = this._data.headerWtrTooltip;
            this.vehicles.dataProvider = this._data.vehicles;
         }
      }
      
      override protected function onDispose() : void
      {
         this.vehicles.dispose();
         this.vehicles = null;
         this.totalIcon.dispose();
         this.totalIcon = null;
         this.damageIcon.dispose();
         this.damageIcon = null;
         this.wtrIcon.dispose();
         this.wtrIcon = null;
         this.headerName = null;
         this.vehiclesMask = null;
         this._data = null;
         super.onDispose();
      }
      
      override protected function setData(param1:SessionVehicleStatsViewVO) : void
      {
         this._data = param1;
         invalidateData();
      }
      
      public function canShowAutomatically() : Boolean
      {
         return true;
      }
      
      public function update(param1:Object) : void
      {
      }
      
      public function getComponentForFocus() : InteractiveObject
      {
         return this;
      }
      
      public function setViewSize(param1:Number, param2:Number) : void
      {
         var _loc3_:int = param2 - this.vehicles.y;
         this.vehiclesMask.height = _loc3_ - _loc3_ % (RENDERER_HEIGHT + GAP);
         this.vehiclesMask.width = param1;
      }
      
      public function get centerOffset() : int
      {
         return 0;
      }
      
      public function set centerOffset(param1:int) : void
      {
      }
      
      public function get active() : Boolean
      {
         return false;
      }
      
      public function set active(param1:Boolean) : void
      {
      }
   }
}
