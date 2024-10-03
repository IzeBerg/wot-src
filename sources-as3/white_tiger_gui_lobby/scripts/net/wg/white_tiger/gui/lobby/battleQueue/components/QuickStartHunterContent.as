package net.wg.white_tiger.gui.lobby.battleQueue.components
{
   import net.wg.data.constants.Values;
   import net.wg.white_tiger.gui.lobby.battleQueue.data.HunterQuickStartPanelVO;
   import net.wg.white_tiger.gui.lobby.battleQueue.data.QuickStartPanelVO;
   import net.wg.white_tiger.gui.lobby.battleQueue.events.QuickStartEvent;
   import scaleform.clik.constants.InvalidationType;
   
   public class QuickStartHunterContent extends QuickStartContentBase
   {
      
      protected static const WIDTH_BIG:int = 952;
      
      protected static const WIDTH_SMALL:int = 816;
      
      protected static const HEIGHT_BIG:int = 202;
      
      protected static const HEIGHT_SMALL:int = 184;
      
      private static const LIST_Y_BIG:int = 76;
      
      private static const LIST_Y_SMALL:int = 69;
      
      private static const GAP:int = 16;
      
      private static const INFO_OFFSET_Y_BIG:int = 28;
      
      private static const QUICK_START_BTN_OFFSET_Y_BIG:int = 24;
      
      private static const INFO_OFFSET_Y_SMALL:int = 26;
      
      private static const QUICK_START_BTN_OFFSET_Y_SMALL:int = 22;
       
      
      public var vehicleList:QuickStartVehicleList = null;
      
      private var _data:HunterQuickStartPanelVO = null;
      
      public function QuickStartHunterContent()
      {
         super();
      }
      
      override public function setData(param1:QuickStartPanelVO) : void
      {
         this._data = HunterQuickStartPanelVO(param1);
         this.vehicleList.setItems(this._data.hunters);
         invalidateData();
      }
      
      override protected function onDispose() : void
      {
         this.vehicleList.removeEventListener(QuickStartEvent.VEHICLE_SELECTED,this.onQuickStartVehicleSelected);
         this.vehicleList.dispose();
         this.vehicleList = null;
         this._data = null;
         super.onDispose();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.vehicleList.addEventListener(QuickStartEvent.VEHICLE_SELECTED,this.onQuickStartVehicleSelected);
         quickStartBtn.visible = false;
      }
      
      override protected function draw() : void
      {
         var _loc1_:String = null;
         var _loc2_:String = null;
         var _loc3_:String = null;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         super.draw();
         if(this._data)
         {
            if(isInvalid(InvalidationType.STATE,InvalidationType.DATA))
            {
               if(isVehicleSelected)
               {
                  _loc1_ = this.vehicleList.selectedVehicle.name;
                  _loc2_ = App.utils.locale.makeString(EVENT.BATTLEQUEUE_WIDGET_CHANGETITLE,{"vehicle":_loc1_});
                  _loc3_ = App.utils.locale.makeString(EVENT.BATTLEQUEUE_WIDGET_BTNLABEL,{"vehicle":_loc1_});
                  quickStartBtn.enabled = !this.vehicleList.selectedVehicle.isInBattle;
                  quickStartBtn.visible = true;
                  quickStartBtn.label = _loc3_;
                  infoText.text = _loc2_;
               }
               else
               {
                  quickStartBtn.visible = false;
                  infoText.text = EVENT.BATTLEQUEUE_WIDGET_OFFERHUNTERTTILE;
               }
               invalidateSize();
            }
            if(isInvalid(InvalidationType.SIZE))
            {
               App.utils.commons.updateTextFieldSize(infoText);
               rect.width = width;
               infoText.y = Boolean(rect.y + isSmall) ? Number(INFO_OFFSET_Y_SMALL) : Number(INFO_OFFSET_Y_BIG);
               quickStartBtn.y = Boolean(rect.y + isSmall) ? Number(QUICK_START_BTN_OFFSET_Y_SMALL) : Number(QUICK_START_BTN_OFFSET_Y_BIG);
               this.vehicleList.y = !!isSmall ? Number(LIST_Y_SMALL) : Number(LIST_Y_BIG);
               _loc4_ = infoText.textWidth;
               if(isVehicleSelected)
               {
                  _loc5_ = _loc4_ + GAP + quickStartBtn.width;
                  infoText.x = width - _loc5_ >> 1;
                  quickStartBtn.x = infoText.x + _loc4_ + GAP;
               }
               else
               {
                  infoText.x = width - _loc4_ >> 1;
               }
            }
         }
      }
      
      override protected function updateSize() : void
      {
         var _loc1_:int = !!isSmall ? int(WIDTH_SMALL) : int(WIDTH_BIG);
         var _loc2_:int = !!isSmall ? int(HEIGHT_SMALL) : int(HEIGHT_BIG);
         setSize(_loc1_,_loc2_);
      }
      
      override public function set isSmall(param1:Boolean) : void
      {
         super.isSmall = this.vehicleList.isSmall = param1;
      }
      
      override public function get selectedVehId() : int
      {
         return Boolean(this.vehicleList.selectedVehicle) ? int(this.vehicleList.selectedVehicle.vehID) : int(Values.DEFAULT_INT);
      }
      
      private function onQuickStartVehicleSelected(param1:QuickStartEvent) : void
      {
         invalidateState();
      }
   }
}
