package net.wg.gui.battle.views.sixthSense
{
   import net.wg.data.constants.generated.DAMAGE_INFO_PANEL_CONSTS;
   import net.wg.infrastructure.base.meta.ISixthSenseMeta;
   import net.wg.infrastructure.base.meta.impl.SixthSenseMeta;
   
   public class SixthSense extends SixthSenseMeta implements ISixthSenseMeta
   {
       
      
      public function SixthSense()
      {
         super();
         mouseChildren = false;
         mouseEnabled = false;
      }
      
      public function as_show() : void
      {
         gotoAndPlay(DAMAGE_INFO_PANEL_CONSTS.SHOW_SIXTH_SENSE);
      }
      
      public function as_hide() : void
      {
         gotoAndPlay(DAMAGE_INFO_PANEL_CONSTS.HIDE_SIXTH_SENSE);
      }
   }
}
