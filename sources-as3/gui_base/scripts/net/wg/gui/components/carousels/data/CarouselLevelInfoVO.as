package net.wg.gui.components.carousels.data
{
   import net.wg.data.constants.Values;
   import net.wg.data.daapi.base.DAAPIUpdatableDataClass;
   import net.wg.utils.StageSizeBoundaries;
   
   public class CarouselLevelInfoVO extends DAAPIUpdatableDataClass
   {
      
      public static const WIDTH_EXTENDED_NORMAL:uint = 338;
      
      public static const WIDTH_EXTENDED_NORMAL_1024:uint = 222;
      
      public static const WIDTH_EXTENDED_BIG:uint = 235;
      
      public static const WIDTH_COLLAPSED:uint = 36;
       
      
      public var level:uint = 0;
      
      public var isCollapsed:Boolean = true;
      
      public var isCollapsible:Boolean = false;
      
      public var infoText:String = "";
      
      public var isDoubled:Boolean = false;
      
      public function CarouselLevelInfoVO(param1:Object)
      {
         super(param1);
      }
      
      public function getActualWidth(param1:Boolean, param2:uint) : int
      {
         var _loc3_:int = Values.DEFAULT_INT;
         if(!this.isCollapsible || this.isCollapsed)
         {
            _loc3_ = WIDTH_COLLAPSED;
         }
         else if(!param1 && param2 > 1)
         {
            _loc3_ = WIDTH_EXTENDED_BIG;
         }
         else
         {
            _loc3_ = App.appWidth <= StageSizeBoundaries.WIDTH_1024 ? int(WIDTH_EXTENDED_NORMAL_1024) : int(WIDTH_EXTENDED_NORMAL);
         }
         return _loc3_;
      }
   }
}
