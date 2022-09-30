package net.wg.gui.components.controls
{
   import flash.text.TextField;
   import net.wg.gui.components.tooltips.VO.UnitCommandVO;
   import net.wg.infrastructure.base.UIComponentEx;
   import net.wg.infrastructure.interfaces.entity.IUpdatable;
   
   public class UnitCommanderStats extends UIComponentEx implements IUpdatable
   {
       
      
      public var stats:TextField = null;
      
      public var descr:TextField = null;
      
      public var statsIcon:UILoaderAlt = null;
      
      public function UnitCommanderStats()
      {
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.statsIcon.source = RES_ICONS.MAPS_ICONS_LIBRARY_UNITCOMMAND_STATSICON;
      }
      
      override protected function onDispose() : void
      {
         this.stats = null;
         this.descr = null;
         this.statsIcon.dispose();
         this.statsIcon = null;
         super.onDispose();
      }
      
      public function update(param1:Object) : void
      {
         var _loc2_:UnitCommandVO = UnitCommandVO(param1);
         this.stats.text = _loc2_.commanderRating;
         this.descr.text = _loc2_.commanderRatingDesc;
      }
   }
}
