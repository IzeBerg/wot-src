package net.wg.gui.battle.historicalBattles.battleDamagePanel
{
   import net.wg.data.constants.generated.HBBATTLEDAMAGELOG_IMAGES;
   import net.wg.gui.components.battleDamagePanel.components.DamageLogRenderer;
   
   public class HBDamageLogRenderer extends DamageLogRenderer
   {
      
      private static const HB_ICONS_WITH_BLIND:Vector.<String> = new <String>[HBBATTLEDAMAGELOG_IMAGES.DAMAGELOG_BY_AIRSTRIKE_FIELD_16X16,HBBATTLEDAMAGELOG_IMAGES.DAMAGELOG_BY_ARTILLERY_FIELD_16X16];
       
      
      public function HBDamageLogRenderer()
      {
         super();
      }
      
      override protected function getBlindIconIndex(param1:String) : int
      {
         var _loc2_:int = HB_ICONS_WITH_BLIND.indexOf(param1);
         return _loc2_ != -1 ? int(_loc2_) : int(super.getBlindIconIndex(param1));
      }
   }
}
