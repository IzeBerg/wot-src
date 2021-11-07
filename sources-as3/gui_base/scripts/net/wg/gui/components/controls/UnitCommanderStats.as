package net.wg.gui.components.controls
{
   import flash.text.TextField;
   import net.wg.gui.components.tooltips.VO.UnitCommandVO;
   import net.wg.infrastructure.interfaces.entity.IUpdatable;
   import scaleform.clik.core.UIComponent;
   
   public class UnitCommanderStats extends UIComponent implements IUpdatable
   {
       
      
      public var stats:TextField = null;
      
      public var descr:TextField = null;
      
      public function UnitCommanderStats()
      {
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
      }
      
      override protected function onDispose() : void
      {
         this.stats = null;
         this.descr = null;
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
