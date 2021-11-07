package net.wg.gui.battle.views.battleTankCarousel.data
{
   import net.wg.data.constants.Values;
   import net.wg.data.daapi.base.DAAPIUpdatableDataClass;
   import net.wg.gui.components.carousels.data.CarouselLevelInfoVO;
   import net.wg.gui.components.controls.scroller.data.IScrollerItemRendererData;
   
   public class BattleVehicleCarouselVO extends DAAPIUpdatableDataClass implements IScrollerItemRendererData
   {
      
      private static const LEVEL_INFO_FIELD:String = "levelInfo";
       
      
      public var vehicleID:int = -1;
      
      public var flagIcon:String = "";
      
      public var vehicleIcon:String = "";
      
      public var vehicleTypeIcon:String = "";
      
      public var vehicleLevelIcon:String = "";
      
      public var vehicleName:String = "";
      
      public var isElite:Boolean = false;
      
      public var isPremium:Boolean = false;
      
      public var favorite:Boolean = false;
      
      public var enabled:Boolean = false;
      
      public var cooldown:String = "";
      
      public var settings:int = -1;
      
      public var levelInfo:CarouselLevelInfoVO = null;
      
      private var _hasExtendedInfo:Boolean = false;
      
      public function BattleVehicleCarouselVO(param1:Object)
      {
         super(param1);
      }
      
      override protected function onDataWrite(param1:String, param2:Object) : Boolean
      {
         if(param1 == LEVEL_INFO_FIELD)
         {
            this.levelInfo = new CarouselLevelInfoVO(param2);
            this._hasExtendedInfo = this.levelInfo != null && this.levelInfo.level > 0;
            return false;
         }
         return super.onDataWrite(param1,param2);
      }
      
      override protected function onDispose() : void
      {
         if(this.levelInfo != null)
         {
            this.levelInfo.dispose();
            this.levelInfo = null;
         }
         super.onDispose();
      }
      
      public function get hasExtendedInfo() : Boolean
      {
         return this._hasExtendedInfo;
      }
      
      public function get isItemExtended() : Boolean
      {
         return this._hasExtendedInfo && !this.levelInfo.isCollapsed;
      }
      
      public function get isItemExtendendable() : Boolean
      {
         return this._hasExtendedInfo && this.levelInfo.isCollapsible;
      }
      
      public function dataBasedWidth(param1:Boolean, param2:uint) : int
      {
         return !!this._hasExtendedInfo ? int(this.levelInfo.getActualWidth(param1,param2)) : int(Values.DEFAULT_INT);
      }
   }
}
