package net.wg.gui.lobby.vehicleCustomization.data
{
   import net.wg.data.VO.TankCarouselFilterInitVO;
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class CustomizationBottomPanelInitVO extends DAAPIDataClass
   {
      
      private static const AVAILABLE_REGIONS:String = "tabsAvailableRegions";
      
      private static const FILTERS_VO:String = "filtersVO";
       
      
      public var tabsAvailableRegions:Vector.<int> = null;
      
      public var filtersVO:TankCarouselFilterInitVO = null;
      
      public function CustomizationBottomPanelInitVO(param1:Object)
      {
         super(param1);
      }
      
      override protected function onDataWrite(param1:String, param2:Object) : Boolean
      {
         var _loc4_:int = 0;
         var _loc3_:Array = null;
         if(param1 == AVAILABLE_REGIONS)
         {
            _loc3_ = param2 as Array;
            this.tabsAvailableRegions = new Vector.<int>();
            for each(_loc4_ in _loc3_)
            {
               this.tabsAvailableRegions.push(_loc4_);
            }
            return false;
         }
         if(param1 == FILTERS_VO)
         {
            this.filtersVO = new TankCarouselFilterInitVO(param2);
            return false;
         }
         return super.onDataWrite(param1,param2);
      }
      
      override protected function onDispose() : void
      {
         if(this.tabsAvailableRegions)
         {
            this.tabsAvailableRegions.splice(0,this.tabsAvailableRegions.length);
            this.tabsAvailableRegions = null;
         }
         if(this.filtersVO)
         {
            this.filtersVO.dispose();
            this.filtersVO = null;
         }
         super.onDispose();
      }
   }
}
