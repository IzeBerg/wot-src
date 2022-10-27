package net.wg.gui.battle.halloween.ribbonsPanel
{
   import net.wg.data.constants.generated.BATTLEATLAS;
   import net.wg.data.constants.generated.BATTLE_EFFICIENCY_TYPES;
   import net.wg.gui.components.ribbon.constants.RibbonColors;
   import net.wg.gui.components.ribbon.data.RibbonSettingByType;
   import net.wg.gui.components.ribbon.data.RibbonSettings;
   
   public class HWRibbonSettings extends RibbonSettings
   {
       
      
      public function HWRibbonSettings(param1:String, param2:String)
      {
         super(param1,param2);
      }
      
      override protected function atlasInit() : void
      {
         super.atlasInit();
         var _loc1_:String = RibbonColors.GREEN;
         RIBBON_TYPES_MAP[BATTLE_EFFICIENCY_TYPES.HALLOWEEN_REPAIR] = new RibbonSettingByType(_loc1_,BATTLEATLAS.RIBBONS_REPAIR,_loc1_,BATTLEATLAS.RIBBONS_REPAIR,3);
      }
   }
}
