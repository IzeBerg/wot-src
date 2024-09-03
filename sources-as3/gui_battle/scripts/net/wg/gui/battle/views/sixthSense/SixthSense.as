package net.wg.gui.battle.views.sixthSense
{
   import net.wg.data.constants.generated.DAMAGE_INFO_PANEL_CONSTS;
   import net.wg.infrastructure.base.meta.ISixthSenseMeta;
   import net.wg.infrastructure.base.meta.impl.SixthSenseMeta;
   
   public class SixthSense extends SixthSenseMeta implements ISixthSenseMeta
   {
       
      
      private var _isHidden:Boolean = true;
      
      public function SixthSense()
      {
         super();
         mouseChildren = false;
         mouseEnabled = false;
      }
      
      public function as_hide(param1:Boolean) : void
      {
         if(this._isHidden && !param1)
         {
            return;
         }
         gotoAndPlay(!!param1 ? DAMAGE_INFO_PANEL_CONSTS.INIT_SIXTH_SENSE : DAMAGE_INFO_PANEL_CONSTS.HIDE_SIXTH_SENSE);
         this._isHidden = true;
      }
      
      public function as_show() : void
      {
         gotoAndPlay(DAMAGE_INFO_PANEL_CONSTS.SHOW_SIXTH_SENSE);
         this._isHidden = false;
      }
      
      public function get isHidden() : Boolean
      {
         return this._isHidden;
      }
   }
}
