package net.wg.gui.lobby.profile.pages.technique
{
   import net.wg.data.constants.Linkages;
   import net.wg.gui.lobby.profile.components.AwardsTileListBlock;
   import scaleform.clik.constants.DirectionMode;
   
   public class TechniqueAchievementsBlock extends AwardsTileListBlock
   {
      
      private static var defaultIR_smallWidth:int = -1;
       
      
      private const MIN_ITEMS_COUNT:uint = 5;
      
      public function TechniqueAchievementsBlock()
      {
         super();
      }
      
      public static function getBigRendererWidth() : Number
      {
         if(defaultIR_smallWidth == -1)
         {
            defaultIR_smallWidth = getDefaultWidth(Linkages.ACHIEVEMENT_COMMON);
         }
         return defaultIR_smallWidth;
      }
      
      private static function getDefaultWidth(param1:String) : uint
      {
         var _loc2_:Class = getClass(param1);
         var _loc3_:Object = new _loc2_();
         return _loc3_.width;
      }
      
      private static function getClass(param1:String) : Class
      {
         return App.utils.classFactory.getClass(param1);
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         tileList.direction = DirectionMode.VERTICAL;
         tileList.columnWidth = getBigRendererWidth();
         tileList.columnCount = this.MIN_ITEMS_COUNT;
         tileList.itemRenderer = getClass(Linkages.ACHIEVEMENT_COMMON);
      }
      
      override protected function onDispose() : void
      {
         super.onDispose();
      }
   }
}
